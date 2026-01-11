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

double $username$moonbit_examples$cmd$enums$area(void* shape$504);

int32_t $$moonbitlang$core$builtin$Show$$Double$$output(
  double self$503,
  struct $$moonbitlang$core$builtin$Logger logger$502
);

moonbit_string_t $Double$$to_string(double self$501);

moonbit_string_t $moonbitlang$core$double$internal$ryu$ryu_to_string(
  double val$488
);

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* $moonbitlang$core$double$internal$ryu$d2d_small_int(
  uint64_t ieeeMantissa$482,
  int32_t ieeeExponent$484
);

moonbit_string_t $moonbitlang$core$double$internal$ryu$to_chars(
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* v$455,
  int32_t sign$453
);

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* $moonbitlang$core$double$internal$ryu$d2d(
  uint64_t ieeeMantissa$397,
  uint32_t ieeeExponent$396
);

int32_t $moonbitlang$core$double$internal$ryu$decimal_length17(
  uint64_t v$393
);

struct $$moonbitlang$core$double$internal$ryu$Pow5Pair $moonbitlang$core$double$internal$ryu$double_computeInvPow5(
  int32_t i$376
);

struct $$moonbitlang$core$double$internal$ryu$Pow5Pair $moonbitlang$core$double$internal$ryu$double_computePow5(
  int32_t i$358
);

struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result $moonbitlang$core$double$internal$ryu$mulShiftAll64(
  uint64_t m$331,
  struct $$moonbitlang$core$double$internal$ryu$Pow5Pair mul$328,
  int32_t j$344,
  int32_t mmShift$346
);

int32_t $moonbitlang$core$double$internal$ryu$multipleOfPowerOf2(
  uint64_t value$325,
  int32_t p$326
);

int32_t $moonbitlang$core$double$internal$ryu$multipleOfPowerOf5(
  uint64_t value$323,
  int32_t p$324
);

int32_t $moonbitlang$core$double$internal$ryu$pow5Factor(uint64_t value$319);

uint64_t $moonbitlang$core$double$internal$ryu$shiftright128(
  uint64_t lo$318,
  uint64_t hi$316,
  int32_t dist$317
);

struct $$moonbitlang$core$double$internal$ryu$Umul128 $moonbitlang$core$double$internal$ryu$umul128(
  uint64_t a$306,
  uint64_t b$309
);

moonbit_string_t $moonbitlang$core$double$internal$ryu$string_from_bytes(
  moonbit_bytes_t bytes$300,
  int32_t from$304,
  int32_t to$302
);

int32_t $moonbitlang$core$double$internal$ryu$log10Pow2(int32_t e$298);

int32_t $moonbitlang$core$double$internal$ryu$log10Pow5(int32_t e$297);

moonbit_string_t $moonbitlang$core$double$internal$ryu$copy_special_str(
  int32_t sign$295,
  int32_t exponent$296,
  int32_t mantissa$293
);

int32_t $moonbitlang$core$double$internal$ryu$pow5bits(int32_t e$292);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$290,
  struct $$moonbitlang$core$builtin$Logger logger$291
);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$253,
  struct $$moonbitlang$core$builtin$Logger logger$289
);

uint64_t $Bool$$to_uint64(int32_t self$251);

int64_t $Bool$$to_int64(int32_t self$250);

int32_t $Bool$$to_int(int32_t self$249);

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$248);

uint64_t $UInt$$to_uint64(uint32_t self$247);

uint32_t $ReadOnlyArray$$at$1(uint32_t* self$245, int32_t index$246);

uint64_t $ReadOnlyArray$$at$0(uint64_t* self$243, int32_t index$244);

moonbit_string_t $$moonbitlang$core$builtin$Show$$String$$to_string(
  moonbit_string_t self$242
);

int32_t $$moonbitlang$core$builtin$Show$$UInt64$$output(
  uint64_t self$241,
  struct $$moonbitlang$core$builtin$Logger logger$240
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$238,
  struct $StringView str$239
);

moonbit_string_t $UInt64$$to_string$inner(
  uint64_t self$230,
  int32_t radix$229
);

int32_t $moonbitlang$core$builtin$int64_to_string_dec(
  uint16_t* buffer$219,
  uint64_t num$207,
  int32_t digit_start$210,
  int32_t total_len$209
);

int32_t $moonbitlang$core$builtin$int64_to_string_generic(
  uint16_t* buffer$201,
  uint64_t num$195,
  int32_t digit_start$193,
  int32_t total_len$192,
  int32_t radix$197
);

int32_t $moonbitlang$core$builtin$int64_to_string_hex(
  uint16_t* buffer$188,
  uint64_t num$184,
  int32_t digit_start$182,
  int32_t total_len$181
);

int32_t $moonbitlang$core$builtin$radix_count64(
  uint64_t value$174,
  int32_t radix$177
);

int32_t $moonbitlang$core$builtin$hex_count64(uint64_t value$172);

int32_t $moonbitlang$core$builtin$dec_count64(uint64_t value$171);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(
  uint64_t self$170
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  moonbit_string_t self$168
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  double self$166
);

int32_t $StringView$$start_offset(struct $StringView self$164);

int32_t $StringView$$length(struct $StringView self$163);

moonbit_string_t $StringView$$data(struct $StringView self$162);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$156,
  moonbit_string_t value$159,
  int32_t start$160,
  int32_t len$161
);

struct moonbit_result_0 $String$$sub(
  moonbit_string_t self$154,
  int64_t start$opt$152,
  int64_t end$155
);

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$144,
  int32_t start$150,
  int64_t end$146
);

uint64_t $Int$$to_uint64(int32_t self$142);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$140,
  moonbit_string_t str$141
);

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$132,
  int32_t bytes_offset$127,
  moonbit_string_t str$134,
  int32_t str_offset$130,
  int32_t length$128
);

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$49
);

int32_t $String$$unsafe_charcode_at(moonbit_string_t self$46, int32_t idx$47);

int32_t $Int$$is_trailing_surrogate(int32_t self$45);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$42,
  int32_t ch$44
);

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$37,
  int32_t required$38
);

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default();

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$31,
  int32_t offset$32,
  int32_t value$30
);

int32_t $UInt$$to_byte(uint32_t self$28);

uint32_t $Char$$to_uint(int32_t self$27);

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$26
);

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$21,
  int32_t offset$25,
  int64_t length$23
);

#define $moonbitlang$core$builtin$unsafe_sub_string moonbit_unsafe_bytes_sub_string

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$18
);

int32_t $Byte$$to_char(int32_t self$16);

int32_t $FixedArray$$unsafe_blit$0(
  moonbit_bytes_t dst$7,
  int32_t dst_offset$9,
  moonbit_bytes_t src$8,
  int32_t src_offset$10,
  int32_t len$12
);

int32_t $moonbitlang$core$builtin$abort$1(
  moonbit_string_t string$5,
  moonbit_string_t loc$6
);

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$3,
  moonbit_string_t loc$4
);

int32_t $moonbitlang$core$abort$abort$1(moonbit_string_t msg$2);

int32_t $moonbitlang$core$abort$abort$0(moonbit_string_t msg$1);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$769,
  int32_t _param$768
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$766,
  struct $StringView _param$765
);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$763,
  moonbit_string_t _param$760,
  int32_t _param$761,
  int32_t _param$762
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$758,
  moonbit_string_t _param$757
);

struct { int32_t rc; uint32_t meta; uint16_t const data[1];
} const moonbit_string_literal_5 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 0), 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_4 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 45, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[20];
} const moonbit_string_literal_16 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 19),
    65, 114, 101, 97, 32, 111, 102, 32, 114, 101, 99, 116, 97, 110, 103,
    108, 101, 58, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[7];
} const moonbit_string_literal_13 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 6),
    10, 32, 32, 97, 116, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[31];
} const moonbit_string_literal_8 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 30),
    114, 97, 100, 105, 120, 32, 109, 117, 115, 116, 32, 98, 101, 32,
    98, 101, 116, 119, 101, 101, 110, 32, 50, 32, 97, 110, 100, 32, 51,
    54, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[9];
} const moonbit_string_literal_6 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 8),
    73, 110, 102, 105, 110, 105, 116, 121, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[4];
} const moonbit_string_literal_3 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 3),
    78, 97, 78, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_0 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 48, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[18];
} const moonbit_string_literal_11 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 17),
    67, 104, 97, 114, 32, 111, 117, 116, 32, 111, 102, 32, 114, 97, 110,
    103, 101, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[49];
} const moonbit_string_literal_12 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 48),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 98, 121,
    116, 101, 115, 46, 109, 98, 116, 58, 50, 57, 56, 58, 53, 45, 50,
    57, 56, 58, 51, 49, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[37];
} const moonbit_string_literal_10 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 36),
    48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 100, 101, 102,
    103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115,
    116, 117, 118, 119, 120, 121, 122, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[59];
} const moonbit_string_literal_2 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 58),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 100, 111, 117, 98, 108, 101, 47, 105, 110, 116,
    101, 114, 110, 97, 108, 47, 114, 121, 117, 58, 114, 121, 117, 46,
    109, 98, 116, 58, 49, 49, 54, 58, 51, 45, 49, 49, 54, 58, 52, 53,
    0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_14 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 10, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[53];
} const moonbit_string_literal_9 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 52),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 116, 111,
    95, 115, 116, 114, 105, 110, 103, 46, 109, 98, 116, 58, 54, 54, 51,
    58, 53, 45, 54, 54, 51, 58, 52, 52, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[26];
} const moonbit_string_literal_1 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 25),
    73, 108, 108, 101, 103, 97, 108, 65, 114, 103, 117, 109, 101, 110,
    116, 69, 120, 99, 101, 112, 116, 105, 111, 110, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[17];
} const moonbit_string_literal_15 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 16),
    65, 114, 101, 97, 32, 111, 102, 32, 99, 105, 114, 99, 108, 101, 58,
    32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[4];
} const moonbit_string_literal_7 =
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

} $moonbitlang$core$double$internal$ryu$ryu_to_string$record$487$object =
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

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* $moonbitlang$core$double$internal$ryu$ryu_to_string$record$487 =
  &$moonbitlang$core$double$internal$ryu$ryu_to_string$record$487$object.data;

struct { int32_t rc; uint32_t meta; struct $Shape$Circle data;
} $username$moonbit_examples$cmd$enums$_main$c$510$object =
  {
    -1,
    Moonbit_make_regular_object_header(
      sizeof(struct $Shape$Circle) >> 2, 0, 0
    ), {.$0 = 0x1.4p+2}
  };

struct $Shape$Circle* $username$moonbit_examples$cmd$enums$_main$c$510 =
  &$username$moonbit_examples$cmd$enums$_main$c$510$object.data;

struct { int32_t rc; uint32_t meta; struct $Shape$Rectangle data;
} $username$moonbit_examples$cmd$enums$_main$r$511$object =
  {
    -1,
    Moonbit_make_regular_object_header(
      sizeof(struct $Shape$Rectangle) >> 2, 0, 1
    ), {.$0 = 0x1p+2, .$1 = 0x1.8p+2}
  };

struct $Shape$Rectangle* $username$moonbit_examples$cmd$enums$_main$r$511 =
  &$username$moonbit_examples$cmd$enums$_main$r$511$object.data;

double $username$moonbit_examples$cmd$enums$area(void* shape$504) {
  switch (Moonbit_object_tag(shape$504)) {
    case 0: {
      struct $Shape$Circle* _Circle$505 = (struct $Shape$Circle*)shape$504;
      double _field$1519 = _Circle$505->$0;
      double _r$506;
      double _tmp$1518;
      moonbit_decref(_Circle$505);
      _r$506 = _field$1519;
      _tmp$1518 = 0x1.921f9f01b866ep+1 * _r$506;
      return _tmp$1518 * _r$506;
      break;
    }
    default: {
      struct $Shape$Rectangle* _Rectangle$507 =
        (struct $Shape$Rectangle*)shape$504;
      double _w$508 = _Rectangle$507->$0;
      double _field$1520 = _Rectangle$507->$1;
      double _h$509;
      moonbit_decref(_Rectangle$507);
      _h$509 = _field$1520;
      return _w$508 * _h$509;
      break;
    }
  }
}

int32_t $$moonbitlang$core$builtin$Show$$Double$$output(
  double self$503,
  struct $$moonbitlang$core$builtin$Logger logger$502
) {
  moonbit_string_t _tmp$1517 = $Double$$to_string(self$503);
  logger$502.$0->$method_0(logger$502.$1, _tmp$1517);
  return 0;
}

moonbit_string_t $Double$$to_string(double self$501) {
  return $moonbitlang$core$double$internal$ryu$ryu_to_string(self$501);
}

moonbit_string_t $moonbitlang$core$double$internal$ryu$ryu_to_string(
  double val$488
) {
  uint64_t bits$489;
  uint64_t _tmp$1516;
  uint64_t _tmp$1515;
  int32_t ieeeSign$490;
  uint64_t ieeeMantissa$491;
  uint64_t _tmp$1514;
  uint64_t _tmp$1513;
  int32_t ieeeExponent$492;
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* v$493;
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* small$494;
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _tmp$1512;
  if (val$488 == 0x0p+0) {
    return (moonbit_string_t)moonbit_string_literal_0.data;
  }
  bits$489 = *(int64_t*)&val$488;
  _tmp$1516 = bits$489 >> 63;
  _tmp$1515 = _tmp$1516 & 1ull;
  ieeeSign$490 = _tmp$1515 != 0ull;
  ieeeMantissa$491 = bits$489 & 4503599627370495ull;
  _tmp$1514 = bits$489 >> 52;
  _tmp$1513 = _tmp$1514 & 2047ull;
  ieeeExponent$492 = (int32_t)_tmp$1513;
  if (
    ieeeExponent$492 == 2047
    || ieeeExponent$492 == 0 && ieeeMantissa$491 == 0ull
  ) {
    int32_t _tmp$1501 = ieeeExponent$492 != 0;
    int32_t _tmp$1502 = ieeeMantissa$491 != 0ull;
    return $moonbitlang$core$double$internal$ryu$copy_special_str(
             ieeeSign$490, _tmp$1501, _tmp$1502
           );
  }
  v$493 = $moonbitlang$core$double$internal$ryu$ryu_to_string$record$487;
  small$494
  = $moonbitlang$core$double$internal$ryu$d2d_small_int(
    ieeeMantissa$491, ieeeExponent$492
  );
  if (small$494 == 0) {
    uint32_t _tmp$1503;
    if (small$494) {
      moonbit_decref(small$494);
    }
    _tmp$1503 = *(uint32_t*)&ieeeExponent$492;
    v$493
    = $moonbitlang$core$double$internal$ryu$d2d(
      ieeeMantissa$491, _tmp$1503
    );
  } else {
    struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _Some$495 =
      small$494;
    struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _f$496 =
      _Some$495;
    struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* x$497 =
      _f$496;
    while (1) {
      struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _tmp$1511 =
        x$497;
      uint64_t _field$1523 = _tmp$1511->$0;
      uint64_t mantissa$1510 = _field$1523;
      uint64_t q$498 = mantissa$1510 / 10ull;
      struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _tmp$1509 =
        x$497;
      uint64_t _field$1522 = _tmp$1509->$0;
      uint64_t mantissa$1507 = _field$1522;
      uint64_t _tmp$1508 = 10ull * q$498;
      uint64_t r$499 = mantissa$1507 - _tmp$1508;
      struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _tmp$1506;
      int32_t _field$1521;
      int32_t exponent$1505;
      int32_t _tmp$1504;
      if (r$499 != 0ull) {
        break;
      }
      _tmp$1506 = x$497;
      _field$1521 = _tmp$1506->$1;
      moonbit_decref(_tmp$1506);
      exponent$1505 = _field$1521;
      _tmp$1504 = exponent$1505 + 1;
      x$497
      = (struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64*)moonbit_malloc(
          sizeof(
            struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64
          )
        );
      Moonbit_object_header(x$497)->meta
      = Moonbit_make_regular_object_header(
        sizeof(
          struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64
        )
        >> 2,
          0,
          0
      );
      x$497->$0 = q$498;
      x$497->$1 = _tmp$1504;
      continue;
      break;
    }
    v$493 = x$497;
  }
  _tmp$1512 = v$493;
  return $moonbitlang$core$double$internal$ryu$to_chars(
           _tmp$1512, ieeeSign$490
         );
}

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* $moonbitlang$core$double$internal$ryu$d2d_small_int(
  uint64_t ieeeMantissa$482,
  int32_t ieeeExponent$484
) {
  uint64_t m2$481 = 4503599627370496ull | ieeeMantissa$482;
  int32_t _tmp$1500 = ieeeExponent$484 - 1023;
  int32_t e2$483 = _tmp$1500 - 52;
  int32_t _tmp$1499;
  uint64_t _tmp$1498;
  uint64_t mask$485;
  uint64_t fraction$486;
  int32_t _tmp$1497;
  uint64_t _tmp$1496;
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _tmp$1495;
  if (e2$483 > 0) {
    return 0;
  }
  if (e2$483 < -52) {
    return 0;
  }
  _tmp$1499 = -e2$483;
  _tmp$1498 = 1ull << (_tmp$1499 & 63);
  mask$485 = _tmp$1498 - 1ull;
  fraction$486 = m2$481 & mask$485;
  if (fraction$486 != 0ull) {
    return 0;
  }
  _tmp$1497 = -e2$483;
  _tmp$1496 = m2$481 >> (_tmp$1497 & 63);
  _tmp$1495
  = (struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64)
    );
  Moonbit_object_header(_tmp$1495)->meta
  = Moonbit_make_regular_object_header(
    sizeof(
      struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64
    )
    >> 2,
      0,
      0
  );
  _tmp$1495->$0 = _tmp$1496;
  _tmp$1495->$1 = 0;
  return _tmp$1495;
}

