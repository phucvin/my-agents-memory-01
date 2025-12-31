#ifdef __cplusplus
extern "C" {
#endif

#include "moonbit.h"

#ifdef _MSC_VER
#define _Noreturn __declspec(noreturn)
#endif

#if defined(__clang__)
#pragma clang diagnostic ignored "-Wshift-op-parentheses"
#pragma clang diagnostic ignored "-Wtautological-compare"
#endif

MOONBIT_EXPORT _Noreturn void moonbit_panic(void);
MOONBIT_EXPORT void *moonbit_malloc_array(enum moonbit_block_kind kind,
                                          int elem_size_shift, int32_t len);
MOONBIT_EXPORT int moonbit_val_array_equal(const void *lhs, const void *rhs);
MOONBIT_EXPORT moonbit_string_t moonbit_add_string(moonbit_string_t s1,
                                                   moonbit_string_t s2);
MOONBIT_EXPORT void moonbit_unsafe_bytes_blit(moonbit_bytes_t dst,
                                              int32_t dst_start,
                                              moonbit_bytes_t src,
                                              int32_t src_offset, int32_t len);
MOONBIT_EXPORT moonbit_string_t moonbit_unsafe_bytes_sub_string(
    moonbit_bytes_t bytes, int32_t start, int32_t len);
MOONBIT_EXPORT void moonbit_println(moonbit_string_t str);
MOONBIT_EXPORT moonbit_bytes_t *moonbit_get_cli_args(void);
MOONBIT_EXPORT void moonbit_runtime_init(int argc, char **argv);
MOONBIT_EXPORT void moonbit_drop_object(void *);

#define Moonbit_make_regular_object_header(ptr_field_offset, ptr_field_count,  \
                                           tag)                                \
  (((uint32_t)moonbit_BLOCK_KIND_REGULAR << 30) |                              \
   (((uint32_t)(ptr_field_offset) & (((uint32_t)1 << 11) - 1)) << 19) |        \
   (((uint32_t)(ptr_field_count) & (((uint32_t)1 << 11) - 1)) << 8) |          \
   ((tag) & 0xFF))

// header manipulation macros
#define Moonbit_object_ptr_field_offset(obj)                                   \
  ((Moonbit_object_header(obj)->meta >> 19) & (((uint32_t)1 << 11) - 1))

#define Moonbit_object_ptr_field_count(obj)                                    \
  ((Moonbit_object_header(obj)->meta >> 8) & (((uint32_t)1 << 11) - 1))

#if !defined(_WIN64) && !defined(_WIN32)
void *malloc(size_t size);
void free(void *ptr);
#define libc_malloc malloc
#define libc_free free
#endif

// several important runtime functions are inlined
static void *moonbit_malloc_inlined(size_t size) {
  struct moonbit_object *ptr = (struct moonbit_object *)libc_malloc(
      sizeof(struct moonbit_object) + size);
  ptr->rc = 1;
  return ptr + 1;
}

#define moonbit_malloc(obj) moonbit_malloc_inlined(obj)
#define moonbit_free(obj) libc_free(Moonbit_object_header(obj))

static void moonbit_incref_inlined(void *ptr) {
  struct moonbit_object *header = Moonbit_object_header(ptr);
  int32_t const count = header->rc;
  if (count > 0) {
    header->rc = count + 1;
  }
}

#define moonbit_incref moonbit_incref_inlined

static void moonbit_decref_inlined(void *ptr) {
  struct moonbit_object *header = Moonbit_object_header(ptr);
  int32_t const count = header->rc;
  if (count > 1) {
    header->rc = count - 1;
  } else if (count == 1) {
    moonbit_drop_object(ptr);
  }
}

#define moonbit_decref moonbit_decref_inlined

#define moonbit_unsafe_make_string moonbit_make_string

// detect whether compiler builtins exist for advanced bitwise operations
#ifdef __has_builtin

#if __has_builtin(__builtin_clz)
#define HAS_BUILTIN_CLZ
#endif

#if __has_builtin(__builtin_ctz)
#define HAS_BUILTIN_CTZ
#endif

#if __has_builtin(__builtin_popcount)
#define HAS_BUILTIN_POPCNT
#endif

#if __has_builtin(__builtin_sqrt)
#define HAS_BUILTIN_SQRT
#endif

#if __has_builtin(__builtin_sqrtf)
#define HAS_BUILTIN_SQRTF
#endif

#if __has_builtin(__builtin_fabs)
#define HAS_BUILTIN_FABS
#endif

#if __has_builtin(__builtin_fabsf)
#define HAS_BUILTIN_FABSF
#endif

#endif

// if there is no builtin operators, use software implementation
#ifdef HAS_BUILTIN_CLZ
static inline int32_t moonbit_clz32(int32_t x) {
  return x == 0 ? 32 : __builtin_clz(x);
}

static inline int32_t moonbit_clz64(int64_t x) {
  return x == 0 ? 64 : __builtin_clzll(x);
}

#undef HAS_BUILTIN_CLZ
#else
// table for [clz] value of 4bit integer.
static const uint8_t moonbit_clz4[] = {4, 3, 2, 2, 1, 1, 1, 1,
                                       0, 0, 0, 0, 0, 0, 0, 0};

int32_t moonbit_clz32(uint32_t x) {
  /* The ideas is to:

     1. narrow down the 4bit block where the most signficant "1" bit lies,
        using binary search
     2. find the number of leading zeros in that 4bit block via table lookup

     Different time/space tradeoff can be made here by enlarging the table
     and do less binary search.
     One benefit of the 4bit lookup table is that it can fit into a single cache
     line.
  */
  int32_t result = 0;
  if (x > 0xffff) {
    x >>= 16;
  } else {
    result += 16;
  }
  if (x > 0xff) {
    x >>= 8;
  } else {
    result += 8;
  }
  if (x > 0xf) {
    x >>= 4;
  } else {
    result += 4;
  }
  return result + moonbit_clz4[x];
}

int32_t moonbit_clz64(uint64_t x) {
  int32_t result = 0;
  if (x > 0xffffffff) {
    x >>= 32;
  } else {
    result += 32;
  }
  return result + moonbit_clz32((uint32_t)x);
}
#endif

#ifdef HAS_BUILTIN_CTZ
static inline int32_t moonbit_ctz32(int32_t x) {
  return x == 0 ? 32 : __builtin_ctz(x);
}

static inline int32_t moonbit_ctz64(int64_t x) {
  return x == 0 ? 64 : __builtin_ctzll(x);
}

#undef HAS_BUILTIN_CTZ
#else
int32_t moonbit_ctz32(int32_t x) {
  /* The algorithm comes from:

       Leiserson, Charles E. et al. “Using de Bruijn Sequences to Index a 1 in a
     Computer Word.” (1998).

     The ideas is:

     1. leave only the least significant "1" bit in the input,
        set all other bits to "0". This is achieved via [x & -x]
     2. now we have [x * n == n << ctz(x)], if [n] is a de bruijn sequence
        (every 5bit pattern occurn exactly once when you cycle through the bit
     string), we can find [ctz(x)] from the most significant 5 bits of [x * n]
 */
  static const uint32_t de_bruijn_32 = 0x077CB531;
  static const uint8_t index32[] = {0,  1,  28, 2,  29, 14, 24, 3,  30, 22, 20,
                                    15, 25, 17, 4,  8,  31, 27, 13, 23, 21, 19,
                                    16, 7,  26, 12, 18, 6,  11, 5,  10, 9};
  return (x == 0) * 32 + index32[(de_bruijn_32 * (x & -x)) >> 27];
}

int32_t moonbit_ctz64(int64_t x) {
  static const uint64_t de_bruijn_64 = 0x0218A392CD3D5DBF;
  static const uint8_t index64[] = {
      0,  1,  2,  7,  3,  13, 8,  19, 4,  25, 14, 28, 9,  34, 20, 40,
      5,  17, 26, 38, 15, 46, 29, 48, 10, 31, 35, 54, 21, 50, 41, 57,
      63, 6,  12, 18, 24, 27, 33, 39, 16, 37, 45, 47, 30, 53, 49, 56,
      62, 11, 23, 32, 36, 44, 52, 55, 61, 22, 43, 51, 60, 42, 59, 58};
  return (x == 0) * 64 + index64[(de_bruijn_64 * (x & -x)) >> 58];
}
#endif

#ifdef HAS_BUILTIN_POPCNT

#define moonbit_popcnt32 __builtin_popcount
#define moonbit_popcnt64 __builtin_popcountll
#undef HAS_BUILTIN_POPCNT

#else
int32_t moonbit_popcnt32(uint32_t x) {
  /* The classic SIMD Within A Register algorithm.
     ref: [https://nimrod.blog/posts/algorithms-behind-popcount/]
 */
  x = x - ((x >> 1) & 0x55555555);
  x = (x & 0x33333333) + ((x >> 2) & 0x33333333);
  x = (x + (x >> 4)) & 0x0F0F0F0F;
  return (x * 0x01010101) >> 24;
}

int32_t moonbit_popcnt64(uint64_t x) {
  x = x - ((x >> 1) & 0x5555555555555555);
  x = (x & 0x3333333333333333) + ((x >> 2) & 0x3333333333333333);
  x = (x + (x >> 4)) & 0x0F0F0F0F0F0F0F0F;
  return (x * 0x0101010101010101) >> 56;
}
#endif

/* The following sqrt implementation comes from
   [musl](https://git.musl-libc.org/cgit/musl),
   with some helpers inlined to make it zero dependency.
 */
#ifdef MOONBIT_NATIVE_NO_SYS_HEADER
const uint16_t __rsqrt_tab[128] = {
    0xb451, 0xb2f0, 0xb196, 0xb044, 0xaef9, 0xadb6, 0xac79, 0xab43, 0xaa14,
    0xa8eb, 0xa7c8, 0xa6aa, 0xa592, 0xa480, 0xa373, 0xa26b, 0xa168, 0xa06a,
    0x9f70, 0x9e7b, 0x9d8a, 0x9c9d, 0x9bb5, 0x9ad1, 0x99f0, 0x9913, 0x983a,
    0x9765, 0x9693, 0x95c4, 0x94f8, 0x9430, 0x936b, 0x92a9, 0x91ea, 0x912e,
    0x9075, 0x8fbe, 0x8f0a, 0x8e59, 0x8daa, 0x8cfe, 0x8c54, 0x8bac, 0x8b07,
    0x8a64, 0x89c4, 0x8925, 0x8889, 0x87ee, 0x8756, 0x86c0, 0x862b, 0x8599,
    0x8508, 0x8479, 0x83ec, 0x8361, 0x82d8, 0x8250, 0x81c9, 0x8145, 0x80c2,
    0x8040, 0xff02, 0xfd0e, 0xfb25, 0xf947, 0xf773, 0xf5aa, 0xf3ea, 0xf234,
    0xf087, 0xeee3, 0xed47, 0xebb3, 0xea27, 0xe8a3, 0xe727, 0xe5b2, 0xe443,
    0xe2dc, 0xe17a, 0xe020, 0xdecb, 0xdd7d, 0xdc34, 0xdaf1, 0xd9b3, 0xd87b,
    0xd748, 0xd61a, 0xd4f1, 0xd3cd, 0xd2ad, 0xd192, 0xd07b, 0xcf69, 0xce5b,
    0xcd51, 0xcc4a, 0xcb48, 0xca4a, 0xc94f, 0xc858, 0xc764, 0xc674, 0xc587,
    0xc49d, 0xc3b7, 0xc2d4, 0xc1f4, 0xc116, 0xc03c, 0xbf65, 0xbe90, 0xbdbe,
    0xbcef, 0xbc23, 0xbb59, 0xba91, 0xb9cc, 0xb90a, 0xb84a, 0xb78c, 0xb6d0,
    0xb617, 0xb560,
};

/* returns a*b*2^-32 - e, with error 0 <= e < 1.  */
static inline uint32_t mul32(uint32_t a, uint32_t b) {
  return (uint64_t)a * b >> 32;
}
#endif

#ifdef MOONBIT_NATIVE_NO_SYS_HEADER
float sqrtf(float x) {
  uint32_t ix, m, m1, m0, even, ey;

  ix = *(uint32_t *)&x;
  if (ix - 0x00800000 >= 0x7f800000 - 0x00800000) {
    /* x < 0x1p-126 or inf or nan.  */
    if (ix * 2 == 0)
      return x;
    if (ix == 0x7f800000)
      return x;
    if (ix > 0x7f800000)
      return (x - x) / (x - x);
    /* x is subnormal, normalize it.  */
    x *= 0x1p23f;
    ix = *(uint32_t *)&x;
    ix -= 23 << 23;
  }

  /* x = 4^e m; with int e and m in [1, 4).  */
  even = ix & 0x00800000;
  m1 = (ix << 8) | 0x80000000;
  m0 = (ix << 7) & 0x7fffffff;
  m = even ? m0 : m1;

  /* 2^e is the exponent part of the return value.  */
  ey = ix >> 1;
  ey += 0x3f800000 >> 1;
  ey &= 0x7f800000;

  /* compute r ~ 1/sqrt(m), s ~ sqrt(m) with 2 goldschmidt iterations.  */
  static const uint32_t three = 0xc0000000;
  uint32_t r, s, d, u, i;
  i = (ix >> 17) % 128;
  r = (uint32_t)__rsqrt_tab[i] << 16;
  /* |r*sqrt(m) - 1| < 0x1p-8 */
  s = mul32(m, r);
  /* |s/sqrt(m) - 1| < 0x1p-8 */
  d = mul32(s, r);
  u = three - d;
  r = mul32(r, u) << 1;
  /* |r*sqrt(m) - 1| < 0x1.7bp-16 */
  s = mul32(s, u) << 1;
  /* |s/sqrt(m) - 1| < 0x1.7bp-16 */
  d = mul32(s, r);
  u = three - d;
  s = mul32(s, u);
  /* -0x1.03p-28 < s/sqrt(m) - 1 < 0x1.fp-31 */
  s = (s - 1) >> 6;
  /* s < sqrt(m) < s + 0x1.08p-23 */

  /* compute nearest rounded result.  */
  uint32_t d0, d1, d2;
  float y, t;
  d0 = (m << 16) - s * s;
  d1 = s - d0;
  d2 = d1 + s + 1;
  s += d1 >> 31;
  s &= 0x007fffff;
  s |= ey;
  y = *(float *)&s;
  /* handle rounding and inexact exception. */
  uint32_t tiny = d2 == 0 ? 0 : 0x01000000;
  tiny |= (d1 ^ d2) & 0x80000000;
  t = *(float *)&tiny;
  y = y + t;
  return y;
}
#endif

#ifdef MOONBIT_NATIVE_NO_SYS_HEADER
/* returns a*b*2^-64 - e, with error 0 <= e < 3.  */
static inline uint64_t mul64(uint64_t a, uint64_t b) {
  uint64_t ahi = a >> 32;
  uint64_t alo = a & 0xffffffff;
  uint64_t bhi = b >> 32;
  uint64_t blo = b & 0xffffffff;
  return ahi * bhi + (ahi * blo >> 32) + (alo * bhi >> 32);
}

double sqrt(double x) {
  uint64_t ix, top, m;

  /* special case handling.  */
  ix = *(uint64_t *)&x;
  top = ix >> 52;
  if (top - 0x001 >= 0x7ff - 0x001) {
    /* x < 0x1p-1022 or inf or nan.  */
    if (ix * 2 == 0)
      return x;
    if (ix == 0x7ff0000000000000)
      return x;
    if (ix > 0x7ff0000000000000)
      return (x - x) / (x - x);
    /* x is subnormal, normalize it.  */
    x *= 0x1p52;
    ix = *(uint64_t *)&x;
    top = ix >> 52;
    top -= 52;
  }

  /* argument reduction:
     x = 4^e m; with integer e, and m in [1, 4)
     m: fixed point representation [2.62]
     2^e is the exponent part of the result.  */
  int even = top & 1;
  m = (ix << 11) | 0x8000000000000000;
  if (even)
    m >>= 1;
  top = (top + 0x3ff) >> 1;

  /* approximate r ~ 1/sqrt(m) and s ~ sqrt(m) when m in [1,4)

     initial estimate:
     7bit table lookup (1bit exponent and 6bit significand).

     iterative approximation:
     using 2 goldschmidt iterations with 32bit int arithmetics
     and a final iteration with 64bit int arithmetics.

     details:

     the relative error (e = r0 sqrt(m)-1) of a linear estimate
     (r0 = a m + b) is |e| < 0.085955 ~ 0x1.6p-4 at best,
     a table lookup is faster and needs one less iteration
     6 bit lookup table (128b) gives |e| < 0x1.f9p-8
     7 bit lookup table (256b) gives |e| < 0x1.fdp-9
     for single and double prec 6bit is enough but for quad
     prec 7bit is needed (or modified iterations). to avoid
     one more iteration >=13bit table would be needed (16k).

     a newton-raphson iteration for r is
       w = r*r
       u = 3 - m*w
       r = r*u/2
     can use a goldschmidt iteration for s at the end or
       s = m*r

     first goldschmidt iteration is
       s = m*r
       u = 3 - s*r
       r = r*u/2
       s = s*u/2
     next goldschmidt iteration is
       u = 3 - s*r
       r = r*u/2
       s = s*u/2
     and at the end r is not computed only s.

     they use the same amount of operations and converge at the
     same quadratic rate, i.e. if
       r1 sqrt(m) - 1 = e, then
       r2 sqrt(m) - 1 = -3/2 e^2 - 1/2 e^3
     the advantage of goldschmidt is that the mul for s and r
     are independent (computed in parallel), however it is not
     "self synchronizing": it only uses the input m in the
     first iteration so rounding errors accumulate. at the end
     or when switching to larger precision arithmetics rounding
     errors dominate so the first iteration should be used.

     the fixed point representations are
       m: 2.30 r: 0.32, s: 2.30, d: 2.30, u: 2.30, three: 2.30
     and after switching to 64 bit
       m: 2.62 r: 0.64, s: 2.62, d: 2.62, u: 2.62, three: 2.62  */

  static const uint64_t three = 0xc0000000;
  uint64_t r, s, d, u, i;

  i = (ix >> 46) % 128;
  r = (uint32_t)__rsqrt_tab[i] << 16;
  /* |r sqrt(m) - 1| < 0x1.fdp-9 */
  s = mul32(m >> 32, r);
  /* |s/sqrt(m) - 1| < 0x1.fdp-9 */
  d = mul32(s, r);
  u = three - d;
  r = mul32(r, u) << 1;
  /* |r sqrt(m) - 1| < 0x1.7bp-16 */
  s = mul32(s, u) << 1;
  /* |s/sqrt(m) - 1| < 0x1.7bp-16 */
  d = mul32(s, r);
  u = three - d;
  r = mul32(r, u) << 1;
  /* |r sqrt(m) - 1| < 0x1.3704p-29 (measured worst-case) */
  r = r << 32;
  s = mul64(m, r);
  d = mul64(s, r);
  u = (three << 32) - d;
  s = mul64(s, u); /* repr: 3.61 */
  /* -0x1p-57 < s - sqrt(m) < 0x1.8001p-61 */
  s = (s - 2) >> 9; /* repr: 12.52 */
  /* -0x1.09p-52 < s - sqrt(m) < -0x1.fffcp-63 */

  /* s < sqrt(m) < s + 0x1.09p-52,
     compute nearest rounded result:
     the nearest result to 52 bits is either s or s+0x1p-52,
     we can decide by comparing (2^52 s + 0.5)^2 to 2^104 m.  */
  uint64_t d0, d1, d2;
  double y, t;
  d0 = (m << 42) - s * s;
  d1 = s - d0;
  d2 = d1 + s + 1;
  s += d1 >> 63;
  s &= 0x000fffffffffffff;
  s |= top << 52;
  y = *(double *)&s;
  return y;
}
#endif

#ifdef MOONBIT_NATIVE_NO_SYS_HEADER
double fabs(double x) {
  union {
    double f;
    uint64_t i;
  } u = {x};
  u.i &= 0x7fffffffffffffffULL;
  return u.f;
}
#endif

#ifdef MOONBIT_NATIVE_NO_SYS_HEADER
float fabsf(float x) {
  union {
    float f;
    uint32_t i;
  } u = {x};
  u.i &= 0x7fffffff;
  return u.f;
}
#endif

#ifdef _MSC_VER
/* MSVC treats syntactic division by zero as fatal error,
   even for float point numbers,
   so we have to use a constant variable to work around this */
static const int MOONBIT_ZERO = 0;
#else
#define MOONBIT_ZERO 0
#endif

#ifdef __cplusplus
}
#endif
struct $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger;

struct $Shape$Rectangle;

struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$;

struct $Shape$Circle;

struct $Result$3c$StringView$2a$$moonbitlang$core$builtin$CreatingViewError$3e$$Ok;

struct $StringView;

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64;

struct $$moonbitlang$core$builtin$SourceLocRepr;

struct $$moonbitlang$core$builtin$Logger;

struct $$moonbitlang$core$double$internal$ryu$Umul128;

struct $$3c$StringView$2a$StringView$3e$;

struct $$moonbitlang$core$double$internal$ryu$Pow5Pair;

struct $Option$3c$StringView$3e$$Some;

struct $Result$3c$StringView$2a$$moonbitlang$core$builtin$CreatingViewError$3e$$Err;

struct $$moonbitlang$core$builtin$Logger$static_method_table;

struct $$moonbitlang$core$builtin$StringBuilder;

struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result;

struct $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger {
  struct $$moonbitlang$core$builtin$Logger$static_method_table* $0;
  void* $1;

};

struct $Shape$Rectangle {
  double $0;
  double $1;

};

struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$ {
  int32_t $0_1;
  int32_t $0_2;
  moonbit_string_t $0_0;
  void* $1;

};

struct $Shape$Circle {
  double $0;

};

struct $Result$3c$StringView$2a$$moonbitlang$core$builtin$CreatingViewError$3e$$Ok {
  int32_t $0_1;
  int32_t $0_2;
  moonbit_string_t $0_0;

};

struct $StringView {
  int32_t $1;
  int32_t $2;
  moonbit_string_t $0;

};

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64 {
  uint64_t $0;
  int32_t $1;

};

struct $$moonbitlang$core$builtin$SourceLocRepr {
  int32_t $0_1;
  int32_t $0_2;
  int32_t $1_1;
  int32_t $1_2;
  int32_t $2_1;
  int32_t $2_2;
  int32_t $3_1;
  int32_t $3_2;
  int32_t $4_1;
  int32_t $4_2;
  int32_t $5_1;
  int32_t $5_2;
  moonbit_string_t $0_0;
  moonbit_string_t $1_0;
  moonbit_string_t $2_0;
  moonbit_string_t $3_0;
  moonbit_string_t $4_0;
  moonbit_string_t $5_0;

};

struct $$moonbitlang$core$builtin$Logger {
  struct $$moonbitlang$core$builtin$Logger$static_method_table* $0;
  void* $1;

};

struct $$moonbitlang$core$double$internal$ryu$Umul128 {
  uint64_t $0;
  uint64_t $1;

};

struct $$3c$StringView$2a$StringView$3e$ {
  int32_t $0_1;
  int32_t $0_2;
  int32_t $1_1;
  int32_t $1_2;
  moonbit_string_t $0_0;
  moonbit_string_t $1_0;

};

struct $$moonbitlang$core$double$internal$ryu$Pow5Pair {
  uint64_t $0;
  uint64_t $1;

};

struct $Option$3c$StringView$3e$$Some {
  int32_t $0_1;
  int32_t $0_2;
  moonbit_string_t $0_0;

};

struct $Result$3c$StringView$2a$$moonbitlang$core$builtin$CreatingViewError$3e$$Err {
  void* $0;

};

struct $$moonbitlang$core$builtin$Logger$static_method_table {
  int32_t(* $method_0)(void*, moonbit_string_t);
  int32_t(* $method_1)(void*, moonbit_string_t, int32_t, int32_t);
  int32_t(* $method_2)(void*, struct $StringView);
  int32_t(* $method_3)(void*, int32_t);

};

struct $$moonbitlang$core$builtin$StringBuilder {
  int32_t $1;
  moonbit_bytes_t $0;

};

struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result {
  uint64_t $0;
  uint64_t $1;
  uint64_t $2;

};

struct moonbit_result_0 {
  int tag;
  union { struct $StringView ok; void* err;  } data;

};

double $username$moonbit_examples$cmd$enum$area(void* shape$531);

int32_t $$moonbitlang$core$builtin$Show$$Double$$output(
  double self$530,
  struct $$moonbitlang$core$builtin$Logger logger$529
);

moonbit_string_t $Double$$to_string(double self$528);

moonbit_string_t $moonbitlang$core$double$internal$ryu$ryu_to_string(
  double val$515
);

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* $moonbitlang$core$double$internal$ryu$d2d_small_int(
  uint64_t ieeeMantissa$509,
  int32_t ieeeExponent$511
);

moonbit_string_t $moonbitlang$core$double$internal$ryu$to_chars(
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* v$482,
  int32_t sign$480
);

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* $moonbitlang$core$double$internal$ryu$d2d(
  uint64_t ieeeMantissa$424,
  uint32_t ieeeExponent$423
);

int32_t $moonbitlang$core$double$internal$ryu$decimal_length17(
  uint64_t v$420
);

struct $$moonbitlang$core$double$internal$ryu$Pow5Pair $moonbitlang$core$double$internal$ryu$double_computeInvPow5(
  int32_t i$403
);

struct $$moonbitlang$core$double$internal$ryu$Pow5Pair $moonbitlang$core$double$internal$ryu$double_computePow5(
  int32_t i$385
);

struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result $moonbitlang$core$double$internal$ryu$mulShiftAll64(
  uint64_t m$358,
  struct $$moonbitlang$core$double$internal$ryu$Pow5Pair mul$355,
  int32_t j$371,
  int32_t mmShift$373
);

int32_t $moonbitlang$core$double$internal$ryu$multipleOfPowerOf2(
  uint64_t value$352,
  int32_t p$353
);

int32_t $moonbitlang$core$double$internal$ryu$multipleOfPowerOf5(
  uint64_t value$350,
  int32_t p$351
);

int32_t $moonbitlang$core$double$internal$ryu$pow5Factor(uint64_t value$346);

uint64_t $moonbitlang$core$double$internal$ryu$shiftright128(
  uint64_t lo$345,
  uint64_t hi$343,
  int32_t dist$344
);

struct $$moonbitlang$core$double$internal$ryu$Umul128 $moonbitlang$core$double$internal$ryu$umul128(
  uint64_t a$333,
  uint64_t b$336
);

moonbit_string_t $moonbitlang$core$double$internal$ryu$string_from_bytes(
  moonbit_bytes_t bytes$327,
  int32_t from$331,
  int32_t to$329
);

int32_t $moonbitlang$core$double$internal$ryu$log10Pow2(int32_t e$325);