moonbit_string_t $moonbitlang$core$double$internal$ryu$to_chars(
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* v$455,
  int32_t sign$453
) {
  moonbit_bytes_t result$451 = (moonbit_bytes_t)moonbit_make_bytes(25, 0);
  int32_t index$452 = 0;
  uint64_t output$454;
  uint64_t _tmp$1494;
  int32_t olength$456;
  int32_t _field$1524;
  int32_t exponent$1493;
  int32_t _tmp$1492;
  int32_t exp$457;
  int32_t _tmp$1491;
  int32_t _tmp$1489;
  int32_t scientificNotation$458;
  if (sign$453) {
    int32_t _tmp$1364 = index$452;
    int32_t _tmp$1365;
    if (_tmp$1364 < 0 || _tmp$1364 >= Moonbit_array_length(result$451)) {
      moonbit_panic();
    }
    result$451[_tmp$1364] = 45;
    _tmp$1365 = index$452;
    index$452 = _tmp$1365 + 1;
  }
  output$454 = v$455->$0;
  _tmp$1494 = output$454;
  olength$456
  = $moonbitlang$core$double$internal$ryu$decimal_length17(
    _tmp$1494
  );
  _field$1524 = v$455->$1;
  moonbit_decref(v$455);
  exponent$1493 = _field$1524;
  _tmp$1492 = exponent$1493 + olength$456;
  exp$457 = _tmp$1492 - 1;
  _tmp$1491 = exp$457;
  if (_tmp$1491 >= -6) {
    int32_t _tmp$1490 = exp$457;
    _tmp$1489 = _tmp$1490 < 21;
  } else {
    _tmp$1489 = 0;
  }
  scientificNotation$458 = !_tmp$1489;
  if (scientificNotation$458) {
    int32_t _end41$459 = olength$456 - 1;
    int32_t i$460 = 0;
    int32_t _tmp$1375;
    uint64_t _tmp$1380;
    int32_t _tmp$1379;
    int32_t _tmp$1378;
    int32_t _tmp$1377;
    int32_t _tmp$1376;
    int32_t _tmp$1384;
    int32_t _tmp$1385;
    int32_t _tmp$1386;
    int32_t _tmp$1387;
    int32_t _tmp$1388;
    int32_t _tmp$1394;
    int32_t _tmp$1427;
    while (1) {
      if (i$460 < _end41$459) {
        uint64_t _tmp$1373 = output$454;
        uint64_t c$461 = _tmp$1373 % 10ull;
        uint64_t _tmp$1366 = output$454;
        int32_t _tmp$1372;
        int32_t _tmp$1371;
        int32_t _tmp$1367;
        int32_t _tmp$1370;
        int32_t _tmp$1369;
        int32_t _tmp$1368;
        int32_t _tmp$1374;
        output$454 = _tmp$1366 / 10ull;
        _tmp$1372 = index$452;
        _tmp$1371 = _tmp$1372 + olength$456;
        _tmp$1367 = _tmp$1371 - i$460;
        _tmp$1370 = (int32_t)c$461;
        _tmp$1369 = 48 + _tmp$1370;
        _tmp$1368 = _tmp$1369 & 0xff;
        if (_tmp$1367 < 0 || _tmp$1367 >= Moonbit_array_length(result$451)) {
          moonbit_panic();
        }
        result$451[_tmp$1367] = _tmp$1368;
        _tmp$1374 = i$460 + 1;
        i$460 = _tmp$1374;
        continue;
      }
      break;
    }
    _tmp$1375 = index$452;
    _tmp$1380 = output$454;
    _tmp$1379 = (int32_t)_tmp$1380;
    _tmp$1378 = _tmp$1379 % 10;
    _tmp$1377 = 48 + _tmp$1378;
    _tmp$1376 = _tmp$1377 & 0xff;
    if (_tmp$1375 < 0 || _tmp$1375 >= Moonbit_array_length(result$451)) {
      moonbit_panic();
    }
    result$451[_tmp$1375] = _tmp$1376;
    if (olength$456 > 1) {
      int32_t _tmp$1382 = index$452;
      int32_t _tmp$1381 = _tmp$1382 + 1;
      if (_tmp$1381 < 0 || _tmp$1381 >= Moonbit_array_length(result$451)) {
        moonbit_panic();
      }
      result$451[_tmp$1381] = 46;
    } else {
      int32_t _tmp$1383 = index$452;
      index$452 = _tmp$1383 - 1;
    }
    _tmp$1384 = index$452;
    _tmp$1385 = olength$456 + 1;
    index$452 = _tmp$1384 + _tmp$1385;
    _tmp$1386 = index$452;
    if (_tmp$1386 < 0 || _tmp$1386 >= Moonbit_array_length(result$451)) {
      moonbit_panic();
    }
    result$451[_tmp$1386] = 101;
    _tmp$1387 = index$452;
    index$452 = _tmp$1387 + 1;
    _tmp$1388 = exp$457;
    if (_tmp$1388 < 0) {
      int32_t _tmp$1389 = index$452;
      int32_t _tmp$1390;
      int32_t _tmp$1391;
      if (_tmp$1389 < 0 || _tmp$1389 >= Moonbit_array_length(result$451)) {
        moonbit_panic();
      }
      result$451[_tmp$1389] = 45;
      _tmp$1390 = index$452;
      index$452 = _tmp$1390 + 1;
      _tmp$1391 = exp$457;
      exp$457 = -_tmp$1391;
    } else {
      int32_t _tmp$1392 = index$452;
      int32_t _tmp$1393;
      if (_tmp$1392 < 0 || _tmp$1392 >= Moonbit_array_length(result$451)) {
        moonbit_panic();
      }
      result$451[_tmp$1392] = 43;
      _tmp$1393 = index$452;
      index$452 = _tmp$1393 + 1;
    }
    _tmp$1394 = exp$457;
    if (_tmp$1394 >= 100) {
      int32_t _tmp$1410 = exp$457;
      int32_t a$463 = _tmp$1410 / 100;
      int32_t _tmp$1409 = exp$457;
      int32_t _tmp$1408 = _tmp$1409 / 10;
      int32_t b$464 = _tmp$1408 % 10;
      int32_t _tmp$1407 = exp$457;
      int32_t c$465 = _tmp$1407 % 10;
      int32_t _tmp$1395 = index$452;
      int32_t _tmp$1397 = 48 + a$463;
      int32_t _tmp$1396 = _tmp$1397 & 0xff;
      int32_t _tmp$1401;
      int32_t _tmp$1398;
      int32_t _tmp$1400;
      int32_t _tmp$1399;
      int32_t _tmp$1405;
      int32_t _tmp$1402;
      int32_t _tmp$1404;
      int32_t _tmp$1403;
      int32_t _tmp$1406;
      if (_tmp$1395 < 0 || _tmp$1395 >= Moonbit_array_length(result$451)) {
        moonbit_panic();
      }
      result$451[_tmp$1395] = _tmp$1396;
      _tmp$1401 = index$452;
      _tmp$1398 = _tmp$1401 + 1;
      _tmp$1400 = 48 + b$464;
      _tmp$1399 = _tmp$1400 & 0xff;
      if (_tmp$1398 < 0 || _tmp$1398 >= Moonbit_array_length(result$451)) {
        moonbit_panic();
      }
      result$451[_tmp$1398] = _tmp$1399;
      _tmp$1405 = index$452;
      _tmp$1402 = _tmp$1405 + 2;
      _tmp$1404 = 48 + c$465;
      _tmp$1403 = _tmp$1404 & 0xff;
      if (_tmp$1402 < 0 || _tmp$1402 >= Moonbit_array_length(result$451)) {
        moonbit_panic();
      }
      result$451[_tmp$1402] = _tmp$1403;
      _tmp$1406 = index$452;
      index$452 = _tmp$1406 + 3;
    } else {
      int32_t _tmp$1411 = exp$457;
      if (_tmp$1411 >= 10) {
        int32_t _tmp$1421 = exp$457;
        int32_t a$466 = _tmp$1421 / 10;
        int32_t _tmp$1420 = exp$457;
        int32_t b$467 = _tmp$1420 % 10;
        int32_t _tmp$1412 = index$452;
        int32_t _tmp$1414 = 48 + a$466;
        int32_t _tmp$1413 = _tmp$1414 & 0xff;
        int32_t _tmp$1418;
        int32_t _tmp$1415;
        int32_t _tmp$1417;
        int32_t _tmp$1416;
        int32_t _tmp$1419;
        if (_tmp$1412 < 0 || _tmp$1412 >= Moonbit_array_length(result$451)) {
          moonbit_panic();
        }
        result$451[_tmp$1412] = _tmp$1413;
        _tmp$1418 = index$452;
        _tmp$1415 = _tmp$1418 + 1;
        _tmp$1417 = 48 + b$467;
        _tmp$1416 = _tmp$1417 & 0xff;
        if (_tmp$1415 < 0 || _tmp$1415 >= Moonbit_array_length(result$451)) {
          moonbit_panic();
        }
        result$451[_tmp$1415] = _tmp$1416;
        _tmp$1419 = index$452;
        index$452 = _tmp$1419 + 2;
      } else {
        int32_t _tmp$1422 = index$452;
        int32_t _tmp$1425 = exp$457;
        int32_t _tmp$1424 = 48 + _tmp$1425;
        int32_t _tmp$1423 = _tmp$1424 & 0xff;
        int32_t _tmp$1426;
        if (_tmp$1422 < 0 || _tmp$1422 >= Moonbit_array_length(result$451)) {
          moonbit_panic();
        }
        result$451[_tmp$1422] = _tmp$1423;
        _tmp$1426 = index$452;
        index$452 = _tmp$1426 + 1;
      }
    }
    _tmp$1427 = index$452;
    return $moonbitlang$core$double$internal$ryu$string_from_bytes(
             result$451, 0, _tmp$1427
           );
  } else {
    int32_t _tmp$1428 = exp$457;
    int32_t _tmp$1488;
    if (_tmp$1428 < 0) {
      int32_t _tmp$1429 = index$452;
      int32_t _tmp$1430;
      int32_t _tmp$1431;
      int32_t _tmp$1432;
      int32_t i$468;
      int32_t current$470;
      int32_t i$471;
      if (_tmp$1429 < 0 || _tmp$1429 >= Moonbit_array_length(result$451)) {
        moonbit_panic();
      }
      result$451[_tmp$1429] = 48;
      _tmp$1430 = index$452;
      index$452 = _tmp$1430 + 1;
      _tmp$1431 = index$452;
      if (_tmp$1431 < 0 || _tmp$1431 >= Moonbit_array_length(result$451)) {
        moonbit_panic();
      }
      result$451[_tmp$1431] = 46;
      _tmp$1432 = index$452;
      index$452 = _tmp$1432 + 1;
      i$468 = -1;
      while (1) {
        int32_t _tmp$1433 = exp$457;
        if (i$468 > _tmp$1433) {
          int32_t _tmp$1434 = index$452;
          int32_t _tmp$1435;
          int32_t _tmp$1436;
          if (_tmp$1434 < 0 || _tmp$1434 >= Moonbit_array_length(result$451)) {
            moonbit_panic();
          }
          result$451[_tmp$1434] = 48;
          _tmp$1435 = index$452;
          index$452 = _tmp$1435 + 1;
          _tmp$1436 = i$468 - 1;
          i$468 = _tmp$1436;
          continue;
        }
        break;
      }
      current$470 = index$452;
      i$471 = 0;
      while (1) {
        if (i$471 < olength$456) {
          int32_t _tmp$1444 = current$470 + olength$456;
          int32_t _tmp$1443 = _tmp$1444 - i$471;
          int32_t _tmp$1437 = _tmp$1443 - 1;
          uint64_t _tmp$1442 = output$454;
          uint64_t _tmp$1441 = _tmp$1442 % 10ull;
          int32_t _tmp$1440 = (int32_t)_tmp$1441;
          int32_t _tmp$1439 = 48 + _tmp$1440;
          int32_t _tmp$1438 = _tmp$1439 & 0xff;
          uint64_t _tmp$1445;
          int32_t _tmp$1446;
          int32_t _tmp$1447;
          if (_tmp$1437 < 0 || _tmp$1437 >= Moonbit_array_length(result$451)) {
            moonbit_panic();
          }
          result$451[_tmp$1437] = _tmp$1438;
          _tmp$1445 = output$454;
          output$454 = _tmp$1445 / 10ull;
          _tmp$1446 = index$452;
          index$452 = _tmp$1446 + 1;
          _tmp$1447 = i$471 + 1;
          i$471 = _tmp$1447;
          continue;
        }
        break;
      }
    } else {
      int32_t _tmp$1449 = exp$457;
      int32_t _tmp$1448 = _tmp$1449 + 1;
      if (_tmp$1448 >= olength$456) {
        int32_t i$473 = 0;
        int32_t _tmp$1461;
        int32_t _tmp$1465;
        int32_t _end64$475;
        int32_t i$476;
        while (1) {
          if (i$473 < olength$456) {
            int32_t _tmp$1458 = index$452;
            int32_t _tmp$1457 = _tmp$1458 + olength$456;
            int32_t _tmp$1456 = _tmp$1457 - i$473;
            int32_t _tmp$1450 = _tmp$1456 - 1;
            uint64_t _tmp$1455 = output$454;
            uint64_t _tmp$1454 = _tmp$1455 % 10ull;
            int32_t _tmp$1453 = (int32_t)_tmp$1454;
            int32_t _tmp$1452 = 48 + _tmp$1453;
            int32_t _tmp$1451 = _tmp$1452 & 0xff;
            uint64_t _tmp$1459;
            int32_t _tmp$1460;
            if (
              _tmp$1450 < 0 || _tmp$1450 >= Moonbit_array_length(result$451)
            ) {
              moonbit_panic();
            }
            result$451[_tmp$1450] = _tmp$1451;
            _tmp$1459 = output$454;
            output$454 = _tmp$1459 / 10ull;
            _tmp$1460 = i$473 + 1;
            i$473 = _tmp$1460;
            continue;
          }
          break;
        }
        _tmp$1461 = index$452;
        index$452 = _tmp$1461 + olength$456;
        _tmp$1465 = exp$457;
        _end64$475 = _tmp$1465 + 1;
        i$476 = olength$456;
        while (1) {
          if (i$476 < _end64$475) {
            int32_t _tmp$1462 = index$452;
            int32_t _tmp$1463;
            int32_t _tmp$1464;
            if (
              _tmp$1462 < 0 || _tmp$1462 >= Moonbit_array_length(result$451)
            ) {
              moonbit_panic();
            }
            result$451[_tmp$1462] = 48;
            _tmp$1463 = index$452;
            index$452 = _tmp$1463 + 1;
            _tmp$1464 = i$476 + 1;
            i$476 = _tmp$1464;
            continue;
          }
          break;
        }
      } else {
        int32_t _tmp$1487 = index$452;
        int32_t current$478 = _tmp$1487 + 1;
        int32_t i$479 = 0;
        int32_t _tmp$1485;
        int32_t _tmp$1486;
        while (1) {
          if (i$479 < olength$456) {
            int32_t _tmp$1468 = olength$456 - i$479;
            int32_t _tmp$1466 = _tmp$1468 - 1;
            int32_t _tmp$1467 = exp$457;
            int32_t _tmp$1482;
            int32_t _tmp$1481;
            int32_t _tmp$1480;
            int32_t _tmp$1474;
            uint64_t _tmp$1479;
            uint64_t _tmp$1478;
            int32_t _tmp$1477;
            int32_t _tmp$1476;
            int32_t _tmp$1475;
            uint64_t _tmp$1483;
            int32_t _tmp$1484;
            if (_tmp$1466 == _tmp$1467) {
              int32_t _tmp$1472 = current$478;
              int32_t _tmp$1471 = _tmp$1472 + olength$456;
              int32_t _tmp$1470 = _tmp$1471 - i$479;
              int32_t _tmp$1469 = _tmp$1470 - 1;
              int32_t _tmp$1473;
              if (
                _tmp$1469 < 0
                || _tmp$1469 >= Moonbit_array_length(result$451)
              ) {
                moonbit_panic();
              }
              result$451[_tmp$1469] = 46;
              _tmp$1473 = current$478;
              current$478 = _tmp$1473 - 1;
            }
            _tmp$1482 = current$478;
            _tmp$1481 = _tmp$1482 + olength$456;
            _tmp$1480 = _tmp$1481 - i$479;
            _tmp$1474 = _tmp$1480 - 1;
            _tmp$1479 = output$454;
            _tmp$1478 = _tmp$1479 % 10ull;
            _tmp$1477 = (int32_t)_tmp$1478;
            _tmp$1476 = 48 + _tmp$1477;
            _tmp$1475 = _tmp$1476 & 0xff;
            if (
              _tmp$1474 < 0 || _tmp$1474 >= Moonbit_array_length(result$451)
            ) {
              moonbit_panic();
            }
            result$451[_tmp$1474] = _tmp$1475;
            _tmp$1483 = output$454;
            output$454 = _tmp$1483 / 10ull;
            _tmp$1484 = i$479 + 1;
            i$479 = _tmp$1484;
            continue;
          }
          break;
        }
        _tmp$1485 = index$452;
        _tmp$1486 = olength$456 + 1;
        index$452 = _tmp$1485 + _tmp$1486;
      }
    }
    _tmp$1488 = index$452;
    return $moonbitlang$core$double$internal$ryu$string_from_bytes(
             result$451, 0, _tmp$1488
           );
  }
}

struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* $moonbitlang$core$double$internal$ryu$d2d(
  uint64_t ieeeMantissa$397,
  uint32_t ieeeExponent$396
) {
  int32_t e2$394 = 0;
  uint64_t m2$395 = 0ull;
  uint64_t _tmp$1363;
  uint64_t _tmp$1362;
  int32_t even$398;
  uint64_t _tmp$1361;
  uint64_t mv$399;
  int32_t mmShift$400;
  uint64_t vr$401;
  uint64_t vp$402;
  uint64_t vm$403;
  int32_t e10$404;
  int32_t vmIsTrailingZeros$405;
  int32_t vrIsTrailingZeros$406;
  int32_t _tmp$1253;
  int32_t removed$425;
  int32_t lastRemovedDigit$426;
  uint64_t output$427;
  int32_t _tmp$1359;
  int32_t _tmp$1360;
  int32_t exp$450;
  uint64_t _tmp$1358;
  struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64* _block$1586;
  if (ieeeExponent$396 == 0u) {
    e2$394 = -1076;
    m2$395 = ieeeMantissa$397;
  } else {
    int32_t _tmp$1252 = *(int32_t*)&ieeeExponent$396;
    int32_t _tmp$1251 = _tmp$1252 - 1023;
    int32_t _tmp$1250 = _tmp$1251 - 52;
    e2$394 = _tmp$1250 - 2;
    m2$395 = 4503599627370496ull | ieeeMantissa$397;
  }
  _tmp$1363 = m2$395;
  _tmp$1362 = _tmp$1363 & 1ull;
  even$398 = _tmp$1362 == 0ull;
  _tmp$1361 = m2$395;
  mv$399 = 4ull * _tmp$1361;
  mmShift$400 = ieeeMantissa$397 != 0ull || ieeeExponent$396 <= 1u;
  vr$401 = 0ull;
  vp$402 = 0ull;
  vm$403 = 0ull;
  e10$404 = 0;
  vmIsTrailingZeros$405 = 0;
  vrIsTrailingZeros$406 = 0;
  _tmp$1253 = e2$394;
  if (_tmp$1253 >= 0) {
    int32_t _p$720 = e2$394;
    int32_t _tmp$1279 = _p$720 * 78913;
    uint32_t _tmp$1278 = *(uint32_t*)&_tmp$1279;
    uint32_t _tmp$1277 = _tmp$1278 >> 18;
    int32_t _tmp$1274 = *(int32_t*)&_tmp$1277;
    int32_t _tmp$1276 = e2$394;
    int32_t _p$723 = _tmp$1276 > 3;
    int32_t _tmp$1275;
    int32_t q$407;
    int32_t _tmp$1273;
    uint32_t _tmp$1272;
    uint32_t _tmp$1271;
    int32_t _tmp$1270;
    int32_t _tmp$1269;
    int32_t _tmp$1268;
    int32_t k$408;
    int32_t _tmp$1267;
    int32_t _tmp$1266;
    int32_t _tmp$1265;
    int32_t i$409;
    struct $$moonbitlang$core$double$internal$ryu$Pow5Pair pow5$410;
    uint64_t _tmp$1264;
    struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result _bind$411;
    uint64_t _vrOut$412;
    uint64_t _vpOut$413;
    uint64_t _vmOut$414;
    if (_p$723) {
      _tmp$1275 = 1;
    } else {
      _tmp$1275 = 0;
    }
    q$407 = _tmp$1274 - _tmp$1275;
    e10$404 = q$407;
    _tmp$1273 = q$407 * 1217359;
    _tmp$1272 = *(uint32_t*)&_tmp$1273;
    _tmp$1271 = _tmp$1272 >> 19;
    _tmp$1270 = *(int32_t*)&_tmp$1271;
    _tmp$1269 = _tmp$1270 + 1;
    _tmp$1268 = 125 + _tmp$1269;
    k$408 = _tmp$1268 - 1;
    _tmp$1267 = e2$394;
    _tmp$1266 = -_tmp$1267;
    _tmp$1265 = _tmp$1266 + q$407;
    i$409 = _tmp$1265 + k$408;
    pow5$410
    = $moonbitlang$core$double$internal$ryu$double_computeInvPow5(
      q$407
    );
    _tmp$1264 = m2$395;
    _bind$411
    = $moonbitlang$core$double$internal$ryu$mulShiftAll64(
      _tmp$1264, pow5$410, i$409, mmShift$400
    );
    _vrOut$412 = _bind$411.$0;
    _vpOut$413 = _bind$411.$1;
    _vmOut$414 = _bind$411.$2;
    vr$401 = _vrOut$412;
    vp$402 = _vpOut$413;
    vm$403 = _vmOut$414;
    if (q$407 <= 21) {
      int32_t _tmp$1260 = (int32_t)mv$399;
      uint64_t _tmp$1263 = mv$399 / 5ull;
      int32_t _tmp$1262 = (int32_t)_tmp$1263;
      int32_t _tmp$1261 = 5 * _tmp$1262;
      int32_t mvMod5$415 = _tmp$1260 - _tmp$1261;
      if (mvMod5$415 == 0) {
        vrIsTrailingZeros$406
        = $moonbitlang$core$double$internal$ryu$multipleOfPowerOf5(
          mv$399, q$407
        );
      } else if (even$398) {
        uint64_t _tmp$1255 = mv$399 - 1ull;
        uint64_t _tmp$1256;
        uint64_t _tmp$1254;
        if (mmShift$400) {
          _tmp$1256 = 1ull;
        } else {
          _tmp$1256 = 0ull;
        }
        _tmp$1254 = _tmp$1255 - _tmp$1256;
        vmIsTrailingZeros$405
        = $moonbitlang$core$double$internal$ryu$multipleOfPowerOf5(
          _tmp$1254, q$407
        );
      } else {
        uint64_t _tmp$1257 = vp$402;
        uint64_t _tmp$1259 = mv$399 + 2ull;
        int32_t _p$730 =
          $moonbitlang$core$double$internal$ryu$multipleOfPowerOf5(
            _tmp$1259, q$407
          );
        uint64_t _tmp$1258;
        if (_p$730) {
          _tmp$1258 = 1ull;
        } else {
          _tmp$1258 = 0ull;
        }
        vp$402 = _tmp$1257 - _tmp$1258;
      }
    }
  } else {
    int32_t _tmp$1301 = e2$394;
    int32_t _p$733 = -_tmp$1301;
    int32_t _tmp$1300 = _p$733 * 732923;
    uint32_t _tmp$1299 = *(uint32_t*)&_tmp$1300;
    uint32_t _tmp$1298 = _tmp$1299 >> 20;
    int32_t _tmp$1294 = *(int32_t*)&_tmp$1298;
    int32_t _tmp$1297 = e2$394;
    int32_t _tmp$1296 = -_tmp$1297;
    int32_t _p$736 = _tmp$1296 > 1;
    int32_t _tmp$1295;
    int32_t q$416;
    int32_t _tmp$1280;
    int32_t _tmp$1293;
    int32_t _tmp$1292;
    int32_t i$417;
    int32_t _tmp$1291;
    uint32_t _tmp$1290;
    uint32_t _tmp$1289;
    int32_t _tmp$1288;
    int32_t _tmp$1287;
    int32_t k$418;
    int32_t j$419;
    struct $$moonbitlang$core$double$internal$ryu$Pow5Pair pow5$420;
    uint64_t _tmp$1286;
    struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result _bind$421;
    uint64_t _vrOut$422;
    uint64_t _vpOut$423;
    uint64_t _vmOut$424;
    if (_p$736) {
      _tmp$1295 = 1;
    } else {
      _tmp$1295 = 0;
    }
    q$416 = _tmp$1294 - _tmp$1295;
    _tmp$1280 = e2$394;
    e10$404 = q$416 + _tmp$1280;
    _tmp$1293 = e2$394;
    _tmp$1292 = -_tmp$1293;
    i$417 = _tmp$1292 - q$416;
    _tmp$1291 = i$417 * 1217359;
    _tmp$1290 = *(uint32_t*)&_tmp$1291;
    _tmp$1289 = _tmp$1290 >> 19;
    _tmp$1288 = *(int32_t*)&_tmp$1289;
    _tmp$1287 = _tmp$1288 + 1;
    k$418 = _tmp$1287 - 125;
    j$419 = q$416 - k$418;
    pow5$420
    = $moonbitlang$core$double$internal$ryu$double_computePow5(
      i$417
    );
    _tmp$1286 = m2$395;
    _bind$421
    = $moonbitlang$core$double$internal$ryu$mulShiftAll64(
      _tmp$1286, pow5$420, j$419, mmShift$400
    );
    _vrOut$422 = _bind$421.$0;
    _vpOut$423 = _bind$421.$1;
    _vmOut$424 = _bind$421.$2;
    vr$401 = _vrOut$422;
    vp$402 = _vpOut$423;
    vm$403 = _vmOut$424;
    if (q$416 <= 1) {
      vrIsTrailingZeros$406 = 1;
      if (even$398) {
        int32_t _tmp$1281;
        if (mmShift$400) {
          _tmp$1281 = 1;
        } else {
          _tmp$1281 = 0;
        }
        vmIsTrailingZeros$405 = _tmp$1281 == 1;
      } else {
        uint64_t _tmp$1282 = vp$402;
        vp$402 = _tmp$1282 - 1ull;
      }
    } else if (q$416 < 63) {
      uint64_t _tmp$1285 = 1ull << (q$416 & 63);
      uint64_t _tmp$1284 = _tmp$1285 - 1ull;
      uint64_t _tmp$1283 = mv$399 & _tmp$1284;
      vrIsTrailingZeros$406 = _tmp$1283 == 0ull;
    }
  }
  removed$425 = 0;
  lastRemovedDigit$426 = 0;
  output$427 = 0ull;
  if (vmIsTrailingZeros$405 || vrIsTrailingZeros$406) {
    int32_t _if_result$1583;
    uint64_t _tmp$1331;
    uint64_t _tmp$1336;
    uint64_t _tmp$1337;
    int32_t _if_result$1584;
    int32_t _p$745;
    int64_t _tmp$1333;
    uint64_t _tmp$1332;
    while (1) {
      uint64_t _tmp$1314 = vp$402;
      uint64_t vpDiv10$428 = _tmp$1314 / 10ull;
      uint64_t _tmp$1313 = vm$403;
      uint64_t vmDiv10$429 = _tmp$1313 / 10ull;
      uint64_t _tmp$1312;
      int32_t _tmp$1309;
      int32_t _tmp$1311;
      int32_t _tmp$1310;
      int32_t vmMod10$431;
      uint64_t _tmp$1308;
      uint64_t vrDiv10$432;
      uint64_t _tmp$1307;
      int32_t _tmp$1304;
      int32_t _tmp$1306;
      int32_t _tmp$1305;
      int32_t vrMod10$433;
      int32_t _tmp$1303;
      if (vpDiv10$428 <= vmDiv10$429) {
        break;
      }
      _tmp$1312 = vm$403;
      _tmp$1309 = (int32_t)_tmp$1312;
      _tmp$1311 = (int32_t)vmDiv10$429;
      _tmp$1310 = 10 * _tmp$1311;
      vmMod10$431 = _tmp$1309 - _tmp$1310;
      _tmp$1308 = vr$401;
      vrDiv10$432 = _tmp$1308 / 10ull;
      _tmp$1307 = vr$401;
      _tmp$1304 = (int32_t)_tmp$1307;
      _tmp$1306 = (int32_t)vrDiv10$432;
      _tmp$1305 = 10 * _tmp$1306;
      vrMod10$433 = _tmp$1304 - _tmp$1305;
      vmIsTrailingZeros$405 = vmIsTrailingZeros$405 && vmMod10$431 == 0;
      if (vrIsTrailingZeros$406) {
        int32_t _tmp$1302 = lastRemovedDigit$426;
        vrIsTrailingZeros$406 = _tmp$1302 == 0;
      } else {
        vrIsTrailingZeros$406 = 0;
      }
      lastRemovedDigit$426 = vrMod10$433;
      vr$401 = vrDiv10$432;
      vp$402 = vpDiv10$428;
      vm$403 = vmDiv10$429;
      _tmp$1303 = removed$425;
      removed$425 = _tmp$1303 + 1;
      continue;
      break;
    }
    if (vmIsTrailingZeros$405) {
      while (1) {
        uint64_t _tmp$1327 = vm$403;
        uint64_t vmDiv10$434 = _tmp$1327 / 10ull;
        uint64_t _tmp$1326 = vm$403;
        int32_t _tmp$1323 = (int32_t)_tmp$1326;
        int32_t _tmp$1325 = (int32_t)vmDiv10$434;
        int32_t _tmp$1324 = 10 * _tmp$1325;
        int32_t vmMod10$435 = _tmp$1323 - _tmp$1324;
        uint64_t _tmp$1322;
        uint64_t vpDiv10$437;
        uint64_t _tmp$1321;
        uint64_t vrDiv10$438;
        uint64_t _tmp$1320;
        int32_t _tmp$1317;
        int32_t _tmp$1319;
        int32_t _tmp$1318;
        int32_t vrMod10$439;
        int32_t _tmp$1316;
        if (vmMod10$435 != 0) {
          break;
        }
        _tmp$1322 = vp$402;
        vpDiv10$437 = _tmp$1322 / 10ull;
        _tmp$1321 = vr$401;
        vrDiv10$438 = _tmp$1321 / 10ull;
        _tmp$1320 = vr$401;
        _tmp$1317 = (int32_t)_tmp$1320;
        _tmp$1319 = (int32_t)vrDiv10$438;
        _tmp$1318 = 10 * _tmp$1319;
        vrMod10$439 = _tmp$1317 - _tmp$1318;
        if (vrIsTrailingZeros$406) {
          int32_t _tmp$1315 = lastRemovedDigit$426;
          vrIsTrailingZeros$406 = _tmp$1315 == 0;
        } else {
          vrIsTrailingZeros$406 = 0;
        }
        lastRemovedDigit$426 = vrMod10$439;
        vr$401 = vrDiv10$438;
        vp$402 = vpDiv10$437;
        vm$403 = vmDiv10$434;
        _tmp$1316 = removed$425;
        removed$425 = _tmp$1316 + 1;
        continue;
        break;
      }
    }
    if (vrIsTrailingZeros$406) {
      int32_t _tmp$1330 = lastRemovedDigit$426;
      if (_tmp$1330 == 5) {
        uint64_t _tmp$1329 = vr$401;
        uint64_t _tmp$1328 = _tmp$1329 % 2ull;
        _if_result$1583 = _tmp$1328 == 0ull;
      } else {
        _if_result$1583 = 0;
      }
    } else {
      _if_result$1583 = 0;
    }
    if (_if_result$1583) {
      lastRemovedDigit$426 = 4;
    }
    _tmp$1331 = vr$401;
    _tmp$1336 = vr$401;
    _tmp$1337 = vm$403;
    if (_tmp$1336 == _tmp$1337) {
      if (!even$398) {
        _if_result$1584 = 1;
      } else {
        int32_t _tmp$1335 = vmIsTrailingZeros$405;
        _if_result$1584 = !_tmp$1335;
      }
    } else {
      _if_result$1584 = 0;
    }
    if (_if_result$1584) {
      _p$745 = 1;
    } else {
      int32_t _tmp$1334 = lastRemovedDigit$426;
      _p$745 = _tmp$1334 >= 5;
    }
    if (_p$745) {
      _tmp$1333 = 1ll;
    } else {
      _tmp$1333 = 0ll;
    }
    _tmp$1332 = *(uint64_t*)&_tmp$1333;
    output$427 = _tmp$1331 + _tmp$1332;
  } else {
    int32_t roundUp$440 = 0;
    uint64_t _tmp$1357 = vp$402;
    uint64_t vpDiv100$441 = _tmp$1357 / 100ull;
    uint64_t _tmp$1356 = vm$403;
    uint64_t vmDiv100$442 = _tmp$1356 / 100ull;
    uint64_t _tmp$1352;
    uint64_t _tmp$1354;
    uint64_t _tmp$1355;
    int32_t _p$748;
    uint64_t _tmp$1353;
    if (vpDiv100$441 > vmDiv100$442) {
      uint64_t _tmp$1343 = vr$401;
      uint64_t vrDiv100$443 = _tmp$1343 / 100ull;
      uint64_t _tmp$1342 = vr$401;
      int32_t _tmp$1339 = (int32_t)_tmp$1342;
      int32_t _tmp$1341 = (int32_t)vrDiv100$443;
      int32_t _tmp$1340 = 100 * _tmp$1341;
      int32_t vrMod100$444 = _tmp$1339 - _tmp$1340;
      int32_t _tmp$1338;
      roundUp$440 = vrMod100$444 >= 50;
      vr$401 = vrDiv100$443;
      vp$402 = vpDiv100$441;
      vm$403 = vmDiv100$442;
      _tmp$1338 = removed$425;
      removed$425 = _tmp$1338 + 2;
    }
    while (1) {
      uint64_t _tmp$1351 = vp$402;
      uint64_t vpDiv10$445 = _tmp$1351 / 10ull;
      uint64_t _tmp$1350 = vm$403;
      uint64_t vmDiv10$446 = _tmp$1350 / 10ull;
      uint64_t _tmp$1349;
      uint64_t vrDiv10$448;
      uint64_t _tmp$1348;
      int32_t _tmp$1345;
      int32_t _tmp$1347;
      int32_t _tmp$1346;
      int32_t vrMod10$449;
      int32_t _tmp$1344;
      if (vpDiv10$445 <= vmDiv10$446) {
        break;
      }
      _tmp$1349 = vr$401;
      vrDiv10$448 = _tmp$1349 / 10ull;
      _tmp$1348 = vr$401;
      _tmp$1345 = (int32_t)_tmp$1348;
      _tmp$1347 = (int32_t)vrDiv10$448;
      _tmp$1346 = 10 * _tmp$1347;
      vrMod10$449 = _tmp$1345 - _tmp$1346;
      roundUp$440 = vrMod10$449 >= 5;
      vr$401 = vrDiv10$448;
      vp$402 = vpDiv10$445;
      vm$403 = vmDiv10$446;
      _tmp$1344 = removed$425;
      removed$425 = _tmp$1344 + 1;
      continue;
      break;
    }
    _tmp$1352 = vr$401;
    _tmp$1354 = vr$401;
    _tmp$1355 = vm$403;
    _p$748 = _tmp$1354 == _tmp$1355 || roundUp$440;
    if (_p$748) {
      _tmp$1353 = 1ull;
    } else {
      _tmp$1353 = 0ull;
    }
    output$427 = _tmp$1352 + _tmp$1353;
  }
  _tmp$1359 = e10$404;
  _tmp$1360 = removed$425;
  exp$450 = _tmp$1359 + _tmp$1360;
  _tmp$1358 = output$427;
  _block$1586
  = (struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64)
    );
  Moonbit_object_header(_block$1586)->meta
  = Moonbit_make_regular_object_header(
    sizeof(
      struct $$moonbitlang$core$double$internal$ryu$FloatingDecimal64
    )
    >> 2,
      0,
      0
  );
  _block$1586->$0 = _tmp$1358;
  _block$1586->$1 = exp$450;
  return _block$1586;
}

int32_t $moonbitlang$core$double$internal$ryu$decimal_length17(
  uint64_t v$393
) {
  if (v$393 >= 10000000000000000ull) {
    return 17;
  }
  if (v$393 >= 1000000000000000ull) {
    return 16;
  }
  if (v$393 >= 100000000000000ull) {
    return 15;
  }
  if (v$393 >= 10000000000000ull) {
    return 14;
  }
  if (v$393 >= 1000000000000ull) {
    return 13;
  }
  if (v$393 >= 100000000000ull) {
    return 12;
  }
  if (v$393 >= 10000000000ull) {
    return 11;
  }
  if (v$393 >= 1000000000ull) {
    return 10;
  }
  if (v$393 >= 100000000ull) {
    return 9;
  }
  if (v$393 >= 10000000ull) {
    return 8;
  }
  if (v$393 >= 1000000ull) {
    return 7;
  }
  if (v$393 >= 100000ull) {
    return 6;
  }
  if (v$393 >= 10000ull) {
    return 5;
  }
  if (v$393 >= 1000ull) {
    return 4;
  }
  if (v$393 >= 100ull) {
    return 3;
  }
  if (v$393 >= 10ull) {
    return 2;
  }
  return 1;
}

struct $$moonbitlang$core$double$internal$ryu$Pow5Pair $moonbitlang$core$double$internal$ryu$double_computeInvPow5(
  int32_t i$376
) {
  int32_t _tmp$1249 = i$376 + 26;
  int32_t _tmp$1248 = _tmp$1249 - 1;
  int32_t base$375 = _tmp$1248 / 26;
  int32_t base2$377 = base$375 * 26;
  int32_t offset$378 = base2$377 - i$376;
  int32_t _p$697 = base$375 * 2;
  uint64_t* _tmp$1247;
  uint64_t _tmp$1528;
  uint64_t mul0$379;
  int32_t _tmp$1246;
  int32_t _p$700;
  uint64_t* _tmp$1245;
  uint64_t _tmp$1527;
  uint64_t mul1$380;
  uint64_t* _tmp$1244;
  uint64_t _tmp$1526;
  uint64_t m$381;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$382;
  uint64_t _low1$383;
  uint64_t _high1$384;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$385;
  uint64_t _low0$386;
  uint64_t _high0$387;
  uint64_t sum$388;
  uint64_t high1$389;
  int32_t _tmp$1243;
  uint32_t _tmp$1242;
  uint32_t _tmp$1241;
  int32_t _tmp$1240;
  int32_t _tmp$1234;
  int32_t _tmp$1239;
  uint32_t _tmp$1238;
  uint32_t _tmp$1237;
  int32_t _tmp$1236;
  int32_t _tmp$1235;
  int32_t delta$390;
  int32_t _tmp$1233;
  uint64_t _tmp$1231;
  uint64_t _tmp$1232;
  uint64_t _tmp$1230;
  uint64_t _tmp$1223;
  int32_t _p$711;
  uint32_t* _tmp$1229;
  uint32_t _tmp$1525;
  uint32_t _tmp$1226;
  int32_t _tmp$1228;
  int32_t _tmp$1227;
  uint32_t _tmp$1225;
  uint32_t _p$714;
  uint64_t _tmp$1224;
  uint64_t a$391;
  uint64_t _p$717;
  int32_t _tmp$1222;
  uint64_t _tmp$1220;
  uint64_t _tmp$1221;
  uint64_t b$392;
  moonbit_incref(
    $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_INV_SPLIT2
  );
  _tmp$1247 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_INV_SPLIT2;
  if (_p$697 < 0 || _p$697 >= Moonbit_array_length(_tmp$1247)) {
    moonbit_panic();
  }
  _tmp$1528 = (uint64_t)_tmp$1247[_p$697];
  moonbit_decref(_tmp$1247);
  mul0$379 = _tmp$1528;
  _tmp$1246 = base$375 * 2;
  _p$700 = _tmp$1246 + 1;
  moonbit_incref(
    $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_INV_SPLIT2
  );
  _tmp$1245 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_INV_SPLIT2;
  if (_p$700 < 0 || _p$700 >= Moonbit_array_length(_tmp$1245)) {
    moonbit_panic();
  }
  _tmp$1527 = (uint64_t)_tmp$1245[_p$700];
  moonbit_decref(_tmp$1245);
  mul1$380 = _tmp$1527;
  if (offset$378 == 0) {
    return (struct $$moonbitlang$core$double$internal$ryu$Pow5Pair){
             mul0$379, mul1$380
           };
  }
  moonbit_incref($moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_TABLE);
  _tmp$1244 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_TABLE;
  if (offset$378 < 0 || offset$378 >= Moonbit_array_length(_tmp$1244)) {
    moonbit_panic();
  }
  _tmp$1526 = (uint64_t)_tmp$1244[offset$378];
  moonbit_decref(_tmp$1244);
  m$381 = _tmp$1526;
  _bind$382 = $moonbitlang$core$double$internal$ryu$umul128(m$381, mul1$380);
  _low1$383 = _bind$382.$0;
  _high1$384 = _bind$382.$1;
  _bind$385 = $moonbitlang$core$double$internal$ryu$umul128(m$381, mul0$379);
  _low0$386 = _bind$385.$0;
  _high0$387 = _bind$385.$1;
  sum$388 = _high0$387 + _low1$383;
  high1$389 = _high1$384;
  if (sum$388 < _high0$387) {
    uint64_t _tmp$1219 = high1$389;
    high1$389 = _tmp$1219 + 1ull;
  }
  _tmp$1243 = base2$377 * 1217359;
  _tmp$1242 = *(uint32_t*)&_tmp$1243;
  _tmp$1241 = _tmp$1242 >> 19;
  _tmp$1240 = *(int32_t*)&_tmp$1241;
  _tmp$1234 = _tmp$1240 + 1;
  _tmp$1239 = i$376 * 1217359;
  _tmp$1238 = *(uint32_t*)&_tmp$1239;
  _tmp$1237 = _tmp$1238 >> 19;
  _tmp$1236 = *(int32_t*)&_tmp$1237;
  _tmp$1235 = _tmp$1236 + 1;
  delta$390 = _tmp$1234 - _tmp$1235;
  _tmp$1233 = 64 - delta$390;
  _tmp$1231 = sum$388 << (_tmp$1233 & 63);
  _tmp$1232 = _low0$386 >> (delta$390 & 63);
  _tmp$1230 = _tmp$1231 | _tmp$1232;
  _tmp$1223 = _tmp$1230 + 1ull;
  _p$711 = i$376 / 16;
  moonbit_incref($moonbitlang$core$double$internal$ryu$gPOW5_INV_OFFSETS);
  _tmp$1229 = $moonbitlang$core$double$internal$ryu$gPOW5_INV_OFFSETS;
  if (_p$711 < 0 || _p$711 >= Moonbit_array_length(_tmp$1229)) {
    moonbit_panic();
  }
  _tmp$1525 = (uint32_t)_tmp$1229[_p$711];
  moonbit_decref(_tmp$1229);
  _tmp$1226 = _tmp$1525;
  _tmp$1228 = i$376 % 16;
  _tmp$1227 = _tmp$1228 << 1;
  _tmp$1225 = _tmp$1226 >> (_tmp$1227 & 31);
  _p$714 = _tmp$1225 & 3u;
  _tmp$1224 = (uint64_t)_p$714;
  a$391 = _tmp$1223 + _tmp$1224;
  _p$717 = high1$389;
  _tmp$1222 = 64 - delta$390;
  _tmp$1220 = _p$717 << (_tmp$1222 & 63);
  _tmp$1221 = sum$388 >> (delta$390 & 63);
  b$392 = _tmp$1220 | _tmp$1221;
  return (struct $$moonbitlang$core$double$internal$ryu$Pow5Pair){
           a$391, b$392
         };
}