int32_t $moonbitlang$core$double$internal$ryu$log10Pow5(int32_t e$324);

moonbit_string_t $moonbitlang$core$double$internal$ryu$copy_special_str(
  int32_t sign$322,
  int32_t exponent$323,
  int32_t mantissa$320
);

int32_t $moonbitlang$core$double$internal$ryu$pow5bits(int32_t e$319);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$317,
  struct $$moonbitlang$core$builtin$Logger logger$318
);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$303,
  struct $$moonbitlang$core$builtin$Logger logger$316
);

uint64_t $Bool$$to_uint64(int32_t self$301);

int64_t $Bool$$to_int64(int32_t self$300);

int32_t $Bool$$to_int(int32_t self$299);

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$298);

uint64_t $UInt$$to_uint64(uint32_t self$297);

uint32_t $ReadOnlyArray$$at$1(uint32_t* self$295, int32_t index$296);

uint64_t $ReadOnlyArray$$at$0(uint64_t* self$293, int32_t index$294);

moonbit_string_t $$moonbitlang$core$builtin$Show$$String$$to_string(
  moonbit_string_t self$292
);

int32_t $$moonbitlang$core$builtin$Show$$UInt64$$output(
  uint64_t self$291,
  struct $$moonbitlang$core$builtin$Logger logger$290
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$288,
  struct $StringView str$289
);

int64_t $String$$offset_of_nth_char$inner(
  moonbit_string_t self$285,
  int32_t i$286,
  int32_t start_offset$287,
  int64_t end_offset$283
);

int64_t $String$$offset_of_nth_char_forward(
  moonbit_string_t self$280,
  int32_t n$278,
  int32_t start_offset$274,
  int32_t end_offset$275
);

int64_t $String$$offset_of_nth_char_backward(
  moonbit_string_t self$272,
  int32_t n$270,
  int32_t start_offset$269,
  int32_t end_offset$268
);

int32_t $String$$char_length_ge$inner(
  moonbit_string_t self$258,
  int32_t len$261,
  int32_t start_offset$265,
  int64_t end_offset$256
);

moonbit_string_t $UInt64$$to_string$inner(
  uint64_t self$247,
  int32_t radix$246
);

int32_t $moonbitlang$core$builtin$int64_to_string_dec(
  uint16_t* buffer$236,
  uint64_t num$224,
  int32_t digit_start$227,
  int32_t total_len$226
);

int32_t $moonbitlang$core$builtin$int64_to_string_generic(
  uint16_t* buffer$218,
  uint64_t num$212,
  int32_t digit_start$210,
  int32_t total_len$209,
  int32_t radix$214
);

int32_t $moonbitlang$core$builtin$int64_to_string_hex(
  uint16_t* buffer$205,
  uint64_t num$201,
  int32_t digit_start$199,
  int32_t total_len$198
);

int32_t $moonbitlang$core$builtin$radix_count64(
  uint64_t value$191,
  int32_t radix$194
);

int32_t $moonbitlang$core$builtin$hex_count64(uint64_t value$189);

int32_t $moonbitlang$core$builtin$dec_count64(uint64_t value$188);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(
  uint64_t self$187
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  moonbit_string_t self$185
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  double self$183
);

int32_t $StringView$$start_offset(struct $StringView self$181);

moonbit_string_t $StringView$$data(struct $StringView self$180);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$174,
  moonbit_string_t value$177,
  int32_t start$178,
  int32_t len$179
);

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$167,
  int32_t start$173,
  int64_t end$169
);

uint64_t $Int$$to_uint64(int32_t self$165);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$163,
  moonbit_string_t str$164
);

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$155,
  int32_t bytes_offset$150,
  moonbit_string_t str$157,
  int32_t str_offset$153,
  int32_t length$151
);

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$117
);

struct $$3c$StringView$2a$StringView$3e$* $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
  struct $StringView view$113
);

struct $StringView $StringView$$view$inner(
  struct $StringView self$110,
  int32_t start_offset$111,
  int64_t end_offset$108
);

int64_t $StringView$$rev_find(
  struct $StringView self$106,
  struct $StringView str$105
);

int64_t $moonbitlang$core$builtin$brute_force_rev_find(
  struct $StringView haystack$96,
  struct $StringView needle$98
);

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_rev_find(
  struct $StringView haystack$85,
  struct $StringView needle$87
);

int64_t $StringView$$find(
  struct $StringView self$83,
  struct $StringView str$82
);

int64_t $moonbitlang$core$builtin$brute_force_find(
  struct $StringView haystack$72,
  struct $StringView needle$74
);

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_find(
  struct $StringView haystack$58,
  struct $StringView needle$60
);

int32_t $StringView$$unsafe_charcode_at(
  struct $StringView self$54,
  int32_t index$55
);

int32_t $StringView$$length(struct $StringView self$53);

int32_t $Int$$is_trailing_surrogate(int32_t self$52);

int32_t $Int$$is_leading_surrogate(int32_t self$51);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$48,
  int32_t ch$50
);

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$43,
  int32_t required$44
);

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default();

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$37,
  int32_t offset$38,
  int32_t value$36
);

int32_t $UInt$$to_byte(uint32_t self$34);

uint32_t $Char$$to_uint(int32_t self$33);

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$32
);

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$27,
  int32_t offset$31,
  int64_t length$29
);

#define $moonbitlang$core$builtin$unsafe_sub_string moonbit_unsafe_bytes_sub_string

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$24
);

int32_t $Byte$$to_char(int32_t self$22);

int32_t $FixedArray$$unsafe_blit$0(
  moonbit_bytes_t dst$13,
  int32_t dst_offset$15,
  moonbit_bytes_t src$14,
  int32_t src_offset$16,
  int32_t len$18
);

int64_t $moonbitlang$core$builtin$abort$3(
  moonbit_string_t string$11,
  moonbit_string_t loc$12
);

int32_t $moonbitlang$core$builtin$abort$2(
  moonbit_string_t string$9,
  moonbit_string_t loc$10
);

struct $StringView $moonbitlang$core$builtin$abort$1(
  moonbit_string_t string$7,
  moonbit_string_t loc$8
);

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$5,
  moonbit_string_t loc$6
);

int64_t $moonbitlang$core$abort$abort$3(moonbit_string_t msg$4);

int32_t $moonbitlang$core$abort$abort$2(moonbit_string_t msg$3);

struct $StringView $moonbitlang$core$abort$abort$1(moonbit_string_t msg$2);

int32_t $moonbitlang$core$abort$abort$0(moonbit_string_t msg$1);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$787,
  int32_t _param$786
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$784,
  struct $StringView _param$783
);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$781,
  moonbit_string_t _param$778,
  int32_t _param$779,
  int32_t _param$780
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$776,
  moonbit_string_t _param$775
);

struct { int32_t rc; uint32_t meta; uint16_t const data[1];
} const moonbit_string_literal_7 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 0), 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[50];
} const moonbit_string_literal_13 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 49),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 115, 116,
    114, 105, 110, 103, 46, 109, 98, 116, 58, 52, 57, 49, 58, 57, 45,
    52, 57, 49, 58, 52, 48, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_1 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 45, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[20];
} const moonbit_string_literal_24 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 19),
    65, 114, 101, 97, 32, 111, 102, 32, 114, 101, 99, 116, 97, 110, 103,
    108, 101, 58, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[23];
} const moonbit_string_literal_12 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 22),
    105, 110, 118, 97, 108, 105, 100, 32, 115, 117, 114, 114, 111, 103,
    97, 116, 101, 32, 112, 97, 105, 114, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[7];
} const moonbit_string_literal_21 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 6),
    10, 32, 32, 97, 116, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[49];
} const moonbit_string_literal_20 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 48),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 98, 121,
    116, 101, 115, 46, 109, 98, 116, 58, 50, 57, 48, 58, 53, 45, 50,
    57, 48, 58, 51, 49, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[23];
} const moonbit_string_literal_17 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 22),
    73, 110, 118, 97, 108, 105, 100, 32, 105, 110, 100, 101, 120, 32,
    102, 111, 114, 32, 86, 105, 101, 119, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[31];
} const moonbit_string_literal_14 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 30),
    114, 97, 100, 105, 120, 32, 109, 117, 115, 116, 32, 98, 101, 32,
    98, 101, 116, 119, 101, 101, 110, 32, 50, 32, 97, 110, 100, 32, 51,
    54, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[9];
} const moonbit_string_literal_8 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 8),
    73, 110, 102, 105, 110, 105, 116, 121, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[4];
} const moonbit_string_literal_6 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 3),
    78, 97, 78, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_3 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 48, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[18];
} const moonbit_string_literal_19 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 17),
    67, 104, 97, 114, 32, 111, 117, 116, 32, 111, 102, 32, 114, 97, 110,
    103, 101, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[54];
} const moonbit_string_literal_18 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 53),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 115, 116,
    114, 105, 110, 103, 118, 105, 101, 119, 46, 109, 98, 116, 58, 49,
    49, 49, 58, 53, 45, 49, 49, 49, 58, 51, 54, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[37];
} const moonbit_string_literal_16 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 36),
    48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 100, 101, 102,
    103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115,
    116, 117, 118, 119, 120, 121, 122, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[20];
} const moonbit_string_literal_10 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 19),
    73, 110, 118, 97, 108, 105, 100, 32, 115, 116, 97, 114, 116, 32,
    105, 110, 100, 101, 120, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[59];
} const moonbit_string_literal_5 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 58),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 100, 111, 117, 98, 108, 101, 47, 105, 110, 116,
    101, 114, 110, 97, 108, 47, 114, 121, 117, 58, 114, 121, 117, 46,
    109, 98, 116, 58, 49, 49, 54, 58, 51, 45, 49, 49, 54, 58, 52, 53,
    0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_22 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 10, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_0 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 58, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[53];
} const moonbit_string_literal_15 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 52),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 116, 111,
    95, 115, 116, 114, 105, 110, 103, 46, 109, 98, 116, 58, 54, 54, 51,
    58, 53, 45, 54, 54, 51, 58, 52, 52, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[50];
} const moonbit_string_literal_11 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 49),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 115, 116,
    114, 105, 110, 103, 46, 109, 98, 116, 58, 51, 54, 54, 58, 53, 45,
    51, 54, 54, 58, 51, 51, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_2 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 47, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[26];
} const moonbit_string_literal_4 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 25),
    73, 108, 108, 101, 103, 97, 108, 65, 114, 103, 117, 109, 101, 110,
    116, 69, 120, 99, 101, 112, 116, 105, 111, 110, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[17];
} const moonbit_string_literal_23 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 16),
    65, 114, 101, 97, 32, 111, 102, 32, 99, 105, 114, 99, 108, 101, 58,
    32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[4];
} const moonbit_string_literal_9 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 3),
    48, 46, 48, 0
  };

struct moonbit_object const moonbit_constant_constructor_0 =
  { -1, Moonbit_make_regular_object_header(2, 0, 0)};

struct moonbit_object const moonbit_constant_constructor_1 =
  { -1, Moonbit_make_regular_object_header(2, 0, 1)};

struct {
  int32_t rc;
  uint32_t meta;
  struct $$moonbitlang$core$builtin$Logger$static_method_table data;

} $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id$object =
  {
    -1,
    Moonbit_make_regular_object_header(
      sizeof(
        struct $$moonbitlang$core$builtin$Logger$static_method_table
      )
      >> 2,
        0,
        0
    ),
    {
      .$method_0 = $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger,
        .$method_1 = $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0,
        .$method_2 = $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger,
        .$method_3 = $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger
    }
  };

struct $$moonbitlang$core$builtin$Logger$static_method_table* $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id =
  &$$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id$object.data;

moonbit_string_t $moonbitlang$core$builtin$parse$$2a$bind$7c$5404 =
  (moonbit_string_t)moonbit_string_literal_0.data;

moonbit_string_t $moonbitlang$core$builtin$parse$$2a$bind$7c$5443 =
  (moonbit_string_t)moonbit_string_literal_0.data;

moonbit_string_t $moonbitlang$core$builtin$parse$$2a$bind$7c$5437 =
  (moonbit_string_t)moonbit_string_literal_1.data;

moonbit_string_t $moonbitlang$core$builtin$parse$$2a$bind$7c$5424 =
  (moonbit_string_t)moonbit_string_literal_0.data;

moonbit_string_t $moonbitlang$core$builtin$parse$$2a$bind$7c$5418 =
  (moonbit_string_t)moonbit_string_literal_0.data;

moonbit_string_t $moonbitlang$core$builtin$output$$2a$bind$7c$8193 =
  (moonbit_string_t)moonbit_string_literal_2.data;

moonbit_string_t $moonbitlang$core$builtin$output$$2a$bind$7c$8187 =
  (moonbit_string_t)moonbit_string_literal_2.data;

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_find$constr$56;

int64_t $moonbitlang$core$builtin$brute_force_find$constr$70;

struct { int32_t rc; uint32_t meta; uint64_t data[30];
} $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_INV_SPLIT2$object =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 0, 30),
    1ull, 2305843009213693952ull, 5955668970331000884ull,
    1784059615882449851ull, 8982663654677661702ull, 1380349269358112757ull,
    7286864317269821294ull, 2135987035920910082ull, 7005857020398200553ull,
    1652639921975621497ull, 17965325103354776697ull, 1278668206209430417ull,
    8928596168509315048ull, 1978643211784836272ull, 10075671573058298858ull,
    1530901034580419511ull, 597001226353042382ull, 1184477304306571148ull,
    1527430471115325346ull, 1832889850782397517ull, 12533209867169019542ull,
    1418129833677084982ull, 5577825024675947042ull, 2194449627517475473ull,
    11006974540203867551ull, 1697873161311732311ull, 10313493231639821582ull,
    1313665730009899186ull, 12701016819766672773ull, 2032799256770390445ull
  };

uint64_t* $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_INV_SPLIT2 =
  $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_INV_SPLIT2$object.data;

struct { int32_t rc; uint32_t meta; uint32_t data[19];
} $moonbitlang$core$double$internal$ryu$gPOW5_INV_OFFSETS$object =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 0, 19),
    1414808916u, 67458373u, 268701696u, 4195348u, 1073807360u, 1091917141u,
    1108u, 65604u, 1073741824u, 1140850753u, 1346716752u, 1431634004u,
    1365595476u, 1073758208u, 16777217u, 66816u, 1364284433u, 89478484u,
    0u
  };

uint32_t* $moonbitlang$core$double$internal$ryu$gPOW5_INV_OFFSETS =
  $moonbitlang$core$double$internal$ryu$gPOW5_INV_OFFSETS$object.data;

struct { int32_t rc; uint32_t meta; uint64_t data[26];
} $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_SPLIT2$object =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 0, 26),
    0ull, 1152921504606846976ull, 0ull, 1490116119384765625ull,
    1032610780636961552ull, 1925929944387235853ull, 7910200175544436838ull,
    1244603055572228341ull, 16941905809032713930ull, 1608611746708759036ull,
    13024893955298202172ull, 2079081953128979843ull, 6607496772837067824ull,
    1343575221513417750ull, 17332926989895652603ull, 1736530273035216783ull,
    13037379183483547984ull, 2244412773384604712ull, 1605989338741628675ull,
    1450417759929778918ull, 9630225068416591280ull, 1874621017369538693ull,
    665883850346957067ull, 1211445438634777304ull, 14931890668723713708ull,
    1565756531257009982ull
  };

uint64_t* $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_SPLIT2 =
  $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_SPLIT2$object.data;

struct { int32_t rc; uint32_t meta; uint32_t data[21];
} $moonbitlang$core$double$internal$ryu$gPOW5_OFFSETS$object =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 0, 21),
    0u, 0u, 0u, 0u, 1073741824u, 1500076437u, 1431590229u, 1448432917u,
    1091896580u, 1079333904u, 1146442053u, 1146111296u, 1163220304u,
    1073758208u, 2521039936u, 1431721317u, 1413824581u, 1075134801u,
    1431671125u, 1363170645u, 261u
  };

uint32_t* $moonbitlang$core$double$internal$ryu$gPOW5_OFFSETS =
  $moonbitlang$core$double$internal$ryu$gPOW5_OFFSETS$object.data;

struct { int32_t rc; uint32_t meta; uint64_t data[26];
} $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_TABLE$object =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 0, 26),
    1ull, 5ull, 25ull, 125ull, 625ull, 3125ull, 15625ull, 78125ull,
    390625ull, 1953125ull, 9765625ull, 48828125ull, 244140625ull,
    1220703125ull, 6103515625ull, 30517578125ull, 152587890625ull,
    762939453125ull, 3814697265625ull, 19073486328125ull, 95367431640625ull,
    476837158203125ull, 2384185791015625ull, 11920928955078125ull,
    59604644775390625ull, 298023223876953125ull
  };

uint64_t* $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_TABLE =
  $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_TABLE$object.data;

struct {
  int32_t rc;
  uint32_t meta;
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64 data;

} $moonbitlang$core$double$internal$ryu$ryu_to_string$record$514$object =
  {
    -1,
    Moonbit_make_regular_object_header(
      sizeof(
        struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64
      )
      >> 2,
        0,
        0
    ), {.$0 = 0ull, .$1 = 0}
  };

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* $moonbitlang$core$double$internal$ryu$ryu_to_string$record$514 =
  &$moonbitlang$core$double$internal$ryu$ryu_to_string$record$514$object.data;

struct { int32_t rc; uint32_t meta; struct $Shape$Circle data;
} $username$moonbit_examples$cmd$enum$_main$c$537$object =
  {
    -1,
    Moonbit_make_regular_object_header(
      sizeof(struct $Shape$Circle) >> 2, 0, 0
    ), {.$0 = 0x1.4p+2}
  };

struct $Shape$Circle* $username$moonbit_examples$cmd$enum$_main$c$537 =
  &$username$moonbit_examples$cmd$enum$_main$c$537$object.data;

struct { int32_t rc; uint32_t meta; struct $Shape$Rectangle data;
} $username$moonbit_examples$cmd$enum$_main$r$538$object =
  {
    -1,
    Moonbit_make_regular_object_header(
      sizeof(struct $Shape$Rectangle) >> 2, 0, 1
    ), {.$0 = 0x1p+2, .$1 = 0x1.8p+2}
  };

struct $Shape$Rectangle* $username$moonbit_examples$cmd$enum$_main$r$538 =
  &$username$moonbit_examples$cmd$enum$_main$r$538$object.data;

double $username$moonbit_examples$cmd$enum$area(void* shape$531) {
  switch (Moonbit_object_tag(shape$531)) {
    case 0: {
      struct $Shape$Circle* _Circle$532 = (struct $Shape$Circle*)shape$531;
      double _field$1644 = _Circle$532->$0;
      double _r$533;
      double _tmp$1643;
      moonbit_decref(_Circle$532);
      _r$533 = _field$1644;
      _tmp$1643 = 0x1.921f9f01b866ep+1 * _r$533;
      return _tmp$1643 * _r$533;
      break;
    }
    default: {
      struct $Shape$Rectangle* _Rectangle$534 =
        (struct $Shape$Rectangle*)shape$531;
      double _w$535 = _Rectangle$534->$0;
      double _field$1645 = _Rectangle$534->$1;
      double _h$536;
      moonbit_decref(_Rectangle$534);
      _h$536 = _field$1645;
      return _w$535 * _h$536;
      break;
    }
  }
}

int32_t $$moonbitlang$core$builtin$Show$$Double$$output(
  double self$530,
  struct $$moonbitlang$core$builtin$Logger logger$529
) {
  moonbit_string_t _tmp$1642 = $Double$$to_string(self$530);
  logger$529.$0->$method_0(logger$529.$1, _tmp$1642);
  return 0;
}

moonbit_string_t $Double$$to_string(double self$528) {
  return $moonbitlang$core$double$internal$ryu$ryu_to_string(self$528);
}

moonbit_string_t $moonbitlang$core$double$internal$ryu$ryu_to_string(
  double val$515
) {
  uint64_t bits$516;
  uint64_t _tmp$1641;
  uint64_t _tmp$1640;
  int32_t ieeeSign$517;
  uint64_t ieeeMantissa$518;
  uint64_t _tmp$1639;
  uint64_t _tmp$1638;
  int32_t ieeeExponent$519;
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* v$520;
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* small$521;
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _tmp$1637;
  if (val$515 == 0x0p+0) {
    return (moonbit_string_t)moonbit_string_literal_3.data;
  }
  bits$516 = *(int64_t*)&val$515;
  _tmp$1641 = bits$516 >> 63;
  _tmp$1640 = _tmp$1641 & 1ull;
  ieeeSign$517 = _tmp$1640 != 0ull;
  ieeeMantissa$518 = bits$516 & 4503599627370495ull;
  _tmp$1639 = bits$516 >> 52;
  _tmp$1638 = _tmp$1639 & 2047ull;
  ieeeExponent$519 = (int32_t)_tmp$1638;
  if (
    ieeeExponent$519 == 2047
    || ieeeExponent$519 == 0 && ieeeMantissa$518 == 0ull
  ) {
    int32_t _tmp$1626 = ieeeExponent$519 != 0;
    int32_t _tmp$1627 = ieeeMantissa$518 != 0ull;
    return $moonbitlang$core$double$internal$ryu$copy_special_str(
             ieeeSign$517, _tmp$1626, _tmp$1627
           );
  }
  v$520 = $moonbitlang$core$double$internal$ryu$ryu_to_string$record$514;
  small$521
  = $moonbitlang$core$double$internal$ryu$d2d_small_int(
    ieeeMantissa$518, ieeeExponent$519
  );
  if (small$521 == 0) {
    uint32_t _tmp$1628;
    if (small$521) {
      moonbit_decref(small$521);
    }
    _tmp$1628 = *(uint32_t*)&ieeeExponent$519;
    v$520
    = $moonbitlang$core$double$internal$ryu$d2d(
      ieeeMantissa$518, _tmp$1628
    );
  } else {
    struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _Some$522 =
      small$521;
    struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _f$523 =
      _Some$522;
    struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* x$524 =
      _f$523;
    while (1) {
      struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _tmp$1636 =
        x$524;
      uint64_t _field$1648 = _tmp$1636->$0;
      uint64_t mantissa$1635 = _field$1648;
      uint64_t q$525 = mantissa$1635 / 10ull;
      struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _tmp$1634 =
        x$524;
      uint64_t _field$1647 = _tmp$1634->$0;
      uint64_t mantissa$1632 = _field$1647;
      uint64_t _tmp$1633 = 10ull * q$525;
      uint64_t r$526 = mantissa$1632 - _tmp$1633;
      struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _tmp$1631;
      int32_t _field$1646;
      int32_t exponent$1630;
      int32_t _tmp$1629;
      if (r$526 != 0ull) {
        break;
      }
      _tmp$1631 = x$524;
      _field$1646 = _tmp$1631->$1;
      moonbit_decref(_tmp$1631);
      exponent$1630 = _field$1646;
      _tmp$1629 = exponent$1630 + 1;
      x$524
      = (struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64*)moonbit_malloc(
          sizeof(
            struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64
          )
        );
      Moonbit_object_header(x$524)->meta
      = Moonbit_make_regular_object_header(
        sizeof(
          struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64
        )
        >> 2,
          0,
          0
      );
      x$524->$0 = q$525;
      x$524->$1 = _tmp$1629;
      continue;
      break;
    }
    v$520 = x$524;
  }
  _tmp$1637 = v$520;
  return $moonbitlang$core$double$internal$ryu$to_chars(
           _tmp$1637, ieeeSign$517
         );
}

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* $moonbitlang$core$double$internal$ryu$d2d_small_int(
  uint64_t ieeeMantissa$509,
  int32_t ieeeExponent$511
) {
  uint64_t m2$508 = 4503599627370496ull | ieeeMantissa$509;
  int32_t _tmp$1625 = ieeeExponent$511 - 1023;
  int32_t e2$510 = _tmp$1625 - 52;
  int32_t _tmp$1624;
  uint64_t _tmp$1623;
  uint64_t mask$512;
  uint64_t fraction$513;
  int32_t _tmp$1622;
  uint64_t _tmp$1621;
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _tmp$1620;
  if (e2$510 > 0) {
    return 0;
  }
  if (e2$510 < -52) {
    return 0;
  }
  _tmp$1624 = -e2$510;
  _tmp$1623 = 1ull << (_tmp$1624 & 63);
  mask$512 = _tmp$1623 - 1ull;
  fraction$513 = m2$508 & mask$512;
  if (fraction$513 != 0ull) {
    return 0;
  }
  _tmp$1622 = -e2$510;
  _tmp$1621 = m2$508 >> (_tmp$1622 & 63);
  _tmp$1620
  = (struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64)
    );
  Moonbit_object_header(_tmp$1620)->meta
  = Moonbit_make_regular_object_header(
    sizeof(
      struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64
    )
    >> 2,
      0,
      0
  );
  _tmp$1620->$0 = _tmp$1621;
  _tmp$1620->$1 = 0;
  return _tmp$1620;
}