struct $$moonbitlang$core$double$internal$ryu$Pow5Pair $moonbitlang$core$double$internal$ryu$double_computePow5(
  int32_t i$358
) {
  int32_t base$357 = i$358 / 26;
  int32_t base2$359 = base$357 * 26;
  int32_t offset$360 = i$358 - base2$359;
  int32_t _p$674 = base$357 * 2;
  uint64_t* _tmp$1218;
  uint64_t _tmp$1532;
  uint64_t mul0$361;
  int32_t _tmp$1217;
  int32_t _p$677;
  uint64_t* _tmp$1216;
  uint64_t _tmp$1531;
  uint64_t mul1$362;
  uint64_t* _tmp$1215;
  uint64_t _tmp$1530;
  uint64_t m$363;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$364;
  uint64_t _low1$365;
  uint64_t _high1$366;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$367;
  uint64_t _low0$368;
  uint64_t _high0$369;
  uint64_t sum$370;
  uint64_t high1$371;
  int32_t _tmp$1214;
  uint32_t _tmp$1213;
  uint32_t _tmp$1212;
  int32_t _tmp$1211;
  int32_t _tmp$1205;
  int32_t _tmp$1210;
  uint32_t _tmp$1209;
  uint32_t _tmp$1208;
  int32_t _tmp$1207;
  int32_t _tmp$1206;
  int32_t delta$372;
  int32_t _tmp$1204;
  uint64_t _tmp$1202;
  uint64_t _tmp$1203;
  uint64_t _tmp$1195;
  int32_t _p$688;
  uint32_t* _tmp$1201;
  uint32_t _tmp$1529;
  uint32_t _tmp$1198;
  int32_t _tmp$1200;
  int32_t _tmp$1199;
  uint32_t _tmp$1197;
  uint32_t _p$691;
  uint64_t _tmp$1196;
  uint64_t a$373;
  uint64_t _p$694;
  int32_t _tmp$1194;
  uint64_t _tmp$1192;
  uint64_t _tmp$1193;
  uint64_t b$374;
  moonbit_incref($moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_SPLIT2);
  _tmp$1218 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_SPLIT2;
  if (_p$674 < 0 || _p$674 >= Moonbit_array_length(_tmp$1218)) {
    moonbit_panic();
  }
  _tmp$1532 = (uint64_t)_tmp$1218[_p$674];
  moonbit_decref(_tmp$1218);
  mul0$361 = _tmp$1532;
  _tmp$1217 = base$357 * 2;
  _p$677 = _tmp$1217 + 1;
  moonbit_incref($moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_SPLIT2);
  _tmp$1216 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_SPLIT2;
  if (_p$677 < 0 || _p$677 >= Moonbit_array_length(_tmp$1216)) {
    moonbit_panic();
  }
  _tmp$1531 = (uint64_t)_tmp$1216[_p$677];
  moonbit_decref(_tmp$1216);
  mul1$362 = _tmp$1531;
  if (offset$360 == 0) {
    return (struct $$moonbitlang$core$double$internal$ryu$Pow5Pair){
             mul0$361, mul1$362
           };
  }
  moonbit_incref($moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_TABLE);
  _tmp$1215 = $moonbitlang$core$double$internal$ryu$gDOUBLE_POW5_TABLE;
  if (offset$360 < 0 || offset$360 >= Moonbit_array_length(_tmp$1215)) {
    moonbit_panic();
  }
  _tmp$1530 = (uint64_t)_tmp$1215[offset$360];
  moonbit_decref(_tmp$1215);
  m$363 = _tmp$1530;
  _bind$364 = $moonbitlang$core$double$internal$ryu$umul128(m$363, mul1$362);
  _low1$365 = _bind$364.$0;
  _high1$366 = _bind$364.$1;
  _bind$367 = $moonbitlang$core$double$internal$ryu$umul128(m$363, mul0$361);
  _low0$368 = _bind$367.$0;
  _high0$369 = _bind$367.$1;
  sum$370 = _high0$369 + _low1$365;
  high1$371 = _high1$366;
  if (sum$370 < _high0$369) {
    uint64_t _tmp$1191 = high1$371;
    high1$371 = _tmp$1191 + 1ull;
  }
  _tmp$1214 = i$358 * 1217359;
  _tmp$1213 = *(uint32_t*)&_tmp$1214;
  _tmp$1212 = _tmp$1213 >> 19;
  _tmp$1211 = *(int32_t*)&_tmp$1212;
  _tmp$1205 = _tmp$1211 + 1;
  _tmp$1210 = base2$359 * 1217359;
  _tmp$1209 = *(uint32_t*)&_tmp$1210;
  _tmp$1208 = _tmp$1209 >> 19;
  _tmp$1207 = *(int32_t*)&_tmp$1208;
  _tmp$1206 = _tmp$1207 + 1;
  delta$372 = _tmp$1205 - _tmp$1206;
  _tmp$1204 = 64 - delta$372;
  _tmp$1202 = sum$370 << (_tmp$1204 & 63);
  _tmp$1203 = _low0$368 >> (delta$372 & 63);
  _tmp$1195 = _tmp$1202 | _tmp$1203;
  _p$688 = i$358 / 16;
  moonbit_incref($moonbitlang$core$double$internal$ryu$gPOW5_OFFSETS);
  _tmp$1201 = $moonbitlang$core$double$internal$ryu$gPOW5_OFFSETS;
  if (_p$688 < 0 || _p$688 >= Moonbit_array_length(_tmp$1201)) {
    moonbit_panic();
  }
  _tmp$1529 = (uint32_t)_tmp$1201[_p$688];
  moonbit_decref(_tmp$1201);
  _tmp$1198 = _tmp$1529;
  _tmp$1200 = i$358 % 16;
  _tmp$1199 = _tmp$1200 << 1;
  _tmp$1197 = _tmp$1198 >> (_tmp$1199 & 31);
  _p$691 = _tmp$1197 & 3u;
  _tmp$1196 = (uint64_t)_p$691;
  a$373 = _tmp$1195 + _tmp$1196;
  _p$694 = high1$371;
  _tmp$1194 = 64 - delta$372;
  _tmp$1192 = _p$694 << (_tmp$1194 & 63);
  _tmp$1193 = sum$370 >> (delta$372 & 63);
  b$374 = _tmp$1192 | _tmp$1193;
  return (struct $$moonbitlang$core$double$internal$ryu$Pow5Pair){
           a$373, b$374
         };
}

struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result $moonbitlang$core$double$internal$ryu$mulShiftAll64(
  uint64_t m$331,
  struct $$moonbitlang$core$double$internal$ryu$Pow5Pair mul$328,
  int32_t j$344,
  int32_t mmShift$346
) {
  uint64_t _mul0$327 = mul$328.$0;
  uint64_t _mul1$329 = mul$328.$1;
  uint64_t m$330 = m$331 << 1;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$332 =
    $moonbitlang$core$double$internal$ryu$umul128(m$330, _mul0$327);
  uint64_t _lo$333 = _bind$332.$0;
  uint64_t _tmp$334 = _bind$332.$1;
  struct $$moonbitlang$core$double$internal$ryu$Umul128 _bind$335 =
    $moonbitlang$core$double$internal$ryu$umul128(m$330, _mul1$329);
  uint64_t _lo2$336 = _bind$335.$0;
  uint64_t _hi2$337 = _bind$335.$1;
  uint64_t mid$338 = _tmp$334 + _lo2$336;
  uint64_t _tmp$1190;
  uint64_t hi$339;
  uint64_t lo2$340;
  uint64_t _tmp$1188;
  uint64_t _tmp$1189;
  uint64_t mid2$341;
  uint64_t _tmp$1187;
  uint64_t hi2$342;
  int32_t _tmp$1186;
  int32_t _p$662;
  int32_t _tmp$1185;
  uint64_t _tmp$1183;
  uint64_t _tmp$1184;
  uint64_t vp$343;
  uint64_t vm$345;
  int32_t _tmp$1182;
  int32_t _p$671;
  int32_t _tmp$1181;
  uint64_t _tmp$1179;
  uint64_t _tmp$1180;
  uint64_t vr$356;
  uint64_t _tmp$1178;
  if (mid$338 < _tmp$334) {
    _tmp$1190 = 1ull;
  } else {
    _tmp$1190 = 0ull;
  }
  hi$339 = _hi2$337 + _tmp$1190;
  lo2$340 = _lo$333 + _mul0$327;
  _tmp$1188 = mid$338 + _mul1$329;
  if (lo2$340 < _lo$333) {
    _tmp$1189 = 1ull;
  } else {
    _tmp$1189 = 0ull;
  }
  mid2$341 = _tmp$1188 + _tmp$1189;
  if (mid2$341 < mid$338) {
    _tmp$1187 = 1ull;
  } else {
    _tmp$1187 = 0ull;
  }
  hi2$342 = hi$339 + _tmp$1187;
  _tmp$1186 = j$344 - 64;
  _p$662 = _tmp$1186 - 1;
  _tmp$1185 = 64 - _p$662;
  _tmp$1183 = hi2$342 << (_tmp$1185 & 63);
  _tmp$1184 = mid2$341 >> (_p$662 & 63);
  vp$343 = _tmp$1183 | _tmp$1184;
  vm$345 = 0ull;
  if (mmShift$346) {
    uint64_t lo3$347 = _lo$333 - _mul0$327;
    uint64_t _tmp$1166 = mid$338 - _mul1$329;
    uint64_t _tmp$1167;
    uint64_t mid3$348;
    uint64_t _tmp$1165;
    uint64_t hi3$349;
    int32_t _tmp$1164;
    int32_t _p$665;
    int32_t _tmp$1163;
    uint64_t _tmp$1161;
    uint64_t _tmp$1162;
    if (_lo$333 < lo3$347) {
      _tmp$1167 = 1ull;
    } else {
      _tmp$1167 = 0ull;
    }
    mid3$348 = _tmp$1166 - _tmp$1167;
    if (mid$338 < mid3$348) {
      _tmp$1165 = 1ull;
    } else {
      _tmp$1165 = 0ull;
    }
    hi3$349 = hi$339 - _tmp$1165;
    _tmp$1164 = j$344 - 64;
    _p$665 = _tmp$1164 - 1;
    _tmp$1163 = 64 - _p$665;
    _tmp$1161 = hi3$349 << (_tmp$1163 & 63);
    _tmp$1162 = mid3$348 >> (_p$665 & 63);
    vm$345 = _tmp$1161 | _tmp$1162;
  } else {
    uint64_t lo3$350 = _lo$333 + _lo$333;
    uint64_t _tmp$1176 = mid$338 + mid$338;
    uint64_t _tmp$1177;
    uint64_t mid3$351;
    uint64_t _tmp$1174;
    uint64_t _tmp$1175;
    uint64_t hi3$352;
    uint64_t lo4$353;
    uint64_t _tmp$1172;
    uint64_t _tmp$1173;
    uint64_t mid4$354;
    uint64_t _tmp$1171;
    uint64_t hi4$355;
    int32_t _p$668;
    int32_t _tmp$1170;
    uint64_t _tmp$1168;
    uint64_t _tmp$1169;
    if (lo3$350 < _lo$333) {
      _tmp$1177 = 1ull;
    } else {
      _tmp$1177 = 0ull;
    }
    mid3$351 = _tmp$1176 + _tmp$1177;
    _tmp$1174 = hi$339 + hi$339;
    if (mid3$351 < mid$338) {
      _tmp$1175 = 1ull;
    } else {
      _tmp$1175 = 0ull;
    }
    hi3$352 = _tmp$1174 + _tmp$1175;
    lo4$353 = lo3$350 - _mul0$327;
    _tmp$1172 = mid3$351 - _mul1$329;
    if (lo3$350 < lo4$353) {
      _tmp$1173 = 1ull;
    } else {
      _tmp$1173 = 0ull;
    }
    mid4$354 = _tmp$1172 - _tmp$1173;
    if (mid3$351 < mid4$354) {
      _tmp$1171 = 1ull;
    } else {
      _tmp$1171 = 0ull;
    }
    hi4$355 = hi3$352 - _tmp$1171;
    _p$668 = j$344 - 64;
    _tmp$1170 = 64 - _p$668;
    _tmp$1168 = hi4$355 << (_tmp$1170 & 63);
    _tmp$1169 = mid4$354 >> (_p$668 & 63);
    vm$345 = _tmp$1168 | _tmp$1169;
  }
  _tmp$1182 = j$344 - 64;
  _p$671 = _tmp$1182 - 1;
  _tmp$1181 = 64 - _p$671;
  _tmp$1179 = hi$339 << (_tmp$1181 & 63);
  _tmp$1180 = mid$338 >> (_p$671 & 63);
  vr$356 = _tmp$1179 | _tmp$1180;
  _tmp$1178 = vm$345;
  return (struct $$moonbitlang$core$double$internal$ryu$MulShiftAll64Result){
           vr$356, vp$343, _tmp$1178
         };
}

int32_t $moonbitlang$core$double$internal$ryu$multipleOfPowerOf2(
  uint64_t value$325,
  int32_t p$326
) {
  uint64_t _tmp$1160 = 1ull << (p$326 & 63);
  uint64_t _tmp$1159 = _tmp$1160 - 1ull;
  uint64_t _tmp$1158 = value$325 & _tmp$1159;
  return _tmp$1158 == 0ull;
}

int32_t $moonbitlang$core$double$internal$ryu$multipleOfPowerOf5(
  uint64_t value$323,
  int32_t p$324
) {
  int32_t _tmp$1157 =
    $moonbitlang$core$double$internal$ryu$pow5Factor(value$323);
  return _tmp$1157 >= p$324;
}

int32_t $moonbitlang$core$double$internal$ryu$pow5Factor(uint64_t value$319) {
  uint64_t _tmp$1145 = value$319 % 5ull;
  uint64_t _tmp$1146;
  uint64_t _tmp$1147;
  uint64_t _tmp$1148;
  int32_t count$320;
  uint64_t value$321;
  uint64_t _tmp$1156;
  moonbit_string_t _tmp$1155;
  moonbit_string_t _tmp$1154;
  if (_tmp$1145 != 0ull) {
    return 0;
  }
  _tmp$1146 = value$319 % 25ull;
  if (_tmp$1146 != 0ull) {
    return 1;
  }
  _tmp$1147 = value$319 % 125ull;
  if (_tmp$1147 != 0ull) {
    return 2;
  }
  _tmp$1148 = value$319 % 625ull;
  if (_tmp$1148 != 0ull) {
    return 3;
  }
  count$320 = 4;
  value$321 = value$319 / 625ull;
  while (1) {
    uint64_t _tmp$1149 = value$321;
    if (_tmp$1149 > 0ull) {
      uint64_t _tmp$1151 = value$321;
      uint64_t _tmp$1150 = _tmp$1151 % 5ull;
      uint64_t _tmp$1152;
      int32_t _tmp$1153;
      if (_tmp$1150 != 0ull) {
        return count$320;
      }
      _tmp$1152 = value$321;
      value$321 = _tmp$1152 / 5ull;
      _tmp$1153 = count$320;
      count$320 = _tmp$1153 + 1;
      continue;
    }
    break;
  }
  _tmp$1156 = value$321;
  _tmp$1155
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(
    _tmp$1156
  );
  _tmp$1154
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_1.data, _tmp$1155
  );
  return $moonbitlang$core$builtin$abort$0(
           _tmp$1154, (moonbit_string_t)moonbit_string_literal_2.data
         );
}

uint64_t $moonbitlang$core$double$internal$ryu$shiftright128(
  uint64_t lo$318,
  uint64_t hi$316,
  int32_t dist$317
) {
  int32_t _tmp$1144 = 64 - dist$317;
  uint64_t _tmp$1142 = hi$316 << (_tmp$1144 & 63);
  uint64_t _tmp$1143 = lo$318 >> (dist$317 & 63);
  return _tmp$1142 | _tmp$1143;
}

struct $$moonbitlang$core$double$internal$ryu$Umul128 $moonbitlang$core$double$internal$ryu$umul128(
  uint64_t a$306,
  uint64_t b$309
) {
  uint64_t aLo$305 = a$306 & 4294967295ull;
  uint64_t aHi$307 = a$306 >> 32;
  uint64_t bLo$308 = b$309 & 4294967295ull;
  uint64_t bHi$310 = b$309 >> 32;
  uint64_t x$311 = aLo$305 * bLo$308;
  uint64_t _tmp$1140 = aHi$307 * bLo$308;
  uint64_t _tmp$1141 = x$311 >> 32;
  uint64_t y$312 = _tmp$1140 + _tmp$1141;
  uint64_t _tmp$1138 = aLo$305 * bHi$310;
  uint64_t _tmp$1139 = y$312 & 4294967295ull;
  uint64_t z$313 = _tmp$1138 + _tmp$1139;
  uint64_t _tmp$1136 = aHi$307 * bHi$310;
  uint64_t _tmp$1137 = y$312 >> 32;
  uint64_t _tmp$1134 = _tmp$1136 + _tmp$1137;
  uint64_t _tmp$1135 = z$313 >> 32;
  uint64_t w$314 = _tmp$1134 + _tmp$1135;
  uint64_t lo$315 = a$306 * b$309;
  return (struct $$moonbitlang$core$double$internal$ryu$Umul128){
           lo$315, w$314
         };
}

moonbit_string_t $moonbitlang$core$double$internal$ryu$string_from_bytes(
  moonbit_bytes_t bytes$300,
  int32_t from$304,
  int32_t to$302
) {
  int32_t _tmp$1133 = Moonbit_array_length(bytes$300);
  struct $$moonbitlang$core$builtin$StringBuilder* buf$299 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(_tmp$1133);
  int32_t i$301 = from$304;
  while (1) {
    if (i$301 < to$302) {
      int32_t _p$659;
      int32_t _tmp$1131;
      int32_t _tmp$1130;
      int32_t _tmp$1132;
      if (i$301 < 0 || i$301 >= Moonbit_array_length(bytes$300)) {
        moonbit_panic();
      }
      _p$659 = (int32_t)bytes$300[i$301];
      _tmp$1131 = (int32_t)_p$659;
      _tmp$1130 = _tmp$1131;
      moonbit_incref(buf$299);
      $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
        buf$299, _tmp$1130
      );
      _tmp$1132 = i$301 + 1;
      i$301 = _tmp$1132;
      continue;
    } else {
      moonbit_decref(bytes$300);
    }
    break;
  }
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(buf$299);
}

int32_t $moonbitlang$core$double$internal$ryu$log10Pow2(int32_t e$298) {
  int32_t _tmp$1129 = e$298 * 78913;
  uint32_t _tmp$1128 = *(uint32_t*)&_tmp$1129;
  uint32_t _tmp$1127 = _tmp$1128 >> 18;
  return *(int32_t*)&_tmp$1127;
}

int32_t $moonbitlang$core$double$internal$ryu$log10Pow5(int32_t e$297) {
  int32_t _tmp$1126 = e$297 * 732923;
  uint32_t _tmp$1125 = *(uint32_t*)&_tmp$1126;
  uint32_t _tmp$1124 = _tmp$1125 >> 20;
  return *(int32_t*)&_tmp$1124;
}

moonbit_string_t $moonbitlang$core$double$internal$ryu$copy_special_str(
  int32_t sign$295,
  int32_t exponent$296,
  int32_t mantissa$293
) {
  moonbit_string_t s$294;
  if (mantissa$293) {
    return (moonbit_string_t)moonbit_string_literal_3.data;
  }
  if (sign$295) {
    s$294 = (moonbit_string_t)moonbit_string_literal_4.data;
  } else {
    s$294 = (moonbit_string_t)moonbit_string_literal_5.data;
  }
  if (exponent$296) {
    return moonbit_add_string(
             s$294, (moonbit_string_t)moonbit_string_literal_6.data
           );
  }
  return moonbit_add_string(
           s$294, (moonbit_string_t)moonbit_string_literal_7.data
         );
}

int32_t $moonbitlang$core$double$internal$ryu$pow5bits(int32_t e$292) {
  int32_t _tmp$1123 = e$292 * 1217359;
  uint32_t _tmp$1122 = *(uint32_t*)&_tmp$1123;
  uint32_t _tmp$1121 = _tmp$1122 >> 19;
  int32_t _tmp$1120 = *(int32_t*)&_tmp$1121;
  return _tmp$1120 + 1;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$290,
  struct $$moonbitlang$core$builtin$Logger logger$291
) {
  moonbit_string_t _tmp$1119 = self$290;
  struct $$moonbitlang$core$builtin$SourceLocRepr* _tmp$1118 =
    $$moonbitlang$core$builtin$SourceLocRepr$$parse(_tmp$1119);
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
    _tmp$1118, logger$291
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$253,
  struct $$moonbitlang$core$builtin$Logger logger$289
) {
  struct $StringView _field$1542 =
    (struct $StringView){self$253->$0_1, self$253->$0_2, self$253->$0_0};
  struct $StringView pkg$252 = _field$1542;
  moonbit_string_t _field$1541 = pkg$252.$0;
  moonbit_string_t _data$254 = _field$1541;
  int32_t _start$255 = pkg$252.$1;
  int32_t end$1116 = pkg$252.$2;
  int32_t start$1117 = pkg$252.$1;
  int32_t _tmp$1115 = end$1116 - start$1117;
  int32_t _end$256 = _start$255 + _tmp$1115;
  int32_t _cursor$257 = _start$255;
  int32_t accept_state$258 = -1;
  int32_t match_end$259 = -1;
  int32_t match_tag_saver_0$260 = -1;
  int32_t tag_0$261 = -1;
  struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$* _bind$262;
  struct $StringView _field$1540;
  struct $StringView _module_name$285;
  void* _field$1539;
  int32_t _cnt$1563;
  void* _package_name$286;
  struct $StringView _field$1537;
  struct $StringView filename$1078;
  struct $StringView _field$1536;
  struct $StringView start_line$1079;
  struct $StringView _field$1535;
  struct $StringView start_column$1080;
  struct $StringView _field$1534;
  struct $StringView end_line$1081;
  struct $StringView _field$1533;
  int32_t _cnt$1567;
  struct $StringView end_column$1082;
  struct $$moonbitlang$core$builtin$Logger _bind$1077;
  moonbit_incref(_data$254);
  moonbit_incref(pkg$252.$0);
  while (1) {
    int32_t _tmp$1097 = _cursor$257;
    if (_tmp$1097 < _end$256) {
      int32_t _p$632 = _cursor$257;
      int32_t next_char$272 = _data$254[_p$632];
      int32_t _tmp$1098 = _cursor$257;
      _cursor$257 = _tmp$1098 + 1;
      if (next_char$272 < 55296) {
        if (next_char$272 < 47) {
          goto $join$270;
        } else if (next_char$272 > 47) {
          goto $join$270;
        } else {
          while (1) {
            int32_t _tmp$1099;
            tag_0$261 = _cursor$257;
            _tmp$1099 = _cursor$257;
            if (_tmp$1099 < _end$256) {
              int32_t _p$635 = _cursor$257;
              int32_t next_char$275 = _data$254[_p$635];
              int32_t _tmp$1100 = _cursor$257;
              _cursor$257 = _tmp$1100 + 1;
              if (next_char$275 < 55296) {
                if (next_char$275 < 47) {
                  goto $join$273;
                } else if (next_char$275 > 47) {
                  goto $join$273;
                } else {
                  while (1) {
                    int32_t _tmp$1101 = _cursor$257;
                    if (_tmp$1101 < _end$256) {
                      int32_t _p$638 = _cursor$257;
                      int32_t next_char$278 = _data$254[_p$638];
                      int32_t _tmp$1102 = _cursor$257;
                      _cursor$257 = _tmp$1102 + 1;
                      if (next_char$278 < 56319) {
                        if (next_char$278 < 55296) {
                          goto $join$276;
                        } else {
                          int32_t _tmp$1103 = _cursor$257;
                          if (_tmp$1103 < _end$256) {
                            int32_t _p$641 = _cursor$257;
                            int32_t next_char$279 = _data$254[_p$641];
                            int32_t _tmp$1104 = _cursor$257;
                            _cursor$257 = _tmp$1104 + 1;
                            if (next_char$279 < 56320) {
                              goto $join$263;
                            } else if (next_char$279 > 65535) {
                              goto $join$263;
                            } else {
                              continue;
                            }
                          } else {
                            goto $join$263;
                          }
                        }
                      } else if (next_char$278 > 56319) {
                        if (next_char$278 < 65536) {
                          goto $join$276;
                        } else {
                          goto $join$263;
                        }
                      } else {
                        int32_t _tmp$1105 = _cursor$257;
                        if (_tmp$1105 < _end$256) {
                          int32_t _p$644 = _cursor$257;
                          int32_t next_char$280 = _data$254[_p$644];
                          int32_t _tmp$1106 = _cursor$257;
                          _cursor$257 = _tmp$1106 + 1;
                          if (next_char$280 < 56320) {
                            goto $join$263;
                          } else if (next_char$280 > 57343) {
                            goto $join$263;
                          } else {
                            continue;
                          }
                        } else {
                          goto $join$263;
                        }
                      }
                      goto $joinlet$1595;
                      $join$276:;
                      continue;
                      $joinlet$1595:;
                    } else {
                      match_tag_saver_0$260 = tag_0$261;
                      accept_state$258 = 0;
                      match_end$259 = _cursor$257;
                      goto $join$263;
                    }
                    break;
                  }
                }
              } else if (next_char$275 > 56318) {
                if (next_char$275 < 57344) {
                  int32_t _tmp$1107 = _cursor$257;
                  if (_tmp$1107 < _end$256) {
                    int32_t _p$647 = _cursor$257;
                    int32_t next_char$281 = _data$254[_p$647];
                    int32_t _tmp$1108 = _cursor$257;
                    _cursor$257 = _tmp$1108 + 1;
                    if (next_char$281 < 56320) {
                      goto $join$263;
                    } else if (next_char$281 > 57343) {
                      goto $join$263;
                    } else {
                      continue;
                    }
                  } else {
                    goto $join$263;
                  }
                } else if (next_char$275 > 65535) {
                  goto $join$263;
                } else {
                  goto $join$273;
                }
              } else {
                int32_t _tmp$1109 = _cursor$257;
                if (_tmp$1109 < _end$256) {
                  int32_t _p$650 = _cursor$257;
                  int32_t next_char$282 = _data$254[_p$650];
                  int32_t _tmp$1110 = _cursor$257;
                  _cursor$257 = _tmp$1110 + 1;
                  if (next_char$282 < 56320) {
                    goto $join$263;
                  } else if (next_char$282 > 65535) {
                    goto $join$263;
                  } else {
                    continue;
                  }
                } else {
                  goto $join$263;
                }
              }
              goto $joinlet$1593;
              $join$273:;
              continue;
              $joinlet$1593:;
            } else {
              goto $join$263;
            }
            break;
          }
        }
      } else if (next_char$272 > 56318) {
        if (next_char$272 < 57344) {
          int32_t _tmp$1111 = _cursor$257;
          if (_tmp$1111 < _end$256) {
            int32_t _p$653 = _cursor$257;
            int32_t next_char$283 = _data$254[_p$653];
            int32_t _tmp$1112 = _cursor$257;
            _cursor$257 = _tmp$1112 + 1;
            if (next_char$283 < 56320) {
              goto $join$263;
            } else if (next_char$283 > 57343) {
              goto $join$263;
            } else {
              continue;
            }
          } else {
            goto $join$263;
          }
        } else if (next_char$272 > 65535) {
          goto $join$263;
        } else {
          goto $join$270;
        }
      } else {
        int32_t _tmp$1113 = _cursor$257;
        if (_tmp$1113 < _end$256) {
          int32_t _p$656 = _cursor$257;
          int32_t next_char$284 = _data$254[_p$656];
          int32_t _tmp$1114 = _cursor$257;
          _cursor$257 = _tmp$1114 + 1;
          if (next_char$284 < 56320) {
            goto $join$263;
          } else if (next_char$284 > 65535) {
            goto $join$263;
          } else {
            continue;
          }
        } else {
          goto $join$263;
        }
      }
      goto $joinlet$1591;
      $join$270:;
      continue;
      $joinlet$1591:;
    } else {
      goto $join$263;
    }
    break;
  }
  goto $joinlet$1589;
  $join$263:;
  switch (accept_state$258) {
    case 0: {
      void* _try_err$266;
      struct $StringView package_name$264;
      int32_t _tmp$1093;
      int32_t _tmp$1092;
      int64_t _tmp$1089;
      int32_t _tmp$1091;
      int64_t _tmp$1090;
      struct moonbit_result_0 _tmp$1597;
      void* _try_err$269;
      struct $StringView module_name$267;
      int64_t _tmp$1084;
      int32_t _tmp$1086;
      int64_t _tmp$1085;
      struct moonbit_result_0 _tmp$1599;
      void* Some$1083;
      moonbit_decref(pkg$252.$0);
      _tmp$1093 = match_tag_saver_0$260;
      _tmp$1092 = _tmp$1093 + 1;
      _tmp$1089 = (int64_t)_tmp$1092;
      _tmp$1091 = match_end$259;
      _tmp$1090 = (int64_t)_tmp$1091;
      moonbit_incref(_data$254);
      _tmp$1597 = $String$$sub(_data$254, _tmp$1089, _tmp$1090);
      if (_tmp$1597.tag) {
        struct $StringView const _ok$1094 = _tmp$1597.data.ok;
        package_name$264 = _ok$1094;
      } else {
        void* const _err$1095 = _tmp$1597.data.err;
        _try_err$266 = _err$1095;
        goto $join$265;
      }
      goto $joinlet$1596;
      $join$265:;
      moonbit_decref(_try_err$266);
      moonbit_panic();
      $joinlet$1596:;
      _tmp$1084 = (int64_t)_start$255;
      _tmp$1086 = match_tag_saver_0$260;
      _tmp$1085 = (int64_t)_tmp$1086;
      _tmp$1599 = $String$$sub(_data$254, _tmp$1084, _tmp$1085);
      if (_tmp$1599.tag) {
        struct $StringView const _ok$1087 = _tmp$1599.data.ok;
        module_name$267 = _ok$1087;
      } else {
        void* const _err$1088 = _tmp$1599.data.err;
        _try_err$269 = _err$1088;
        goto $join$268;
      }
      goto $joinlet$1598;
      $join$268:;
      moonbit_decref(_try_err$269);
      moonbit_panic();
      $joinlet$1598:;
      Some$1083
      = (void*)moonbit_malloc(sizeof(struct $Option$3c$StringView$3e$$Some));
      Moonbit_object_header(Some$1083)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $Option$3c$StringView$3e$$Some, $0_0) >> 2, 1, 1
      );
      ((struct $Option$3c$StringView$3e$$Some*)Some$1083)->$0_0
      = package_name$264.$0;
      ((struct $Option$3c$StringView$3e$$Some*)Some$1083)->$0_1
      = package_name$264.$1;
      ((struct $Option$3c$StringView$3e$$Some*)Some$1083)->$0_2
      = package_name$264.$2;
      _bind$262
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$262)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$262->$0_0 = module_name$267.$0;
      _bind$262->$0_1 = module_name$267.$1;
      _bind$262->$0_2 = module_name$267.$2;
      _bind$262->$1 = Some$1083;
      break;
    }
    default: {
      void* None$1096;
      moonbit_decref(_data$254);
      None$1096 = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _bind$262
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$262)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$262->$0_0 = pkg$252.$0;
      _bind$262->$0_1 = pkg$252.$1;
      _bind$262->$0_2 = pkg$252.$2;
      _bind$262->$1 = None$1096;
      break;
    }
  }
  $joinlet$1589:;
  _field$1540
  = (struct $StringView){
    _bind$262->$0_1, _bind$262->$0_2, _bind$262->$0_0
  };
  _module_name$285 = _field$1540;
  _field$1539 = _bind$262->$1;
  _cnt$1563 = Moonbit_object_header(_bind$262)->rc;
  if (_cnt$1563 > 1) {
    int32_t _new_cnt$1564 = _cnt$1563 - 1;
    Moonbit_object_header(_bind$262)->rc = _new_cnt$1564;
    moonbit_incref(_field$1539);
    moonbit_incref(_module_name$285.$0);
  } else if (_cnt$1563 == 1) {
    moonbit_free(_bind$262);
  }
  _package_name$286 = _field$1539;
  switch (Moonbit_object_tag(_package_name$286)) {
    case 1: {
      struct $Option$3c$StringView$3e$$Some* _Some$287 =
        (struct $Option$3c$StringView$3e$$Some*)_package_name$286;
      struct $StringView _field$1538 =
        (struct $StringView){
          _Some$287->$0_1, _Some$287->$0_2, _Some$287->$0_0
        };
      int32_t _cnt$1565 = Moonbit_object_header(_Some$287)->rc;
      struct $StringView _pkg_name$288;
      struct $$moonbitlang$core$builtin$Logger _bind$1076;
      if (_cnt$1565 > 1) {
        int32_t _new_cnt$1566 = _cnt$1565 - 1;
        Moonbit_object_header(_Some$287)->rc = _new_cnt$1566;
        moonbit_incref(_field$1538.$0);
      } else if (_cnt$1565 == 1) {
        moonbit_free(_Some$287);
      }
      _pkg_name$288 = _field$1538;
      if (logger$289.$1) {
        moonbit_incref(logger$289.$1);
      }
      logger$289.$0->$method_2(logger$289.$1, _pkg_name$288);
      _bind$1076 = logger$289;
      if (_bind$1076.$1) {
        moonbit_incref(_bind$1076.$1);
      }
      _bind$1076.$0->$method_3(_bind$1076.$1, 47);
      break;
    }
    default: {
      moonbit_decref(_package_name$286);
      break;
    }
  }
  _field$1537
  = (struct $StringView){
    self$253->$1_1, self$253->$1_2, self$253->$1_0
  };
  filename$1078 = _field$1537;
  moonbit_incref(filename$1078.$0);
  if (logger$289.$1) {
    moonbit_incref(logger$289.$1);
  }
  logger$289.$0->$method_2(logger$289.$1, filename$1078);
  if (logger$289.$1) {
    moonbit_incref(logger$289.$1);
  }
  logger$289.$0->$method_3(logger$289.$1, 58);
  _field$1536
  = (struct $StringView){
    self$253->$2_1, self$253->$2_2, self$253->$2_0
  };
  start_line$1079 = _field$1536;
  moonbit_incref(start_line$1079.$0);
  if (logger$289.$1) {
    moonbit_incref(logger$289.$1);
  }
  logger$289.$0->$method_2(logger$289.$1, start_line$1079);
  if (logger$289.$1) {
    moonbit_incref(logger$289.$1);
  }
  logger$289.$0->$method_3(logger$289.$1, 58);
  _field$1535
  = (struct $StringView){
    self$253->$3_1, self$253->$3_2, self$253->$3_0
  };
  start_column$1080 = _field$1535;
  moonbit_incref(start_column$1080.$0);
  if (logger$289.$1) {
    moonbit_incref(logger$289.$1);
  }
  logger$289.$0->$method_2(logger$289.$1, start_column$1080);
  if (logger$289.$1) {
    moonbit_incref(logger$289.$1);
  }
  logger$289.$0->$method_3(logger$289.$1, 45);
  _field$1534
  = (struct $StringView){
    self$253->$4_1, self$253->$4_2, self$253->$4_0
  };
  end_line$1081 = _field$1534;
  moonbit_incref(end_line$1081.$0);
  if (logger$289.$1) {
    moonbit_incref(logger$289.$1);
  }
  logger$289.$0->$method_2(logger$289.$1, end_line$1081);
  if (logger$289.$1) {
    moonbit_incref(logger$289.$1);
  }
  logger$289.$0->$method_3(logger$289.$1, 58);
  _field$1533
  = (struct $StringView){
    self$253->$5_1, self$253->$5_2, self$253->$5_0
  };
  _cnt$1567 = Moonbit_object_header(self$253)->rc;
  if (_cnt$1567 > 1) {
    int32_t _new_cnt$1573 = _cnt$1567 - 1;
    Moonbit_object_header(self$253)->rc = _new_cnt$1573;
    moonbit_incref(_field$1533.$0);
  } else if (_cnt$1567 == 1) {
    struct $StringView _field$1572 =
      (struct $StringView){self$253->$4_1, self$253->$4_2, self$253->$4_0};
    struct $StringView _field$1571;
    struct $StringView _field$1570;
    struct $StringView _field$1569;
    struct $StringView _field$1568;
    moonbit_decref(_field$1572.$0);
    _field$1571
    = (struct $StringView){
      self$253->$3_1, self$253->$3_2, self$253->$3_0
    };
    moonbit_decref(_field$1571.$0);
    _field$1570
    = (struct $StringView){
      self$253->$2_1, self$253->$2_2, self$253->$2_0
    };
    moonbit_decref(_field$1570.$0);
    _field$1569
    = (struct $StringView){
      self$253->$1_1, self$253->$1_2, self$253->$1_0
    };
    moonbit_decref(_field$1569.$0);
    _field$1568
    = (struct $StringView){
      self$253->$0_1, self$253->$0_2, self$253->$0_0
    };
    moonbit_decref(_field$1568.$0);
    moonbit_free(self$253);
  }
  end_column$1082 = _field$1533;
  if (logger$289.$1) {
    moonbit_incref(logger$289.$1);
  }
  logger$289.$0->$method_2(logger$289.$1, end_column$1082);
  if (logger$289.$1) {
    moonbit_incref(logger$289.$1);
  }
  logger$289.$0->$method_3(logger$289.$1, 64);
  _bind$1077 = logger$289;
  _bind$1077.$0->$method_2(_bind$1077.$1, _module_name$285);
  return 0;
}

uint64_t $Bool$$to_uint64(int32_t self$251) {
  if (self$251) {
    return 1ull;
  } else {
    return 0ull;
  }
}

int64_t $Bool$$to_int64(int32_t self$250) {
  if (self$250) {
    return 1ll;
  } else {
    return 0ll;
  }
}

int32_t $Bool$$to_int(int32_t self$249) {
  if (self$249) {
    return 1;
  } else {
    return 0;
  }
}

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$248) {
  moonbit_println(input$248);
  moonbit_decref(input$248);
  return 0;
}

uint64_t $UInt$$to_uint64(uint32_t self$247) {
  return (uint64_t)self$247;
}

uint32_t $ReadOnlyArray$$at$1(uint32_t* self$245, int32_t index$246) {
  uint32_t* _tmp$1075 = self$245;
  uint32_t _tmp$1543;
  if (index$246 < 0 || index$246 >= Moonbit_array_length(_tmp$1075)) {
    moonbit_panic();
  }
  _tmp$1543 = (uint32_t)_tmp$1075[index$246];
  moonbit_decref(_tmp$1075);
  return _tmp$1543;
}

uint64_t $ReadOnlyArray$$at$0(uint64_t* self$243, int32_t index$244) {
  uint64_t* _tmp$1074 = self$243;
  uint64_t _tmp$1544;
  if (index$244 < 0 || index$244 >= Moonbit_array_length(_tmp$1074)) {
    moonbit_panic();
  }
  _tmp$1544 = (uint64_t)_tmp$1074[index$244];
  moonbit_decref(_tmp$1074);
  return _tmp$1544;
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$String$$to_string(
  moonbit_string_t self$242
) {
  return self$242;
}

int32_t $$moonbitlang$core$builtin$Show$$UInt64$$output(
  uint64_t self$241,
  struct $$moonbitlang$core$builtin$Logger logger$240
) {
  moonbit_string_t _tmp$1073 = $UInt64$$to_string$inner(self$241, 10);
  logger$240.$0->$method_0(logger$240.$1, _tmp$1073);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$238,
  struct $StringView str$239
) {
  int32_t len$1055 = self$238->$1;
  int32_t end$1058 = str$239.$2;
  int32_t start$1059 = str$239.$1;
  int32_t _tmp$1057 = end$1058 - start$1059;
  int32_t _tmp$1056 = _tmp$1057 * 2;
  int32_t _tmp$1054 = len$1055 + _tmp$1056;
  moonbit_bytes_t _field$1547;
  moonbit_bytes_t data$1060;
  int32_t len$1061;
  moonbit_string_t _field$1546;
  moonbit_string_t str$1062;
  int32_t start$1063;
  int32_t end$1065;
  int32_t start$1066;
  int32_t _tmp$1064;
  int32_t len$1068;
  int32_t end$1071;
  int32_t _field$1545;
  int32_t start$1072;
  int32_t _tmp$1070;
  int32_t _tmp$1069;
  int32_t _tmp$1067;
  moonbit_incref(self$238);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$238, _tmp$1054
  );
  _field$1547 = self$238->$0;
  data$1060 = _field$1547;
  len$1061 = self$238->$1;
  _field$1546 = str$239.$0;
  str$1062 = _field$1546;
  start$1063 = str$239.$1;
  end$1065 = str$239.$2;
  start$1066 = str$239.$1;
  _tmp$1064 = end$1065 - start$1066;
  moonbit_incref(str$1062);
  moonbit_incref(data$1060);
  $FixedArray$$blit_from_string(
    data$1060, len$1061, str$1062, start$1063, _tmp$1064
  );
  len$1068 = self$238->$1;
  end$1071 = str$239.$2;
  _field$1545 = str$239.$1;
  moonbit_decref(str$239.$0);
  start$1072 = _field$1545;
  _tmp$1070 = end$1071 - start$1072;
  _tmp$1069 = _tmp$1070 * 2;
  _tmp$1067 = len$1068 + _tmp$1069;
  self$238->$1 = _tmp$1067;
  moonbit_decref(self$238);
  return 0;
}

moonbit_string_t $UInt64$$to_string$inner(
  uint64_t self$230,
  int32_t radix$229
) {
  uint16_t* buffer$231;
  if (radix$229 < 2 || radix$229 > 36) {
    $moonbitlang$core$builtin$abort$1(
      (moonbit_string_t)moonbit_string_literal_8.data,
        (moonbit_string_t)moonbit_string_literal_9.data
    );
  }
  if (self$230 == 0ull) {
    return (moonbit_string_t)moonbit_string_literal_0.data;
  }
  switch (radix$229) {
    case 10: {
      int32_t len$232 = $moonbitlang$core$builtin$dec_count64(self$230);
      uint16_t* buffer$233 = (uint16_t*)moonbit_make_string(len$232, 0);
      moonbit_incref(buffer$233);
      $moonbitlang$core$builtin$int64_to_string_dec(
        buffer$233, self$230, 0, len$232
      );
      buffer$231 = buffer$233;
      break;
    }

    case 16: {
      int32_t len$234 = $moonbitlang$core$builtin$hex_count64(self$230);
      uint16_t* buffer$235 = (uint16_t*)moonbit_make_string(len$234, 0);
      moonbit_incref(buffer$235);
      $moonbitlang$core$builtin$int64_to_string_hex(
        buffer$235, self$230, 0, len$234
      );
      buffer$231 = buffer$235;
      break;
    }
    default: {
      int32_t len$236 =
        $moonbitlang$core$builtin$radix_count64(self$230, radix$229);
      uint16_t* buffer$237 = (uint16_t*)moonbit_make_string(len$236, 0);
      moonbit_incref(buffer$237);
      $moonbitlang$core$builtin$int64_to_string_generic(
        buffer$237, self$230, 0, len$236, radix$229
      );
      buffer$231 = buffer$237;
      break;
    }
  }
  return buffer$231;
}