moonbit_string_t $moonbitlang$core$double$internal$ryu$to_chars(
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* v$482,
  int32_t sign$480
) {
  moonbit_bytes_t result$478 = (moonbit_bytes_t)moonbit_make_bytes(25, 0);
  int32_t index$479 = 0;
  uint64_t output$481;
  uint64_t _tmp$1619;
  int32_t olength$483;
  int32_t _field$1649;
  int32_t exponent$1618;
  int32_t _tmp$1617;
  int32_t exp$484;
  int32_t _tmp$1616;
  int32_t _tmp$1614;
  int32_t scientificNotation$485;
  if (sign$480) {
    int32_t _tmp$1489 = index$479;
    int32_t _tmp$1490;
    if (_tmp$1489 < 0 || _tmp$1489 >= Moonbit_array_length(result$478)) {
      moonbit_panic();
    }
    result$478[_tmp$1489] = 45;
    _tmp$1490 = index$479;
    index$479 = _tmp$1490 + 1;
  }
  output$481 = v$482->$0;
  _tmp$1619 = output$481;
  olength$483
  = $moonbitlang$core$double$internal$ryu$decimal_length17(
    _tmp$1619
  );
  _field$1649 = v$482->$1;
  moonbit_decref(v$482);
  exponent$1618 = _field$1649;
  _tmp$1617 = exponent$1618 + olength$483;
  exp$484 = _tmp$1617 - 1;
  _tmp$1616 = exp$484;
  if (_tmp$1616 >= -6) {
    int32_t _tmp$1615 = exp$484;
    _tmp$1614 = _tmp$1615 < 21;
  } else {
    _tmp$1614 = 0;
  }
  scientificNotation$485 = !_tmp$1614;
  if (scientificNotation$485) {
    int32_t _end41$486 = olength$483 - 1;
    int32_t i$487 = 0;
    int32_t _tmp$1500;
    uint64_t _tmp$1505;
    int32_t _tmp$1504;
    int32_t _tmp$1503;
    int32_t _tmp$1502;
    int32_t _tmp$1501;
    int32_t _tmp$1509;
    int32_t _tmp$1510;
    int32_t _tmp$1511;
    int32_t _tmp$1512;
    int32_t _tmp$1513;
    int32_t _tmp$1519;
    int32_t _tmp$1552;
    while (1) {
      if (i$487 < _end41$486) {
        uint64_t _tmp$1498 = output$481;
        uint64_t c$488 = _tmp$1498 % 10ull;
        uint64_t _tmp$1491 = output$481;
        int32_t _tmp$1497;
        int32_t _tmp$1496;
        int32_t _tmp$1492;
        int32_t _tmp$1495;
        int32_t _tmp$1494;
        int32_t _tmp$1493;
        int32_t _tmp$1499;
        output$481 = _tmp$1491 / 10ull;
        _tmp$1497 = index$479;
        _tmp$1496 = _tmp$1497 + olength$483;
        _tmp$1492 = _tmp$1496 - i$487;
        _tmp$1495 = (int32_t)c$488;
        _tmp$1494 = 48 + _tmp$1495;
        _tmp$1493 = _tmp$1494 & 0xff;
        if (_tmp$1492 < 0 || _tmp$1492 >= Moonbit_array_length(result$478)) {
          moonbit_panic();
        }
        result$478[_tmp$1492] = _tmp$1493;
        _tmp$1499 = i$487 + 1;
        i$487 = _tmp$1499;
        continue;
      }
      break;
    }
    _tmp$1500 = index$479;
    _tmp$1505 = output$481;
    _tmp$1504 = (int32_t)_tmp$1505;
    _tmp$1503 = _tmp$1504 % 10;
    _tmp$1502 = 48 + _tmp$1503;
    _tmp$1501 = _tmp$1502 & 0xff;
    if (_tmp$1500 < 0 || _tmp$1500 >= Moonbit_array_length(result$478)) {
      moonbit_panic();
    }
    result$478[_tmp$1500] = _tmp$1501;
    if (olength$483 > 1) {
      int32_t _tmp$1507 = index$479;
      int32_t _tmp$1506 = _tmp$1507 + 1;
      if (_tmp$1506 < 0 || _tmp$1506 >= Moonbit_array_length(result$478)) {
        moonbit_panic();
      }
      result$478[_tmp$1506] = 46;
    } else {
      int32_t _tmp$1508 = index$479;
      index$479 = _tmp$1508 - 1;
    }
    _tmp$1509 = index$479;
    _tmp$1510 = olength$483 + 1;
    index$479 = _tmp$1509 + _tmp$1510;
    _tmp$1511 = index$479;
    if (_tmp$1511 < 0 || _tmp$1511 >= Moonbit_array_length(result$478)) {
      moonbit_panic();
    }
    result$478[_tmp$1511] = 101;
    _tmp$1512 = index$479;
    index$479 = _tmp$1512 + 1;
    _tmp$1513 = exp$484;
    if (_tmp$1513 < 0) {
      int32_t _tmp$1514 = index$479;
      int32_t _tmp$1515;
      int32_t _tmp$1516;
      if (_tmp$1514 < 0 || _tmp$1514 >= Moonbit_array_length(result$478)) {
        moonbit_panic();
      }
      result$478[_tmp$1514] = 45;
      _tmp$1515 = index$479;
      index$479 = _tmp$1515 + 1;
      _tmp$1516 = exp$484;
      exp$484 = -_tmp$1516;
    } else {
      int32_t _tmp$1517 = index$479;
      int32_t _tmp$1518;
      if (_tmp$1517 < 0 || _tmp$1517 >= Moonbit_array_length(result$478)) {
        moonbit_panic();
      }
      result$478[_tmp$1517] = 43;
      _tmp$1518 = index$479;
      index$479 = _tmp$1518 + 1;
    }
    _tmp$1519 = exp$484;
    if (_tmp$1519 >= 100) {
      int32_t _tmp$1535 = exp$484;
      int32_t a$490 = _tmp$1535 / 100;
      int32_t _tmp$1534 = exp$484;
      int32_t _tmp$1533 = _tmp$1534 / 10;
      int32_t b$491 = _tmp$1533 % 10;
      int32_t _tmp$1532 = exp$484;
      int32_t c$492 = _tmp$1532 % 10;
      int32_t _tmp$1520 = index$479;
      int32_t _tmp$1522 = 48 + a$490;
      int32_t _tmp$1521 = _tmp$1522 & 0xff;
      int32_t _tmp$1526;
      int32_t _tmp$1523;
      int32_t _tmp$1525;
      int32_t _tmp$1524;
      int32_t _tmp$1530;
      int32_t _tmp$1527;
      int32_t _tmp$1529;
      int32_t _tmp$1528;
      int32_t _tmp$1531;
      if (_tmp$1520 < 0 || _tmp$1520 >= Moonbit_array_length(result$478)) {
        moonbit_panic();
      }
      result$478[_tmp$1520] = _tmp$1521;
      _tmp$1526 = index$479;
      _tmp$1523 = _tmp$1526 + 1;
      _tmp$1525 = 48 + b$491;
      _tmp$1524 = _tmp$1525 & 0xff;
      if (_tmp$1523 < 0 || _tmp$1523 >= Moonbit_array_length(result$478)) {
        moonbit_panic();
      }
      result$478[_tmp$1523] = _tmp$1524;
      _tmp$1530 = index$479;
      _tmp$1527 = _tmp$1530 + 2;
      _tmp$1529 = 48 + c$492;
      _tmp$1528 = _tmp$1529 & 0xff;
      if (_tmp$1527 < 0 || _tmp$1527 >= Moonbit_array_length(result$478)) {
        moonbit_panic();
      }
      result$478[_tmp$1527] = _tmp$1528;
      _tmp$1531 = index$479;
      index$479 = _tmp$1531 + 3;
    } else {
      int32_t _tmp$1536 = exp$484;
      if (_tmp$1536 >= 10) {
        int32_t _tmp$1546 = exp$484;
        int32_t a$493 = _tmp$1546 / 10;
        int32_t _tmp$1545 = exp$484;
        int32_t b$494 = _tmp$1545 % 10;
        int32_t _tmp$1537 = index$479;
        int32_t _tmp$1539 = 48 + a$493;
        int32_t _tmp$1538 = _tmp$1539 & 0xff;
        int32_t _tmp$1543;
        int32_t _tmp$1540;
        int32_t _tmp$1542;
        int32_t _tmp$1541;
        int32_t _tmp$1544;
        if (_tmp$1537 < 0 || _tmp$1537 >= Moonbit_array_length(result$478)) {
          moonbit_panic();
        }
        result$478[_tmp$1537] = _tmp$1538;
        _tmp$1543 = index$479;
        _tmp$1540 = _tmp$1543 + 1;
        _tmp$1542 = 48 + b$494;
        _tmp$1541 = _tmp$1542 & 0xff;
        if (_tmp$1540 < 0 || _tmp$1540 >= Moonbit_array_length(result$478)) {
          moonbit_panic();
        }
        result$478[_tmp$1540] = _tmp$1541;
        _tmp$1544 = index$479;
        index$479 = _tmp$1544 + 2;
      } else {
        int32_t _tmp$1547 = index$479;
        int32_t _tmp$1550 = exp$484;
        int32_t _tmp$1549 = 48 + _tmp$1550;
        int32_t _tmp$1548 = _tmp$1549 & 0xff;
        int32_t _tmp$1551;
        if (_tmp$1547 < 0 || _tmp$1547 >= Moonbit_array_length(result$478)) {
          moonbit_panic();
        }
        result$478[_tmp$1547] = _tmp$1548;
        _tmp$1551 = index$479;
        index$479 = _tmp$1551 + 1;
      }
    }
    _tmp$1552 = index$479;
    return $moonbitlang$core$double$internal$ryu$string_from_bytes(
             result$478, 0, _tmp$1552
           );
  } else {
    int32_t _tmp$1553 = exp$484;
    int32_t _tmp$1613;
    if (_tmp$1553 < 0) {
      int32_t _tmp$1554 = index$479;
      int32_t _tmp$1555;
      int32_t _tmp$1556;
      int32_t _tmp$1557;
      int32_t i$495;
      int32_t current$497;
      int32_t i$498;
      if (_tmp$1554 < 0 || _tmp$1554 >= Moonbit_array_length(result$478)) {
        moonbit_panic();
      }
      result$478[_tmp$1554] = 48;
      _tmp$1555 = index$479;
      index$479 = _tmp$1555 + 1;
      _tmp$1556 = index$479;
      if (_tmp$1556 < 0 || _tmp$1556 >= Moonbit_array_length(result$478)) {
        moonbit_panic();
      }
      result$478[_tmp$1556] = 46;
      _tmp$1557 = index$479;
      index$479 = _tmp$1557 + 1;
      i$495 = -1;
      while (1) {
        int32_t _tmp$1558 = exp$484;
        if (i$495 > _tmp$1558) {
          int32_t _tmp$1559 = index$479;
          int32_t _tmp$1560;
          int32_t _tmp$1561;
          if (_tmp$1559 < 0 || _tmp$1559 >= Moonbit_array_length(result$478)) {
            moonbit_panic();
          }
          result$478[_tmp$1559] = 48;
          _tmp$1560 = index$479;
          index$479 = _tmp$1560 + 1;
          _tmp$1561 = i$495 - 1;
          i$495 = _tmp$1561;
          continue;
        }
        break;
      }
      current$497 = index$479;
      i$498 = 0;
      while (1) {
        if (i$498 < olength$483) {
          int32_t _tmp$1569 = current$497 + olength$483;
          int32_t _tmp$1568 = _tmp$1569 - i$498;
          int32_t _tmp$1562 = _tmp$1568 - 1;
          uint64_t _tmp$1567 = output$481;
          uint64_t _tmp$1566 = _tmp$1567 % 10ull;
          int32_t _tmp$1565 = (int32_t)_tmp$1566;
          int32_t _tmp$1564 = 48 + _tmp$1565;
          int32_t _tmp$1563 = _tmp$1564 & 0xff;
          uint64_t _tmp$1570;
          int32_t _tmp$1571;
          int32_t _tmp$1572;
          if (_tmp$1562 < 0 || _tmp$1562 >= Moonbit_array_length(result$478)) {
            moonbit_panic();
          }
          result$478[_tmp$1562] = _tmp$1563;
          _tmp$1570 = output$481;
          output$481 = _tmp$1570 / 10ull;
          _tmp$1571 = index$479;
          index$479 = _tmp$1571 + 1;
          _tmp$1572 = i$498 + 1;
          i$498 = _tmp$1572;
          continue;
        }
        break;
      }
    } else {
      int32_t _tmp$1574 = exp$484;
      int32_t _tmp$1573 = _tmp$1574 + 1;
      if (_tmp$1573 >= olength$483) {
        int32_t i$500 = 0;
        int32_t _tmp$1586;
        int32_t _tmp$1590;
        int32_t _end64$502;
        int32_t i$503;
        while (1) {
          if (i$500 < olength$483) {
            int32_t _tmp$1583 = index$479;
            int32_t _tmp$1582 = _tmp$1583 + olength$483;
            int32_t _tmp$1581 = _tmp$1582 - i$500;
            int32_t _tmp$1575 = _tmp$1581 - 1;
            uint64_t _tmp$1580 = output$481;
            uint64_t _tmp$1579 = _tmp$1580 % 10ull;
            int32_t _tmp$1578 = (int32_t)_tmp$1579;
            int32_t _tmp$1577 = 48 + _tmp$1578;
            int32_t _tmp$1576 = _tmp$1577 & 0xff;
            uint64_t _tmp$1584;
            int32_t _tmp$1585;
            if (
              _tmp$1575 < 0 || _tmp$1575 >= Moonbit_array_length(result$478)
            ) {
              moonbit_panic();
            }
            result$478[_tmp$1575] = _tmp$1576;
            _tmp$1584 = output$481;
            output$481 = _tmp$1584 / 10ull;
            _tmp$1585 = i$500 + 1;
            i$500 = _tmp$1585;
            continue;
          }
          break;
        }
        _tmp$1586 = index$479;
        index$479 = _tmp$1586 + olength$483;
        _tmp$1590 = exp$484;
        _end64$502 = _tmp$1590 + 1;
        i$503 = olength$483;
        while (1) {
          if (i$503 < _end64$502) {
            int32_t _tmp$1587 = index$479;
            int32_t _tmp$1588;
            int32_t _tmp$1589;
            if (
              _tmp$1587 < 0 || _tmp$1587 >= Moonbit_array_length(result$478)
            ) {
              moonbit_panic();
            }
            result$478[_tmp$1587] = 48;
            _tmp$1588 = index$479;
            index$479 = _tmp$1588 + 1;
            _tmp$1589 = i$503 + 1;
            i$503 = _tmp$1589;
            continue;
          }
          break;
        }
      } else {
        int32_t _tmp$1612 = index$479;
        int32_t current$505 = _tmp$1612 + 1;
        int32_t i$506 = 0;
        int32_t _tmp$1610;
        int32_t _tmp$1611;
        while (1) {
          if (i$506 < olength$483) {
            int32_t _tmp$1593 = olength$483 - i$506;
            int32_t _tmp$1591 = _tmp$1593 - 1;
            int32_t _tmp$1592 = exp$484;
            int32_t _tmp$1607;
            int32_t _tmp$1606;
            int32_t _tmp$1605;
            int32_t _tmp$1599;
            uint64_t _tmp$1604;
            uint64_t _tmp$1603;
            int32_t _tmp$1602;
            int32_t _tmp$1601;
            int32_t _tmp$1600;
            uint64_t _tmp$1608;
            int32_t _tmp$1609;
            if (_tmp$1591 == _tmp$1592) {
              int32_t _tmp$1597 = current$505;
              int32_t _tmp$1596 = _tmp$1597 + olength$483;
              int32_t _tmp$1595 = _tmp$1596 - i$506;
              int32_t _tmp$1594 = _tmp$1595 - 1;
              int32_t _tmp$1598;
              if (
                _tmp$1594 < 0
                || _tmp$1594 >= Moonbit_array_length(result$478)
              ) {
                moonbit_panic();
              }
              result$478[_tmp$1594] = 46;
              _tmp$1598 = current$505;
              current$505 = _tmp$1598 - 1;
            }
            _tmp$1607 = current$505;
            _tmp$1606 = _tmp$1607 + olength$483;
            _tmp$1605 = _tmp$1606 - i$506;
            _tmp$1599 = _tmp$1605 - 1;
            _tmp$1604 = output$481;
            _tmp$1603 = _tmp$1604 % 10ull;
            _tmp$1602 = (int32_t)_tmp$1603;
            _tmp$1601 = 48 + _tmp$1602;
            _tmp$1600 = _tmp$1601 & 0xff;
            if (
              _tmp$1599 < 0 || _tmp$1599 >= Moonbit_array_length(result$478)
            ) {
              moonbit_panic();
            }
            result$478[_tmp$1599] = _tmp$1600;
            _tmp$1608 = output$481;
            output$481 = _tmp$1608 / 10ull;
            _tmp$1609 = i$506 + 1;
            i$506 = _tmp$1609;
            continue;
          }
          break;
        }
        _tmp$1610 = index$479;
        _tmp$1611 = olength$483 + 1;
        index$479 = _tmp$1610 + _tmp$1611;
      }
    }
    _tmp$1613 = index$479;
    return $moonbitlang$core$double$internal$ryu$string_from_bytes(
             result$478, 0, _tmp$1613
           );
  }
}

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* $moonbitlang$core$double$internal$ryu$d2d(
  uint64_t ieeeMantissa$424,
  uint32_t ieeeExponent$423
) {
  int32_t e2$421 = 0;
  uint64_t m2$422 = 0ull;
  uint64_t _tmp$1488;
  uint64_t _tmp$1487;
  int32_t even$425;
  uint64_t _tmp$1486;
  uint64_t mv$426;
  int32_t mmShift$427;
  uint64_t vr$428;
  uint64_t vp$429;
  uint64_t vm$430;
  int32_t e10$431;
  int32_t vmIsTrailingZeros$432;
  int32_t vrIsTrailingZeros$433;
  int32_t _tmp$1378;
  int32_t removed$452;
  int32_t lastRemovedDigit$453;
  uint64_t output$454;
  int32_t _tmp$1484;
  int32_t _tmp$1485;
  int32_t exp$477;
  uint64_t _tmp$1483;
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _block$1752;
  if (ieeeExponent$423 == 0u) {
    e2$421 = -1076;
    m2$422 = ieeeMantissa$424;
  } else {
    int32_t _tmp$1377 = *(int32_t*)&ieeeExponent$423;
    int32_t _tmp$1376 = _tmp$1377 - 1023;
    int32_t _tmp$1375 = _tmp$1376 - 52;
    e2$421 = _tmp$1375 - 2;
    m2$422 = 4503599627370496ull | ieeeMantissa$424;
  }
  _tmp$1488 = m2$422;
  _tmp$1487 = _tmp$1488 & 1ull;
  even$425 = _tmp$1487 == 0ull;
  _tmp$1486 = m2$422;
  mv$426 = 4ull * _tmp$1486;
  mmShift$427 = ieeeMantissa$424 != 0ull || ieeeExponent$423 <= 1u;
  vr$428 = 0ull;
  vp$429 = 0ull;
  vm$430 = 0ull;
  e10$431 = 0;
  vmIsTrailingZeros$432 = 0;
  vrIsTrailingZeros$433 = 0;
  _tmp$1378 = e2$421;
  if (_tmp$1378 >= 0) {
    int32_t _p$738 = e2$421;
    int32_t _tmp$1404 = _p$738 * 78913;
    uint32_t _tmp$1403 = *(uint32_t*)&_tmp$1404;
    uint32_t _tmp$1402 = _tmp$1403 >> 18;
    int32_t _tmp$1399 = *(int32_t*)&_tmp$1402;
    int32_t _tmp$1401 = e2$421;
    int32_t _p$741 = _tmp$1401 > 3;
    int32_t _tmp$1400;
    int32_t q$434;
    int32_t _tmp$1398;
    uint32_t _tmp$1397;
    uint32_t _tmp$1396;
    int32_t _tmp$1395;
    int32_t _tmp$1394;
    int32_t _tmp$1393;
    int32_t k$435;
    int32_t _tmp$1392;
    int32_t _tmp$1391;
    int32_t _tmp$1390;
    int32_t i$436;
    struct $$moonbitlang$core$double$internal$ryu$Pow5Pair pow5$437;
    uint64_t _tmp$1389;
    struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result _bind$438;
    uint64_t _vrOut$439;
    uint64_t _vpOut$440;
    uint64_t _vmOut$441;
    if (_p$741) {
      _tmp$1400 = 1;
    } else {
      _tmp$1400 = 0;
    }
    q$434 = _tmp$1399 - _tmp$1400;
    e10$431 = q$434;
    _tmp$1398 = q$434 * 1217359;
    _tmp$1397 = *(uint32_t*)&_tmp$1398;
    _tmp$1396 = _tmp$1397 >> 19;
    _tmp$1395 = *(int32_t*)&_tmp$1396;
    _tmp$1394 = _tmp$1395 + 1;
    _tmp$1393 = 125 + _tmp$1394;
    k$435 = _tmp$1393 - 1;
    _tmp$1392 = e2$421;
    _tmp$1391 = -_tmp$1392;
    _tmp$1390 = _tmp$1391 + q$434;
    i$436 = _tmp$1390 + k$435;
    pow5$437
    = $moonbitlang$core$double$internal$ryu$double_computeInvPow5(
      q$434
    );
    _tmp$1389 = m2$422;
    _bind$438
    = $moonbitlang$core$double$internal$ryu$mulShiftAll64(
      _tmp$1389, pow5$437, i$436, mmShift$427
    );
    _vrOut$439 = _bind$438.$0;
    _vpOut$440 = _bind$438.$1;
    _vmOut$441 = _bind$438.$2;
    vr$428 = _vrOut$439;
    vp$429 = _vpOut$440;
    vm$430 = _vmOut$441;
    if (q$434 <= 21) {
      int32_t _tmp$1385 = (int32_t)mv$426;
      uint64_t _tmp$1388 = mv$426 / 5ull;
      int32_t _tmp$1387 = (int32_t)_tmp$1388;
      int32_t _tmp$1386 = 5 * _tmp$1387;
      int32_t mvMod5$442 = _tmp$1385 - _tmp$1386;
      if (mvMod5$442 == 0) {
        vrIsTrailingZeros$433
        = $moonbitlang$core$double$internal$ryu$multipleOfPowerOf5(
          mv$426, q$434
        );
      } else if (even$425) {
        uint64_t _tmp$1380 = mv$426 - 1ull;
        uint64_t _tmp$1381;
        uint64_t _tmp$1379;
        if (mmShift$427) {
          _tmp$1381 = 1ull;
        } else {
          _tmp$1381 = 0ull;
        }
        _tmp$1379 = _tmp$1380 - _tmp$1381;
        vmIsTrailingZeros$432
        = $moonbitlang$core$double$internal$ryu$multipleOfPowerOf5(
          _tmp$1379, q$434
        );
      } else {
        uint64_t _tmp$1382 = vp$429;
        uint64_t _tmp$1384 = mv$426 + 2ull;
        int32_t _p$748 =
          $moonbitlang$core$double$internal$ryu$multipleOfPowerOf5(
            _tmp$1384, q$434
          );
        uint64_t _tmp$1383;
        if (_p$748) {
          _tmp$1383 = 1ull;
        } else {
          _tmp$1383 = 0ull;
        }
        vp$429 = _tmp$1382 - _tmp$1383;
      }
    }
  } else {
    int32_t _tmp$1426 = e2$421;
    int32_t _p$751 = -_tmp$1426;
    int32_t _tmp$1425 = _p$751 * 732923;
    uint32_t _tmp$1424 = *(uint32_t*)&_tmp$1425;
    uint32_t _tmp$1423 = _tmp$1424 >> 20;
    int32_t _tmp$1419 = *(int32_t*)&_tmp$1423;
    int32_t _tmp$1422 = e2$421;
    int32_t _tmp$1421 = -_tmp$1422;
    int32_t _p$754 = _tmp$1421 > 1;
    int32_t _tmp$1420;
    int32_t q$443;
    int32_t _tmp$1405;
    int32_t _tmp$1418;
    int32_t _tmp$1417;
    int32_t i$444;
    int32_t _tmp$1416;
    uint32_t _tmp$1415;
    uint32_t _tmp$1414;
    int32_t _tmp$1413;
    int32_t _tmp$1412;
    int32_t k$445;
    int32_t j$446;
    struct $$moonbitlang$core$double$internal$ryu$Pow5Pair pow5$447;
    uint64_t _tmp$1411;
    struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result _bind$448;
    uint64_t _vrOut$449;
    uint64_t _vpOut$450;
    uint64_t _vmOut$451;
    if (_p$754) {
      _tmp$1420 = 1;
    } else {
      _tmp$1420 = 0;
    }
    q$443 = _tmp$1419 - _tmp$1420;
    _tmp$1405 = e2$421;
    e10$431 = q$443 + _tmp$1405;
    _tmp$1418 = e2$421;
    _tmp$1417 = -_tmp$1418;
    i$444 = _tmp$1417 - q$443;
    _tmp$1416 = i$444 * 1217359;
    _tmp$1415 = *(uint32_t*)&_tmp$1416;
    _tmp$1414 = _tmp$1415 >> 19;
    _tmp$1413 = *(int32_t*)&_tmp$1414;
    _tmp$1412 = _tmp$1413 + 1;
    k$445 = _tmp$1412 - 125;
    j$446 = q$443 - k$445;
    pow5$447
    = $moonbitlang$core$double$internal$ryu$double_computePow5(
      i$444
    );
    _tmp$1411 = m2$422;
    _bind$448
    = $moonbitlang$core$double$internal$ryu$mulShiftAll64(
      _tmp$1411, pow5$447, j$446, mmShift$427
    );
    _vrOut$449 = _bind$448.$0;
    _vpOut$450 = _bind$448.$1;
    _vmOut$451 = _bind$448.$2;
    vr$428 = _vrOut$449;
    vp$429 = _vpOut$450;
    vm$430 = _vmOut$451;
    if (q$443 <= 1) {
      vrIsTrailingZeros$433 = 1;
      if (even$425) {
        int32_t _tmp$1406;
        if (mmShift$427) {
          _tmp$1406 = 1;
        } else {
          _tmp$1406 = 0;
        }
        vmIsTrailingZeros$432 = _tmp$1406 == 1;
      } else {
        uint64_t _tmp$1407 = vp$429;
        vp$429 = _tmp$1407 - 1ull;
      }
    } else if (q$443 < 63) {
      uint64_t _tmp$1410 = 1ull << (q$443 & 63);
      uint64_t _tmp$1409 = _tmp$1410 - 1ull;
      uint64_t _tmp$1408 = mv$426 & _tmp$1409;
      vrIsTrailingZeros$433 = _tmp$1408 == 0ull;
    }
  }
  removed$452 = 0;
  lastRemovedDigit$453 = 0;
  output$454 = 0ull;
  if (vmIsTrailingZeros$432 || vrIsTrailingZeros$433) {
    int32_t _if_result$1749;
    uint64_t _tmp$1456;
    uint64_t _tmp$1461;
    uint64_t _tmp$1462;
    int32_t _if_result$1750;
    int32_t _p$763;
    int64_t _tmp$1458;
    uint64_t _tmp$1457;
    while (1) {
      uint64_t _tmp$1439 = vp$429;
      uint64_t vpDiv10$455 = _tmp$1439 / 10ull;
      uint64_t _tmp$1438 = vm$430;
      uint64_t vmDiv10$456 = _tmp$1438 / 10ull;
      uint64_t _tmp$1437;
      int32_t _tmp$1434;
      int32_t _tmp$1436;
      int32_t _tmp$1435;
      int32_t vmMod10$458;
      uint64_t _tmp$1433;
      uint64_t vrDiv10$459;
      uint64_t _tmp$1432;
      int32_t _tmp$1429;
      int32_t _tmp$1431;
      int32_t _tmp$1430;
      int32_t vrMod10$460;
      int32_t _tmp$1428;
      if (vpDiv10$455 <= vmDiv10$456) {
        break;
      }
      _tmp$1437 = vm$430;
      _tmp$1434 = (int32_t)_tmp$1437;
      _tmp$1436 = (int32_t)vmDiv10$456;
      _tmp$1435 = 10 * _tmp$1436;
      vmMod10$458 = _tmp$1434 - _tmp$1435;
      _tmp$1433 = vr$428;
      vrDiv10$459 = _tmp$1433 / 10ull;
      _tmp$1432 = vr$428;
      _tmp$1429 = (int32_t)_tmp$1432;
      _tmp$1431 = (int32_t)vrDiv10$459;
      _tmp$1430 = 10 * _tmp$1431;
      vrMod10$460 = _tmp$1429 - _tmp$1430;
      vmIsTrailingZeros$432 = vmIsTrailingZeros$432 && vmMod10$458 == 0;
      if (vrIsTrailingZeros$433) {
        int32_t _tmp$1427 = lastRemovedDigit$453;
        vrIsTrailingZeros$433 = _tmp$1427 == 0;
      } else {
        vrIsTrailingZeros$433 = 0;
      }
      lastRemovedDigit$453 = vrMod10$460;
      vr$428 = vrDiv10$459;
      vp$429 = vpDiv10$455;
      vm$430 = vmDiv10$456;
      _tmp$1428 = removed$452;
      removed$452 = _tmp$1428 + 1;
      continue;
      break;
    }
    if (vmIsTrailingZeros$432) {
      while (1) {
        uint64_t _tmp$1452 = vm$430;
        uint64_t vmDiv10$461 = _tmp$1452 / 10ull;
        uint64_t _tmp$1451 = vm$430;
        int32_t _tmp$1448 = (int32_t)_tmp$1451;
        int32_t _tmp$1450 = (int32_t)vmDiv10$461;
        int32_t _tmp$1449 = 10 * _tmp$1450;
        int32_t vmMod10$462 = _tmp$1448 - _tmp$1449;
        uint64_t _tmp$1447;
        uint64_t vpDiv10$464;
        uint64_t _tmp$1446;
        uint64_t vrDiv10$465;
        uint64_t _tmp$1445;
        int32_t _tmp$1442;
        int32_t _tmp$1444;
        int32_t _tmp$1443;
        int32_t vrMod10$466;
        int32_t _tmp$1441;
        if (vmMod10$462 != 0) {
          break;
        }
        _tmp$1447 = vp$429;
        vpDiv10$464 = _tmp$1447 / 10ull;
        _tmp$1446 = vr$428;
        vrDiv10$465 = _tmp$1446 / 10ull;
        _tmp$1445 = vr$428;
        _tmp$1442 = (int32_t)_tmp$1445;
        _tmp$1444 = (int32_t)vrDiv10$465;
        _tmp$1443 = 10 * _tmp$1444;
        vrMod10$466 = _tmp$1442 - _tmp$1443;
        if (vrIsTrailingZeros$433) {
          int32_t _tmp$1440 = lastRemovedDigit$453;
          vrIsTrailingZeros$433 = _tmp$1440 == 0;
        } else {
          vrIsTrailingZeros$433 = 0;
        }
        lastRemovedDigit$453 = vrMod10$466;
        vr$428 = vrDiv10$465;
        vp$429 = vpDiv10$464;
        vm$430 = vmDiv10$461;
        _tmp$1441 = removed$452;
        removed$452 = _tmp$1441 + 1;
        continue;
        break;
      }
    }
    if (vrIsTrailingZeros$433) {
      int32_t _tmp$1455 = lastRemovedDigit$453;
      if (_tmp$1455 == 5) {
        uint64_t _tmp$1454 = vr$428;
        uint64_t _tmp$1453 = _tmp$1454 % 2ull;
        _if_result$1749 = _tmp$1453 == 0ull;
      } else {
        _if_result$1749 = 0;
      }
    } else {
      _if_result$1749 = 0;
    }
    if (_if_result$1749) {
      lastRemovedDigit$453 = 4;
    }
    _tmp$1456 = vr$428;
    _tmp$1461 = vr$428;
    _tmp$1462 = vm$430;
    if (_tmp$1461 == _tmp$1462) {
      if (!even$425) {
        _if_result$1750 = 1;
      } else {
        int32_t _tmp$1460 = vmIsTrailingZeros$432;
        _if_result$1750 = !_tmp$1460;
      }
    } else {
      _if_result$1750 = 0;
    }
    if (_if_result$1750) {
      _p$763 = 1;
    } else {
      int32_t _tmp$1459 = lastRemovedDigit$453;
      _p$763 = _tmp$1459 >= 5;
    }
    if (_p$763) {
      _tmp$1458 = 1ll;
    } else {
      _tmp$1458 = 0ll;
    }
    _tmp$1457 = *(uint64_t*)&_tmp$1458;
    output$454 = _tmp$1456 + _tmp$1457;
  } else {
    int32_t roundUp$467 = 0;
    uint64_t _tmp$1482 = vp$429;
    uint64_t vpDiv100$468 = _tmp$1482 / 100ull;
    uint64_t _tmp$1481 = vm$430;
    uint64_t vmDiv100$469 = _tmp$1481 / 100ull;
    uint64_t _tmp$1477;
    uint64_t _tmp$1479;
    uint64_t _tmp$1480;
    int32_t _p$766;
    uint64_t _tmp$1478;
    if (vpDiv100$468 > vmDiv100$469) {
      uint64_t _tmp$1468 = vr$428;
      uint64_t vrDiv100$470 = _tmp$1468 / 100ull;
      uint64_t _tmp$1467 = vr$428;
      int32_t _tmp$1464 = (int32_t)_tmp$1467;
      int32_t _tmp$1466 = (int32_t)vrDiv100$470;
      int32_t _tmp$1465 = 100 * _tmp$1466;
      int32_t vrMod100$471 = _tmp$1464 - _tmp$1465;
      int32_t _tmp$1463;
      roundUp$467 = vrMod100$471 >= 50;
      vr$428 = vrDiv100$470;
      vp$429 = vpDiv100$468;
      vm$430 = vmDiv100$469;
      _tmp$1463 = removed$452;
      removed$452 = _tmp$1463 + 2;
    }
    while (1) {
      uint64_t _tmp$1476 = vp$429;
      uint64_t vpDiv10$472 = _tmp$1476 / 10ull;
      uint64_t _tmp$1475 = vm$430;
      uint64_t vmDiv10$473 = _tmp$1475 / 10ull;
      uint64_t _tmp$1474;
      uint64_t vrDiv10$475;
      uint64_t _tmp$1473;
      int32_t _tmp$1470;
      int32_t _tmp$1472;
      int32_t _tmp$1471;
      int32_t vrMod10$476;
      int32_t _tmp$1469;
      if (vpDiv10$472 <= vmDiv10$473) {
        break;
      }
      _tmp$1474 = vr$428;
      vrDiv10$475 = _tmp$1474 / 10ull;
      _tmp$1473 = vr$428;
      _tmp$1470 = (int32_t)_tmp$1473;
      _tmp$1472 = (int32_t)vrDiv10$475;
      _tmp$1471 = 10 * _tmp$1472;
      vrMod10$476 = _tmp$1470 - _tmp$1471;
      roundUp$467 = vrMod10$476 >= 5;
      vr$428 = vrDiv10$475;
      vp$429 = vpDiv10$472;
      vm$430 = vmDiv10$473;
      _tmp$1469 = removed$452;
      removed$452 = _tmp$1469 + 1;
      continue;
      break;
    }
    _tmp$1477 = vr$428;
    _tmp$1479 = vr$428;
    _tmp$1480 = vm$430;
    _p$766 = _tmp$1479 == _tmp$1480 || roundUp$467;
    if (_p$766) {
      _tmp$1478 = 1ull;
    } else {
      _tmp$1478 = 0ull;
    }
    output$454 = _tmp$1477 + _tmp$1478;
  }
  _tmp$1484 = e10$431;
  _tmp$1485 = removed$452;
  exp$477 = _tmp$1484 + _tmp$1485;
  _tmp$1483 = output$454;
  _block$1752
  = (struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64)
    );
  Moonbit_object_header(_block$1752)->meta
  = Moonbit_make_regular_object_header(
    sizeof(
      struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64
    )
    >> 2,
      0,
      0
  );
  _block$1752->$0 = _tmp$1483;
  _block$1752->$1 = exp$477;
  return _block$1752;
}