int32_t $moonbitlang$core$builtin$int64_to_string_dec(
  uint16_t* buffer$219,
  uint64_t num$207,
  int32_t digit_start$210,
  int32_t total_len$209
) {
  uint64_t num$206 = num$207;
  int32_t offset$208 = total_len$209 - digit_start$210;
  uint64_t _tmp$1053;
  int32_t remaining$221;
  int32_t _tmp$1034;
  while (1) {
    uint64_t _tmp$997 = num$206;
    if (_tmp$997 >= 10000ull) {
      uint64_t _tmp$1020 = num$206;
      uint64_t t$211 = _tmp$1020 / 10000ull;
      uint64_t _tmp$1019 = num$206;
      uint64_t _tmp$1018 = _tmp$1019 % 10000ull;
      int32_t r$212 = (int32_t)_tmp$1018;
      int32_t d1$213;
      int32_t d2$214;
      int32_t _tmp$998;
      int32_t _tmp$1017;
      int32_t _tmp$1016;
      int32_t d1_hi$215;
      int32_t _tmp$1015;
      int32_t _tmp$1014;
      int32_t d1_lo$216;
      int32_t _tmp$1013;
      int32_t _tmp$1012;
      int32_t d2_hi$217;
      int32_t _tmp$1011;
      int32_t _tmp$1010;
      int32_t d2_lo$218;
      int32_t _tmp$1000;
      int32_t _tmp$999;
      int32_t _tmp$1003;
      int32_t _tmp$1002;
      int32_t _tmp$1001;
      int32_t _tmp$1006;
      int32_t _tmp$1005;
      int32_t _tmp$1004;
      int32_t _tmp$1009;
      int32_t _tmp$1008;
      int32_t _tmp$1007;
      num$206 = t$211;
      d1$213 = r$212 / 100;
      d2$214 = r$212 % 100;
      _tmp$998 = offset$208;
      offset$208 = _tmp$998 - 4;
      _tmp$1017 = d1$213 / 10;
      _tmp$1016 = 48 + _tmp$1017;
      d1_hi$215 = (uint16_t)_tmp$1016;
      _tmp$1015 = d1$213 % 10;
      _tmp$1014 = 48 + _tmp$1015;
      d1_lo$216 = (uint16_t)_tmp$1014;
      _tmp$1013 = d2$214 / 10;
      _tmp$1012 = 48 + _tmp$1013;
      d2_hi$217 = (uint16_t)_tmp$1012;
      _tmp$1011 = d2$214 % 10;
      _tmp$1010 = 48 + _tmp$1011;
      d2_lo$218 = (uint16_t)_tmp$1010;
      _tmp$1000 = offset$208;
      _tmp$999 = digit_start$210 + _tmp$1000;
      buffer$219[_tmp$999] = d1_hi$215;
      _tmp$1003 = offset$208;
      _tmp$1002 = digit_start$210 + _tmp$1003;
      _tmp$1001 = _tmp$1002 + 1;
      buffer$219[_tmp$1001] = d1_lo$216;
      _tmp$1006 = offset$208;
      _tmp$1005 = digit_start$210 + _tmp$1006;
      _tmp$1004 = _tmp$1005 + 2;
      buffer$219[_tmp$1004] = d2_hi$217;
      _tmp$1009 = offset$208;
      _tmp$1008 = digit_start$210 + _tmp$1009;
      _tmp$1007 = _tmp$1008 + 3;
      buffer$219[_tmp$1007] = d2_lo$218;
      continue;
    }
    break;
  }
  _tmp$1053 = num$206;
  remaining$221 = (int32_t)_tmp$1053;
  while (1) {
    int32_t _tmp$1021 = remaining$221;
    if (_tmp$1021 >= 100) {
      int32_t _tmp$1033 = remaining$221;
      int32_t t$222 = _tmp$1033 / 100;
      int32_t _tmp$1032 = remaining$221;
      int32_t d$223 = _tmp$1032 % 100;
      int32_t _tmp$1022;
      int32_t _tmp$1031;
      int32_t _tmp$1030;
      int32_t d_hi$224;
      int32_t _tmp$1029;
      int32_t _tmp$1028;
      int32_t d_lo$225;
      int32_t _tmp$1024;
      int32_t _tmp$1023;
      int32_t _tmp$1027;
      int32_t _tmp$1026;
      int32_t _tmp$1025;
      remaining$221 = t$222;
      _tmp$1022 = offset$208;
      offset$208 = _tmp$1022 - 2;
      _tmp$1031 = d$223 / 10;
      _tmp$1030 = 48 + _tmp$1031;
      d_hi$224 = (uint16_t)_tmp$1030;
      _tmp$1029 = d$223 % 10;
      _tmp$1028 = 48 + _tmp$1029;
      d_lo$225 = (uint16_t)_tmp$1028;
      _tmp$1024 = offset$208;
      _tmp$1023 = digit_start$210 + _tmp$1024;
      buffer$219[_tmp$1023] = d_hi$224;
      _tmp$1027 = offset$208;
      _tmp$1026 = digit_start$210 + _tmp$1027;
      _tmp$1025 = _tmp$1026 + 1;
      buffer$219[_tmp$1025] = d_lo$225;
      continue;
    }
    break;
  }
  _tmp$1034 = remaining$221;
  if (_tmp$1034 >= 10) {
    int32_t _tmp$1035 = offset$208;
    int32_t _tmp$1046;
    int32_t _tmp$1045;
    int32_t _tmp$1044;
    int32_t d_hi$227;
    int32_t _tmp$1043;
    int32_t _tmp$1042;
    int32_t _tmp$1041;
    int32_t d_lo$228;
    int32_t _tmp$1037;
    int32_t _tmp$1036;
    int32_t _tmp$1040;
    int32_t _tmp$1039;
    int32_t _tmp$1038;
    offset$208 = _tmp$1035 - 2;
    _tmp$1046 = remaining$221;
    _tmp$1045 = _tmp$1046 / 10;
    _tmp$1044 = 48 + _tmp$1045;
    d_hi$227 = (uint16_t)_tmp$1044;
    _tmp$1043 = remaining$221;
    _tmp$1042 = _tmp$1043 % 10;
    _tmp$1041 = 48 + _tmp$1042;
    d_lo$228 = (uint16_t)_tmp$1041;
    _tmp$1037 = offset$208;
    _tmp$1036 = digit_start$210 + _tmp$1037;
    buffer$219[_tmp$1036] = d_hi$227;
    _tmp$1040 = offset$208;
    _tmp$1039 = digit_start$210 + _tmp$1040;
    _tmp$1038 = _tmp$1039 + 1;
    buffer$219[_tmp$1038] = d_lo$228;
    moonbit_decref(buffer$219);
  } else {
    int32_t _tmp$1047 = offset$208;
    int32_t _tmp$1052;
    int32_t _tmp$1048;
    int32_t _tmp$1051;
    int32_t _tmp$1050;
    int32_t _tmp$1049;
    offset$208 = _tmp$1047 - 1;
    _tmp$1052 = offset$208;
    _tmp$1048 = digit_start$210 + _tmp$1052;
    _tmp$1051 = remaining$221;
    _tmp$1050 = 48 + _tmp$1051;
    _tmp$1049 = (uint16_t)_tmp$1050;
    buffer$219[_tmp$1048] = _tmp$1049;
    moonbit_decref(buffer$219);
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int64_to_string_generic(
  uint16_t* buffer$201,
  uint64_t num$195,
  int32_t digit_start$193,
  int32_t total_len$192,
  int32_t radix$197
) {
  int32_t offset$191 = total_len$192 - digit_start$193;
  uint64_t n$194 = num$195;
  int64_t _tmp$996 = (int64_t)radix$197;
  uint64_t base$196 = *(uint64_t*)&_tmp$996;
  int32_t _tmp$976 = radix$197 - 1;
  int32_t _tmp$975 = radix$197 & _tmp$976;
  if (_tmp$975 == 0) {
    int32_t shift$198 = moonbit_ctz32(radix$197);
    uint64_t mask$199 = base$196 - 1ull;
    while (1) {
      uint64_t _tmp$977 = n$194;
      if (_tmp$977 > 0ull) {
        int32_t _tmp$978 = offset$191;
        uint64_t _tmp$985;
        uint64_t _tmp$984;
        int32_t digit$200;
        int32_t _tmp$982;
        int32_t _tmp$979;
        int32_t _tmp$981;
        int32_t _tmp$980;
        uint64_t _tmp$983;
        offset$191 = _tmp$978 - 1;
        _tmp$985 = n$194;
        _tmp$984 = _tmp$985 & mask$199;
        digit$200 = (int32_t)_tmp$984;
        _tmp$982 = offset$191;
        _tmp$979 = digit_start$193 + _tmp$982;
        _tmp$981
        = ((moonbit_string_t)moonbit_string_literal_10.data)[
          digit$200
        ];
        _tmp$980 = (uint16_t)_tmp$981;
        buffer$201[_tmp$979] = _tmp$980;
        _tmp$983 = n$194;
        n$194 = _tmp$983 >> (shift$198 & 63);
        continue;
      } else {
        moonbit_decref(buffer$201);
      }
      break;
    }
  } else {
    while (1) {
      uint64_t _tmp$986 = n$194;
      if (_tmp$986 > 0ull) {
        int32_t _tmp$987 = offset$191;
        uint64_t _tmp$995;
        uint64_t q$203;
        uint64_t _tmp$993;
        uint64_t _tmp$994;
        uint64_t _tmp$992;
        int32_t digit$204;
        int32_t _tmp$991;
        int32_t _tmp$988;
        int32_t _tmp$990;
        int32_t _tmp$989;
        offset$191 = _tmp$987 - 1;
        _tmp$995 = n$194;
        q$203 = _tmp$995 / base$196;
        _tmp$993 = n$194;
        _tmp$994 = q$203 * base$196;
        _tmp$992 = _tmp$993 - _tmp$994;
        digit$204 = (int32_t)_tmp$992;
        _tmp$991 = offset$191;
        _tmp$988 = digit_start$193 + _tmp$991;
        _tmp$990
        = ((moonbit_string_t)moonbit_string_literal_10.data)[
          digit$204
        ];
        _tmp$989 = (uint16_t)_tmp$990;
        buffer$201[_tmp$988] = _tmp$989;
        n$194 = q$203;
        continue;
      } else {
        moonbit_decref(buffer$201);
      }
      break;
    }
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int64_to_string_hex(
  uint16_t* buffer$188,
  uint64_t num$184,
  int32_t digit_start$182,
  int32_t total_len$181
) {
  int32_t offset$180 = total_len$181 - digit_start$182;
  uint64_t n$183 = num$184;
  int32_t _tmp$970;
  while (1) {
    int32_t _tmp$956 = offset$180;
    if (_tmp$956 >= 2) {
      int32_t _tmp$957 = offset$180;
      uint64_t _tmp$969;
      uint64_t _tmp$968;
      int32_t byte_val$185;
      int32_t hi$186;
      int32_t lo$187;
      int32_t _tmp$961;
      int32_t _tmp$958;
      int32_t _tmp$960;
      int32_t _tmp$959;
      int32_t _tmp$966;
      int32_t _tmp$965;
      int32_t _tmp$962;
      int32_t _tmp$964;
      int32_t _tmp$963;
      uint64_t _tmp$967;
      offset$180 = _tmp$957 - 2;
      _tmp$969 = n$183;
      _tmp$968 = _tmp$969 & 255ull;
      byte_val$185 = (int32_t)_tmp$968;
      hi$186 = byte_val$185 / 16;
      lo$187 = byte_val$185 % 16;
      _tmp$961 = offset$180;
      _tmp$958 = digit_start$182 + _tmp$961;
      _tmp$960 = ((moonbit_string_t)moonbit_string_literal_10.data)[hi$186];
      _tmp$959 = (uint16_t)_tmp$960;
      buffer$188[_tmp$958] = _tmp$959;
      _tmp$966 = offset$180;
      _tmp$965 = digit_start$182 + _tmp$966;
      _tmp$962 = _tmp$965 + 1;
      _tmp$964 = ((moonbit_string_t)moonbit_string_literal_10.data)[lo$187];
      _tmp$963 = (uint16_t)_tmp$964;
      buffer$188[_tmp$962] = _tmp$963;
      _tmp$967 = n$183;
      n$183 = _tmp$967 >> 8;
      continue;
    }
    break;
  }
  _tmp$970 = offset$180;
  if (_tmp$970 == 1) {
    uint64_t _tmp$974 = n$183;
    uint64_t _tmp$973 = _tmp$974 & 15ull;
    int32_t nibble$190 = (int32_t)_tmp$973;
    int32_t _tmp$972 =
      ((moonbit_string_t)moonbit_string_literal_10.data)[nibble$190];
    int32_t _tmp$971 = (uint16_t)_tmp$972;
    buffer$188[digit_start$182] = _tmp$971;
    moonbit_decref(buffer$188);
  } else {
    moonbit_decref(buffer$188);
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$radix_count64(
  uint64_t value$174,
  int32_t radix$177
) {
  uint64_t num$175;
  int64_t _tmp$955;
  uint64_t base$176;
  int32_t count$178;
  if (value$174 == 0ull) {
    return 1;
  }
  num$175 = value$174;
  _tmp$955 = (int64_t)radix$177;
  base$176 = *(uint64_t*)&_tmp$955;
  count$178 = 0;
  while (1) {
    uint64_t _tmp$952 = num$175;
    if (_tmp$952 > 0ull) {
      int32_t _tmp$953 = count$178;
      uint64_t _tmp$954;
      count$178 = _tmp$953 + 1;
      _tmp$954 = num$175;
      num$175 = _tmp$954 / base$176;
      continue;
    }
    break;
  }
  return count$178;
}

int32_t $moonbitlang$core$builtin$hex_count64(uint64_t value$172) {
  if (value$172 == 0ull) {
    return 1;
  } else {
    int32_t leading_zeros$173 = moonbit_clz64(value$172);
    int32_t _tmp$951 = 63 - leading_zeros$173;
    int32_t _tmp$950 = _tmp$951 / 4;
    return _tmp$950 + 1;
  }
}

int32_t $moonbitlang$core$builtin$dec_count64(uint64_t value$171) {
  if (value$171 >= 10000000000ull) {
    if (value$171 >= 100000000000000ull) {
      if (value$171 >= 10000000000000000ull) {
        if (value$171 >= 1000000000000000000ull) {
          if (value$171 >= 10000000000000000000ull) {
            return 20;
          } else {
            return 19;
          }
        } else if (value$171 >= 100000000000000000ull) {
          return 18;
        } else {
          return 17;
        }
      } else if (value$171 >= 1000000000000000ull) {
        return 16;
      } else {
        return 15;
      }
    } else if (value$171 >= 1000000000000ull) {
      if (value$171 >= 10000000000000ull) {
        return 14;
      } else {
        return 13;
      }
    } else if (value$171 >= 100000000000ull) {
      return 12;
    } else {
      return 11;
    }
  } else if (value$171 >= 100000ull) {
    if (value$171 >= 10000000ull) {
      if (value$171 >= 1000000000ull) {
        return 10;
      } else if (value$171 >= 100000000ull) {
        return 9;
      } else {
        return 8;
      }
    } else if (value$171 >= 1000000ull) {
      return 7;
    } else {
      return 6;
    }
  } else if (value$171 >= 1000ull) {
    if (value$171 >= 10000ull) {
      return 5;
    } else {
      return 4;
    }
  } else if (value$171 >= 100ull) {
    return 3;
  } else if (value$171 >= 10ull) {
    return 2;
  } else {
    return 1;
  }
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(
  uint64_t self$170
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$169 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$949;
  moonbit_incref(logger$169);
  _tmp$949
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$169
  };
  $$moonbitlang$core$builtin$Show$$UInt64$$output(self$170, _tmp$949);
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$169);
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  moonbit_string_t self$168
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$167 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$948;
  moonbit_incref(logger$167);
  _tmp$948
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$167
  };
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
    self$168, _tmp$948
  );
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$167);
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  double self$166
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$165 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$947;
  moonbit_incref(logger$165);
  _tmp$947
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$165
  };
  $$moonbitlang$core$builtin$Show$$Double$$output(self$166, _tmp$947);
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$165);
}

int32_t $StringView$$start_offset(struct $StringView self$164) {
  int32_t _field$1548 = self$164.$1;
  moonbit_decref(self$164.$0);
  return _field$1548;
}

int32_t $StringView$$length(struct $StringView self$163) {
  int32_t end$945 = self$163.$2;
  int32_t _field$1549 = self$163.$1;
  int32_t start$946;
  moonbit_decref(self$163.$0);
  start$946 = _field$1549;
  return end$945 - start$946;
}

moonbit_string_t $StringView$$data(struct $StringView self$162) {
  moonbit_string_t _field$1550 = self$162.$0;
  return _field$1550;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$156,
  moonbit_string_t value$159,
  int32_t start$160,
  int32_t len$161
) {
  void* _try_err$158;
  struct $StringView _tmp$940;
  int32_t _tmp$942 = start$160 + len$161;
  int64_t _tmp$941 = (int64_t)_tmp$942;
  struct moonbit_result_0 _tmp$1607 =
    $String$$sub$inner(value$159, start$160, _tmp$941);
  if (_tmp$1607.tag) {
    struct $StringView const _ok$943 = _tmp$1607.data.ok;
    _tmp$940 = _ok$943;
  } else {
    void* const _err$944 = _tmp$1607.data.err;
    _try_err$158 = _err$944;
    goto $join$157;
  }
  goto $joinlet$1606;
  $join$157:;
  moonbit_decref(_try_err$158);
  moonbit_panic();
  $joinlet$1606:;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    self$156, _tmp$940
  );
  return 0;
}

struct moonbit_result_0 $String$$sub(
  moonbit_string_t self$154,
  int64_t start$opt$152,
  int64_t end$155
) {
  int32_t start$151;
  if (start$opt$152 == 4294967296ll) {
    start$151 = 0;
  } else {
    int64_t _Some$153 = start$opt$152;
    start$151 = (int32_t)_Some$153;
  }
  return $String$$sub$inner(self$154, start$151, end$155);
}

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$144,
  int32_t start$150,
  int64_t end$146
) {
  int32_t len$143 = Moonbit_array_length(self$144);
  int32_t end$145;
  int32_t start$149;
  if (end$146 == 4294967296ll) {
    end$145 = len$143;
  } else {
    int64_t _Some$147 = end$146;
    int32_t _end$148 = (int32_t)_Some$147;
    if (_end$148 < 0) {
      end$145 = len$143 + _end$148;
    } else {
      end$145 = _end$148;
    }
  }
  if (start$150 < 0) {
    start$149 = len$143 + start$150;
  } else {
    start$149 = start$150;
  }
  if (start$149 >= 0 && start$149 <= end$145 && end$145 <= len$143) {
    int32_t _if_result$1608;
    int32_t _if_result$1610;
    struct $StringView _tmp$938;
    struct moonbit_result_0 _result$1612;
    if (start$149 < len$143) {
      int32_t _p$604 = self$144[start$149];
      _if_result$1608 = 56320 <= _p$604 && _p$604 <= 57343;
    } else {
      _if_result$1608 = 0;
    }
    if (_if_result$1608) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$936;
      struct moonbit_result_0 _result$1609;
      moonbit_decref(self$144);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$936
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$1609.tag = 0;
      _result$1609.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$936;
      return _result$1609;
    }
    if (end$145 < len$143) {
      int32_t _p$607 = self$144[end$145];
      _if_result$1610 = 56320 <= _p$607 && _p$607 <= 57343;
    } else {
      _if_result$1610 = 0;
    }
    if (_if_result$1610) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$937;
      struct moonbit_result_0 _result$1611;
      moonbit_decref(self$144);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$937
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$1611.tag = 0;
      _result$1611.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$937;
      return _result$1611;
    }
    _tmp$938 = (struct $StringView){start$149, end$145, self$144};
    _result$1612.tag = 1;
    _result$1612.data.ok = _tmp$938;
    return _result$1612;
  } else {
    void* moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$939;
    struct moonbit_result_0 _result$1613;
    moonbit_decref(self$144);
    moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$939
    = (struct moonbit_object*)&moonbit_constant_constructor_1 + 1;
    _result$1613.tag = 0;
    _result$1613.data.err
    = moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$939;
    return _result$1613;
  }
}

uint64_t $Int$$to_uint64(int32_t self$142) {
  int64_t _tmp$935 = (int64_t)self$142;
  return *(uint64_t*)&_tmp$935;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$140,
  moonbit_string_t str$141
) {
  int32_t len$925 = self$140->$1;
  int32_t _tmp$927 = Moonbit_array_length(str$141);
  int32_t _tmp$926 = _tmp$927 * 2;
  int32_t _tmp$924 = len$925 + _tmp$926;
  moonbit_bytes_t _field$1552;
  moonbit_bytes_t data$928;
  int32_t len$929;
  int32_t _tmp$930;
  int32_t len$932;
  int32_t _tmp$1551;
  int32_t _tmp$934;
  int32_t _tmp$933;
  int32_t _tmp$931;
  moonbit_incref(self$140);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$140, _tmp$924
  );
  _field$1552 = self$140->$0;
  data$928 = _field$1552;
  len$929 = self$140->$1;
  _tmp$930 = Moonbit_array_length(str$141);
  moonbit_incref(data$928);
  moonbit_incref(str$141);
  $FixedArray$$blit_from_string(data$928, len$929, str$141, 0, _tmp$930);
  len$932 = self$140->$1;
  _tmp$1551 = Moonbit_array_length(str$141);
  moonbit_decref(str$141);
  _tmp$934 = _tmp$1551;
  _tmp$933 = _tmp$934 * 2;
  _tmp$931 = len$932 + _tmp$933;
  self$140->$1 = _tmp$931;
  moonbit_decref(self$140);
  return 0;
}

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$132,
  int32_t bytes_offset$127,
  moonbit_string_t str$134,
  int32_t str_offset$130,
  int32_t length$128
) {
  int32_t _tmp$923 = length$128 * 2;
  int32_t _tmp$922 = bytes_offset$127 + _tmp$923;
  int32_t e1$126 = _tmp$922 - 1;
  int32_t _tmp$921 = str_offset$130 + length$128;
  int32_t e2$129 = _tmp$921 - 1;
  int32_t len1$131 = Moonbit_array_length(self$132);
  int32_t len2$133 = Moonbit_array_length(str$134);
  if (
    length$128 >= 0
    && bytes_offset$127 >= 0
    && e1$126 < len1$131
    && str_offset$130 >= 0
    && e2$129 < len2$133
  ) {
    int32_t end_str_offset$135 = str_offset$130 + length$128;
    int32_t i$136 = str_offset$130;
    int32_t j$137 = bytes_offset$127;
    while (1) {
      if (i$136 < end_str_offset$135) {
        int32_t _tmp$918 = str$134[i$136];
        uint32_t c$138 = *(uint32_t*)&_tmp$918;
        uint32_t _p$598 = c$138 & 255u;
        int32_t _tmp$914 = *(int32_t*)&_p$598;
        int32_t _tmp$913 = _tmp$914 & 0xff;
        int32_t _tmp$915;
        uint32_t _p$601;
        int32_t _tmp$917;
        int32_t _tmp$916;
        int32_t _tmp$919;
        int32_t _tmp$920;
        if (j$137 < 0 || j$137 >= Moonbit_array_length(self$132)) {
          moonbit_panic();
        }
        self$132[j$137] = _tmp$913;
        _tmp$915 = j$137 + 1;
        _p$601 = c$138 >> 8;
        _tmp$917 = *(int32_t*)&_p$601;
        _tmp$916 = _tmp$917 & 0xff;
        if (_tmp$915 < 0 || _tmp$915 >= Moonbit_array_length(self$132)) {
          moonbit_panic();
        }
        self$132[_tmp$915] = _tmp$916;
        _tmp$919 = i$136 + 1;
        _tmp$920 = j$137 + 2;
        i$136 = _tmp$919;
        j$137 = _tmp$920;
        continue;
      } else {
        moonbit_decref(str$134);
        moonbit_decref(self$132);
      }
      break;
    }
  } else {
    moonbit_decref(str$134);
    moonbit_decref(self$132);
    moonbit_panic();
  }
  return 0;
}

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$49
) {
  int32_t _tmp$912 = Moonbit_array_length(repr$49);
  struct $StringView _bind$48 = (struct $StringView){0, _tmp$912, repr$49};
  moonbit_string_t _field$1554 = _bind$48.$0;
  moonbit_string_t _data$50 = _field$1554;
  int32_t _start$51 = _bind$48.$1;
  int32_t end$910 = _bind$48.$2;
  int32_t _field$1553 = _bind$48.$1;
  int32_t start$911 = _field$1553;
  int32_t _tmp$909 = end$910 - start$911;
  int32_t _end$52 = _start$51 + _tmp$909;
  int32_t _cursor$53 = _start$51;
  int32_t accept_state$54 = -1;
  int32_t match_end$55 = -1;
  int32_t match_tag_saver_0$56 = -1;
  int32_t match_tag_saver_1$57 = -1;
  int32_t match_tag_saver_2$58 = -1;
  int32_t match_tag_saver_3$59 = -1;
  int32_t match_tag_saver_4$60 = -1;
  int32_t tag_0$61 = -1;
  int32_t tag_1$62 = -1;
  int32_t tag_1_1$63 = -1;
  int32_t tag_1_2$64 = -1;
  int32_t tag_3$65 = -1;
  int32_t tag_2$66 = -1;
  int32_t tag_2_1$67 = -1;
  int32_t tag_4$68 = -1;
  int32_t join_dispatch_19$89;
  int32_t _tmp$899 = _cursor$53;
  int32_t dispatch_19$90;
  if (_tmp$899 < _end$52) {
    int32_t _p$544 = _cursor$53;
    int32_t next_char$118 = _data$50[_p$544];
    int32_t _tmp$900 = _cursor$53;
    _cursor$53 = _tmp$900 + 1;
    if (next_char$118 < 65) {
      if (next_char$118 < 64) {
        goto $join$69;
      } else {
        while (1) {
          int32_t _tmp$901;
          tag_0$61 = _cursor$53;
          _tmp$901 = _cursor$53;
          if (_tmp$901 < _end$52) {
            int32_t _p$547 = _cursor$53;
            int32_t next_char$121 = _data$50[_p$547];
            int32_t _tmp$902 = _cursor$53;
            _cursor$53 = _tmp$902 + 1;
            if (next_char$121 < 55296) {
              if (next_char$121 < 58) {
                goto $join$119;
              } else if (next_char$121 > 58) {
                goto $join$119;
              } else {
                int32_t _tmp$903 = _cursor$53;
                if (_tmp$903 < _end$52) {
                  int32_t _p$550 = _cursor$53;
                  int32_t next_char$123 = _data$50[_p$550];
                  int32_t _tmp$904 = _cursor$53;
                  _cursor$53 = _tmp$904 + 1;
                  if (next_char$123 < 56319) {
                    if (next_char$123 < 55296) {
                      goto $join$122;
                    } else {
                      join_dispatch_19$89 = 7;
                      goto $join$88;
                    }
                  } else if (next_char$123 > 56319) {
                    if (next_char$123 < 65536) {
                      goto $join$122;
                    } else {
                      goto $join$69;
                    }
                  } else {
                    join_dispatch_19$89 = 8;
                    goto $join$88;
                  }
                  $join$122:;
                  join_dispatch_19$89 = 0;
                  goto $join$88;
                } else {
                  goto $join$69;
                }
              }
            } else if (next_char$121 > 56318) {
              if (next_char$121 < 57344) {
                int32_t _tmp$905 = _cursor$53;
                if (_tmp$905 < _end$52) {
                  int32_t _p$553 = _cursor$53;
                  int32_t next_char$124 = _data$50[_p$553];
                  int32_t _tmp$906 = _cursor$53;
                  _cursor$53 = _tmp$906 + 1;
                  if (next_char$124 < 56320) {
                    goto $join$69;
                  } else if (next_char$124 > 57343) {
                    goto $join$69;
                  } else {
                    continue;
                  }
                } else {
                  goto $join$69;
                }
              } else if (next_char$121 > 65535) {
                goto $join$69;
              } else {
                goto $join$119;
              }
            } else {
              int32_t _tmp$907 = _cursor$53;
              if (_tmp$907 < _end$52) {
                int32_t _p$556 = _cursor$53;
                int32_t next_char$125 = _data$50[_p$556];
                int32_t _tmp$908 = _cursor$53;
                _cursor$53 = _tmp$908 + 1;
                if (next_char$125 < 56320) {
                  goto $join$69;
                } else if (next_char$125 > 65535) {
                  goto $join$69;
                } else {
                  continue;
                }
              } else {
                goto $join$69;
              }
            }
            $join$119:;
            continue;
          } else {
            goto $join$69;
          }
          break;
        }
      }
    } else {
      goto $join$69;
    }
  } else {
    goto $join$69;
  }
  $join$88:;
  dispatch_19$90 = join_dispatch_19$89;
  $loop_label_19$93:;
  while (1) {
    int32_t _tmp$873;
    switch (dispatch_19$90) {
      case 3: {
        int32_t _tmp$875;
        tag_1_2$64 = tag_1_1$63;
        tag_1_1$63 = tag_1$62;
        tag_1$62 = _cursor$53;
        _tmp$875 = _cursor$53;
        if (_tmp$875 < _end$52) {
          int32_t _p$559 = _cursor$53;
          int32_t next_char$97 = _data$50[_p$559];
          int32_t _tmp$876 = _cursor$53;
          _cursor$53 = _tmp$876 + 1;
          if (next_char$97 < 55296) {
            if (next_char$97 < 58) {
              if (next_char$97 < 48) {
                goto $join$96;
              } else {
                int32_t _tmp$877;
                tag_1$62 = _cursor$53;
                tag_2_1$67 = tag_2$66;
                tag_2$66 = _cursor$53;
                tag_3$65 = _cursor$53;
                _tmp$877 = _cursor$53;
                if (_tmp$877 < _end$52) {
                  int32_t _p$562 = _cursor$53;
                  int32_t next_char$99 = _data$50[_p$562];
                  int32_t _tmp$878 = _cursor$53;
                  _cursor$53 = _tmp$878 + 1;
                  if (next_char$99 < 59) {
                    if (next_char$99 < 46) {
                      if (next_char$99 < 45) {
                        goto $join$98;
                      } else {
                        goto $join$91;
                      }
                    } else if (next_char$99 > 47) {
                      if (next_char$99 < 58) {
                        dispatch_19$90 = 6;
                        goto $loop_label_19$93;
                      } else {
                        dispatch_19$90 = 3;
                        goto $loop_label_19$93;
                      }
                    } else {
                      goto $join$98;
                    }
                  } else if (next_char$99 > 55295) {
                    if (next_char$99 < 57344) {
                      if (next_char$99 < 56319) {
                        dispatch_19$90 = 7;
                        goto $loop_label_19$93;
                      } else {
                        dispatch_19$90 = 8;
                        goto $loop_label_19$93;
                      }
                    } else if (next_char$99 > 65535) {
                      goto $join$69;
                    } else {
                      goto $join$98;
                    }
                  } else {
                    goto $join$98;
                  }
                  $join$98:;
                  dispatch_19$90 = 0;
                  goto $loop_label_19$93;
                } else {
                  goto $join$69;
                }
              }
            } else if (next_char$97 > 58) {
              goto $join$96;
            } else {
              dispatch_19$90 = 1;
              goto $loop_label_19$93;
            }
          } else if (next_char$97 > 56318) {
            if (next_char$97 < 57344) {
              dispatch_19$90 = 8;
              goto $loop_label_19$93;
            } else if (next_char$97 > 65535) {
              goto $join$69;
            } else {
              goto $join$96;
            }
          } else {
            dispatch_19$90 = 7;
            goto $loop_label_19$93;
          }
          $join$96:;
          dispatch_19$90 = 0;
          goto $loop_label_19$93;
        } else {
          goto $join$69;
        }
        break;
      }

      case 2: {
        int32_t _tmp$879;
        tag_1$62 = _cursor$53;
        tag_2$66 = _cursor$53;
        _tmp$879 = _cursor$53;
        if (_tmp$879 < _end$52) {
          int32_t _p$565 = _cursor$53;
          int32_t next_char$101 = _data$50[_p$565];
          int32_t _tmp$880 = _cursor$53;
          _cursor$53 = _tmp$880 + 1;
          if (next_char$101 < 55296) {
            if (next_char$101 < 58) {
              if (next_char$101 < 48) {
                goto $join$100;
              } else {
                dispatch_19$90 = 2;
                goto $loop_label_19$93;
              }
            } else if (next_char$101 > 58) {
              goto $join$100;
            } else {
              dispatch_19$90 = 3;
              goto $loop_label_19$93;
            }
          } else if (next_char$101 > 56318) {
            if (next_char$101 < 57344) {
              dispatch_19$90 = 8;
              goto $loop_label_19$93;
            } else if (next_char$101 > 65535) {
              goto $join$69;
            } else {
              goto $join$100;
            }
          } else {
            dispatch_19$90 = 7;
            goto $loop_label_19$93;
          }
          $join$100:;
          dispatch_19$90 = 0;
          goto $loop_label_19$93;
        } else {
          goto $join$69;
        }
        break;
      }

      case 0: {
        int32_t _tmp$881;
        tag_1$62 = _cursor$53;
        _tmp$881 = _cursor$53;
        if (_tmp$881 < _end$52) {
          int32_t _p$568 = _cursor$53;
          int32_t next_char$103 = _data$50[_p$568];
          int32_t _tmp$882 = _cursor$53;
          _cursor$53 = _tmp$882 + 1;
          if (next_char$103 < 55296) {
            if (next_char$103 < 58) {
              goto $join$102;
            } else if (next_char$103 > 58) {
              goto $join$102;
            } else {
              dispatch_19$90 = 1;
              goto $loop_label_19$93;
            }
          } else if (next_char$103 > 56318) {
            if (next_char$103 < 57344) {
              dispatch_19$90 = 8;
              goto $loop_label_19$93;
            } else if (next_char$103 > 65535) {
              goto $join$69;
            } else {
              goto $join$102;
            }
          } else {
            dispatch_19$90 = 7;
            goto $loop_label_19$93;
          }
          $join$102:;
          dispatch_19$90 = 0;
          goto $loop_label_19$93;
        } else {
          goto $join$69;
        }
        break;
      }

      case 8: {
        int32_t _tmp$883 = _cursor$53;
        if (_tmp$883 < _end$52) {
          int32_t _p$571 = _cursor$53;
          int32_t next_char$104 = _data$50[_p$571];
          int32_t _tmp$884 = _cursor$53;
          _cursor$53 = _tmp$884 + 1;
          if (next_char$104 < 56320) {
            goto $join$69;
          } else if (next_char$104 > 57343) {
            goto $join$69;
          } else {
            dispatch_19$90 = 0;
            goto $loop_label_19$93;
          }
        } else {
          goto $join$69;
        }
        break;
      }

      case 4: {
        int32_t _tmp$885;
        tag_1$62 = _cursor$53;
        tag_4$68 = _cursor$53;
        _tmp$885 = _cursor$53;
        if (_tmp$885 < _end$52) {
          int32_t _p$574 = _cursor$53;
          int32_t next_char$106 = _data$50[_p$574];
          int32_t _tmp$886 = _cursor$53;
          _cursor$53 = _tmp$886 + 1;
          if (next_char$106 < 55296) {
            if (next_char$106 < 58) {
              if (next_char$106 < 48) {
                goto $join$105;
              } else {
                dispatch_19$90 = 4;
                goto $loop_label_19$93;
              }
            } else if (next_char$106 > 58) {
              goto $join$105;
            } else {
              int32_t _tmp$887;
              tag_1_2$64 = tag_1_1$63;
              tag_1_1$63 = tag_1$62;
              tag_1$62 = _cursor$53;
              _tmp$887 = _cursor$53;
              if (_tmp$887 < _end$52) {
                int32_t _p$577 = _cursor$53;
                int32_t next_char$108 = _data$50[_p$577];
                int32_t _tmp$888 = _cursor$53;
                _cursor$53 = _tmp$888 + 1;
                if (next_char$108 < 55296) {
                  if (next_char$108 < 58) {
                    if (next_char$108 < 48) {
                      goto $join$107;
                    } else {
                      int32_t _tmp$889;
                      tag_1$62 = _cursor$53;
                      tag_2_1$67 = tag_2$66;
                      tag_2$66 = _cursor$53;
                      _tmp$889 = _cursor$53;
                      if (_tmp$889 < _end$52) {
                        int32_t _p$580 = _cursor$53;
                        int32_t next_char$110 = _data$50[_p$580];
                        int32_t _tmp$890 = _cursor$53;
                        _cursor$53 = _tmp$890 + 1;
                        if (next_char$110 < 55296) {
                          if (next_char$110 < 58) {
                            if (next_char$110 < 48) {
                              goto $join$109;
                            } else {
                              dispatch_19$90 = 5;
                              goto $loop_label_19$93;
                            }
                          } else if (next_char$110 > 58) {
                            goto $join$109;
                          } else {
                            dispatch_19$90 = 3;
                            goto $loop_label_19$93;
                          }
                        } else if (next_char$110 > 56318) {
                          if (next_char$110 < 57344) {
                            dispatch_19$90 = 8;
                            goto $loop_label_19$93;
                          } else if (next_char$110 > 65535) {
                            goto $join$69;
                          } else {
                            goto $join$109;
                          }
                        } else {
                          dispatch_19$90 = 7;
                          goto $loop_label_19$93;
                        }
                        $join$109:;
                        dispatch_19$90 = 0;
                        goto $loop_label_19$93;
                      } else {
                        goto $join$95;
                      }
                    }
                  } else if (next_char$108 > 58) {
                    goto $join$107;
                  } else {
                    dispatch_19$90 = 1;
                    goto $loop_label_19$93;
                  }
                } else if (next_char$108 > 56318) {
                  if (next_char$108 < 57344) {
                    dispatch_19$90 = 8;
                    goto $loop_label_19$93;
                  } else if (next_char$108 > 65535) {
                    goto $join$69;
                  } else {
                    goto $join$107;
                  }
                } else {
                  dispatch_19$90 = 7;
                  goto $loop_label_19$93;
                }
                $join$107:;
                dispatch_19$90 = 0;
                goto $loop_label_19$93;
              } else {
                goto $join$69;
              }
            }
          } else if (next_char$106 > 56318) {
            if (next_char$106 < 57344) {
              dispatch_19$90 = 8;
              goto $loop_label_19$93;
            } else if (next_char$106 > 65535) {
              goto $join$69;
            } else {
              goto $join$105;
            }
          } else {
            dispatch_19$90 = 7;
            goto $loop_label_19$93;
          }
          $join$105:;
          dispatch_19$90 = 0;
          goto $loop_label_19$93;
        } else {
          goto $join$69;
        }
        break;
      }

      case 5: {
        int32_t _tmp$891;
        tag_1$62 = _cursor$53;
        tag_2$66 = _cursor$53;
        _tmp$891 = _cursor$53;
        if (_tmp$891 < _end$52) {
          int32_t _p$583 = _cursor$53;
          int32_t next_char$112 = _data$50[_p$583];
          int32_t _tmp$892 = _cursor$53;
          _cursor$53 = _tmp$892 + 1;
          if (next_char$112 < 55296) {
            if (next_char$112 < 58) {
              if (next_char$112 < 48) {
                goto $join$111;
              } else {
                dispatch_19$90 = 5;
                goto $loop_label_19$93;
              }
            } else if (next_char$112 > 58) {
              goto $join$111;
            } else {
              dispatch_19$90 = 3;
              goto $loop_label_19$93;
            }
          } else if (next_char$112 > 56318) {
            if (next_char$112 < 57344) {
              dispatch_19$90 = 8;
              goto $loop_label_19$93;
            } else if (next_char$112 > 65535) {
              goto $join$69;
            } else {
              goto $join$111;
            }
          } else {
            dispatch_19$90 = 7;
            goto $loop_label_19$93;
          }
          $join$111:;
          dispatch_19$90 = 0;
          goto $loop_label_19$93;
        } else {
          goto $join$95;
        }
        break;
      }

      case 6: {
        int32_t _tmp$893;
        tag_1$62 = _cursor$53;
        tag_2$66 = _cursor$53;
        tag_3$65 = _cursor$53;
        _tmp$893 = _cursor$53;
        if (_tmp$893 < _end$52) {
          int32_t _p$586 = _cursor$53;
          int32_t next_char$114 = _data$50[_p$586];
          int32_t _tmp$894 = _cursor$53;
          _cursor$53 = _tmp$894 + 1;
          if (next_char$114 < 59) {
            if (next_char$114 < 46) {
              if (next_char$114 < 45) {
                goto $join$113;
              } else {
                goto $join$91;
              }
            } else if (next_char$114 > 47) {
              if (next_char$114 < 58) {
                dispatch_19$90 = 6;
                goto $loop_label_19$93;
              } else {
                dispatch_19$90 = 3;
                goto $loop_label_19$93;
              }
            } else {
              goto $join$113;
            }
          } else if (next_char$114 > 55295) {
            if (next_char$114 < 57344) {
              if (next_char$114 < 56319) {
                dispatch_19$90 = 7;
                goto $loop_label_19$93;
              } else {
                dispatch_19$90 = 8;
                goto $loop_label_19$93;
              }
            } else if (next_char$114 > 65535) {
              goto $join$69;
            } else {
              goto $join$113;
            }
          } else {
            goto $join$113;
          }
          $join$113:;
          dispatch_19$90 = 0;
          goto $loop_label_19$93;
        } else {
          goto $join$69;
        }
        break;
      }

      case 7: {
        int32_t _tmp$895 = _cursor$53;
        if (_tmp$895 < _end$52) {
          int32_t _p$589 = _cursor$53;
          int32_t next_char$115 = _data$50[_p$589];
          int32_t _tmp$896 = _cursor$53;
          _cursor$53 = _tmp$896 + 1;
          if (next_char$115 < 56320) {
            goto $join$69;
          } else if (next_char$115 > 65535) {
            goto $join$69;
          } else {
            dispatch_19$90 = 0;
            goto $loop_label_19$93;
          }
        } else {
          goto $join$69;
        }
        break;
      }

      case 1: {
        int32_t _tmp$897;
        tag_1_1$63 = tag_1$62;
        tag_1$62 = _cursor$53;
        _tmp$897 = _cursor$53;
        if (_tmp$897 < _end$52) {
          int32_t _p$592 = _cursor$53;
          int32_t next_char$117 = _data$50[_p$592];
          int32_t _tmp$898 = _cursor$53;
          _cursor$53 = _tmp$898 + 1;
          if (next_char$117 < 55296) {
            if (next_char$117 < 58) {
              if (next_char$117 < 48) {
                goto $join$116;
              } else {
                dispatch_19$90 = 2;
                goto $loop_label_19$93;
              }
            } else if (next_char$117 > 58) {
              goto $join$116;
            } else {
              dispatch_19$90 = 1;
              goto $loop_label_19$93;
            }
          } else if (next_char$117 > 56318) {
            if (next_char$117 < 57344) {
              dispatch_19$90 = 8;
              goto $loop_label_19$93;
            } else if (next_char$117 > 65535) {
              goto $join$69;
            } else {
              goto $join$116;
            }
          } else {
            dispatch_19$90 = 7;
            goto $loop_label_19$93;
          }
          $join$116:;
          dispatch_19$90 = 0;
          goto $loop_label_19$93;
        } else {
          goto $join$69;
        }
        break;
      }
      default: {
        goto $join$69;
        break;
      }
    }
    $join$95:;
    tag_1$62 = tag_1_2$64;
    tag_2$66 = tag_2_1$67;
    match_tag_saver_0$56 = tag_0$61;
    match_tag_saver_1$57 = tag_1$62;
    match_tag_saver_2$58 = tag_2$66;
    match_tag_saver_3$59 = tag_3$65;
    match_tag_saver_4$60 = tag_4$68;
    accept_state$54 = 0;
    match_end$55 = _cursor$53;
    goto $join$69;
    $join$91:;
    tag_1_1$63 = tag_1_2$64;
    tag_1$62 = _cursor$53;
    tag_2$66 = tag_2_1$67;
    _tmp$873 = _cursor$53;
    if (_tmp$873 < _end$52) {
      int32_t _p$595 = _cursor$53;
      int32_t next_char$94 = _data$50[_p$595];
      int32_t _tmp$874 = _cursor$53;
      _cursor$53 = _tmp$874 + 1;
      if (next_char$94 < 55296) {
        if (next_char$94 < 58) {
          if (next_char$94 < 48) {
            goto $join$92;
          } else {
            dispatch_19$90 = 4;
            continue;
          }
        } else if (next_char$94 > 58) {
          goto $join$92;
        } else {
          dispatch_19$90 = 1;
          continue;
        }
      } else if (next_char$94 > 56318) {
        if (next_char$94 < 57344) {
          dispatch_19$90 = 8;
          continue;
        } else if (next_char$94 > 65535) {
          goto $join$69;
        } else {
          goto $join$92;
        }
      } else {
        dispatch_19$90 = 7;
        continue;
      }
      $join$92:;
      dispatch_19$90 = 0;
      continue;
    } else {
      goto $join$69;
    }
    break;
  }
  $join$69:;
  switch (accept_state$54) {
    case 0: {
      void* _try_err$72;
      struct $StringView start_line$70;
      int32_t _tmp$870 = match_tag_saver_1$57;
      int32_t _tmp$869 = _tmp$870 + 1;
      int64_t _tmp$866 = (int64_t)_tmp$869;
      int32_t _tmp$868 = match_tag_saver_2$58;
      int64_t _tmp$867 = (int64_t)_tmp$868;
      struct moonbit_result_0 _tmp$1635;
      void* _try_err$75;
      struct $StringView start_column$73;
      int32_t _tmp$863;
      int32_t _tmp$862;
      int64_t _tmp$859;
      int32_t _tmp$861;
      int64_t _tmp$860;
      struct moonbit_result_0 _tmp$1637;
      void* _try_err$78;
      struct $StringView pkg$76;
      int32_t _tmp$856;
      int64_t _tmp$853;
      int32_t _tmp$855;
      int64_t _tmp$854;
      struct moonbit_result_0 _tmp$1639;
      void* _try_err$81;
      struct $StringView filename$79;
      int32_t _tmp$850;
      int32_t _tmp$849;
      int64_t _tmp$846;
      int32_t _tmp$848;
      int64_t _tmp$847;
      struct moonbit_result_0 _tmp$1641;
      void* _try_err$84;
      struct $StringView end_line$82;
      int32_t _tmp$843;
      int32_t _tmp$842;
      int64_t _tmp$839;
      int32_t _tmp$841;
      int64_t _tmp$840;
      struct moonbit_result_0 _tmp$1643;
      void* _try_err$87;
      struct $StringView end_column$85;
      int32_t _tmp$836;
      int32_t _tmp$835;
      int64_t _tmp$832;
      int32_t _tmp$834;
      int64_t _tmp$833;
      struct moonbit_result_0 _tmp$1645;
      struct $$moonbitlang$core$builtin$SourceLocRepr* _block$1646;
      moonbit_incref(_data$50);
      _tmp$1635 = $String$$sub(_data$50, _tmp$866, _tmp$867);
      if (_tmp$1635.tag) {
        struct $StringView const _ok$871 = _tmp$1635.data.ok;
        start_line$70 = _ok$871;
      } else {
        void* const _err$872 = _tmp$1635.data.err;
        _try_err$72 = _err$872;
        goto $join$71;
      }
      goto $joinlet$1634;
      $join$71:;
      moonbit_decref(_try_err$72);
      moonbit_panic();
      $joinlet$1634:;
      _tmp$863 = match_tag_saver_2$58;
      _tmp$862 = _tmp$863 + 1;
      _tmp$859 = (int64_t)_tmp$862;
      _tmp$861 = match_tag_saver_3$59;
      _tmp$860 = (int64_t)_tmp$861;
      moonbit_incref(_data$50);
      _tmp$1637 = $String$$sub(_data$50, _tmp$859, _tmp$860);
      if (_tmp$1637.tag) {
        struct $StringView const _ok$864 = _tmp$1637.data.ok;
        start_column$73 = _ok$864;
      } else {
        void* const _err$865 = _tmp$1637.data.err;
        _try_err$75 = _err$865;
        goto $join$74;
      }
      goto $joinlet$1636;
      $join$74:;
      moonbit_decref(_try_err$75);
      moonbit_panic();
      $joinlet$1636:;
      _tmp$856 = _start$51 + 1;
      _tmp$853 = (int64_t)_tmp$856;
      _tmp$855 = match_tag_saver_0$56;
      _tmp$854 = (int64_t)_tmp$855;
      moonbit_incref(_data$50);
      _tmp$1639 = $String$$sub(_data$50, _tmp$853, _tmp$854);
      if (_tmp$1639.tag) {
        struct $StringView const _ok$857 = _tmp$1639.data.ok;
        pkg$76 = _ok$857;
      } else {
        void* const _err$858 = _tmp$1639.data.err;
        _try_err$78 = _err$858;
        goto $join$77;
      }
      goto $joinlet$1638;
      $join$77:;
      moonbit_decref(_try_err$78);
      moonbit_panic();
      $joinlet$1638:;
      _tmp$850 = match_tag_saver_0$56;
      _tmp$849 = _tmp$850 + 1;
      _tmp$846 = (int64_t)_tmp$849;
      _tmp$848 = match_tag_saver_1$57;
      _tmp$847 = (int64_t)_tmp$848;
      moonbit_incref(_data$50);
      _tmp$1641 = $String$$sub(_data$50, _tmp$846, _tmp$847);
      if (_tmp$1641.tag) {
        struct $StringView const _ok$851 = _tmp$1641.data.ok;
        filename$79 = _ok$851;
      } else {
        void* const _err$852 = _tmp$1641.data.err;
        _try_err$81 = _err$852;
        goto $join$80;
      }
      goto $joinlet$1640;
      $join$80:;
      moonbit_decref(_try_err$81);
      moonbit_panic();
      $joinlet$1640:;
      _tmp$843 = match_tag_saver_3$59;
      _tmp$842 = _tmp$843 + 1;
      _tmp$839 = (int64_t)_tmp$842;
      _tmp$841 = match_tag_saver_4$60;
      _tmp$840 = (int64_t)_tmp$841;
      moonbit_incref(_data$50);
      _tmp$1643 = $String$$sub(_data$50, _tmp$839, _tmp$840);
      if (_tmp$1643.tag) {
        struct $StringView const _ok$844 = _tmp$1643.data.ok;
        end_line$82 = _ok$844;
      } else {
        void* const _err$845 = _tmp$1643.data.err;
        _try_err$84 = _err$845;
        goto $join$83;
      }
      goto $joinlet$1642;
      $join$83:;
      moonbit_decref(_try_err$84);
      moonbit_panic();
      $joinlet$1642:;
      _tmp$836 = match_tag_saver_4$60;
      _tmp$835 = _tmp$836 + 1;
      _tmp$832 = (int64_t)_tmp$835;
      _tmp$834 = match_end$55;
      _tmp$833 = (int64_t)_tmp$834;
      _tmp$1645 = $String$$sub(_data$50, _tmp$832, _tmp$833);
      if (_tmp$1645.tag) {
        struct $StringView const _ok$837 = _tmp$1645.data.ok;
        end_column$85 = _ok$837;
      } else {
        void* const _err$838 = _tmp$1645.data.err;
        _try_err$87 = _err$838;
        goto $join$86;
      }
      goto $joinlet$1644;
      $join$86:;
      moonbit_decref(_try_err$87);
      moonbit_panic();
      $joinlet$1644:;
      _block$1646
      = (struct $$moonbitlang$core$builtin$SourceLocRepr*)moonbit_malloc(
          sizeof(struct $$moonbitlang$core$builtin$SourceLocRepr)
        );
      Moonbit_object_header(_block$1646)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $$moonbitlang$core$builtin$SourceLocRepr, $0_0) >> 2,
          6,
          0
      );
      _block$1646->$0_0 = pkg$76.$0;
      _block$1646->$0_1 = pkg$76.$1;
      _block$1646->$0_2 = pkg$76.$2;
      _block$1646->$1_0 = filename$79.$0;
      _block$1646->$1_1 = filename$79.$1;
      _block$1646->$1_2 = filename$79.$2;
      _block$1646->$2_0 = start_line$70.$0;
      _block$1646->$2_1 = start_line$70.$1;
      _block$1646->$2_2 = start_line$70.$2;
      _block$1646->$3_0 = start_column$73.$0;
      _block$1646->$3_1 = start_column$73.$1;
      _block$1646->$3_2 = start_column$73.$2;
      _block$1646->$4_0 = end_line$82.$0;
      _block$1646->$4_1 = end_line$82.$1;
      _block$1646->$4_2 = end_line$82.$2;
      _block$1646->$5_0 = end_column$85.$0;
      _block$1646->$5_1 = end_column$85.$1;
      _block$1646->$5_2 = end_column$85.$2;
      return _block$1646;
      break;
    }
    default: {
      moonbit_decref(_data$50);
      moonbit_panic();
      break;
    }
  }
}