int32_t $moonbitlang$core$double$internal$ryu$decimal_length17(
  uint64_t v$420
) {
  if (v$420 >= 10000000000000000ull) {
    return 17;
  }
  if (v$420 >= 1000000000000000ull) {
    return 16;
  }
  if (v$420 >= 100000000000000ull) {
    return 15;
  }
  if (v$420 >= 10000000000000ull) {
    return 14;
  }
  if (v$420 >= 1000000000000ull) {
    return 13;
  }
  if (v$420 >= 100000000000ull) {
    return 12;
  }
  if (v$420 >= 10000000000ull) {
    return 11;
  }
  if (v$420 >= 1000000000ull) {
    return 10;
  }
  if (v$420 >= 100000000ull) {
    return 9;
  }
  if (v$420 >= 10000000ull) {
    return 8;
  }
  if (v$420 >= 1000000ull) {
    return 7;
  }
  if (v$420 >= 100000ull) {
    return 6;
  }
  if (v$420 >= 10000ull) {
    return 5;
  }
  if (v$420 >= 1000ull) {
    return 4;
  }
  if (v$420 >= 100ull) {
    return 3;
  }
  if (v$420 >= 10ull) {
    return 2;
  }
  return 1;
}

struct $$moonbitlang$core$double$internal$ryu$Pow5Pair $moonbitlang$core$double$internal$ryu$double_computeInvPow5(
  int32_t i$403
) {
  int32_t _tmp$1374 = i$403 + 26;
  int32_t _tmp$1373 = _tmp$1374 - 1;
  int32_t base$402 = _tmp$1373 / 26;
  int32_t base2$404 = base$402 * 26;
  int32_t offset$405 = base2$404 - i$403;
  int32_t _p$715 = base$402 * 2;
  uint64_t* _tmp$1372;
  uint64_t _tmp$1653;
  uint64_t mul0$406;
  int32_t _tmp$1371;
  int32_t _p$718;
  uint64_t* _tmp$1370;
  uint64_t _tmp$1652;
  uint64_t mul1$407;
  uint64_t* _tmp$1369;
  uint64_t _tmp$1651;
  uint64_t m$408;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$409;
  uint64_t _low1$410;
  uint64_t _high1$411;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$412;
  uint64_t _low0$413;
  uint64_t _high0$414;
  uint64_t sum$415;
  uint64_t high1$416;
  int32_t _tmp$1368;
  uint32_t _tmp$1367;
  uint32_t _tmp$1366;
  int32_t _tmp$1365;
  int32_t _tmp$1359;
  int32_t _tmp$1364;
  uint32_t _tmp$1363;
  uint32_t _tmp$1362;
  int32_t _tmp$1361;
  int32_t _tmp$1360;
  int32_t delta$417;
  int32_t _tmp$1358;
  uint64_t _tmp$1356;
  uint64_t _tmp$1357;
  uint64_t _tmp$1355;
  uint64_t _tmp$1348;
  int32_t _p$729;
  uint32_t* _tmp$1354;
  uint32_t _tmp$1650;
  uint32_t _tmp$1351;
  int32_t _tmp$1353;
  int32_t _tmp$1352;
  uint32_t _tmp$1350;
  uint32_t _p$732;
  uint64_t _tmp$1349;
  uint64_t a$418;
  uint64_t _p$735;
  int32_t _tmp$1347;
  uint64_t _tmp$1345;
  uint64_t _tmp$1346;
  uint64_t b$419;
  moonbit_incref(
    $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_INV_SPLIT2
  );
  _tmp$1372 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_INV_SPLIT2;
  if (_p$715 < 0 || _p$715 >= Moonbit_array_length(_tmp$1372)) {
    moonbit_panic();
  }
  _tmp$1653 = (uint64_t)_tmp$1372[_p$715];
  moonbit_decref(_tmp$1372);
  mul0$406 = _tmp$1653;
  _tmp$1371 = base$402 * 2;
  _p$718 = _tmp$1371 + 1;
  moonbit_incref(
    $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_INV_SPLIT2
  );
  _tmp$1370 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_INV_SPLIT2;
  if (_p$718 < 0 || _p$718 >= Moonbit_array_length(_tmp$1370)) {
    moonbit_panic();
  }
  _tmp$1652 = (uint64_t)_tmp$1370[_p$718];
  moonbit_decref(_tmp$1370);
  mul1$407 = _tmp$1652;
  if (offset$405 == 0) {
    return (struct $$moonbitlang$core$double$internal$ryu$Pow5Pair){
             mul0$406, mul1$407
           };
  }
  moonbit_incref($moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_TABLE);
  _tmp$1369 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_TABLE;
  if (offset$405 < 0 || offset$405 >= Moonbit_array_length(_tmp$1369)) {
    moonbit_panic();
  }
  _tmp$1651 = (uint64_t)_tmp$1369[offset$405];
  moonbit_decref(_tmp$1369);
  m$408 = _tmp$1651;
  _bind$409 = $moonbitlang$core$double$internal$ryu$umul128(m$408, mul1$407);
  _low1$410 = _bind$409.$0;
  _high1$411 = _bind$409.$1;
  _bind$412 = $moonbitlang$core$double$internal$ryu$umul128(m$408, mul0$406);
  _low0$413 = _bind$412.$0;
  _high0$414 = _bind$412.$1;
  sum$415 = _high0$414 + _low1$410;
  high1$416 = _high1$411;
  if (sum$415 < _high0$414) {
    uint64_t _tmp$1344 = high1$416;
    high1$416 = _tmp$1344 + 1ull;
  }
  _tmp$1368 = base2$404 * 1217359;
  _tmp$1367 = *(uint32_t*)&_tmp$1368;
  _tmp$1366 = _tmp$1367 >> 19;
  _tmp$1365 = *(int32_t*)&_tmp$1366;
  _tmp$1359 = _tmp$1365 + 1;
  _tmp$1364 = i$403 * 1217359;
  _tmp$1363 = *(uint32_t*)&_tmp$1364;
  _tmp$1362 = _tmp$1363 >> 19;
  _tmp$1361 = *(int32_t*)&_tmp$1362;
  _tmp$1360 = _tmp$1361 + 1;
  delta$417 = _tmp$1359 - _tmp$1360;
  _tmp$1358 = 64 - delta$417;
  _tmp$1356 = sum$415 << (_tmp$1358 & 63);
  _tmp$1357 = _low0$413 >> (delta$417 & 63);
  _tmp$1355 = _tmp$1356 | _tmp$1357;
  _tmp$1348 = _tmp$1355 + 1ull;
  _p$729 = i$403 / 16;
  moonbit_incref($moonbitlang$core$double$internal$ryu$gPOW5_INV_OFFSETS);
  _tmp$1354 = $moonbitlang$core$double$internal$ryu$gPOW5_INV_OFFSETS;
  if (_p$729 < 0 || _p$729 >= Moonbit_array_length(_tmp$1354)) {
    moonbit_panic();
  }
  _tmp$1650 = (uint32_t)_tmp$1354[_p$729];
  moonbit_decref(_tmp$1354);
  _tmp$1351 = _tmp$1650;
  _tmp$1353 = i$403 % 16;
  _tmp$1352 = _tmp$1353 << 1;
  _tmp$1350 = _tmp$1351 >> (_tmp$1352 & 31);
  _p$732 = _tmp$1350 & 3u;
  _tmp$1349 = (uint64_t)_p$732;
  a$418 = _tmp$1348 + _tmp$1349;
  _p$735 = high1$416;
  _tmp$1347 = 64 - delta$417;
  _tmp$1345 = _p$735 << (_tmp$1347 & 63);
  _tmp$1346 = sum$415 >> (delta$417 & 63);
  b$419 = _tmp$1345 | _tmp$1346;
  return (struct $$moonbitlang$core$double$internal$ryu$Pow5Pair){
           a$418, b$419
         };
}

struct $$moonbitlang$core$double$internal$ryu$Pow5Pair $moonbitlang$core$double$internal$ryu$double_computePow5(
  int32_t i$385
) {
  int32_t base$384 = i$385 / 26;
  int32_t base2$386 = base$384 * 26;
  int32_t offset$387 = i$385 - base2$386;
  int32_t _p$692 = base$384 * 2;
  uint64_t* _tmp$1343;
  uint64_t _tmp$1657;
  uint64_t mul0$388;
  int32_t _tmp$1342;
  int32_t _p$695;
  uint64_t* _tmp$1341;
  uint64_t _tmp$1656;
  uint64_t mul1$389;
  uint64_t* _tmp$1340;
  uint64_t _tmp$1655;
  uint64_t m$390;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$391;
  uint64_t _low1$392;
  uint64_t _high1$393;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$394;
  uint64_t _low0$395;
  uint64_t _high0$396;
  uint64_t sum$397;
  uint64_t high1$398;
  int32_t _tmp$1339;
  uint32_t _tmp$1338;
  uint32_t _tmp$1337;
  int32_t _tmp$1336;
  int32_t _tmp$1330;
  int32_t _tmp$1335;
  uint32_t _tmp$1334;
  uint32_t _tmp$1333;
  int32_t _tmp$1332;
  int32_t _tmp$1331;
  int32_t delta$399;
  int32_t _tmp$1329;
  uint64_t _tmp$1327;
  uint64_t _tmp$1328;
  uint64_t _tmp$1320;
  int32_t _p$706;
  uint32_t* _tmp$1326;
  uint32_t _tmp$1654;
  uint32_t _tmp$1323;
  int32_t _tmp$1325;
  int32_t _tmp$1324;
  uint32_t _tmp$1322;
  uint32_t _p$709;
  uint64_t _tmp$1321;
  uint64_t a$400;
  uint64_t _p$712;
  int32_t _tmp$1319;
  uint64_t _tmp$1317;
  uint64_t _tmp$1318;
  uint64_t b$401;
  moonbit_incref($moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_SPLIT2);
  _tmp$1343 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_SPLIT2;
  if (_p$692 < 0 || _p$692 >= Moonbit_array_length(_tmp$1343)) {
    moonbit_panic();
  }
  _tmp$1657 = (uint64_t)_tmp$1343[_p$692];
  moonbit_decref(_tmp$1343);
  mul0$388 = _tmp$1657;
  _tmp$1342 = base$384 * 2;
  _p$695 = _tmp$1342 + 1;
  moonbit_incref($moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_SPLIT2);
  _tmp$1341 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_SPLIT2;
  if (_p$695 < 0 || _p$695 >= Moonbit_array_length(_tmp$1341)) {
    moonbit_panic();
  }
  _tmp$1656 = (uint64_t)_tmp$1341[_p$695];
  moonbit_decref(_tmp$1341);
  mul1$389 = _tmp$1656;
  if (offset$387 == 0) {
    return (struct $$moonbitlang$core$double$internal$ryu$Pow5Pair){
             mul0$388, mul1$389
           };
  }
  moonbit_incref($moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_TABLE);
  _tmp$1340 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_TABLE;
  if (offset$387 < 0 || offset$387 >= Moonbit_array_length(_tmp$1340)) {
    moonbit_panic();
  }
  _tmp$1655 = (uint64_t)_tmp$1340[offset$387];
  moonbit_decref(_tmp$1340);
  m$390 = _tmp$1655;
  _bind$391 = $moonbitlang$core$double$internal$ryu$umul128(m$390, mul1$389);
  _low1$392 = _bind$391.$0;
  _high1$393 = _bind$391.$1;
  _bind$394 = $moonbitlang$core$double$internal$ryu$umul128(m$390, mul0$388);
  _low0$395 = _bind$394.$0;
  _high0$396 = _bind$394.$1;
  sum$397 = _high0$396 + _low1$392;
  high1$398 = _high1$393;
  if (sum$397 < _high0$396) {
    uint64_t _tmp$1316 = high1$398;
    high1$398 = _tmp$1316 + 1ull;
  }
  _tmp$1339 = i$385 * 1217359;
  _tmp$1338 = *(uint32_t*)&_tmp$1339;
  _tmp$1337 = _tmp$1338 >> 19;
  _tmp$1336 = *(int32_t*)&_tmp$1337;
  _tmp$1330 = _tmp$1336 + 1;
  _tmp$1335 = base2$386 * 1217359;
  _tmp$1334 = *(uint32_t*)&_tmp$1335;
  _tmp$1333 = _tmp$1334 >> 19;
  _tmp$1332 = *(int32_t*)&_tmp$1333;
  _tmp$1331 = _tmp$1332 + 1;
  delta$399 = _tmp$1330 - _tmp$1331;
  _tmp$1329 = 64 - delta$399;
  _tmp$1327 = sum$397 << (_tmp$1329 & 63);
  _tmp$1328 = _low0$395 >> (delta$399 & 63);
  _tmp$1320 = _tmp$1327 | _tmp$1328;
  _p$706 = i$385 / 16;
  moonbit_incref($moonbitlang$core$double$internal$ryu$gPOW5_OFFSETS);
  _tmp$1326 = $moonbitlang$core$double$internal$ryu$gPOW5_OFFSETS;
  if (_p$706 < 0 || _p$706 >= Moonbit_array_length(_tmp$1326)) {
    moonbit_panic();
  }
  _tmp$1654 = (uint32_t)_tmp$1326[_p$706];
  moonbit_decref(_tmp$1326);
  _tmp$1323 = _tmp$1654;
  _tmp$1325 = i$385 % 16;
  _tmp$1324 = _tmp$1325 << 1;
  _tmp$1322 = _tmp$1323 >> (_tmp$1324 & 31);
  _p$709 = _tmp$1322 & 3u;
  _tmp$1321 = (uint64_t)_p$709;
  a$400 = _tmp$1320 + _tmp$1321;
  _p$712 = high1$398;
  _tmp$1319 = 64 - delta$399;
  _tmp$1317 = _p$712 << (_tmp$1319 & 63);
  _tmp$1318 = sum$397 >> (delta$399 & 63);
  b$401 = _tmp$1317 | _tmp$1318;
  return (struct $$moonbitlang$core$double$internal$ryu$Pow5Pair){
           a$400, b$401
         };
}

struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result $moonbitlang$core$double$internal$ryu$mulShiftAll64(
  uint64_t m$358,
  struct $$moonbitlang$core$double$internal$ryu$Pow5Pair mul$355,
  int32_t j$371,
  int32_t mmShift$373
) {
  uint64_t _mul0$354 = mul$355.$0;
  uint64_t _mul1$356 = mul$355.$1;
  uint64_t m$357 = m$358 << 1;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$359 =
    $moonbitlang$core$double$internal$ryu$umul128(m$357, _mul0$354);
  uint64_t _lo$360 = _bind$359.$0;
  uint64_t _tmp$361 = _bind$359.$1;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$362 =
    $moonbitlang$core$double$internal$ryu$umul128(m$357, _mul1$356);
  uint64_t _lo2$363 = _bind$362.$0;
  uint64_t _hi2$364 = _bind$362.$1;
  uint64_t mid$365 = _tmp$361 + _lo2$363;
  uint64_t _tmp$1315;
  uint64_t hi$366;
  uint64_t lo2$367;
  uint64_t _tmp$1313;
  uint64_t _tmp$1314;
  uint64_t mid2$368;
  uint64_t _tmp$1312;
  uint64_t hi2$369;
  int32_t _tmp$1311;
  int32_t _p$680;
  int32_t _tmp$1310;
  uint64_t _tmp$1308;
  uint64_t _tmp$1309;
  uint64_t vp$370;
  uint64_t vm$372;
  int32_t _tmp$1307;
  int32_t _p$689;
  int32_t _tmp$1306;
  uint64_t _tmp$1304;
  uint64_t _tmp$1305;
  uint64_t vr$383;
  uint64_t _tmp$1303;
  if (mid$365 < _tmp$361) {
    _tmp$1315 = 1ull;
  } else {
    _tmp$1315 = 0ull;
  }
  hi$366 = _hi2$364 + _tmp$1315;
  lo2$367 = _lo$360 + _mul0$354;
  _tmp$1313 = mid$365 + _mul1$356;
  if (lo2$367 < _lo$360) {
    _tmp$1314 = 1ull;
  } else {
    _tmp$1314 = 0ull;
  }
  mid2$368 = _tmp$1313 + _tmp$1314;
  if (mid2$368 < mid$365) {
    _tmp$1312 = 1ull;
  } else {
    _tmp$1312 = 0ull;
  }
  hi2$369 = hi$366 + _tmp$1312;
  _tmp$1311 = j$371 - 64;
  _p$680 = _tmp$1311 - 1;
  _tmp$1310 = 64 - _p$680;
  _tmp$1308 = hi2$369 << (_tmp$1310 & 63);
  _tmp$1309 = mid2$368 >> (_p$680 & 63);
  vp$370 = _tmp$1308 | _tmp$1309;
  vm$372 = 0ull;
  if (mmShift$373) {
    uint64_t lo3$374 = _lo$360 - _mul0$354;
    uint64_t _tmp$1291 = mid$365 - _mul1$356;
    uint64_t _tmp$1292;
    uint64_t mid3$375;
    uint64_t _tmp$1290;
    uint64_t hi3$376;
    int32_t _tmp$1289;
    int32_t _p$683;
    int32_t _tmp$1288;
    uint64_t _tmp$1286;
    uint64_t _tmp$1287;
    if (_lo$360 < lo3$374) {
      _tmp$1292 = 1ull;
    } else {
      _tmp$1292 = 0ull;
    }
    mid3$375 = _tmp$1291 - _tmp$1292;
    if (mid$365 < mid3$375) {
      _tmp$1290 = 1ull;
    } else {
      _tmp$1290 = 0ull;
    }
    hi3$376 = hi$366 - _tmp$1290;
    _tmp$1289 = j$371 - 64;
    _p$683 = _tmp$1289 - 1;
    _tmp$1288 = 64 - _p$683;
    _tmp$1286 = hi3$376 << (_tmp$1288 & 63);
    _tmp$1287 = mid3$375 >> (_p$683 & 63);
    vm$372 = _tmp$1286 | _tmp$1287;
  } else {
    uint64_t lo3$377 = _lo$360 + _lo$360;
    uint64_t _tmp$1301 = mid$365 + mid$365;
    uint64_t _tmp$1302;
    uint64_t mid3$378;
    uint64_t _tmp$1299;
    uint64_t _tmp$1300;
    uint64_t hi3$379;
    uint64_t lo4$380;
    uint64_t _tmp$1297;
    uint64_t _tmp$1298;
    uint64_t mid4$381;
    uint64_t _tmp$1296;
    uint64_t hi4$382;
    int32_t _p$686;
    int32_t _tmp$1295;
    uint64_t _tmp$1293;
    uint64_t _tmp$1294;
    if (lo3$377 < _lo$360) {
      _tmp$1302 = 1ull;
    } else {
      _tmp$1302 = 0ull;
    }
    mid3$378 = _tmp$1301 + _tmp$1302;
    _tmp$1299 = hi$366 + hi$366;
    if (mid3$378 < mid$365) {
      _tmp$1300 = 1ull;
    } else {
      _tmp$1300 = 0ull;
    }
    hi3$379 = _tmp$1299 + _tmp$1300;
    lo4$380 = lo3$377 - _mul0$354;
    _tmp$1297 = mid3$378 - _mul1$356;
    if (lo3$377 < lo4$380) {
      _tmp$1298 = 1ull;
    } else {
      _tmp$1298 = 0ull;
    }
    mid4$381 = _tmp$1297 - _tmp$1298;
    if (mid3$378 < mid4$381) {
      _tmp$1296 = 1ull;
    } else {
      _tmp$1296 = 0ull;
    }
    hi4$382 = hi3$379 - _tmp$1296;
    _p$686 = j$371 - 64;
    _tmp$1295 = 64 - _p$686;
    _tmp$1293 = hi4$382 << (_tmp$1295 & 63);
    _tmp$1294 = mid4$381 >> (_p$686 & 63);
    vm$372 = _tmp$1293 | _tmp$1294;
  }
  _tmp$1307 = j$371 - 64;
  _p$689 = _tmp$1307 - 1;
  _tmp$1306 = 64 - _p$689;
  _tmp$1304 = hi$366 << (_tmp$1306 & 63);
  _tmp$1305 = mid$365 >> (_p$689 & 63);
  vr$383 = _tmp$1304 | _tmp$1305;
  _tmp$1303 = vm$372;
  return (struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result){
           vr$383, vp$370, _tmp$1303
         };
}

int32_t $moonbitlang$core$double$internal$ryu$multipleOfPowerOf2(
  uint64_t value$352,
  int32_t p$353
) {
  uint64_t _tmp$1285 = 1ull << (p$353 & 63);
  uint64_t _tmp$1284 = _tmp$1285 - 1ull;
  uint64_t _tmp$1283 = value$352 & _tmp$1284;
  return _tmp$1283 == 0ull;
}

int32_t $moonbitlang$core$double$internal$ryu$multipleOfPowerOf5(
  uint64_t value$350,
  int32_t p$351
) {
  int32_t _tmp$1282 =
    $moonbitlang$core$double$internal$ryu$pow5Factor(value$350);
  return _tmp$1282 >= p$351;
}

int32_t $moonbitlang$core$double$internal$ryu$pow5Factor(uint64_t value$346) {
  uint64_t _tmp$1270 = value$346 % 5ull;
  uint64_t _tmp$1271;
  uint64_t _tmp$1272;
  uint64_t _tmp$1273;
  int32_t count$347;
  uint64_t value$348;
  uint64_t _tmp$1281;
  moonbit_string_t _tmp$1280;
  moonbit_string_t _tmp$1279;
  if (_tmp$1270 != 0ull) {
    return 0;
  }
  _tmp$1271 = value$346 % 25ull;
  if (_tmp$1271 != 0ull) {
    return 1;
  }
  _tmp$1272 = value$346 % 125ull;
  if (_tmp$1272 != 0ull) {
    return 2;
  }
  _tmp$1273 = value$346 % 625ull;
  if (_tmp$1273 != 0ull) {
    return 3;
  }
  count$347 = 4;
  value$348 = value$346 / 625ull;
  while (1) {
    uint64_t _tmp$1274 = value$348;
    if (_tmp$1274 > 0ull) {
      uint64_t _tmp$1276 = value$348;
      uint64_t _tmp$1275 = _tmp$1276 % 5ull;
      uint64_t _tmp$1277;
      int32_t _tmp$1278;
      if (_tmp$1275 != 0ull) {
        return count$347;
      }
      _tmp$1277 = value$348;
      value$348 = _tmp$1277 / 5ull;
      _tmp$1278 = count$347;
      count$347 = _tmp$1278 + 1;
      continue;
    }
    break;
  }
  _tmp$1281 = value$348;
  _tmp$1280
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(
    _tmp$1281
  );
  _tmp$1279
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_4.data, _tmp$1280
  );
  return $moonbitlang$core$builtin$abort$0(
           _tmp$1279, (moonbit_string_t)moonbit_string_literal_5.data
         );
}

uint64_t $moonbitlang$core$double$internal$ryu$shiftright128(
  uint64_t lo$345,
  uint64_t hi$343,
  int32_t dist$344
) {
  int32_t _tmp$1269 = 64 - dist$344;
  uint64_t _tmp$1267 = hi$343 << (_tmp$1269 & 63);
  uint64_t _tmp$1268 = lo$345 >> (dist$344 & 63);
  return _tmp$1267 | _tmp$1268;
}

struct $$moonbitlang$core$double$internal$ryu$Umul128 $moonbitlang$core$double$internal$ryu$umul128(
  uint64_t a$333,
  uint64_t b$336
) {
  uint64_t aLo$332 = a$333 & 4294967295ull;
  uint64_t aHi$334 = a$333 >> 32;
  uint64_t bLo$335 = b$336 & 4294967295ull;
  uint64_t bHi$337 = b$336 >> 32;
  uint64_t x$338 = aLo$332 * bLo$335;
  uint64_t _tmp$1265 = aHi$334 * bLo$335;
  uint64_t _tmp$1266 = x$338 >> 32;
  uint64_t y$339 = _tmp$1265 + _tmp$1266;
  uint64_t _tmp$1263 = aLo$332 * bHi$337;
  uint64_t _tmp$1264 = y$339 & 4294967295ull;
  uint64_t z$340 = _tmp$1263 + _tmp$1264;
  uint64_t _tmp$1261 = aHi$334 * bHi$337;
  uint64_t _tmp$1262 = y$339 >> 32;
  uint64_t _tmp$1259 = _tmp$1261 + _tmp$1262;
  uint64_t _tmp$1260 = z$340 >> 32;
  uint64_t w$341 = _tmp$1259 + _tmp$1260;
  uint64_t lo$342 = a$333 * b$336;
  return (struct $$moonbitlang$core$double$internal$ryu$Umul128){
           lo$342, w$341
         };
}

moonbit_string_t $moonbitlang$core$double$internal$ryu$string_from_bytes(
  moonbit_bytes_t bytes$327,
  int32_t from$331,
  int32_t to$329
) {
  int32_t _tmp$1258 = Moonbit_array_length(bytes$327);
  struct $$moonbitlang$core$builtin$StringBuilder* buf$326 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(_tmp$1258);
  int32_t i$328 = from$331;
  while (1) {
    if (i$328 < to$329) {
      int32_t _p$677;
      int32_t _tmp$1256;
      int32_t _tmp$1255;
      int32_t _tmp$1257;
      if (i$328 < 0 || i$328 >= Moonbit_array_length(bytes$327)) {
        moonbit_panic();
      }
      _p$677 = (int32_t)bytes$327[i$328];
      _tmp$1256 = (int32_t)_p$677;
      _tmp$1255 = _tmp$1256;
      moonbit_incref(buf$326);
      $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
        buf$326, _tmp$1255
      );
      _tmp$1257 = i$328 + 1;
      i$328 = _tmp$1257;
      continue;
    } else {
      moonbit_decref(bytes$327);
    }
    break;
  }
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(buf$326);
}

int32_t $moonbitlang$core$double$internal$ryu$log10Pow2(int32_t e$325) {
  int32_t _tmp$1254 = e$325 * 78913;
  uint32_t _tmp$1253 = *(uint32_t*)&_tmp$1254;
  uint32_t _tmp$1252 = _tmp$1253 >> 18;
  return *(int32_t*)&_tmp$1252;
}

int32_t $moonbitlang$core$double$internal$ryu$log10Pow5(int32_t e$324) {
  int32_t _tmp$1251 = e$324 * 732923;
  uint32_t _tmp$1250 = *(uint32_t*)&_tmp$1251;
  uint32_t _tmp$1249 = _tmp$1250 >> 20;
  return *(int32_t*)&_tmp$1249;
}

moonbit_string_t $moonbitlang$core$double$internal$ryu$copy_special_str(
  int32_t sign$322,
  int32_t exponent$323,
  int32_t mantissa$320
) {
  moonbit_string_t s$321;
  if (mantissa$320) {
    return (moonbit_string_t)moonbit_string_literal_6.data;
  }
  if (sign$322) {
    s$321 = (moonbit_string_t)moonbit_string_literal_1.data;
  } else {
    s$321 = (moonbit_string_t)moonbit_string_literal_7.data;
  }
  if (exponent$323) {
    return moonbit_add_string(
             s$321, (moonbit_string_t)moonbit_string_literal_8.data
           );
  }
  return moonbit_add_string(
           s$321, (moonbit_string_t)moonbit_string_literal_9.data
         );
}

int32_t $moonbitlang$core$double$internal$ryu$pow5bits(int32_t e$319) {
  int32_t _tmp$1248 = e$319 * 1217359;
  uint32_t _tmp$1247 = *(uint32_t*)&_tmp$1248;
  uint32_t _tmp$1246 = _tmp$1247 >> 19;
  int32_t _tmp$1245 = *(int32_t*)&_tmp$1246;
  return _tmp$1245 + 1;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$317,
  struct $$moonbitlang$core$builtin$Logger logger$318
) {
  moonbit_string_t _tmp$1244 = self$317;
  struct $$moonbitlang$core$builtin$SourceLocRepr* _tmp$1243 =
    $$moonbitlang$core$builtin$SourceLocRepr$$parse(_tmp$1244);
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
    _tmp$1243, logger$318
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$303,
  struct $$moonbitlang$core$builtin$Logger logger$316
) {
  struct $StringView _field$1666 =
    (struct $StringView){self$303->$0_1, self$303->$0_2, self$303->$0_0};
  struct $StringView pkg$302 = _field$1666;
  int32_t _tmp$1242 =
    Moonbit_array_length($moonbitlang$core$builtin$output$$2a$bind$7c$8193);
  struct $StringView _tmp$1241;
  int64_t _bind$304;
  struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$* _bind$305;
  struct $StringView _field$1665;
  struct $StringView _module_name$312;
  void* _field$1664;
  int32_t _cnt$1725;
  void* _package_name$313;
  struct $StringView _field$1662;
  struct $StringView filename$1224;
  struct $StringView _field$1661;
  struct $StringView start_line$1225;
  struct $StringView _field$1660;
  struct $StringView start_column$1226;
  struct $StringView _field$1659;
  struct $StringView end_line$1227;
  struct $StringView _field$1658;
  int32_t _cnt$1729;
  struct $StringView end_column$1228;
  struct $$moonbitlang$core$builtin$Logger _bind$1223;
  moonbit_incref($moonbitlang$core$builtin$output$$2a$bind$7c$8193);
  _tmp$1241
  = (struct $StringView){
    0, _tmp$1242, $moonbitlang$core$builtin$output$$2a$bind$7c$8193
  };
  moonbit_incref(pkg$302.$0);
  moonbit_incref(pkg$302.$0);
  _bind$304 = $StringView$$find(pkg$302, _tmp$1241);
  if (_bind$304 == 4294967296ll) {
    void* None$1229 =
      (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
    _bind$305
    = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
        sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
      );
    Moonbit_object_header(_bind$305)->meta
    = Moonbit_make_regular_object_header(
      offsetof(
        struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
      )
      >> 2,
        2,
        0
    );
    _bind$305->$0_0 = pkg$302.$0;
    _bind$305->$0_1 = pkg$302.$1;
    _bind$305->$0_2 = pkg$302.$2;
    _bind$305->$1 = None$1229;
  } else {
    int64_t _Some$306 = _bind$304;
    int32_t _first_slash$307 = (int32_t)_Some$306;
    int32_t _tmp$1240 = _first_slash$307 + 1;
    struct $StringView _tmp$1237;
    int32_t _tmp$1239;
    struct $StringView _tmp$1238;
    int64_t _bind$308;
    moonbit_incref(pkg$302.$0);
    _tmp$1237 = $StringView$$view$inner(pkg$302, _tmp$1240, 4294967296ll);
    _tmp$1239
    = Moonbit_array_length(
      $moonbitlang$core$builtin$output$$2a$bind$7c$8187
    );
    moonbit_incref($moonbitlang$core$builtin$output$$2a$bind$7c$8187);
    _tmp$1238
    = (struct $StringView){
      0, _tmp$1239, $moonbitlang$core$builtin$output$$2a$bind$7c$8187
    };
    _bind$308 = $StringView$$find(_tmp$1237, _tmp$1238);
    if (_bind$308 == 4294967296ll) {
      void* None$1230 =
        (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _bind$305
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$305)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$305->$0_0 = pkg$302.$0;
      _bind$305->$0_1 = pkg$302.$1;
      _bind$305->$0_2 = pkg$302.$2;
      _bind$305->$1 = None$1230;
    } else {
      int64_t _Some$309 = _bind$308;
      int32_t _second_slash$310 = (int32_t)_Some$309;
      int32_t _tmp$1236 = _first_slash$307 + 1;
      int32_t module_name_end$311 = _tmp$1236 + _second_slash$310;
      int64_t _tmp$1235 = (int64_t)module_name_end$311;
      struct $StringView _tmp$1231;
      int32_t _tmp$1234;
      struct $StringView _tmp$1233;
      void* Some$1232;
      moonbit_incref(pkg$302.$0);
      _tmp$1231 = $StringView$$view$inner(pkg$302, 0, _tmp$1235);
      _tmp$1234 = module_name_end$311 + 1;
      _tmp$1233 = $StringView$$view$inner(pkg$302, _tmp$1234, 4294967296ll);
      Some$1232
      = (void*)moonbit_malloc(sizeof(struct $Option$3c$StringView$3e$$Some));
      Moonbit_object_header(Some$1232)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $Option$3c$StringView$3e$$Some, $0_0) >> 2, 1, 1
      );
      ((struct $Option$3c$StringView$3e$$Some*)Some$1232)->$0_0
      = _tmp$1233.$0;
      ((struct $Option$3c$StringView$3e$$Some*)Some$1232)->$0_1
      = _tmp$1233.$1;
      ((struct $Option$3c$StringView$3e$$Some*)Some$1232)->$0_2
      = _tmp$1233.$2;
      _bind$305
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$305)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$305->$0_0 = _tmp$1231.$0;
      _bind$305->$0_1 = _tmp$1231.$1;
      _bind$305->$0_2 = _tmp$1231.$2;
      _bind$305->$1 = Some$1232;
    }
  }
  _field$1665
  = (struct $StringView){
    _bind$305->$0_1, _bind$305->$0_2, _bind$305->$0_0
  };
  _module_name$312 = _field$1665;
  _field$1664 = _bind$305->$1;
  _cnt$1725 = Moonbit_object_header(_bind$305)->rc;
  if (_cnt$1725 > 1) {
    int32_t _new_cnt$1726;
    moonbit_incref(_field$1664);
    moonbit_incref(_module_name$312.$0);
    _new_cnt$1726 = _cnt$1725 - 1;
    Moonbit_object_header(_bind$305)->rc = _new_cnt$1726;
  } else if (_cnt$1725 == 1) {
    moonbit_free(_bind$305);
  }
  _package_name$313 = _field$1664;
  switch (Moonbit_object_tag(_package_name$313)) {
    case 1: {
      struct $Option$3c$StringView$3e$$Some* _Some$314 =
        (struct $Option$3c$StringView$3e$$Some*)_package_name$313;
      struct $StringView _field$1663 =
        (struct $StringView){
          _Some$314->$0_1, _Some$314->$0_2, _Some$314->$0_0
        };
      int32_t _cnt$1727 = Moonbit_object_header(_Some$314)->rc;
      struct $StringView _pkg_name$315;
      struct $$moonbitlang$core$builtin$Logger _bind$1222;
      if (_cnt$1727 > 1) {
        int32_t _new_cnt$1728;
        moonbit_incref(_field$1663.$0);
        _new_cnt$1728 = _cnt$1727 - 1;
        Moonbit_object_header(_Some$314)->rc = _new_cnt$1728;
      } else if (_cnt$1727 == 1) {
        moonbit_free(_Some$314);
      }
      _pkg_name$315 = _field$1663;
      if (logger$316.$1) {
        moonbit_incref(logger$316.$1);
      }
      logger$316.$0->$method_2(logger$316.$1, _pkg_name$315);
      _bind$1222 = logger$316;
      if (_bind$1222.$1) {
        moonbit_incref(_bind$1222.$1);
      }
      _bind$1222.$0->$method_3(_bind$1222.$1, 47);
      break;
    }
    default: {
      moonbit_decref(_package_name$313);
      break;
    }
  }
  _field$1662
  = (struct $StringView){
    self$303->$1_1, self$303->$1_2, self$303->$1_0
  };
  filename$1224 = _field$1662;
  moonbit_incref(filename$1224.$0);
  if (logger$316.$1) {
    moonbit_incref(logger$316.$1);
  }
  logger$316.$0->$method_2(logger$316.$1, filename$1224);
  if (logger$316.$1) {
    moonbit_incref(logger$316.$1);
  }
  logger$316.$0->$method_3(logger$316.$1, 58);
  _field$1661
  = (struct $StringView){
    self$303->$2_1, self$303->$2_2, self$303->$2_0
  };
  start_line$1225 = _field$1661;
  moonbit_incref(start_line$1225.$0);
  if (logger$316.$1) {
    moonbit_incref(logger$316.$1);
  }
  logger$316.$0->$method_2(logger$316.$1, start_line$1225);
  if (logger$316.$1) {
    moonbit_incref(logger$316.$1);
  }
  logger$316.$0->$method_3(logger$316.$1, 58);
  _field$1660
  = (struct $StringView){
    self$303->$3_1, self$303->$3_2, self$303->$3_0
  };
  start_column$1226 = _field$1660;
  moonbit_incref(start_column$1226.$0);
  if (logger$316.$1) {
    moonbit_incref(logger$316.$1);
  }
  logger$316.$0->$method_2(logger$316.$1, start_column$1226);
  if (logger$316.$1) {
    moonbit_incref(logger$316.$1);
  }
  logger$316.$0->$method_3(logger$316.$1, 45);
  _field$1659
  = (struct $StringView){
    self$303->$4_1, self$303->$4_2, self$303->$4_0
  };
  end_line$1227 = _field$1659;
  moonbit_incref(end_line$1227.$0);
  if (logger$316.$1) {
    moonbit_incref(logger$316.$1);
  }
  logger$316.$0->$method_2(logger$316.$1, end_line$1227);
  if (logger$316.$1) {
    moonbit_incref(logger$316.$1);
  }
  logger$316.$0->$method_3(logger$316.$1, 58);
  _field$1658
  = (struct $StringView){
    self$303->$5_1, self$303->$5_2, self$303->$5_0
  };
  _cnt$1729 = Moonbit_object_header(self$303)->rc;
  if (_cnt$1729 > 1) {
    int32_t _new_cnt$1735;
    moonbit_incref(_field$1658.$0);
    _new_cnt$1735 = _cnt$1729 - 1;
    Moonbit_object_header(self$303)->rc = _new_cnt$1735;
  } else if (_cnt$1729 == 1) {
    struct $StringView _field$1734 =
      (struct $StringView){self$303->$4_1, self$303->$4_2, self$303->$4_0};
    struct $StringView _field$1733;
    struct $StringView _field$1732;
    struct $StringView _field$1731;
    struct $StringView _field$1730;
    moonbit_decref(_field$1734.$0);
    _field$1733
    = (struct $StringView){
      self$303->$3_1, self$303->$3_2, self$303->$3_0
    };
    moonbit_decref(_field$1733.$0);
    _field$1732
    = (struct $StringView){
      self$303->$2_1, self$303->$2_2, self$303->$2_0
    };
    moonbit_decref(_field$1732.$0);
    _field$1731
    = (struct $StringView){
      self$303->$1_1, self$303->$1_2, self$303->$1_0
    };
    moonbit_decref(_field$1731.$0);
    _field$1730
    = (struct $StringView){
      self$303->$0_1, self$303->$0_2, self$303->$0_0
    };
    moonbit_decref(_field$1730.$0);
    moonbit_free(self$303);
  }
  end_column$1228 = _field$1658;
  if (logger$316.$1) {
    moonbit_incref(logger$316.$1);
  }
  logger$316.$0->$method_2(logger$316.$1, end_column$1228);
  if (logger$316.$1) {
    moonbit_incref(logger$316.$1);
  }
  logger$316.$0->$method_3(logger$316.$1, 64);
  _bind$1223 = logger$316;
  _bind$1223.$0->$method_2(_bind$1223.$1, _module_name$312);
  return 0;
}

uint64_t $Bool$$to_uint64(int32_t self$301) {
  if (self$301) {
    return 1ull;
  } else {
    return 0ull;
  }
}

int64_t $Bool$$to_int64(int32_t self$300) {
  if (self$300) {
    return 1ll;
  } else {
    return 0ll;
  }
}

int32_t $Bool$$to_int(int32_t self$299) {
  if (self$299) {
    return 1;
  } else {
    return 0;
  }
}

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$298) {
  moonbit_println(input$298);
  moonbit_decref(input$298);
  return 0;
}

uint64_t $UInt$$to_uint64(uint32_t self$297) {
  return (uint64_t)self$297;
}

uint32_t $ReadOnlyArray$$at$1(uint32_t* self$295, int32_t index$296) {
  uint32_t* _tmp$1221 = self$295;
  uint32_t _tmp$1667;
  if (index$296 < 0 || index$296 >= Moonbit_array_length(_tmp$1221)) {
    moonbit_panic();
  }
  _tmp$1667 = (uint32_t)_tmp$1221[index$296];
  moonbit_decref(_tmp$1221);
  return _tmp$1667;
}

uint64_t $ReadOnlyArray$$at$0(uint64_t* self$293, int32_t index$294) {
  uint64_t* _tmp$1220 = self$293;
  uint64_t _tmp$1668;
  if (index$294 < 0 || index$294 >= Moonbit_array_length(_tmp$1220)) {
    moonbit_panic();
  }
  _tmp$1668 = (uint64_t)_tmp$1220[index$294];
  moonbit_decref(_tmp$1220);
  return _tmp$1668;
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$String$$to_string(
  moonbit_string_t self$292
) {
  return self$292;
}

int32_t $$moonbitlang$core$builtin$Show$$UInt64$$output(
  uint64_t self$291,
  struct $$moonbitlang$core$builtin$Logger logger$290
) {
  moonbit_string_t _tmp$1219 = $UInt64$$to_string$inner(self$291, 10);
  logger$290.$0->$method_0(logger$290.$1, _tmp$1219);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$288,
  struct $StringView str$289
) {
  int32_t len$1201 = self$288->$1;
  int32_t end$1204 = str$289.$2;
  int32_t start$1205 = str$289.$1;
  int32_t _tmp$1203 = end$1204 - start$1205;
  int32_t _tmp$1202 = _tmp$1203 * 2;
  int32_t _tmp$1200 = len$1201 + _tmp$1202;
  moonbit_bytes_t _field$1671;
  moonbit_bytes_t data$1206;
  int32_t len$1207;
  moonbit_string_t _field$1670;
  moonbit_string_t str$1208;
  int32_t start$1209;
  int32_t end$1211;
  int32_t start$1212;
  int32_t _tmp$1210;
  int32_t len$1214;
  int32_t end$1217;
  int32_t _field$1669;
  int32_t start$1218;
  int32_t _tmp$1216;
  int32_t _tmp$1215;
  int32_t _tmp$1213;
  moonbit_incref(self$288);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$288, _tmp$1200
  );
  _field$1671 = self$288->$0;
  data$1206 = _field$1671;
  len$1207 = self$288->$1;
  _field$1670 = str$289.$0;
  str$1208 = _field$1670;
  start$1209 = str$289.$1;
  end$1211 = str$289.$2;
  start$1212 = str$289.$1;
  _tmp$1210 = end$1211 - start$1212;
  moonbit_incref(str$1208);
  moonbit_incref(data$1206);
  $FixedArray$$blit_from_string(
    data$1206, len$1207, str$1208, start$1209, _tmp$1210
  );
  len$1214 = self$288->$1;
  end$1217 = str$289.$2;
  _field$1669 = str$289.$1;
  moonbit_decref(str$289.$0);
  start$1218 = _field$1669;
  _tmp$1216 = end$1217 - start$1218;
  _tmp$1215 = _tmp$1216 * 2;
  _tmp$1213 = len$1214 + _tmp$1215;
  self$288->$1 = _tmp$1213;
  moonbit_decref(self$288);
  return 0;
}

int64_t $String$$offset_of_nth_char$inner(
  moonbit_string_t self$285,
  int32_t i$286,
  int32_t start_offset$287,
  int64_t end_offset$283
) {
  int32_t end_offset$282;
  if (end_offset$283 == 4294967296ll) {
    end_offset$282 = Moonbit_array_length(self$285);
  } else {
    int64_t _Some$284 = end_offset$283;
    end_offset$282 = (int32_t)_Some$284;
  }
  if (i$286 >= 0) {
    return $String$$offset_of_nth_char_forward(
             self$285, i$286, start_offset$287, end_offset$282
           );
  } else {
    int32_t _tmp$1199 = -i$286;
    return $String$$offset_of_nth_char_backward(
             self$285, _tmp$1199, start_offset$287, end_offset$282
           );
  }
}

int64_t $String$$offset_of_nth_char_forward(
  moonbit_string_t self$280,
  int32_t n$278,
  int32_t start_offset$274,
  int32_t end_offset$275
) {
  if (start_offset$274 >= 0 && start_offset$274 <= end_offset$275) {
    int32_t utf16_offset$276 = start_offset$274;
    int32_t char_count$277 = 0;
    int32_t _tmp$1197;
    int32_t _if_result$1757;
    while (1) {
      int32_t _tmp$1191 = utf16_offset$276;
      int32_t _if_result$1756;
      if (_tmp$1191 < end_offset$275) {
        int32_t _tmp$1190 = char_count$277;
        _if_result$1756 = _tmp$1190 < n$278;
      } else {
        _if_result$1756 = 0;
      }
      if (_if_result$1756) {
        int32_t _tmp$1195 = utf16_offset$276;
        int32_t c$279 = self$280[_tmp$1195];
        int32_t _tmp$1194;
        if (55296 <= c$279 && c$279 <= 56319) {
          int32_t _tmp$1192 = utf16_offset$276;
          utf16_offset$276 = _tmp$1192 + 2;
        } else {
          int32_t _tmp$1193 = utf16_offset$276;
          utf16_offset$276 = _tmp$1193 + 1;
        }
        _tmp$1194 = char_count$277;
        char_count$277 = _tmp$1194 + 1;
        continue;
      } else {
        moonbit_decref(self$280);
      }
      break;
    }
    _tmp$1197 = char_count$277;
    if (_tmp$1197 < n$278) {
      _if_result$1757 = 1;
    } else {
      int32_t _tmp$1196 = utf16_offset$276;
      _if_result$1757 = _tmp$1196 >= end_offset$275;
    }
    if (_if_result$1757) {
      return 4294967296ll;
    } else {
      int32_t _tmp$1198 = utf16_offset$276;
      return (int64_t)_tmp$1198;
    }
  } else {
    moonbit_decref(self$280);
    return $moonbitlang$core$builtin$abort$3(
             (moonbit_string_t)moonbit_string_literal_10.data,
               (moonbit_string_t)moonbit_string_literal_11.data
           );
  }
}