int32_t $String$$unsafe_charcode_at(moonbit_string_t self$46, int32_t idx$47) {
  int32_t _tmp$1555 = self$46[idx$47];
  moonbit_decref(self$46);
  return _tmp$1555;
}

int32_t $Int$$is_trailing_surrogate(int32_t self$45) {
  return 56320 <= self$45 && self$45 <= 57343;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$42,
  int32_t ch$44
) {
  int32_t len$827 = self$42->$1;
  int32_t _tmp$826 = len$827 + 4;
  moonbit_bytes_t _field$1556;
  moonbit_bytes_t data$830;
  int32_t len$831;
  int32_t inc$43;
  int32_t len$829;
  int32_t _tmp$828;
  moonbit_incref(self$42);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$42, _tmp$826
  );
  _field$1556 = self$42->$0;
  data$830 = _field$1556;
  len$831 = self$42->$1;
  moonbit_incref(data$830);
  inc$43 = $FixedArray$$set_utf16le_char(data$830, len$831, ch$44);
  len$829 = self$42->$1;
  _tmp$828 = len$829 + inc$43;
  self$42->$1 = _tmp$828;
  moonbit_decref(self$42);
  return 0;
}

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$37,
  int32_t required$38
) {
  moonbit_bytes_t _field$1560 = self$37->$0;
  moonbit_bytes_t data$825 = _field$1560;
  int32_t _tmp$1559 = Moonbit_array_length(data$825);
  int32_t current_len$36 = _tmp$1559;
  int32_t enough_space$39;
  int32_t _tmp$824;
  moonbit_bytes_t new_data$41;
  moonbit_bytes_t _field$1558;
  moonbit_bytes_t data$822;
  int32_t len$823;
  moonbit_bytes_t _old$1557;
  if (required$38 <= current_len$36) {
    moonbit_decref(self$37);
    return 0;
  }
  enough_space$39 = current_len$36;
  while (1) {
    int32_t _tmp$820 = enough_space$39;
    if (_tmp$820 < required$38) {
      int32_t _tmp$821 = enough_space$39;
      enough_space$39 = _tmp$821 * 2;
      continue;
    }
    break;
  }
  _tmp$824 = enough_space$39;
  new_data$41 = (moonbit_bytes_t)moonbit_make_bytes(_tmp$824, 0);
  _field$1558 = self$37->$0;
  data$822 = _field$1558;
  len$823 = self$37->$1;
  moonbit_incref(data$822);
  moonbit_incref(new_data$41);
  $FixedArray$$unsafe_blit$0(new_data$41, 0, data$822, 0, len$823);
  _old$1557 = self$37->$0;
  moonbit_decref(_old$1557);
  self$37->$0 = new_data$41;
  moonbit_decref(self$37);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default() {
  return 0;
}

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$31,
  int32_t offset$32,
  int32_t value$30
) {
  int32_t _tmp$819 = value$30;
  uint32_t code$29 = *(uint32_t*)&_tmp$819;
  if (code$29 < 65536u) {
    uint32_t _p$518 = code$29 & 255u;
    int32_t _tmp$802 = *(int32_t*)&_p$518;
    int32_t _tmp$801 = _tmp$802 & 0xff;
    int32_t _tmp$803;
    uint32_t _p$521;
    int32_t _tmp$805;
    int32_t _tmp$804;
    if (offset$32 < 0 || offset$32 >= Moonbit_array_length(self$31)) {
      moonbit_panic();
    }
    self$31[offset$32] = _tmp$801;
    _tmp$803 = offset$32 + 1;
    _p$521 = code$29 >> 8;
    _tmp$805 = *(int32_t*)&_p$521;
    _tmp$804 = _tmp$805 & 0xff;
    if (_tmp$803 < 0 || _tmp$803 >= Moonbit_array_length(self$31)) {
      moonbit_panic();
    }
    self$31[_tmp$803] = _tmp$804;
    moonbit_decref(self$31);
    return 2;
  } else if (code$29 < 1114112u) {
    uint32_t hi$33 = code$29 - 65536u;
    uint32_t _tmp$818 = hi$33 >> 10;
    uint32_t lo$34 = _tmp$818 | 55296u;
    uint32_t _tmp$817 = hi$33 & 1023u;
    uint32_t hi$35 = _tmp$817 | 56320u;
    uint32_t _p$524 = lo$34 & 255u;
    int32_t _tmp$807 = *(int32_t*)&_p$524;
    int32_t _tmp$806 = _tmp$807 & 0xff;
    int32_t _tmp$808;
    uint32_t _p$527;
    int32_t _tmp$810;
    int32_t _tmp$809;
    int32_t _tmp$811;
    uint32_t _p$530;
    int32_t _tmp$813;
    int32_t _tmp$812;
    int32_t _tmp$814;
    uint32_t _p$533;
    int32_t _tmp$816;
    int32_t _tmp$815;
    if (offset$32 < 0 || offset$32 >= Moonbit_array_length(self$31)) {
      moonbit_panic();
    }
    self$31[offset$32] = _tmp$806;
    _tmp$808 = offset$32 + 1;
    _p$527 = lo$34 >> 8;
    _tmp$810 = *(int32_t*)&_p$527;
    _tmp$809 = _tmp$810 & 0xff;
    if (_tmp$808 < 0 || _tmp$808 >= Moonbit_array_length(self$31)) {
      moonbit_panic();
    }
    self$31[_tmp$808] = _tmp$809;
    _tmp$811 = offset$32 + 2;
    _p$530 = hi$35 & 255u;
    _tmp$813 = *(int32_t*)&_p$530;
    _tmp$812 = _tmp$813 & 0xff;
    if (_tmp$811 < 0 || _tmp$811 >= Moonbit_array_length(self$31)) {
      moonbit_panic();
    }
    self$31[_tmp$811] = _tmp$812;
    _tmp$814 = offset$32 + 3;
    _p$533 = hi$35 >> 8;
    _tmp$816 = *(int32_t*)&_p$533;
    _tmp$815 = _tmp$816 & 0xff;
    if (_tmp$814 < 0 || _tmp$814 >= Moonbit_array_length(self$31)) {
      moonbit_panic();
    }
    self$31[_tmp$814] = _tmp$815;
    moonbit_decref(self$31);
    return 4;
  } else {
    moonbit_decref(self$31);
    return $moonbitlang$core$builtin$abort$0(
             (moonbit_string_t)moonbit_string_literal_11.data,
               (moonbit_string_t)moonbit_string_literal_12.data
           );
  }
}

int32_t $UInt$$to_byte(uint32_t self$28) {
  int32_t _tmp$800 = *(int32_t*)&self$28;
  return _tmp$800 & 0xff;
}

uint32_t $Char$$to_uint(int32_t self$27) {
  int32_t _tmp$799 = self$27;
  return *(uint32_t*)&_tmp$799;
}

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$26
) {
  moonbit_bytes_t _field$1562 = self$26->$0;
  moonbit_bytes_t data$798 = _field$1562;
  moonbit_bytes_t _tmp$795;
  int32_t _field$1561;
  int32_t len$797;
  int64_t _tmp$796;
  moonbit_incref(data$798);
  _tmp$795 = data$798;
  _field$1561 = self$26->$1;
  moonbit_decref(self$26);
  len$797 = _field$1561;
  _tmp$796 = (int64_t)len$797;
  return $Bytes$$to_unchecked_string$inner(_tmp$795, 0, _tmp$796);
}

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$21,
  int32_t offset$25,
  int64_t length$23
) {
  int32_t len$20 = Moonbit_array_length(self$21);
  int32_t length$22;
  int32_t _if_result$1648;
  if (length$23 == 4294967296ll) {
    length$22 = len$20 - offset$25;
  } else {
    int64_t _Some$24 = length$23;
    length$22 = (int32_t)_Some$24;
  }
  if (offset$25 >= 0) {
    if (length$22 >= 0) {
      int32_t _tmp$794 = offset$25 + length$22;
      _if_result$1648 = _tmp$794 <= len$20;
    } else {
      _if_result$1648 = 0;
    }
  } else {
    _if_result$1648 = 0;
  }
  if (_if_result$1648) {
    return $moonbitlang$core$builtin$unsafe_sub_string(
             self$21, offset$25, length$22
           );
  } else {
    moonbit_decref(self$21);
    moonbit_panic();
  }
}

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$18
) {
  int32_t initial$17;
  moonbit_bytes_t data$19;
  struct $$moonbitlang$core$builtin$StringBuilder* _block$1649;
  if (size_hint$18 < 1) {
    initial$17 = 1;
  } else {
    initial$17 = size_hint$18;
  }
  data$19 = (moonbit_bytes_t)moonbit_make_bytes(initial$17, 0);
  _block$1649
  = (struct $$moonbitlang$core$builtin$StringBuilder*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$builtin$StringBuilder)
    );
  Moonbit_object_header(_block$1649)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $$moonbitlang$core$builtin$StringBuilder, $0) >> 2, 1, 0
  );
  _block$1649->$0 = data$19;
  _block$1649->$1 = 0;
  return _block$1649;
}

int32_t $Byte$$to_char(int32_t self$16) {
  int32_t _tmp$793 = (int32_t)self$16;
  return _tmp$793;
}

int32_t $FixedArray$$unsafe_blit$0(
  moonbit_bytes_t dst$7,
  int32_t dst_offset$9,
  moonbit_bytes_t src$8,
  int32_t src_offset$10,
  int32_t len$12
) {
  if (dst$7 == src$8 && dst_offset$9 < src_offset$10) {
    int32_t i$11 = 0;
    while (1) {
      if (i$11 < len$12) {
        int32_t _tmp$784 = dst_offset$9 + i$11;
        int32_t _tmp$786 = src_offset$10 + i$11;
        int32_t _tmp$785;
        int32_t _tmp$787;
        if (_tmp$786 < 0 || _tmp$786 >= Moonbit_array_length(src$8)) {
          moonbit_panic();
        }
        _tmp$785 = (int32_t)src$8[_tmp$786];
        if (_tmp$784 < 0 || _tmp$784 >= Moonbit_array_length(dst$7)) {
          moonbit_panic();
        }
        dst$7[_tmp$784] = _tmp$785;
        _tmp$787 = i$11 + 1;
        i$11 = _tmp$787;
        continue;
      } else {
        moonbit_decref(src$8);
        moonbit_decref(dst$7);
      }
      break;
    }
  } else {
    int32_t _tmp$792 = len$12 - 1;
    int32_t i$14 = _tmp$792;
    while (1) {
      if (i$14 >= 0) {
        int32_t _tmp$788 = dst_offset$9 + i$14;
        int32_t _tmp$790 = src_offset$10 + i$14;
        int32_t _tmp$789;
        int32_t _tmp$791;
        if (_tmp$790 < 0 || _tmp$790 >= Moonbit_array_length(src$8)) {
          moonbit_panic();
        }
        _tmp$789 = (int32_t)src$8[_tmp$790];
        if (_tmp$788 < 0 || _tmp$788 >= Moonbit_array_length(dst$7)) {
          moonbit_panic();
        }
        dst$7[_tmp$788] = _tmp$789;
        _tmp$791 = i$14 - 1;
        i$14 = _tmp$791;
        continue;
      } else {
        moonbit_decref(src$8);
        moonbit_decref(dst$7);
      }
      break;
    }
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$abort$1(
  moonbit_string_t string$5,
  moonbit_string_t loc$6
) {
  moonbit_string_t _tmp$782 =
    moonbit_add_string(
      string$5, (moonbit_string_t)moonbit_string_literal_13.data
    );
  moonbit_string_t _tmp$783 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$6);
  moonbit_string_t _tmp$781 = moonbit_add_string(_tmp$782, _tmp$783);
  moonbit_string_t _tmp$780 =
    moonbit_add_string(
      _tmp$781, (moonbit_string_t)moonbit_string_literal_14.data
    );
  $moonbitlang$core$abort$abort$1(_tmp$780);
  return 0;
}

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$3,
  moonbit_string_t loc$4
) {
  moonbit_string_t _tmp$778 =
    moonbit_add_string(
      string$3, (moonbit_string_t)moonbit_string_literal_13.data
    );
  moonbit_string_t _tmp$779 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$4);
  moonbit_string_t _tmp$777 = moonbit_add_string(_tmp$778, _tmp$779);
  moonbit_string_t _tmp$776 =
    moonbit_add_string(
      _tmp$777, (moonbit_string_t)moonbit_string_literal_14.data
    );
  return $moonbitlang$core$abort$abort$0(_tmp$776);
}

int32_t $moonbitlang$core$abort$abort$1(moonbit_string_t msg$2) {
  moonbit_println(msg$2);
  moonbit_decref(msg$2);
  moonbit_panic();
  return 0;
}

int32_t $moonbitlang$core$abort$abort$0(moonbit_string_t msg$1) {
  moonbit_println(msg$1);
  moonbit_decref(msg$1);
  moonbit_panic();
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$769,
  int32_t _param$768
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$767 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$769;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
    _self$767, _param$768
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$766,
  struct $StringView _param$765
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$764 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$766;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    _self$764, _param$765
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$763,
  moonbit_string_t _param$760,
  int32_t _param$761,
  int32_t _param$762
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$759 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$763;
  $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
    _self$759, _param$760, _param$761, _param$762
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$758,
  moonbit_string_t _param$757
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$756 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$758;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
    _self$756, _param$757
  );
  return 0;
}

void moonbit_init() {

}

int main(int argc, char** argv) {
  double _tmp$772;
  moonbit_string_t _tmp$771;
  moonbit_string_t _tmp$770;
  double _tmp$775;
  moonbit_string_t _tmp$774;
  moonbit_string_t _tmp$773;
  moonbit_runtime_init(argc, argv);
  moonbit_init();
  moonbit_incref($username$moonbit_examples$cmd$enums$_main$c$510);
  _tmp$772
  = $username$moonbit_examples$cmd$enums$area(
    $username$moonbit_examples$cmd$enums$_main$c$510
  );
  _tmp$771
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
    _tmp$772
  );
  _tmp$770
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_15.data, _tmp$771
  );
  $moonbitlang$core$builtin$println$0(_tmp$770);
  moonbit_incref($username$moonbit_examples$cmd$enums$_main$r$511);
  _tmp$775
  = $username$moonbit_examples$cmd$enums$area(
    $username$moonbit_examples$cmd$enums$_main$r$511
  );
  _tmp$774
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
    _tmp$775
  );
  _tmp$773
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_16.data, _tmp$774
  );
  $moonbitlang$core$builtin$println$0(_tmp$773);
  return 0;
}