int64_t $String$$offset_of_nth_char_backward(
  moonbit_string_t self$272,
  int32_t n$270,
  int32_t start_offset$269,
  int32_t end_offset$268
) {
  int32_t char_count$266 = 0;
  int32_t utf16_offset$267 = end_offset$268;
  int32_t _tmp$1188;
  int32_t _if_result$1760;
  while (1) {
    int32_t _tmp$1181 = utf16_offset$267;
    int32_t _tmp$1180 = _tmp$1181 - 1;
    int32_t _if_result$1759;
    if (_tmp$1180 >= start_offset$269) {
      int32_t _tmp$1179 = char_count$266;
      _if_result$1759 = _tmp$1179 < n$270;
    } else {
      _if_result$1759 = 0;
    }
    if (_if_result$1759) {
      int32_t _tmp$1186 = utf16_offset$267;
      int32_t _tmp$1185 = _tmp$1186 - 1;
      int32_t c$271 = self$272[_tmp$1185];
      int32_t _tmp$1184;
      if (56320 <= c$271 && c$271 <= 57343) {
        int32_t _tmp$1182 = utf16_offset$267;
        utf16_offset$267 = _tmp$1182 - 2;
      } else {
        int32_t _tmp$1183 = utf16_offset$267;
        utf16_offset$267 = _tmp$1183 - 1;
      }
      _tmp$1184 = char_count$266;
      char_count$266 = _tmp$1184 + 1;
      continue;
    } else {
      moonbit_decref(self$272);
    }
    break;
  }
  _tmp$1188 = char_count$266;
  if (_tmp$1188 < n$270) {
    _if_result$1760 = 1;
  } else {
    int32_t _tmp$1187 = utf16_offset$267;
    _if_result$1760 = _tmp$1187 < start_offset$269;
  }
  if (_if_result$1760) {
    return 4294967296ll;
  } else {
    int32_t _tmp$1189 = utf16_offset$267;
    return (int64_t)_tmp$1189;
  }
}

int32_t $String$$char_length_ge$inner(
  moonbit_string_t self$258,
  int32_t len$261,
  int32_t start_offset$265,
  int64_t end_offset$256
) {
  int32_t end_offset$255;
  int32_t index$259;
  int32_t count$260;
  if (end_offset$256 == 4294967296ll) {
    end_offset$255 = Moonbit_array_length(self$258);
  } else {
    int64_t _Some$257 = end_offset$256;
    end_offset$255 = (int32_t)_Some$257;
  }
  index$259 = start_offset$265;
  count$260 = 0;
  while (1) {
    if (index$259 < end_offset$255 && count$260 < len$261) {
      int32_t c1$262 = self$258[index$259];
      int32_t _if_result$1762;
      int32_t _tmp$1177;
      int32_t _tmp$1178;
      if (55296 <= c1$262 && c1$262 <= 56319) {
        int32_t _tmp$1173 = index$259 + 1;
        _if_result$1762 = _tmp$1173 < end_offset$255;
      } else {
        _if_result$1762 = 0;
      }
      if (_if_result$1762) {
        int32_t _tmp$1176 = index$259 + 1;
        int32_t c2$263 = self$258[_tmp$1176];
        if (56320 <= c2$263 && c2$263 <= 57343) {
          int32_t _tmp$1174 = index$259 + 2;
          int32_t _tmp$1175 = count$260 + 1;
          index$259 = _tmp$1174;
          count$260 = _tmp$1175;
          continue;
        } else {
          $moonbitlang$core$builtin$abort$2(
            (moonbit_string_t)moonbit_string_literal_12.data,
              (moonbit_string_t)moonbit_string_literal_13.data
          );
        }
      }
      _tmp$1177 = index$259 + 1;
      _tmp$1178 = count$260 + 1;
      index$259 = _tmp$1177;
      count$260 = _tmp$1178;
      continue;
    } else {
      moonbit_decref(self$258);
      return count$260 >= len$261;
    }
    break;
  }
}

moonbit_string_t $UInt64$$to_string$inner(
  uint64_t self$247,
  int32_t radix$246
) {
  uint16_t* buffer$248;
  if (radix$246 < 2 || radix$246 > 36) {
    $moonbitlang$core$builtin$abort$2(
      (moonbit_string_t)moonbit_string_literal_14.data,
        (moonbit_string_t)moonbit_string_literal_15.data
    );
  }
  if (self$247 == 0ull) {
    return (moonbit_string_t)moonbit_string_literal_3.data;
  }
  switch (radix$246) {
    case 10: {
      int32_t len$249 = $moonbitlang$core$builtin$dec_count64(self$247);
      uint16_t* buffer$250 = (uint16_t*)moonbit_make_string(len$249, 0);
      moonbit_incref(buffer$250);
      $moonbitlang$core$builtin$int64_to_string_dec(
        buffer$250, self$247, 0, len$249
      );
      buffer$248 = buffer$250;
      break;
    }

    case 16: {
      int32_t len$251 = $moonbitlang$core$builtin$hex_count64(self$247);
      uint16_t* buffer$252 = (uint16_t*)moonbit_make_string(len$251, 0);
      moonbit_incref(buffer$252);
      $moonbitlang$core$builtin$int64_to_string_hex(
        buffer$252, self$247, 0, len$251
      );
      buffer$248 = buffer$252;
      break;
    }
    default: {
      int32_t len$253 =
        $moonbitlang$core$builtin$radix_count64(self$247, radix$246);
      uint16_t* buffer$254 = (uint16_t*)moonbit_make_string(len$253, 0);
      moonbit_incref(buffer$254);
      $moonbitlang$core$builtin$int64_to_string_generic(
        buffer$254, self$247, 0, len$253, radix$246
      );
      buffer$248 = buffer$254;
      break;
    }
  }
  return buffer$248;
}

int32_t $moonbitlang$core$builtin$int64_to_string_dec(
  uint16_t* buffer$236,
  uint64_t num$224,
  int32_t digit_start$227,
  int32_t total_len$226
) {
  uint64_t num$223 = num$224;
  int32_t offset$225 = total_len$226 - digit_start$227;
  uint64_t _tmp$1172;
  int32_t remaining$238;
  int32_t _tmp$1153;
  while (1) {
    uint64_t _tmp$1116 = num$223;
    if (_tmp$1116 >= 10000ull) {
      uint64_t _tmp$1139 = num$223;
      uint64_t t$228 = _tmp$1139 / 10000ull;
      uint64_t _tmp$1138 = num$223;
      uint64_t _tmp$1137 = _tmp$1138 % 10000ull;
      int32_t r$229 = (int32_t)_tmp$1137;
      int32_t d1$230;
      int32_t d2$231;
      int32_t _tmp$1117;
      int32_t _tmp$1136;
      int32_t _tmp$1135;
      int32_t d1_hi$232;
      int32_t _tmp$1134;
      int32_t _tmp$1133;
      int32_t d1_lo$233;
      int32_t _tmp$1132;
      int32_t _tmp$1131;
      int32_t d2_hi$234;
      int32_t _tmp$1130;
      int32_t _tmp$1129;
      int32_t d2_lo$235;
      int32_t _tmp$1119;
      int32_t _tmp$1118;
      int32_t _tmp$1122;
      int32_t _tmp$1121;
      int32_t _tmp$1120;
      int32_t _tmp$1125;
      int32_t _tmp$1124;
      int32_t _tmp$1123;
      int32_t _tmp$1128;
      int32_t _tmp$1127;
      int32_t _tmp$1126;
      num$223 = t$228;
      d1$230 = r$229 / 100;
      d2$231 = r$229 % 100;
      _tmp$1117 = offset$225;
      offset$225 = _tmp$1117 - 4;
      _tmp$1136 = d1$230 / 10;
      _tmp$1135 = 48 + _tmp$1136;
      d1_hi$232 = (uint16_t)_tmp$1135;
      _tmp$1134 = d1$230 % 10;
      _tmp$1133 = 48 + _tmp$1134;
      d1_lo$233 = (uint16_t)_tmp$1133;
      _tmp$1132 = d2$231 / 10;
      _tmp$1131 = 48 + _tmp$1132;
      d2_hi$234 = (uint16_t)_tmp$1131;
      _tmp$1130 = d2$231 % 10;
      _tmp$1129 = 48 + _tmp$1130;
      d2_lo$235 = (uint16_t)_tmp$1129;
      _tmp$1119 = offset$225;
      _tmp$1118 = digit_start$227 + _tmp$1119;
      buffer$236[_tmp$1118] = d1_hi$232;
      _tmp$1122 = offset$225;
      _tmp$1121 = digit_start$227 + _tmp$1122;
      _tmp$1120 = _tmp$1121 + 1;
      buffer$236[_tmp$1120] = d1_lo$233;
      _tmp$1125 = offset$225;
      _tmp$1124 = digit_start$227 + _tmp$1125;
      _tmp$1123 = _tmp$1124 + 2;
      buffer$236[_tmp$1123] = d2_hi$234;
      _tmp$1128 = offset$225;
      _tmp$1127 = digit_start$227 + _tmp$1128;
      _tmp$1126 = _tmp$1127 + 3;
      buffer$236[_tmp$1126] = d2_lo$235;
      continue;
    }
    break;
  }
  _tmp$1172 = num$223;
  remaining$238 = (int32_t)_tmp$1172;
  while (1) {
    int32_t _tmp$1140 = remaining$238;
    if (_tmp$1140 >= 100) {
      int32_t _tmp$1152 = remaining$238;
      int32_t t$239 = _tmp$1152 / 100;
      int32_t _tmp$1151 = remaining$238;
      int32_t d$240 = _tmp$1151 % 100;
      int32_t _tmp$1141;
      int32_t _tmp$1150;
      int32_t _tmp$1149;
      int32_t d_hi$241;
      int32_t _tmp$1148;
      int32_t _tmp$1147;
      int32_t d_lo$242;
      int32_t _tmp$1143;
      int32_t _tmp$1142;
      int32_t _tmp$1146;
      int32_t _tmp$1145;
      int32_t _tmp$1144;
      remaining$238 = t$239;
      _tmp$1141 = offset$225;
      offset$225 = _tmp$1141 - 2;
      _tmp$1150 = d$240 / 10;
      _tmp$1149 = 48 + _tmp$1150;
      d_hi$241 = (uint16_t)_tmp$1149;
      _tmp$1148 = d$240 % 10;
      _tmp$1147 = 48 + _tmp$1148;
      d_lo$242 = (uint16_t)_tmp$1147;
      _tmp$1143 = offset$225;
      _tmp$1142 = digit_start$227 + _tmp$1143;
      buffer$236[_tmp$1142] = d_hi$241;
      _tmp$1146 = offset$225;
      _tmp$1145 = digit_start$227 + _tmp$1146;
      _tmp$1144 = _tmp$1145 + 1;
      buffer$236[_tmp$1144] = d_lo$242;
      continue;
    }
    break;
  }
  _tmp$1153 = remaining$238;
  if (_tmp$1153 >= 10) {
    int32_t _tmp$1154 = offset$225;
    int32_t _tmp$1165;
    int32_t _tmp$1164;
    int32_t _tmp$1163;
    int32_t d_hi$244;
    int32_t _tmp$1162;
    int32_t _tmp$1161;
    int32_t _tmp$1160;
    int32_t d_lo$245;
    int32_t _tmp$1156;
    int32_t _tmp$1155;
    int32_t _tmp$1159;
    int32_t _tmp$1158;
    int32_t _tmp$1157;
    offset$225 = _tmp$1154 - 2;
    _tmp$1165 = remaining$238;
    _tmp$1164 = _tmp$1165 / 10;
    _tmp$1163 = 48 + _tmp$1164;
    d_hi$244 = (uint16_t)_tmp$1163;
    _tmp$1162 = remaining$238;
    _tmp$1161 = _tmp$1162 % 10;
    _tmp$1160 = 48 + _tmp$1161;
    d_lo$245 = (uint16_t)_tmp$1160;
    _tmp$1156 = offset$225;
    _tmp$1155 = digit_start$227 + _tmp$1156;
    buffer$236[_tmp$1155] = d_hi$244;
    _tmp$1159 = offset$225;
    _tmp$1158 = digit_start$227 + _tmp$1159;
    _tmp$1157 = _tmp$1158 + 1;
    buffer$236[_tmp$1157] = d_lo$245;
    moonbit_decref(buffer$236);
  } else {
    int32_t _tmp$1166 = offset$225;
    int32_t _tmp$1171;
    int32_t _tmp$1167;
    int32_t _tmp$1170;
    int32_t _tmp$1169;
    int32_t _tmp$1168;
    offset$225 = _tmp$1166 - 1;
    _tmp$1171 = offset$225;
    _tmp$1167 = digit_start$227 + _tmp$1171;
    _tmp$1170 = remaining$238;
    _tmp$1169 = 48 + _tmp$1170;
    _tmp$1168 = (uint16_t)_tmp$1169;
    buffer$236[_tmp$1167] = _tmp$1168;
    moonbit_decref(buffer$236);
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int64_to_string_generic(
  uint16_t* buffer$218,
  uint64_t num$212,
  int32_t digit_start$210,
  int32_t total_len$209,
  int32_t radix$214
) {
  int32_t offset$208 = total_len$209 - digit_start$210;
  uint64_t n$211 = num$212;
  int64_t _tmp$1115 = (int64_t)radix$214;
  uint64_t base$213 = *(uint64_t*)&_tmp$1115;
  int32_t _tmp$1095 = radix$214 - 1;
  int32_t _tmp$1094 = radix$214 & _tmp$1095;
  if (_tmp$1094 == 0) {
    int32_t shift$215 = moonbit_ctz32(radix$214);
    uint64_t mask$216 = base$213 - 1ull;
    while (1) {
      uint64_t _tmp$1096 = n$211;
      if (_tmp$1096 > 0ull) {
        int32_t _tmp$1097 = offset$208;
        uint64_t _tmp$1104;
        uint64_t _tmp$1103;
        int32_t digit$217;
        int32_t _tmp$1101;
        int32_t _tmp$1098;
        int32_t _tmp$1100;
        int32_t _tmp$1099;
        uint64_t _tmp$1102;
        offset$208 = _tmp$1097 - 1;
        _tmp$1104 = n$211;
        _tmp$1103 = _tmp$1104 & mask$216;
        digit$217 = (int32_t)_tmp$1103;
        _tmp$1101 = offset$208;
        _tmp$1098 = digit_start$210 + _tmp$1101;
        _tmp$1100
        = ((moonbit_string_t)moonbit_string_literal_16.data)[
          digit$217
        ];
        _tmp$1099 = (uint16_t)_tmp$1100;
        buffer$218[_tmp$1098] = _tmp$1099;
        _tmp$1102 = n$211;
        n$211 = _tmp$1102 >> (shift$215 & 63);
        continue;
      } else {
        moonbit_decref(buffer$218);
      }
      break;
    }
  } else {
    while (1) {
      uint64_t _tmp$1105 = n$211;
      if (_tmp$1105 > 0ull) {
        int32_t _tmp$1106 = offset$208;
        uint64_t _tmp$1114;
        uint64_t q$220;
        uint64_t _tmp$1112;
        uint64_t _tmp$1113;
        uint64_t _tmp$1111;
        int32_t digit$221;
        int32_t _tmp$1110;
        int32_t _tmp$1107;
        int32_t _tmp$1109;
        int32_t _tmp$1108;
        offset$208 = _tmp$1106 - 1;
        _tmp$1114 = n$211;
        q$220 = _tmp$1114 / base$213;
        _tmp$1112 = n$211;
        _tmp$1113 = q$220 * base$213;
        _tmp$1111 = _tmp$1112 - _tmp$1113;
        digit$221 = (int32_t)_tmp$1111;
        _tmp$1110 = offset$208;
        _tmp$1107 = digit_start$210 + _tmp$1110;
        _tmp$1109
        = ((moonbit_string_t)moonbit_string_literal_16.data)[
          digit$221
        ];
        _tmp$1108 = (uint16_t)_tmp$1109;
        buffer$218[_tmp$1107] = _tmp$1108;
        n$211 = q$220;
        continue;
      } else {
        moonbit_decref(buffer$218);
      }
      break;
    }
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int64_to_string_hex(
  uint16_t* buffer$205,
  uint64_t num$201,
  int32_t digit_start$199,
  int32_t total_len$198
) {
  int32_t offset$197 = total_len$198 - digit_start$199;
  uint64_t n$200 = num$201;
  int32_t _tmp$1089;
  while (1) {
    int32_t _tmp$1075 = offset$197;
    if (_tmp$1075 >= 2) {
      int32_t _tmp$1076 = offset$197;
      uint64_t _tmp$1088;
      uint64_t _tmp$1087;
      int32_t byte_val$202;
      int32_t hi$203;
      int32_t lo$204;
      int32_t _tmp$1080;
      int32_t _tmp$1077;
      int32_t _tmp$1079;
      int32_t _tmp$1078;
      int32_t _tmp$1085;
      int32_t _tmp$1084;
      int32_t _tmp$1081;
      int32_t _tmp$1083;
      int32_t _tmp$1082;
      uint64_t _tmp$1086;
      offset$197 = _tmp$1076 - 2;
      _tmp$1088 = n$200;
      _tmp$1087 = _tmp$1088 & 255ull;
      byte_val$202 = (int32_t)_tmp$1087;
      hi$203 = byte_val$202 / 16;
      lo$204 = byte_val$202 % 16;
      _tmp$1080 = offset$197;
      _tmp$1077 = digit_start$199 + _tmp$1080;
      _tmp$1079 = ((moonbit_string_t)moonbit_string_literal_16.data)[hi$203];
      _tmp$1078 = (uint16_t)_tmp$1079;
      buffer$205[_tmp$1077] = _tmp$1078;
      _tmp$1085 = offset$197;
      _tmp$1084 = digit_start$199 + _tmp$1085;
      _tmp$1081 = _tmp$1084 + 1;
      _tmp$1083 = ((moonbit_string_t)moonbit_string_literal_16.data)[lo$204];
      _tmp$1082 = (uint16_t)_tmp$1083;
      buffer$205[_tmp$1081] = _tmp$1082;
      _tmp$1086 = n$200;
      n$200 = _tmp$1086 >> 8;
      continue;
    }
    break;
  }
  _tmp$1089 = offset$197;
  if (_tmp$1089 == 1) {
    uint64_t _tmp$1093 = n$200;
    uint64_t _tmp$1092 = _tmp$1093 & 15ull;
    int32_t nibble$207 = (int32_t)_tmp$1092;
    int32_t _tmp$1091 =
      ((moonbit_string_t)moonbit_string_literal_16.data)[nibble$207];
    int32_t _tmp$1090 = (uint16_t)_tmp$1091;
    buffer$205[digit_start$199] = _tmp$1090;
    moonbit_decref(buffer$205);
  } else {
    moonbit_decref(buffer$205);
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$radix_count64(
  uint64_t value$191,
  int32_t radix$194
) {
  uint64_t num$192;
  int64_t _tmp$1074;
  uint64_t base$193;
  int32_t count$195;
  if (value$191 == 0ull) {
    return 1;
  }
  num$192 = value$191;
  _tmp$1074 = (int64_t)radix$194;
  base$193 = *(uint64_t*)&_tmp$1074;
  count$195 = 0;
  while (1) {
    uint64_t _tmp$1071 = num$192;
    if (_tmp$1071 > 0ull) {
      int32_t _tmp$1072 = count$195;
      uint64_t _tmp$1073;
      count$195 = _tmp$1072 + 1;
      _tmp$1073 = num$192;
      num$192 = _tmp$1073 / base$193;
      continue;
    }
    break;
  }
  return count$195;
}

int32_t $moonbitlang$core$builtin$hex_count64(uint64_t value$189) {
  if (value$189 == 0ull) {
    return 1;
  } else {
    int32_t leading_zeros$190 = moonbit_clz64(value$189);
    int32_t _tmp$1070 = 63 - leading_zeros$190;
    int32_t _tmp$1069 = _tmp$1070 / 4;
    return _tmp$1069 + 1;
  }
}

int32_t $moonbitlang$core$builtin$dec_count64(uint64_t value$188) {
  if (value$188 >= 10000000000ull) {
    if (value$188 >= 100000000000000ull) {
      if (value$188 >= 10000000000000000ull) {
        if (value$188 >= 1000000000000000000ull) {
          if (value$188 >= 10000000000000000000ull) {
            return 20;
          } else {
            return 19;
          }
        } else if (value$188 >= 100000000000000000ull) {
          return 18;
        } else {
          return 17;
        }
      } else if (value$188 >= 1000000000000000ull) {
        return 16;
      } else {
        return 15;
      }
    } else if (value$188 >= 1000000000000ull) {
      if (value$188 >= 10000000000000ull) {
        return 14;
      } else {
        return 13;
      }
    } else if (value$188 >= 100000000000ull) {
      return 12;
    } else {
      return 11;
    }
  } else if (value$188 >= 100000ull) {
    if (value$188 >= 10000000ull) {
      if (value$188 >= 1000000000ull) {
        return 10;
      } else if (value$188 >= 100000000ull) {
        return 9;
      } else {
        return 8;
      }
    } else if (value$188 >= 1000000ull) {
      return 7;
    } else {
      return 6;
    }
  } else if (value$188 >= 1000ull) {
    if (value$188 >= 10000ull) {
      return 5;
    } else {
      return 4;
    }
  } else if (value$188 >= 100ull) {
    return 3;
  } else if (value$188 >= 10ull) {
    return 2;
  } else {
    return 1;
  }
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(
  uint64_t self$187
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$186 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$1068;
  moonbit_incref(logger$186);
  _tmp$1068
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$186
  };
  $$moonbitlang$core$builtin$Show$$UInt64$$output(self$187, _tmp$1068);
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$186);
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  moonbit_string_t self$185
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$184 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$1067;
  moonbit_incref(logger$184);
  _tmp$1067
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$184
  };
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
    self$185, _tmp$1067
  );
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$184);
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  double self$183
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$182 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$1066;
  moonbit_incref(logger$182);
  _tmp$1066
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$182
  };
  $$moonbitlang$core$builtin$Show$$Double$$output(self$183, _tmp$1066);
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$182);
}

int32_t $StringView$$start_offset(struct $StringView self$181) {
  int32_t _field$1672 = self$181.$1;
  moonbit_decref(self$181.$0);
  return _field$1672;
}

moonbit_string_t $StringView$$data(struct $StringView self$180) {
  moonbit_string_t _field$1673 = self$180.$0;
  return _field$1673;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$174,
  moonbit_string_t value$177,
  int32_t start$178,
  int32_t len$179
) {
  void* _try_err$176;
  struct $StringView _tmp$1061;
  int32_t _tmp$1063 = start$178 + len$179;
  int64_t _tmp$1062 = (int64_t)_tmp$1063;
  struct moonbit_result_0 _tmp$1770 =
    $String$$sub$inner(value$177, start$178, _tmp$1062);
  if (_tmp$1770.tag) {
    struct $StringView const _ok$1064 = _tmp$1770.data.ok;
    _tmp$1061 = _ok$1064;
  } else {
    void* const _err$1065 = _tmp$1770.data.err;
    _try_err$176 = _err$1065;
    goto $join$175;
  }
  goto $joinlet$1769;
  $join$175:;
  moonbit_decref(_try_err$176);
  moonbit_panic();
  $joinlet$1769:;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    self$174, _tmp$1061
  );
  return 0;
}

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$167,
  int32_t start$173,
  int64_t end$169
) {
  int32_t len$166 = Moonbit_array_length(self$167);
  int32_t end$168;
  int32_t start$172;
  if (end$169 == 4294967296ll) {
    end$168 = len$166;
  } else {
    int64_t _Some$170 = end$169;
    int32_t _end$171 = (int32_t)_Some$170;
    if (_end$171 < 0) {
      end$168 = len$166 + _end$171;
    } else {
      end$168 = _end$171;
    }
  }
  if (start$173 < 0) {
    start$172 = len$166 + start$173;
  } else {
    start$172 = start$173;
  }
  if (start$172 >= 0 && start$172 <= end$168 && end$168 <= len$166) {
    int32_t _if_result$1771;
    int32_t _if_result$1773;
    struct $StringView _tmp$1059;
    struct moonbit_result_0 _result$1775;
    if (start$172 < len$166) {
      int32_t _p$647 = self$167[start$172];
      _if_result$1771 = 56320 <= _p$647 && _p$647 <= 57343;
    } else {
      _if_result$1771 = 0;
    }
    if (_if_result$1771) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$1057;
      struct moonbit_result_0 _result$1772;
      moonbit_decref(self$167);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$1057
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$1772.tag = 0;
      _result$1772.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$1057;
      return _result$1772;
    }
    if (end$168 < len$166) {
      int32_t _p$650 = self$167[end$168];
      _if_result$1773 = 56320 <= _p$650 && _p$650 <= 57343;
    } else {
      _if_result$1773 = 0;
    }
    if (_if_result$1773) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$1058;
      struct moonbit_result_0 _result$1774;
      moonbit_decref(self$167);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$1058
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$1774.tag = 0;
      _result$1774.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$1058;
      return _result$1774;
    }
    _tmp$1059 = (struct $StringView){start$172, end$168, self$167};
    _result$1775.tag = 1;
    _result$1775.data.ok = _tmp$1059;
    return _result$1775;
  } else {
    void* moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$1060;
    struct moonbit_result_0 _result$1776;
    moonbit_decref(self$167);
    moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$1060
    = (struct moonbit_object*)&moonbit_constant_constructor_1 + 1;
    _result$1776.tag = 0;
    _result$1776.data.err
    = moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$1060;
    return _result$1776;
  }
}

uint64_t $Int$$to_uint64(int32_t self$165) {
  int64_t _tmp$1056 = (int64_t)self$165;
  return *(uint64_t*)&_tmp$1056;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$163,
  moonbit_string_t str$164
) {
  int32_t len$1046 = self$163->$1;
  int32_t _tmp$1048 = Moonbit_array_length(str$164);
  int32_t _tmp$1047 = _tmp$1048 * 2;
  int32_t _tmp$1045 = len$1046 + _tmp$1047;
  moonbit_bytes_t _field$1675;
  moonbit_bytes_t data$1049;
  int32_t len$1050;
  int32_t _tmp$1051;
  int32_t len$1053;
  int32_t _tmp$1674;
  int32_t _tmp$1055;
  int32_t _tmp$1054;
  int32_t _tmp$1052;
  moonbit_incref(self$163);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$163, _tmp$1045
  );
  _field$1675 = self$163->$0;
  data$1049 = _field$1675;
  len$1050 = self$163->$1;
  _tmp$1051 = Moonbit_array_length(str$164);
  moonbit_incref(data$1049);
  moonbit_incref(str$164);
  $FixedArray$$blit_from_string(data$1049, len$1050, str$164, 0, _tmp$1051);
  len$1053 = self$163->$1;
  _tmp$1674 = Moonbit_array_length(str$164);
  moonbit_decref(str$164);
  _tmp$1055 = _tmp$1674;
  _tmp$1054 = _tmp$1055 * 2;
  _tmp$1052 = len$1053 + _tmp$1054;
  self$163->$1 = _tmp$1052;
  moonbit_decref(self$163);
  return 0;
}

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$155,
  int32_t bytes_offset$150,
  moonbit_string_t str$157,
  int32_t str_offset$153,
  int32_t length$151
) {
  int32_t _tmp$1044 = length$151 * 2;
  int32_t _tmp$1043 = bytes_offset$150 + _tmp$1044;
  int32_t e1$149 = _tmp$1043 - 1;
  int32_t _tmp$1042 = str_offset$153 + length$151;
  int32_t e2$152 = _tmp$1042 - 1;
  int32_t len1$154 = Moonbit_array_length(self$155);
  int32_t len2$156 = Moonbit_array_length(str$157);
  if (
    length$151 >= 0
    && bytes_offset$150 >= 0
    && e1$149 < len1$154
    && str_offset$153 >= 0
    && e2$152 < len2$156
  ) {
    int32_t end_str_offset$158 = str_offset$153 + length$151;
    int32_t i$159 = str_offset$153;
    int32_t j$160 = bytes_offset$150;
    while (1) {
      if (i$159 < end_str_offset$158) {
        int32_t _tmp$1039 = str$157[i$159];
        uint32_t c$161 = *(uint32_t*)&_tmp$1039;
        uint32_t _p$641 = c$161 & 255u;
        int32_t _tmp$1035 = *(int32_t*)&_p$641;
        int32_t _tmp$1034 = _tmp$1035 & 0xff;
        int32_t _tmp$1036;
        uint32_t _p$644;
        int32_t _tmp$1038;
        int32_t _tmp$1037;
        int32_t _tmp$1040;
        int32_t _tmp$1041;
        if (j$160 < 0 || j$160 >= Moonbit_array_length(self$155)) {
          moonbit_panic();
        }
        self$155[j$160] = _tmp$1034;
        _tmp$1036 = j$160 + 1;
        _p$644 = c$161 >> 8;
        _tmp$1038 = *(int32_t*)&_p$644;
        _tmp$1037 = _tmp$1038 & 0xff;
        if (_tmp$1036 < 0 || _tmp$1036 >= Moonbit_array_length(self$155)) {
          moonbit_panic();
        }
        self$155[_tmp$1036] = _tmp$1037;
        _tmp$1040 = i$159 + 1;
        _tmp$1041 = j$160 + 2;
        i$159 = _tmp$1040;
        j$160 = _tmp$1041;
        continue;
      } else {
        moonbit_decref(str$157);
        moonbit_decref(self$155);
      }
      break;
    }
  } else {
    moonbit_decref(str$157);
    moonbit_decref(self$155);
    moonbit_panic();
  }
  return 0;
}

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$117
) {
  int32_t _tmp$1003 = Moonbit_array_length(repr$117);
  int64_t _tmp$1002 = (int64_t)_tmp$1003;
  moonbit_incref(repr$117);
  if ($String$$char_length_ge$inner(repr$117, 1, 0, _tmp$1002)) {
    int32_t _tmp$1033 = repr$117[0];
    int32_t _x$118 = _tmp$1033;
    if (_x$118 == 64) {
      int32_t _tmp$1032 = Moonbit_array_length(repr$117);
      int64_t _tmp$1031 = (int64_t)_tmp$1032;
      int64_t _bind$539;
      int32_t _tmp$1029;
      int32_t _tmp$1030;
      struct $StringView _x$119;
      int32_t _tmp$1028;
      struct $StringView _tmp$1027;
      int64_t _bind$121;
      moonbit_incref(repr$117);
      _bind$539
      = $String$$offset_of_nth_char$inner(
        repr$117, 1, 0, _tmp$1031
      );
      if (_bind$539 == 4294967296ll) {
        _tmp$1029 = Moonbit_array_length(repr$117);
      } else {
        int64_t _Some$120 = _bind$539;
        _tmp$1029 = (int32_t)_Some$120;
      }
      _tmp$1030 = Moonbit_array_length(repr$117);
      _x$119 = (struct $StringView){_tmp$1029, _tmp$1030, repr$117};
      _tmp$1028
      = Moonbit_array_length(
        $moonbitlang$core$builtin$parse$$2a$bind$7c$5443
      );
      moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5443);
      _tmp$1027
      = (struct $StringView){
        0, _tmp$1028, $moonbitlang$core$builtin$parse$$2a$bind$7c$5443
      };
      moonbit_incref(_x$119.$0);
      _bind$121 = $StringView$$find(_x$119, _tmp$1027);
      if (_bind$121 == 4294967296ll) {
        moonbit_decref(_x$119.$0);
        moonbit_panic();
      } else {
        int64_t _Some$122 = _bind$121;
        int32_t _pkg_end$123 = (int32_t)_Some$122;
        int64_t _tmp$1026 = (int64_t)_pkg_end$123;
        struct $StringView pkg$124;
        int32_t _tmp$1025;
        struct $StringView _tmp$1024;
        int64_t _bind$125;
        moonbit_incref(_x$119.$0);
        pkg$124 = $StringView$$view$inner(_x$119, 0, _tmp$1026);
        _tmp$1025
        = Moonbit_array_length(
          $moonbitlang$core$builtin$parse$$2a$bind$7c$5437
        );
        moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5437);
        _tmp$1024
        = (struct $StringView){
          0, _tmp$1025, $moonbitlang$core$builtin$parse$$2a$bind$7c$5437
        };
        moonbit_incref(_x$119.$0);
        _bind$125 = $StringView$$rev_find(_x$119, _tmp$1024);
        if (_bind$125 == 4294967296ll) {
          moonbit_decref(pkg$124.$0);
          moonbit_decref(_x$119.$0);
          moonbit_panic();
        } else {
          int64_t _Some$126 = _bind$125;
          int32_t _start_loc_end$127 = (int32_t)_Some$126;
          int32_t _tmp$1004 = _start_loc_end$127 + 1;
          int32_t end$1006 = _x$119.$2;
          int32_t start$1007 = _x$119.$1;
          int32_t _tmp$1005 = end$1006 - start$1007;
          if (_tmp$1004 < _tmp$1005) {
            int32_t _tmp$1023 = _start_loc_end$127 + 1;
            struct $StringView end_loc$128;
            struct $$3c$StringView$2a$StringView$3e$* _bind$129;
            moonbit_incref(_x$119.$0);
            end_loc$128
            = $StringView$$view$inner(
              _x$119, _tmp$1023, 4294967296ll
            );
            _bind$129
            = $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
              end_loc$128
            );
            if (_bind$129 == 0) {
              if (_bind$129) {
                moonbit_decref(_bind$129);
              }
              moonbit_decref(pkg$124.$0);
              moonbit_decref(_x$119.$0);
              moonbit_panic();
            } else {
              struct $$3c$StringView$2a$StringView$3e$* _Some$130 = _bind$129;
              struct $$3c$StringView$2a$StringView$3e$* _x$131 = _Some$130;
              struct $StringView _field$1679 =
                (struct $StringView){
                  _x$131->$0_1, _x$131->$0_2, _x$131->$0_0
                };
              struct $StringView _end_line$132 = _field$1679;
              struct $StringView _field$1678 =
                (struct $StringView){
                  _x$131->$1_1, _x$131->$1_2, _x$131->$1_0
                };
              int32_t _cnt$1736 = Moonbit_object_header(_x$131)->rc;
              struct $StringView _end_column$133;
              int64_t _tmp$1022;
              struct $StringView rest$134;
              int32_t _tmp$1021;
              struct $StringView _tmp$1020;
              int64_t _bind$136;
              if (_cnt$1736 > 1) {
                int32_t _new_cnt$1737;
                moonbit_incref(_field$1678.$0);
                moonbit_incref(_end_line$132.$0);
                _new_cnt$1737 = _cnt$1736 - 1;
                Moonbit_object_header(_x$131)->rc = _new_cnt$1737;
              } else if (_cnt$1736 == 1) {
                moonbit_free(_x$131);
              }
              _end_column$133 = _field$1678;
              _tmp$1022 = (int64_t)_start_loc_end$127;
              rest$134 = $StringView$$view$inner(_x$119, 0, _tmp$1022);
              _tmp$1021
              = Moonbit_array_length(
                $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              );
              moonbit_incref(
                $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              );
              _tmp$1020
              = (struct $StringView){
                0,
                  _tmp$1021,
                  $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              };
              moonbit_incref(rest$134.$0);
              _bind$136 = $StringView$$rev_find(rest$134, _tmp$1020);
              if (_bind$136 == 4294967296ll) {
                moonbit_decref(rest$134.$0);
                moonbit_decref(_end_column$133.$0);
                moonbit_decref(_end_line$132.$0);
                moonbit_decref(pkg$124.$0);
                goto $join$135;
              } else {
                int64_t _Some$137 = _bind$136;
                int32_t _start_line_end$138 = (int32_t)_Some$137;
                int64_t _tmp$1019 = (int64_t)_start_line_end$138;
                struct $StringView _tmp$1016;
                int32_t _tmp$1018;
                struct $StringView _tmp$1017;
                int64_t _bind$139;
                moonbit_incref(rest$134.$0);
                _tmp$1016 = $StringView$$view$inner(rest$134, 0, _tmp$1019);
                _tmp$1018
                = Moonbit_array_length(
                  $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                );
                moonbit_incref(
                  $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                );
                _tmp$1017
                = (struct $StringView){
                  0,
                    _tmp$1018,
                    $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                };
                _bind$139 = $StringView$$rev_find(_tmp$1016, _tmp$1017);
                if (_bind$139 == 4294967296ll) {
                  moonbit_decref(rest$134.$0);
                  moonbit_decref(_end_column$133.$0);
                  moonbit_decref(_end_line$132.$0);
                  moonbit_decref(pkg$124.$0);
                  goto $join$135;
                } else {
                  int64_t _Some$140 = _bind$139;
                  int32_t _filename_end$141 = (int32_t)_Some$140;
                  int32_t _tmp$1008 = _filename_end$141 + 1;
                  int32_t end$1010 = rest$134.$2;
                  int32_t start$1011 = rest$134.$1;
                  int32_t _tmp$1009 = end$1010 - start$1011;
                  if (_tmp$1008 < _tmp$1009) {
                    int32_t _tmp$1015 = _filename_end$141 + 1;
                    struct $StringView start_loc$142;
                    struct $$3c$StringView$2a$StringView$3e$* _bind$143;
                    moonbit_incref(rest$134.$0);
                    start_loc$142
                    = $StringView$$view$inner(
                      rest$134, _tmp$1015, 4294967296ll
                    );
                    _bind$143
                    = $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
                      start_loc$142
                    );
                    if (_bind$143 == 0) {
                      if (_bind$143) {
                        moonbit_decref(_bind$143);
                      }
                      moonbit_decref(rest$134.$0);
                      moonbit_decref(_end_column$133.$0);
                      moonbit_decref(_end_line$132.$0);
                      moonbit_decref(pkg$124.$0);
                      moonbit_panic();
                    } else {
                      struct $$3c$StringView$2a$StringView$3e$* _Some$144 =
                        _bind$143;
                      struct $$3c$StringView$2a$StringView$3e$* _x$145 =
                        _Some$144;
                      struct $StringView _field$1677 =
                        (struct $StringView){
                          _x$145->$0_1, _x$145->$0_2, _x$145->$0_0
                        };
                      struct $StringView _start_line$146 = _field$1677;
                      struct $StringView _field$1676 =
                        (struct $StringView){
                          _x$145->$1_1, _x$145->$1_2, _x$145->$1_0
                        };
                      int32_t _cnt$1738 = Moonbit_object_header(_x$145)->rc;
                      struct $StringView _start_column$147;
                      int32_t _tmp$1012;
                      if (_cnt$1738 > 1) {
                        int32_t _new_cnt$1739;
                        moonbit_incref(_field$1676.$0);
                        moonbit_incref(_start_line$146.$0);
                        _new_cnt$1739 = _cnt$1738 - 1;
                        Moonbit_object_header(_x$145)->rc = _new_cnt$1739;
                      } else if (_cnt$1738 == 1) {
                        moonbit_free(_x$145);
                      }
                      _start_column$147 = _field$1676;
                      _tmp$1012 = _pkg_end$123 + 1;
                      if (_filename_end$141 > _tmp$1012) {
                        int32_t _tmp$1013 = _pkg_end$123 + 1;
                        int64_t _tmp$1014 = (int64_t)_filename_end$141;
                        struct $StringView filename$148 =
                          $StringView$$view$inner(
                            rest$134, _tmp$1013, _tmp$1014
                          );
                        struct $$moonbitlang$core$builtin$SourceLocRepr* _block$1780 =
                          (struct $$moonbitlang$core$builtin$SourceLocRepr*)moonbit_malloc(
                            sizeof(
                              struct $$moonbitlang$core$builtin$SourceLocRepr
                            )
                          );
                        Moonbit_object_header(_block$1780)->meta
                        = Moonbit_make_regular_object_header(
                          offsetof(
                            struct $$moonbitlang$core$builtin$SourceLocRepr,
                              $0_0
                          )
                          >> 2,
                            6,
                            0
                        );
                        _block$1780->$0_0 = pkg$124.$0;
                        _block$1780->$0_1 = pkg$124.$1;
                        _block$1780->$0_2 = pkg$124.$2;
                        _block$1780->$1_0 = filename$148.$0;
                        _block$1780->$1_1 = filename$148.$1;
                        _block$1780->$1_2 = filename$148.$2;
                        _block$1780->$2_0 = _start_line$146.$0;
                        _block$1780->$2_1 = _start_line$146.$1;
                        _block$1780->$2_2 = _start_line$146.$2;
                        _block$1780->$3_0 = _start_column$147.$0;
                        _block$1780->$3_1 = _start_column$147.$1;
                        _block$1780->$3_2 = _start_column$147.$2;
                        _block$1780->$4_0 = _end_line$132.$0;
                        _block$1780->$4_1 = _end_line$132.$1;
                        _block$1780->$4_2 = _end_line$132.$2;
                        _block$1780->$5_0 = _end_column$133.$0;
                        _block$1780->$5_1 = _end_column$133.$1;
                        _block$1780->$5_2 = _end_column$133.$2;
                        return _block$1780;
                      } else {
                        moonbit_decref(_start_column$147.$0);
                        moonbit_decref(_start_line$146.$0);
                        moonbit_decref(rest$134.$0);
                        moonbit_decref(_end_column$133.$0);
                        moonbit_decref(_end_line$132.$0);
                        moonbit_decref(pkg$124.$0);
                        moonbit_panic();
                      }
                    }
                  } else {
                    moonbit_decref(rest$134.$0);
                    moonbit_decref(_end_column$133.$0);
                    moonbit_decref(_end_line$132.$0);
                    moonbit_decref(pkg$124.$0);
                    moonbit_panic();
                  }
                }
              }
              $join$135:;
              moonbit_panic();
            }
          } else {
            moonbit_decref(pkg$124.$0);
            moonbit_decref(_x$119.$0);
            moonbit_panic();
          }
        }
      }
    } else {
      moonbit_decref(repr$117);
      goto $join$116;
    }
  } else {
    moonbit_decref(repr$117);
    goto $join$116;
  }
  $join$116:;
  moonbit_panic();
}

struct $$3c$StringView$2a$StringView$3e$* $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
  struct $StringView view$113
) {
  int32_t _tmp$1001 =
    Moonbit_array_length($moonbitlang$core$builtin$parse$$2a$bind$7c$5404);
  struct $StringView _tmp$1000;
  int64_t _bind$112;
  moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5404);
  _tmp$1000
  = (struct $StringView){
    0, _tmp$1001, $moonbitlang$core$builtin$parse$$2a$bind$7c$5404
  };
  moonbit_incref(view$113.$0);
  _bind$112 = $StringView$$find(view$113, _tmp$1000);
  if (_bind$112 == 4294967296ll) {
    moonbit_decref(view$113.$0);
    return 0;
  } else {
    int64_t _Some$114 = _bind$112;
    int32_t _i$115 = (int32_t)_Some$114;
    int32_t _if_result$1781;
    if (_i$115 > 0) {
      int32_t _tmp$991 = _i$115 + 1;
      int32_t end$993 = view$113.$2;
      int32_t start$994 = view$113.$1;
      int32_t _tmp$992 = end$993 - start$994;
      _if_result$1781 = _tmp$991 < _tmp$992;
    } else {
      _if_result$1781 = 0;
    }
    if (_if_result$1781) {
      int64_t _tmp$999 = (int64_t)_i$115;
      struct $StringView _tmp$996;
      int32_t _tmp$998;
      struct $StringView _tmp$997;
      struct $$3c$StringView$2a$StringView$3e$* _tuple$995;
      moonbit_incref(view$113.$0);
      _tmp$996 = $StringView$$view$inner(view$113, 0, _tmp$999);
      _tmp$998 = _i$115 + 1;
      _tmp$997 = $StringView$$view$inner(view$113, _tmp$998, 4294967296ll);
      _tuple$995
      = (struct $$3c$StringView$2a$StringView$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$StringView$3e$)
        );
      Moonbit_object_header(_tuple$995)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $$3c$StringView$2a$StringView$3e$, $0_0) >> 2, 2, 0
      );
      _tuple$995->$0_0 = _tmp$996.$0;
      _tuple$995->$0_1 = _tmp$996.$1;
      _tuple$995->$0_2 = _tmp$996.$2;
      _tuple$995->$1_0 = _tmp$997.$0;
      _tuple$995->$1_1 = _tmp$997.$1;
      _tuple$995->$1_2 = _tmp$997.$2;
      return _tuple$995;
    } else {
      moonbit_decref(view$113.$0);
      return 0;
    }
  }
}

struct $StringView $StringView$$view$inner(
  struct $StringView self$110,
  int32_t start_offset$111,
  int64_t end_offset$108
) {
  int32_t end_offset$107;
  int32_t _if_result$1782;
  if (end_offset$108 == 4294967296ll) {
    int32_t end$989 = self$110.$2;
    int32_t start$990 = self$110.$1;
    end_offset$107 = end$989 - start$990;
  } else {
    int64_t _Some$109 = end_offset$108;
    end_offset$107 = (int32_t)_Some$109;
  }
  if (start_offset$111 >= 0) {
    if (start_offset$111 <= end_offset$107) {
      int32_t end$982 = self$110.$2;
      int32_t start$983 = self$110.$1;
      int32_t _tmp$981 = end$982 - start$983;
      _if_result$1782 = end_offset$107 <= _tmp$981;
    } else {
      _if_result$1782 = 0;
    }
  } else {
    _if_result$1782 = 0;
  }
  if (_if_result$1782) {
    moonbit_string_t _field$1681 = self$110.$0;
    moonbit_string_t str$984 = _field$1681;
    int32_t start$988 = self$110.$1;
    int32_t _tmp$985 = start$988 + start_offset$111;
    int32_t _field$1680 = self$110.$1;
    int32_t start$987 = _field$1680;
    int32_t _tmp$986 = start$987 + end_offset$107;
    return (struct $StringView){_tmp$985, _tmp$986, str$984};
  } else {
    moonbit_decref(self$110.$0);
    return $moonbitlang$core$builtin$abort$1(
             (moonbit_string_t)moonbit_string_literal_17.data,
               (moonbit_string_t)moonbit_string_literal_18.data
           );
  }
}

int64_t $StringView$$rev_find(
  struct $StringView self$106,
  struct $StringView str$105
) {
  int32_t end$979 = str$105.$2;
  int32_t start$980 = str$105.$1;
  int32_t _tmp$978 = end$979 - start$980;
  if (_tmp$978 <= 4) {
    return $moonbitlang$core$builtin$brute_force_rev_find(self$106, str$105);
  } else {
    return $moonbitlang$core$builtin$boyer_moore_horspool_rev_find(
             self$106, str$105
           );
  }
}

int64_t $moonbitlang$core$builtin$brute_force_rev_find(
  struct $StringView haystack$96,
  struct $StringView needle$98
) {
  int32_t end$976 = haystack$96.$2;
  int32_t start$977 = haystack$96.$1;
  int32_t haystack_len$95 = end$976 - start$977;
  int32_t end$974 = needle$98.$2;
  int32_t start$975 = needle$98.$1;
  int32_t needle_len$97 = end$974 - start$975;
  if (needle_len$97 > 0) {
    if (haystack_len$95 >= needle_len$97) {
      int32_t _p$618 = 0;
      moonbit_string_t _field$1689 = needle$98.$0;
      moonbit_string_t str$971 = _field$1689;
      int32_t start$973 = needle$98.$1;
      int32_t _tmp$972 = start$973 + _p$618;
      int32_t _tmp$1688 = str$971[_tmp$972];
      int32_t needle_first$99 = _tmp$1688;
      int32_t i$100 = haystack_len$95 - needle_len$97;
      while (1) {
        int32_t _tmp$951 = i$100;
        if (_tmp$951 >= 0) {
          int32_t _tmp$958;
          while (1) {
            int32_t _tmp$956 = i$100;
            int32_t _if_result$1785;
            if (_tmp$956 >= 0) {
              int32_t _p$621 = i$100;
              moonbit_string_t _field$1687 = haystack$96.$0;
              moonbit_string_t str$953 = _field$1687;
              int32_t start$955 = haystack$96.$1;
              int32_t _tmp$954 = start$955 + _p$621;
              int32_t _tmp$1686 = str$953[_tmp$954];
              int32_t _tmp$952 = _tmp$1686;
              _if_result$1785 = _tmp$952 != needle_first$99;
            } else {
              _if_result$1785 = 0;
            }
            if (_if_result$1785) {
              int32_t _tmp$957 = i$100;
              i$100 = _tmp$957 - 1;
              continue;
            }
            break;
          }
          _tmp$958 = i$100;
          if (_tmp$958 >= 0) {
            int32_t j$102 = 1;
            int32_t _tmp$970;
            while (1) {
              if (j$102 < needle_len$97) {
                int32_t _tmp$967 = i$100;
                int32_t _p$624 = _tmp$967 + j$102;
                moonbit_string_t _field$1685 = haystack$96.$0;
                moonbit_string_t str$964 = _field$1685;
                int32_t start$966 = haystack$96.$1;
                int32_t _tmp$965 = start$966 + _p$624;
                int32_t _tmp$1684 = str$964[_tmp$965];
                int32_t _tmp$959 = _tmp$1684;
                moonbit_string_t _field$1683 = needle$98.$0;
                moonbit_string_t str$961 = _field$1683;
                int32_t start$963 = needle$98.$1;
                int32_t _tmp$962 = start$963 + j$102;
                int32_t _tmp$1682 = str$961[_tmp$962];
                int32_t _tmp$960 = _tmp$1682;
                int32_t _tmp$968;
                if (_tmp$959 != _tmp$960) {
                  break;
                }
                _tmp$968 = j$102 + 1;
                j$102 = _tmp$968;
                continue;
              } else {
                int32_t _tmp$969;
                moonbit_decref(needle$98.$0);
                moonbit_decref(haystack$96.$0);
                _tmp$969 = i$100;
                return (int64_t)_tmp$969;
              }
              break;
            }
            _tmp$970 = i$100;
            i$100 = _tmp$970 - 1;
          }
          continue;
        } else {
          moonbit_decref(needle$98.$0);
          moonbit_decref(haystack$96.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$98.$0);
      moonbit_decref(haystack$96.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$98.$0);
    moonbit_decref(haystack$96.$0);
    return (int64_t)haystack_len$95;
  }
}

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_rev_find(
  struct $StringView haystack$85,
  struct $StringView needle$87
) {
  int32_t end$949 = haystack$85.$2;
  int32_t start$950 = haystack$85.$1;
  int32_t haystack_len$84 = end$949 - start$950;
  int32_t end$947 = needle$87.$2;
  int32_t start$948 = needle$87.$1;
  int32_t needle_len$86 = end$947 - start$948;
  if (needle_len$86 > 0) {
    if (haystack_len$84 >= needle_len$86) {
      int32_t* skip_table$88 =
        (int32_t*)moonbit_make_int32_array(256, needle_len$86);
      int32_t _tmp$929 = needle_len$86 - 1;
      int32_t i$89 = _tmp$929;
      int32_t _tmp$946;
      int32_t i$91;
      while (1) {
        if (i$89 > 0) {
          moonbit_string_t _field$1697 = needle$87.$0;
          moonbit_string_t str$925 = _field$1697;
          int32_t start$927 = needle$87.$1;
          int32_t _tmp$926 = start$927 + i$89;
          int32_t _tmp$1696 = str$925[_tmp$926];
          int32_t _tmp$924 = _tmp$1696;
          int32_t _tmp$923 = _tmp$924 & 255;
          int32_t _tmp$928;
          if (
            _tmp$923 < 0 || _tmp$923 >= Moonbit_array_length(skip_table$88)
          ) {
            moonbit_panic();
          }
          skip_table$88[_tmp$923] = i$89;
          _tmp$928 = i$89 - 1;
          i$89 = _tmp$928;
          continue;
        }
        break;
      }
      _tmp$946 = haystack_len$84 - needle_len$86;
      i$91 = _tmp$946;
      while (1) {
        if (i$91 >= 0) {
          int32_t j$92 = 0;
          moonbit_string_t _field$1691;
          moonbit_string_t str$943;
          int32_t start$945;
          int32_t _tmp$944;
          int32_t _tmp$1690;
          int32_t _tmp$942;
          int32_t _tmp$941;
          int32_t _tmp$940;
          int32_t _tmp$939;
          while (1) {
            if (j$92 < needle_len$86) {
              int32_t _p$607 = i$91 + j$92;
              moonbit_string_t _field$1695 = haystack$85.$0;
              moonbit_string_t str$935 = _field$1695;
              int32_t start$937 = haystack$85.$1;
              int32_t _tmp$936 = start$937 + _p$607;
              int32_t _tmp$1694 = str$935[_tmp$936];
              int32_t _tmp$930 = _tmp$1694;
              moonbit_string_t _field$1693 = needle$87.$0;
              moonbit_string_t str$932 = _field$1693;
              int32_t start$934 = needle$87.$1;
              int32_t _tmp$933 = start$934 + j$92;
              int32_t _tmp$1692 = str$932[_tmp$933];
              int32_t _tmp$931 = _tmp$1692;
              int32_t _tmp$938;
              if (_tmp$930 != _tmp$931) {
                break;
              }
              _tmp$938 = j$92 + 1;
              j$92 = _tmp$938;
              continue;
            } else {
              moonbit_decref(skip_table$88);
              moonbit_decref(needle$87.$0);
              moonbit_decref(haystack$85.$0);
              return (int64_t)i$91;
            }
            break;
          }
          _field$1691 = haystack$85.$0;
          str$943 = _field$1691;
          start$945 = haystack$85.$1;
          _tmp$944 = start$945 + i$91;
          _tmp$1690 = str$943[_tmp$944];
          _tmp$942 = _tmp$1690;
          _tmp$941 = _tmp$942 & 255;
          if (
            _tmp$941 < 0 || _tmp$941 >= Moonbit_array_length(skip_table$88)
          ) {
            moonbit_panic();
          }
          _tmp$940 = (int32_t)skip_table$88[_tmp$941];
          _tmp$939 = i$91 - _tmp$940;
          i$91 = _tmp$939;
          continue;
        } else {
          moonbit_decref(skip_table$88);
          moonbit_decref(needle$87.$0);
          moonbit_decref(haystack$85.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$87.$0);
      moonbit_decref(haystack$85.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$87.$0);
    moonbit_decref(haystack$85.$0);
    return (int64_t)haystack_len$84;
  }
}

int64_t $StringView$$find(
  struct $StringView self$83,
  struct $StringView str$82
) {
  int32_t end$921 = str$82.$2;
  int32_t start$922 = str$82.$1;
  int32_t _tmp$920 = end$921 - start$922;
  if (_tmp$920 <= 4) {
    return $moonbitlang$core$builtin$brute_force_find(self$83, str$82);
  } else {
    return $moonbitlang$core$builtin$boyer_moore_horspool_find(
             self$83, str$82
           );
  }
}

int64_t $moonbitlang$core$builtin$brute_force_find(
  struct $StringView haystack$72,
  struct $StringView needle$74
) {
  int32_t end$918 = haystack$72.$2;
  int32_t start$919 = haystack$72.$1;
  int32_t haystack_len$71 = end$918 - start$919;
  int32_t end$916 = needle$74.$2;
  int32_t start$917 = needle$74.$1;
  int32_t needle_len$73 = end$916 - start$917;
  if (needle_len$73 > 0) {
    if (haystack_len$71 >= needle_len$73) {
      int32_t _p$588 = 0;
      moonbit_string_t _field$1705 = needle$74.$0;
      moonbit_string_t str$913 = _field$1705;
      int32_t start$915 = needle$74.$1;
      int32_t _tmp$914 = start$915 + _p$588;
      int32_t _tmp$1704 = str$913[_tmp$914];
      int32_t needle_first$75 = _tmp$1704;
      int32_t forward_len$76 = haystack_len$71 - needle_len$73;
      int32_t i$77 = 0;
      while (1) {
        int32_t _tmp$893 = i$77;
        if (_tmp$893 <= forward_len$76) {
          int32_t _tmp$900;
          while (1) {
            int32_t _tmp$898 = i$77;
            int32_t _if_result$1792;
            if (_tmp$898 <= forward_len$76) {
              int32_t _p$591 = i$77;
              moonbit_string_t _field$1703 = haystack$72.$0;
              moonbit_string_t str$895 = _field$1703;
              int32_t start$897 = haystack$72.$1;
              int32_t _tmp$896 = start$897 + _p$591;
              int32_t _tmp$1702 = str$895[_tmp$896];
              int32_t _tmp$894 = _tmp$1702;
              _if_result$1792 = _tmp$894 != needle_first$75;
            } else {
              _if_result$1792 = 0;
            }
            if (_if_result$1792) {
              int32_t _tmp$899 = i$77;
              i$77 = _tmp$899 + 1;
              continue;
            }
            break;
          }
          _tmp$900 = i$77;
          if (_tmp$900 <= forward_len$76) {
            int32_t j$79 = 1;
            int32_t _tmp$912;
            while (1) {
              if (j$79 < needle_len$73) {
                int32_t _tmp$909 = i$77;
                int32_t _p$594 = _tmp$909 + j$79;
                moonbit_string_t _field$1701 = haystack$72.$0;
                moonbit_string_t str$906 = _field$1701;
                int32_t start$908 = haystack$72.$1;
                int32_t _tmp$907 = start$908 + _p$594;
                int32_t _tmp$1700 = str$906[_tmp$907];
                int32_t _tmp$901 = _tmp$1700;
                moonbit_string_t _field$1699 = needle$74.$0;
                moonbit_string_t str$903 = _field$1699;
                int32_t start$905 = needle$74.$1;
                int32_t _tmp$904 = start$905 + j$79;
                int32_t _tmp$1698 = str$903[_tmp$904];
                int32_t _tmp$902 = _tmp$1698;
                int32_t _tmp$910;
                if (_tmp$901 != _tmp$902) {
                  break;
                }
                _tmp$910 = j$79 + 1;
                j$79 = _tmp$910;
                continue;
              } else {
                int32_t _tmp$911;
                moonbit_decref(needle$74.$0);
                moonbit_decref(haystack$72.$0);
                _tmp$911 = i$77;
                return (int64_t)_tmp$911;
              }
              break;
            }
            _tmp$912 = i$77;
            i$77 = _tmp$912 + 1;
          }
          continue;
        } else {
          moonbit_decref(needle$74.$0);
          moonbit_decref(haystack$72.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$74.$0);
      moonbit_decref(haystack$72.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$74.$0);
    moonbit_decref(haystack$72.$0);
    return $moonbitlang$core$builtin$brute_force_find$constr$70;
  }
}

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_find(
  struct $StringView haystack$58,
  struct $StringView needle$60
) {
  int32_t end$891 = haystack$58.$2;
  int32_t start$892 = haystack$58.$1;
  int32_t haystack_len$57 = end$891 - start$892;
  int32_t end$889 = needle$60.$2;
  int32_t start$890 = needle$60.$1;
  int32_t needle_len$59 = end$889 - start$890;
  if (needle_len$59 > 0) {
    if (haystack_len$57 >= needle_len$59) {
      int32_t* skip_table$61 =
        (int32_t*)moonbit_make_int32_array(256, needle_len$59);
      int32_t _end4301$62 = needle_len$59 - 1;
      int32_t i$63 = 0;
      int32_t i$65;
      while (1) {
        if (i$63 < _end4301$62) {
          moonbit_string_t _field$1713 = needle$60.$0;
          moonbit_string_t str$867 = _field$1713;
          int32_t start$869 = needle$60.$1;
          int32_t _tmp$868 = start$869 + i$63;
          int32_t _tmp$1712 = str$867[_tmp$868];
          int32_t _tmp$866 = _tmp$1712;
          int32_t _tmp$863 = _tmp$866 & 255;
          int32_t _tmp$865 = needle_len$59 - 1;
          int32_t _tmp$864 = _tmp$865 - i$63;
          int32_t _tmp$870;
          if (
            _tmp$863 < 0 || _tmp$863 >= Moonbit_array_length(skip_table$61)
          ) {
            moonbit_panic();
          }
          skip_table$61[_tmp$863] = _tmp$864;
          _tmp$870 = i$63 + 1;
          i$63 = _tmp$870;
          continue;
        }
        break;
      }
      i$65 = 0;
      while (1) {
        int32_t _tmp$871 = haystack_len$57 - needle_len$59;
        if (i$65 <= _tmp$871) {
          int32_t _end4307$66 = needle_len$59 - 1;
          int32_t j$67 = 0;
          int32_t _tmp$888;
          int32_t _p$581;
          moonbit_string_t _field$1707;
          moonbit_string_t str$885;
          int32_t start$887;
          int32_t _tmp$886;
          int32_t _tmp$1706;
          int32_t _tmp$884;
          int32_t _tmp$883;
          int32_t _tmp$882;
          int32_t _tmp$881;
          while (1) {
            if (j$67 <= _end4307$66) {
              int32_t _p$576 = i$65 + j$67;
              moonbit_string_t _field$1711 = haystack$58.$0;
              moonbit_string_t str$877 = _field$1711;
              int32_t start$879 = haystack$58.$1;
              int32_t _tmp$878 = start$879 + _p$576;
              int32_t _tmp$1710 = str$877[_tmp$878];
              int32_t _tmp$872 = _tmp$1710;
              moonbit_string_t _field$1709 = needle$60.$0;
              moonbit_string_t str$874 = _field$1709;
              int32_t start$876 = needle$60.$1;
              int32_t _tmp$875 = start$876 + j$67;
              int32_t _tmp$1708 = str$874[_tmp$875];
              int32_t _tmp$873 = _tmp$1708;
              int32_t _tmp$880;
              if (_tmp$872 != _tmp$873) {
                break;
              }
              _tmp$880 = j$67 + 1;
              j$67 = _tmp$880;
              continue;
            } else {
              moonbit_decref(skip_table$61);
              moonbit_decref(needle$60.$0);
              moonbit_decref(haystack$58.$0);
              return (int64_t)i$65;
            }
            break;
          }
          _tmp$888 = i$65 + needle_len$59;
          _p$581 = _tmp$888 - 1;
          _field$1707 = haystack$58.$0;
          str$885 = _field$1707;
          start$887 = haystack$58.$1;
          _tmp$886 = start$887 + _p$581;
          _tmp$1706 = str$885[_tmp$886];
          _tmp$884 = _tmp$1706;
          _tmp$883 = _tmp$884 & 255;
          if (
            _tmp$883 < 0 || _tmp$883 >= Moonbit_array_length(skip_table$61)
          ) {
            moonbit_panic();
          }
          _tmp$882 = (int32_t)skip_table$61[_tmp$883];
          _tmp$881 = i$65 + _tmp$882;
          i$65 = _tmp$881;
          continue;
        } else {
          moonbit_decref(skip_table$61);
          moonbit_decref(needle$60.$0);
          moonbit_decref(haystack$58.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$60.$0);
      moonbit_decref(haystack$58.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$60.$0);
    moonbit_decref(haystack$58.$0);
    return $moonbitlang$core$builtin$boyer_moore_horspool_find$constr$56;
  }
}

int32_t $StringView$$unsafe_charcode_at(
  struct $StringView self$54,
  int32_t index$55
) {
  moonbit_string_t _field$1716 = self$54.$0;
  moonbit_string_t str$860 = _field$1716;
  int32_t _field$1715 = self$54.$1;
  int32_t start$862 = _field$1715;
  int32_t _tmp$861 = start$862 + index$55;
  int32_t _tmp$1714 = str$860[_tmp$861];
  moonbit_decref(str$860);
  return _tmp$1714;
}

int32_t $StringView$$length(struct $StringView self$53) {
  int32_t end$858 = self$53.$2;
  int32_t _field$1717 = self$53.$1;
  int32_t start$859;
  moonbit_decref(self$53.$0);
  start$859 = _field$1717;
  return end$858 - start$859;
}

int32_t $Int$$is_trailing_surrogate(int32_t self$52) {
  return 56320 <= self$52 && self$52 <= 57343;
}

int32_t $Int$$is_leading_surrogate(int32_t self$51) {
  return 55296 <= self$51 && self$51 <= 56319;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$48,
  int32_t ch$50
) {
  int32_t len$853 = self$48->$1;
  int32_t _tmp$852 = len$853 + 4;
  moonbit_bytes_t _field$1718;
  moonbit_bytes_t data$856;
  int32_t len$857;
  int32_t inc$49;
  int32_t len$855;
  int32_t _tmp$854;
  moonbit_incref(self$48);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$48, _tmp$852
  );
  _field$1718 = self$48->$0;
  data$856 = _field$1718;
  len$857 = self$48->$1;
  moonbit_incref(data$856);
  inc$49 = $FixedArray$$set_utf16le_char(data$856, len$857, ch$50);
  len$855 = self$48->$1;
  _tmp$854 = len$855 + inc$49;
  self$48->$1 = _tmp$854;
  moonbit_decref(self$48);
  return 0;
}

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$43,
  int32_t required$44
) {
  moonbit_bytes_t _field$1722 = self$43->$0;
  moonbit_bytes_t data$851 = _field$1722;
  int32_t _tmp$1721 = Moonbit_array_length(data$851);
  int32_t current_len$42 = _tmp$1721;
  int32_t enough_space$45;
  int32_t _tmp$850;
  moonbit_bytes_t new_data$47;
  moonbit_bytes_t _field$1720;
  moonbit_bytes_t data$848;
  int32_t len$849;
  moonbit_bytes_t _old$1719;
  if (required$44 <= current_len$42) {
    moonbit_decref(self$43);
    return 0;
  }
  enough_space$45 = current_len$42;
  while (1) {
    int32_t _tmp$846 = enough_space$45;
    if (_tmp$846 < required$44) {
      int32_t _tmp$847 = enough_space$45;
      enough_space$45 = _tmp$847 * 2;
      continue;
    }
    break;
  }
  _tmp$850 = enough_space$45;
  new_data$47 = (moonbit_bytes_t)moonbit_make_bytes(_tmp$850, 0);
  _field$1720 = self$43->$0;
  data$848 = _field$1720;
  len$849 = self$43->$1;
  moonbit_incref(data$848);
  moonbit_incref(new_data$47);
  $FixedArray$$unsafe_blit$0(new_data$47, 0, data$848, 0, len$849);
  _old$1719 = self$43->$0;
  moonbit_decref(_old$1719);
  self$43->$0 = new_data$47;
  moonbit_decref(self$43);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default() {
  return 0;
}

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$37,
  int32_t offset$38,
  int32_t value$36
) {
  int32_t _tmp$845 = value$36;
  uint32_t code$35 = *(uint32_t*)&_tmp$845;
  if (code$35 < 65536u) {
    uint32_t _p$550 = code$35 & 255u;
    int32_t _tmp$828 = *(int32_t*)&_p$550;
    int32_t _tmp$827 = _tmp$828 & 0xff;
    int32_t _tmp$829;
    uint32_t _p$553;
    int32_t _tmp$831;
    int32_t _tmp$830;
    if (offset$38 < 0 || offset$38 >= Moonbit_array_length(self$37)) {
      moonbit_panic();
    }
    self$37[offset$38] = _tmp$827;
    _tmp$829 = offset$38 + 1;
    _p$553 = code$35 >> 8;
    _tmp$831 = *(int32_t*)&_p$553;
    _tmp$830 = _tmp$831 & 0xff;
    if (_tmp$829 < 0 || _tmp$829 >= Moonbit_array_length(self$37)) {
      moonbit_panic();
    }
    self$37[_tmp$829] = _tmp$830;
    moonbit_decref(self$37);
    return 2;
  } else if (code$35 < 1114112u) {
    uint32_t hi$39 = code$35 - 65536u;
    uint32_t _tmp$844 = hi$39 >> 10;
    uint32_t lo$40 = _tmp$844 | 55296u;
    uint32_t _tmp$843 = hi$39 & 1023u;
    uint32_t hi$41 = _tmp$843 | 56320u;
    uint32_t _p$556 = lo$40 & 255u;
    int32_t _tmp$833 = *(int32_t*)&_p$556;
    int32_t _tmp$832 = _tmp$833 & 0xff;
    int32_t _tmp$834;
    uint32_t _p$559;
    int32_t _tmp$836;
    int32_t _tmp$835;
    int32_t _tmp$837;
    uint32_t _p$562;
    int32_t _tmp$839;
    int32_t _tmp$838;
    int32_t _tmp$840;
    uint32_t _p$565;
    int32_t _tmp$842;
    int32_t _tmp$841;
    if (offset$38 < 0 || offset$38 >= Moonbit_array_length(self$37)) {
      moonbit_panic();
    }
    self$37[offset$38] = _tmp$832;
    _tmp$834 = offset$38 + 1;
    _p$559 = lo$40 >> 8;
    _tmp$836 = *(int32_t*)&_p$559;
    _tmp$835 = _tmp$836 & 0xff;
    if (_tmp$834 < 0 || _tmp$834 >= Moonbit_array_length(self$37)) {
      moonbit_panic();
    }
    self$37[_tmp$834] = _tmp$835;
    _tmp$837 = offset$38 + 2;
    _p$562 = hi$41 & 255u;
    _tmp$839 = *(int32_t*)&_p$562;
    _tmp$838 = _tmp$839 & 0xff;
    if (_tmp$837 < 0 || _tmp$837 >= Moonbit_array_length(self$37)) {
      moonbit_panic();
    }
    self$37[_tmp$837] = _tmp$838;
    _tmp$840 = offset$38 + 3;
    _p$565 = hi$41 >> 8;
    _tmp$842 = *(int32_t*)&_p$565;
    _tmp$841 = _tmp$842 & 0xff;
    if (_tmp$840 < 0 || _tmp$840 >= Moonbit_array_length(self$37)) {
      moonbit_panic();
    }
    self$37[_tmp$840] = _tmp$841;
    moonbit_decref(self$37);
    return 4;
  } else {
    moonbit_decref(self$37);
    return $moonbitlang$core$builtin$abort$0(
             (moonbit_string_t)moonbit_string_literal_19.data,
               (moonbit_string_t)moonbit_string_literal_20.data
           );
  }
}

int32_t $UInt$$to_byte(uint32_t self$34) {
  int32_t _tmp$826 = *(int32_t*)&self$34;
  return _tmp$826 & 0xff;
}

uint32_t $Char$$to_uint(int32_t self$33) {
  int32_t _tmp$825 = self$33;
  return *(uint32_t*)&_tmp$825;
}

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$32
) {
  moonbit_bytes_t _field$1724 = self$32->$0;
  moonbit_bytes_t data$824 = _field$1724;
  moonbit_bytes_t _tmp$821;
  int32_t _field$1723;
  int32_t len$823;
  int64_t _tmp$822;
  moonbit_incref(data$824);
  _tmp$821 = data$824;
  _field$1723 = self$32->$1;
  moonbit_decref(self$32);
  len$823 = _field$1723;
  _tmp$822 = (int64_t)len$823;
  return $Bytes$$to_unchecked_string$inner(_tmp$821, 0, _tmp$822);
}

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$27,
  int32_t offset$31,
  int64_t length$29
) {
  int32_t len$26 = Moonbit_array_length(self$27);
  int32_t length$28;
  int32_t _if_result$1798;
  if (length$29 == 4294967296ll) {
    length$28 = len$26 - offset$31;
  } else {
    int64_t _Some$30 = length$29;
    length$28 = (int32_t)_Some$30;
  }
  if (offset$31 >= 0) {
    if (length$28 >= 0) {
      int32_t _tmp$820 = offset$31 + length$28;
      _if_result$1798 = _tmp$820 <= len$26;
    } else {
      _if_result$1798 = 0;
    }
  } else {
    _if_result$1798 = 0;
  }
  if (_if_result$1798) {
    return $moonbitlang$core$builtin$unsafe_sub_string(
             self$27, offset$31, length$28
           );
  } else {
    moonbit_decref(self$27);
    moonbit_panic();
  }
}

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$24
) {
  int32_t initial$23;
  moonbit_bytes_t data$25;
  struct $$moonbitlang$core$builtin$StringBuilder* _block$1799;
  if (size_hint$24 < 1) {
    initial$23 = 1;
  } else {
    initial$23 = size_hint$24;
  }
  data$25 = (moonbit_bytes_t)moonbit_make_bytes(initial$23, 0);
  _block$1799
  = (struct $$moonbitlang$core$builtin$StringBuilder*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$builtin$StringBuilder)
    );
  Moonbit_object_header(_block$1799)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $$moonbitlang$core$builtin$StringBuilder, $0) >> 2, 1, 0
  );
  _block$1799->$0 = data$25;
  _block$1799->$1 = 0;
  return _block$1799;
}

int32_t $Byte$$to_char(int32_t self$22) {
  int32_t _tmp$819 = (int32_t)self$22;
  return _tmp$819;
}

int32_t $FixedArray$$unsafe_blit$0(
  moonbit_bytes_t dst$13,
  int32_t dst_offset$15,
  moonbit_bytes_t src$14,
  int32_t src_offset$16,
  int32_t len$18
) {
  if (dst$13 == src$14 && dst_offset$15 < src_offset$16) {
    int32_t i$17 = 0;
    while (1) {
      if (i$17 < len$18) {
        int32_t _tmp$810 = dst_offset$15 + i$17;
        int32_t _tmp$812 = src_offset$16 + i$17;
        int32_t _tmp$811;
        int32_t _tmp$813;
        if (_tmp$812 < 0 || _tmp$812 >= Moonbit_array_length(src$14)) {
          moonbit_panic();
        }
        _tmp$811 = (int32_t)src$14[_tmp$812];
        if (_tmp$810 < 0 || _tmp$810 >= Moonbit_array_length(dst$13)) {
          moonbit_panic();
        }
        dst$13[_tmp$810] = _tmp$811;
        _tmp$813 = i$17 + 1;
        i$17 = _tmp$813;
        continue;
      } else {
        moonbit_decref(src$14);
        moonbit_decref(dst$13);
      }
      break;
    }
  } else {
    int32_t _tmp$818 = len$18 - 1;
    int32_t i$20 = _tmp$818;
    while (1) {
      if (i$20 >= 0) {
        int32_t _tmp$814 = dst_offset$15 + i$20;
        int32_t _tmp$816 = src_offset$16 + i$20;
        int32_t _tmp$815;
        int32_t _tmp$817;
        if (_tmp$816 < 0 || _tmp$816 >= Moonbit_array_length(src$14)) {
          moonbit_panic();
        }
        _tmp$815 = (int32_t)src$14[_tmp$816];
        if (_tmp$814 < 0 || _tmp$814 >= Moonbit_array_length(dst$13)) {
          moonbit_panic();
        }
        dst$13[_tmp$814] = _tmp$815;
        _tmp$817 = i$20 - 1;
        i$20 = _tmp$817;
        continue;
      } else {
        moonbit_decref(src$14);
        moonbit_decref(dst$13);
      }
      break;
    }
  }
  return 0;
}

int64_t $moonbitlang$core$builtin$abort$3(
  moonbit_string_t string$11,
  moonbit_string_t loc$12
) {
  moonbit_string_t _tmp$808 =
    moonbit_add_string(
      string$11, (moonbit_string_t)moonbit_string_literal_21.data
    );
  moonbit_string_t _tmp$809 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$12);
  moonbit_string_t _tmp$807 = moonbit_add_string(_tmp$808, _tmp$809);
  moonbit_string_t _tmp$806 =
    moonbit_add_string(
      _tmp$807, (moonbit_string_t)moonbit_string_literal_22.data
    );
  return $moonbitlang$core$abort$abort$3(_tmp$806);
}

int32_t $moonbitlang$core$builtin$abort$2(
  moonbit_string_t string$9,
  moonbit_string_t loc$10
) {
  moonbit_string_t _tmp$804 =
    moonbit_add_string(
      string$9, (moonbit_string_t)moonbit_string_literal_21.data
    );
  moonbit_string_t _tmp$805 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$10);
  moonbit_string_t _tmp$803 = moonbit_add_string(_tmp$804, _tmp$805);
  moonbit_string_t _tmp$802 =
    moonbit_add_string(
      _tmp$803, (moonbit_string_t)moonbit_string_literal_22.data
    );
  $moonbitlang$core$abort$abort$2(_tmp$802);
  return 0;
}

struct $StringView $moonbitlang$core$builtin$abort$1(
  moonbit_string_t string$7,
  moonbit_string_t loc$8
) {
  moonbit_string_t _tmp$800 =
    moonbit_add_string(
      string$7, (moonbit_string_t)moonbit_string_literal_21.data
    );
  moonbit_string_t _tmp$801 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$8);
  moonbit_string_t _tmp$799 = moonbit_add_string(_tmp$800, _tmp$801);
  moonbit_string_t _tmp$798 =
    moonbit_add_string(
      _tmp$799, (moonbit_string_t)moonbit_string_literal_22.data
    );
  return $moonbitlang$core$abort$abort$1(_tmp$798);
}

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$5,
  moonbit_string_t loc$6
) {
  moonbit_string_t _tmp$796 =
    moonbit_add_string(
      string$5, (moonbit_string_t)moonbit_string_literal_21.data
    );
  moonbit_string_t _tmp$797 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$6);
  moonbit_string_t _tmp$795 = moonbit_add_string(_tmp$796, _tmp$797);
  moonbit_string_t _tmp$794 =
    moonbit_add_string(
      _tmp$795, (moonbit_string_t)moonbit_string_literal_22.data
    );
  return $moonbitlang$core$abort$abort$0(_tmp$794);
}

int64_t $moonbitlang$core$abort$abort$3(moonbit_string_t msg$4) {
  moonbit_println(msg$4);
  moonbit_decref(msg$4);
  moonbit_panic();
}

int32_t $moonbitlang$core$abort$abort$2(moonbit_string_t msg$3) {
  moonbit_println(msg$3);
  moonbit_decref(msg$3);
  moonbit_panic();
  return 0;
}

struct $StringView $moonbitlang$core$abort$abort$1(moonbit_string_t msg$2) {
  moonbit_println(msg$2);
  moonbit_decref(msg$2);
  moonbit_panic();
}

int32_t $moonbitlang$core$abort$abort$0(moonbit_string_t msg$1) {
  moonbit_println(msg$1);
  moonbit_decref(msg$1);
  moonbit_panic();
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$787,
  int32_t _param$786
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$785 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$787;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
    _self$785, _param$786
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$784,
  struct $StringView _param$783
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$782 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$784;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    _self$782, _param$783
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$781,
  moonbit_string_t _param$778,
  int32_t _param$779,
  int32_t _param$780
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$777 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$781;
  $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
    _self$777, _param$778, _param$779, _param$780
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$776,
  moonbit_string_t _param$775
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$774 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$776;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
    _self$774, _param$775
  );
  return 0;
}

void moonbit_init() {
  $moonbitlang$core$builtin$boyer_moore_horspool_find$constr$56 = (int64_t)0;
  $moonbitlang$core$builtin$brute_force_find$constr$70 = (int64_t)0;
}

int main(int argc, char** argv) {
  double _tmp$790;
  moonbit_string_t _tmp$789;
  moonbit_string_t _tmp$788;
  double _tmp$793;
  moonbit_string_t _tmp$792;
  moonbit_string_t _tmp$791;
  moonbit_runtime_init(argc, argv);
  moonbit_init();
  moonbit_incref($username$moonbit_examples$cmd$enum$_main$c$537);
  _tmp$790
  = $username$moonbit_examples$cmd$enum$area(
    $username$moonbit_examples$cmd$enum$_main$c$537
  );
  _tmp$789
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
    _tmp$790
  );
  _tmp$788
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_23.data, _tmp$789
  );
  $moonbitlang$core$builtin$println$0(_tmp$788);
  moonbit_incref($username$moonbit_examples$cmd$enum$_main$r$538);
  _tmp$793
  = $username$moonbit_examples$cmd$enum$area(
    $username$moonbit_examples$cmd$enum$_main$r$538
  );
  _tmp$792
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
    _tmp$793
  );
  _tmp$791
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_24.data, _tmp$792
  );
  $moonbitlang$core$builtin$println$0(_tmp$791);
  return 0;
}