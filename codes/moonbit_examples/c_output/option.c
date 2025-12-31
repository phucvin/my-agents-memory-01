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

struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$;

struct $Result$3c$StringView$2a$$moonbitlang$core$builtin$CreatingViewError$3e$$Ok;

struct $StringView;

struct $$moonbitlang$core$builtin$SourceLocRepr;

struct $$moonbitlang$core$builtin$Logger;

struct $$3c$StringView$2a$StringView$3e$;

struct $Option$3c$StringView$3e$$Some;

struct $Result$3c$StringView$2a$$moonbitlang$core$builtin$CreatingViewError$3e$$Err;

struct $$moonbitlang$core$builtin$Logger$static_method_table;

struct $$moonbitlang$core$builtin$StringBuilder;

struct $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger {
  struct $$moonbitlang$core$builtin$Logger$static_method_table* $0;
  void* $1;

};

struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$ {
  int32_t $0_1;
  int32_t $0_2;
  moonbit_string_t $0_0;
  void* $1;

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

struct $$3c$StringView$2a$StringView$3e$ {
  int32_t $0_1;
  int32_t $0_2;
  int32_t $1_1;
  int32_t $1_2;
  moonbit_string_t $0_0;
  moonbit_string_t $1_0;

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

struct moonbit_result_0 {
  int tag;
  union { struct $StringView ok; void* err;  } data;

};

int64_t $username$moonbit_examples$cmd$option$safe_divide(
  int32_t a$316,
  int32_t b$315
);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$313,
  struct $$moonbitlang$core$builtin$Logger logger$314
);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$299,
  struct $$moonbitlang$core$builtin$Logger logger$312
);

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$297);

moonbit_string_t $$moonbitlang$core$builtin$Show$$String$$to_string(
  moonbit_string_t self$296
);

int32_t $$moonbitlang$core$builtin$Show$$Int$$output(
  int32_t self$295,
  struct $$moonbitlang$core$builtin$Logger logger$294
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$292,
  struct $StringView str$293
);

int64_t $String$$offset_of_nth_char$inner(
  moonbit_string_t self$289,
  int32_t i$290,
  int32_t start_offset$291,
  int64_t end_offset$287
);

int64_t $String$$offset_of_nth_char_forward(
  moonbit_string_t self$284,
  int32_t n$282,
  int32_t start_offset$278,
  int32_t end_offset$279
);

int64_t $String$$offset_of_nth_char_backward(
  moonbit_string_t self$276,
  int32_t n$274,
  int32_t start_offset$273,
  int32_t end_offset$272
);

int32_t $String$$char_length_ge$inner(
  moonbit_string_t self$262,
  int32_t len$265,
  int32_t start_offset$269,
  int64_t end_offset$260
);

moonbit_string_t $Int$$to_string$inner(int32_t self$243, int32_t radix$242);

int32_t $moonbitlang$core$builtin$radix_count32(
  uint32_t value$236,
  int32_t radix$239
);

int32_t $moonbitlang$core$builtin$hex_count32(uint32_t value$234);

int32_t $moonbitlang$core$builtin$dec_count32(uint32_t value$233);

int32_t $moonbitlang$core$builtin$int_to_string_dec(
  uint16_t* buffer$223,
  uint32_t num$211,
  int32_t digit_start$214,
  int32_t total_len$213
);

int32_t $moonbitlang$core$builtin$int_to_string_generic(
  uint16_t* buffer$205,
  uint32_t num$199,
  int32_t digit_start$197,
  int32_t total_len$196,
  int32_t radix$201
);

int32_t $moonbitlang$core$builtin$int_to_string_hex(
  uint16_t* buffer$192,
  uint32_t num$188,
  int32_t digit_start$186,
  int32_t total_len$185
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  moonbit_string_t self$183
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  int32_t self$181
);

int32_t $StringView$$start_offset(struct $StringView self$179);

moonbit_string_t $StringView$$data(struct $StringView self$178);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$172,
  moonbit_string_t value$175,
  int32_t start$176,
  int32_t len$177
);

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$165,
  int32_t start$171,
  int64_t end$167
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$162,
  moonbit_string_t str$163
);

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$154,
  int32_t bytes_offset$149,
  moonbit_string_t str$156,
  int32_t str_offset$152,
  int32_t length$150
);

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$116
);

struct $$3c$StringView$2a$StringView$3e$* $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
  struct $StringView view$112
);

struct $StringView $StringView$$view$inner(
  struct $StringView self$109,
  int32_t start_offset$110,
  int64_t end_offset$107
);

int64_t $StringView$$rev_find(
  struct $StringView self$105,
  struct $StringView str$104
);

int64_t $moonbitlang$core$builtin$brute_force_rev_find(
  struct $StringView haystack$95,
  struct $StringView needle$97
);

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_rev_find(
  struct $StringView haystack$84,
  struct $StringView needle$86
);

int64_t $StringView$$find(
  struct $StringView self$82,
  struct $StringView str$81
);

int64_t $moonbitlang$core$builtin$brute_force_find(
  struct $StringView haystack$71,
  struct $StringView needle$73
);

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_find(
  struct $StringView haystack$57,
  struct $StringView needle$59
);

int32_t $StringView$$unsafe_charcode_at(
  struct $StringView self$53,
  int32_t index$54
);

int32_t $StringView$$length(struct $StringView self$52);

int32_t $Int$$is_trailing_surrogate(int32_t self$51);

int32_t $Int$$is_leading_surrogate(int32_t self$50);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$47,
  int32_t ch$49
);

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$42,
  int32_t required$43
);

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default();

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$36,
  int32_t offset$37,
  int32_t value$35
);

int32_t $UInt$$to_byte(uint32_t self$33);

uint32_t $Char$$to_uint(int32_t self$32);

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$31
);

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$26,
  int32_t offset$30,
  int64_t length$28
);

#define $moonbitlang$core$builtin$unsafe_sub_string moonbit_unsafe_bytes_sub_string

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$23
);

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

struct $StringView $moonbitlang$core$builtin$abort$2(
  moonbit_string_t string$9,
  moonbit_string_t loc$10
);

int32_t $moonbitlang$core$builtin$abort$1(
  moonbit_string_t string$7,
  moonbit_string_t loc$8
);

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$5,
  moonbit_string_t loc$6
);

int64_t $moonbitlang$core$abort$abort$3(moonbit_string_t msg$4);

struct $StringView $moonbitlang$core$abort$abort$2(moonbit_string_t msg$3);

int32_t $moonbitlang$core$abort$abort$1(moonbit_string_t msg$2);

int32_t $moonbitlang$core$abort$abort$0(moonbit_string_t msg$1);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$481,
  int32_t _param$480
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$478,
  struct $StringView _param$477
);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$475,
  moonbit_string_t _param$472,
  int32_t _param$473,
  int32_t _param$474
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$470,
  moonbit_string_t _param$469
);

struct { int32_t rc; uint32_t meta; uint16_t const data[22];
} const moonbit_string_literal_17 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 21),
    67, 97, 110, 110, 111, 116, 32, 100, 105, 118, 105, 100, 101, 32,
    98, 121, 32, 122, 101, 114, 111, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[50];
} const moonbit_string_literal_6 =
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

struct { int32_t rc; uint32_t meta; uint16_t const data[23];
} const moonbit_string_literal_5 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 22),
    105, 110, 118, 97, 108, 105, 100, 32, 115, 117, 114, 114, 111, 103,
    97, 116, 101, 32, 112, 97, 105, 114, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[7];
} const moonbit_string_literal_15 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 6),
    10, 32, 32, 97, 116, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[49];
} const moonbit_string_literal_14 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 48),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 98, 121,
    116, 101, 115, 46, 109, 98, 116, 58, 50, 57, 48, 58, 53, 45, 50,
    57, 48, 58, 51, 49, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[23];
} const moonbit_string_literal_11 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 22),
    73, 110, 118, 97, 108, 105, 100, 32, 105, 110, 100, 101, 120, 32,
    102, 111, 114, 32, 86, 105, 101, 119, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[31];
} const moonbit_string_literal_7 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 30),
    114, 97, 100, 105, 120, 32, 109, 117, 115, 116, 32, 98, 101, 32,
    98, 101, 116, 119, 101, 101, 110, 32, 50, 32, 97, 110, 100, 32, 51,
    54, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_9 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 48, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[18];
} const moonbit_string_literal_13 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 17),
    67, 104, 97, 114, 32, 111, 117, 116, 32, 111, 102, 32, 114, 97, 110,
    103, 101, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[4];
} const moonbit_string_literal_18 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 3),
    32, 47, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[54];
} const moonbit_string_literal_12 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 53),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 115, 116,
    114, 105, 110, 103, 118, 105, 101, 119, 46, 109, 98, 116, 58, 49,
    49, 49, 58, 53, 45, 49, 49, 49, 58, 51, 54, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[53];
} const moonbit_string_literal_8 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 52),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 116, 111,
    95, 115, 116, 114, 105, 110, 103, 46, 109, 98, 116, 58, 50, 51, 57,
    58, 53, 45, 50, 51, 57, 58, 52, 52, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[37];
} const moonbit_string_literal_10 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 36),
    48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 100, 101, 102,
    103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115,
    116, 117, 118, 119, 120, 121, 122, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[20];
} const moonbit_string_literal_3 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 19),
    73, 110, 118, 97, 108, 105, 100, 32, 115, 116, 97, 114, 116, 32,
    105, 110, 100, 101, 120, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_16 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 10, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[4];
} const moonbit_string_literal_19 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 3),
    32, 61, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_0 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 58, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[50];
} const moonbit_string_literal_4 =
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

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_find$constr$55;

int64_t $moonbitlang$core$builtin$brute_force_find$constr$69;

int64_t $username$moonbit_examples$cmd$option$safe_divide(
  int32_t a$316,
  int32_t b$315
) {
  if (b$315 == 0) {
    return 4294967296ll;
  } else {
    int32_t _tmp$946 = a$316 / b$315;
    return (int64_t)_tmp$946;
  }
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$313,
  struct $$moonbitlang$core$builtin$Logger logger$314
) {
  moonbit_string_t _tmp$945 = self$313;
  struct $$moonbitlang$core$builtin$SourceLocRepr* _tmp$944 =
    $$moonbitlang$core$builtin$SourceLocRepr$$parse(_tmp$945);
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
    _tmp$944, logger$314
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$299,
  struct $$moonbitlang$core$builtin$Logger logger$312
) {
  struct $StringView _field$955 =
    (struct $StringView){self$299->$0_1, self$299->$0_2, self$299->$0_0};
  struct $StringView pkg$298 = _field$955;
  int32_t _tmp$943 =
    Moonbit_array_length($moonbitlang$core$builtin$output$$2a$bind$7c$8193);
  struct $StringView _tmp$942;
  int64_t _bind$300;
  struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$* _bind$301;
  struct $StringView _field$954;
  struct $StringView _module_name$308;
  void* _field$953;
  int32_t _cnt$1012;
  void* _package_name$309;
  struct $StringView _field$951;
  struct $StringView filename$925;
  struct $StringView _field$950;
  struct $StringView start_line$926;
  struct $StringView _field$949;
  struct $StringView start_column$927;
  struct $StringView _field$948;
  struct $StringView end_line$928;
  struct $StringView _field$947;
  int32_t _cnt$1016;
  struct $StringView end_column$929;
  struct $$moonbitlang$core$builtin$Logger _bind$924;
  moonbit_incref($moonbitlang$core$builtin$output$$2a$bind$7c$8193);
  _tmp$942
  = (struct $StringView){
    0, _tmp$943, $moonbitlang$core$builtin$output$$2a$bind$7c$8193
  };
  moonbit_incref(pkg$298.$0);
  moonbit_incref(pkg$298.$0);
  _bind$300 = $StringView$$find(pkg$298, _tmp$942);
  if (_bind$300 == 4294967296ll) {
    void* None$930 =
      (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
    _bind$301
    = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
        sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
      );
    Moonbit_object_header(_bind$301)->meta
    = Moonbit_make_regular_object_header(
      offsetof(
        struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
      )
      >> 2,
        2,
        0
    );
    _bind$301->$0_0 = pkg$298.$0;
    _bind$301->$0_1 = pkg$298.$1;
    _bind$301->$0_2 = pkg$298.$2;
    _bind$301->$1 = None$930;
  } else {
    int64_t _Some$302 = _bind$300;
    int32_t _first_slash$303 = (int32_t)_Some$302;
    int32_t _tmp$941 = _first_slash$303 + 1;
    struct $StringView _tmp$938;
    int32_t _tmp$940;
    struct $StringView _tmp$939;
    int64_t _bind$304;
    moonbit_incref(pkg$298.$0);
    _tmp$938 = $StringView$$view$inner(pkg$298, _tmp$941, 4294967296ll);
    _tmp$940
    = Moonbit_array_length(
      $moonbitlang$core$builtin$output$$2a$bind$7c$8187
    );
    moonbit_incref($moonbitlang$core$builtin$output$$2a$bind$7c$8187);
    _tmp$939
    = (struct $StringView){
      0, _tmp$940, $moonbitlang$core$builtin$output$$2a$bind$7c$8187
    };
    _bind$304 = $StringView$$find(_tmp$938, _tmp$939);
    if (_bind$304 == 4294967296ll) {
      void* None$931 =
        (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _bind$301
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$301)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$301->$0_0 = pkg$298.$0;
      _bind$301->$0_1 = pkg$298.$1;
      _bind$301->$0_2 = pkg$298.$2;
      _bind$301->$1 = None$931;
    } else {
      int64_t _Some$305 = _bind$304;
      int32_t _second_slash$306 = (int32_t)_Some$305;
      int32_t _tmp$937 = _first_slash$303 + 1;
      int32_t module_name_end$307 = _tmp$937 + _second_slash$306;
      int64_t _tmp$936 = (int64_t)module_name_end$307;
      struct $StringView _tmp$932;
      int32_t _tmp$935;
      struct $StringView _tmp$934;
      void* Some$933;
      moonbit_incref(pkg$298.$0);
      _tmp$932 = $StringView$$view$inner(pkg$298, 0, _tmp$936);
      _tmp$935 = module_name_end$307 + 1;
      _tmp$934 = $StringView$$view$inner(pkg$298, _tmp$935, 4294967296ll);
      Some$933
      = (void*)moonbit_malloc(sizeof(struct $Option$3c$StringView$3e$$Some));
      Moonbit_object_header(Some$933)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $Option$3c$StringView$3e$$Some, $0_0) >> 2, 1, 1
      );
      ((struct $Option$3c$StringView$3e$$Some*)Some$933)->$0_0 = _tmp$934.$0;
      ((struct $Option$3c$StringView$3e$$Some*)Some$933)->$0_1 = _tmp$934.$1;
      ((struct $Option$3c$StringView$3e$$Some*)Some$933)->$0_2 = _tmp$934.$2;
      _bind$301
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$301)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$301->$0_0 = _tmp$932.$0;
      _bind$301->$0_1 = _tmp$932.$1;
      _bind$301->$0_2 = _tmp$932.$2;
      _bind$301->$1 = Some$933;
    }
  }
  _field$954
  = (struct $StringView){
    _bind$301->$0_1, _bind$301->$0_2, _bind$301->$0_0
  };
  _module_name$308 = _field$954;
  _field$953 = _bind$301->$1;
  _cnt$1012 = Moonbit_object_header(_bind$301)->rc;
  if (_cnt$1012 > 1) {
    int32_t _new_cnt$1013;
    moonbit_incref(_field$953);
    moonbit_incref(_module_name$308.$0);
    _new_cnt$1013 = _cnt$1012 - 1;
    Moonbit_object_header(_bind$301)->rc = _new_cnt$1013;
  } else if (_cnt$1012 == 1) {
    moonbit_free(_bind$301);
  }
  _package_name$309 = _field$953;
  switch (Moonbit_object_tag(_package_name$309)) {
    case 1: {
      struct $Option$3c$StringView$3e$$Some* _Some$310 =
        (struct $Option$3c$StringView$3e$$Some*)_package_name$309;
      struct $StringView _field$952 =
        (struct $StringView){
          _Some$310->$0_1, _Some$310->$0_2, _Some$310->$0_0
        };
      int32_t _cnt$1014 = Moonbit_object_header(_Some$310)->rc;
      struct $StringView _pkg_name$311;
      struct $$moonbitlang$core$builtin$Logger _bind$923;
      if (_cnt$1014 > 1) {
        int32_t _new_cnt$1015;
        moonbit_incref(_field$952.$0);
        _new_cnt$1015 = _cnt$1014 - 1;
        Moonbit_object_header(_Some$310)->rc = _new_cnt$1015;
      } else if (_cnt$1014 == 1) {
        moonbit_free(_Some$310);
      }
      _pkg_name$311 = _field$952;
      if (logger$312.$1) {
        moonbit_incref(logger$312.$1);
      }
      logger$312.$0->$method_2(logger$312.$1, _pkg_name$311);
      _bind$923 = logger$312;
      if (_bind$923.$1) {
        moonbit_incref(_bind$923.$1);
      }
      _bind$923.$0->$method_3(_bind$923.$1, 47);
      break;
    }
    default: {
      moonbit_decref(_package_name$309);
      break;
    }
  }
  _field$951
  = (struct $StringView){
    self$299->$1_1, self$299->$1_2, self$299->$1_0
  };
  filename$925 = _field$951;
  moonbit_incref(filename$925.$0);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_2(logger$312.$1, filename$925);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_3(logger$312.$1, 58);
  _field$950
  = (struct $StringView){
    self$299->$2_1, self$299->$2_2, self$299->$2_0
  };
  start_line$926 = _field$950;
  moonbit_incref(start_line$926.$0);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_2(logger$312.$1, start_line$926);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_3(logger$312.$1, 58);
  _field$949
  = (struct $StringView){
    self$299->$3_1, self$299->$3_2, self$299->$3_0
  };
  start_column$927 = _field$949;
  moonbit_incref(start_column$927.$0);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_2(logger$312.$1, start_column$927);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_3(logger$312.$1, 45);
  _field$948
  = (struct $StringView){
    self$299->$4_1, self$299->$4_2, self$299->$4_0
  };
  end_line$928 = _field$948;
  moonbit_incref(end_line$928.$0);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_2(logger$312.$1, end_line$928);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_3(logger$312.$1, 58);
  _field$947
  = (struct $StringView){
    self$299->$5_1, self$299->$5_2, self$299->$5_0
  };
  _cnt$1016 = Moonbit_object_header(self$299)->rc;
  if (_cnt$1016 > 1) {
    int32_t _new_cnt$1022;
    moonbit_incref(_field$947.$0);
    _new_cnt$1022 = _cnt$1016 - 1;
    Moonbit_object_header(self$299)->rc = _new_cnt$1022;
  } else if (_cnt$1016 == 1) {
    struct $StringView _field$1021 =
      (struct $StringView){self$299->$4_1, self$299->$4_2, self$299->$4_0};
    struct $StringView _field$1020;
    struct $StringView _field$1019;
    struct $StringView _field$1018;
    struct $StringView _field$1017;
    moonbit_decref(_field$1021.$0);
    _field$1020
    = (struct $StringView){
      self$299->$3_1, self$299->$3_2, self$299->$3_0
    };
    moonbit_decref(_field$1020.$0);
    _field$1019
    = (struct $StringView){
      self$299->$2_1, self$299->$2_2, self$299->$2_0
    };
    moonbit_decref(_field$1019.$0);
    _field$1018
    = (struct $StringView){
      self$299->$1_1, self$299->$1_2, self$299->$1_0
    };
    moonbit_decref(_field$1018.$0);
    _field$1017
    = (struct $StringView){
      self$299->$0_1, self$299->$0_2, self$299->$0_0
    };
    moonbit_decref(_field$1017.$0);
    moonbit_free(self$299);
  }
  end_column$929 = _field$947;
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_2(logger$312.$1, end_column$929);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_3(logger$312.$1, 64);
  _bind$924 = logger$312;
  _bind$924.$0->$method_2(_bind$924.$1, _module_name$308);
  return 0;
}

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$297) {
  moonbit_println(input$297);
  moonbit_decref(input$297);
  return 0;
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$String$$to_string(
  moonbit_string_t self$296
) {
  return self$296;
}

int32_t $$moonbitlang$core$builtin$Show$$Int$$output(
  int32_t self$295,
  struct $$moonbitlang$core$builtin$Logger logger$294
) {
  moonbit_string_t _tmp$922 = $Int$$to_string$inner(self$295, 10);
  logger$294.$0->$method_0(logger$294.$1, _tmp$922);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$292,
  struct $StringView str$293
) {
  int32_t len$904 = self$292->$1;
  int32_t end$907 = str$293.$2;
  int32_t start$908 = str$293.$1;
  int32_t _tmp$906 = end$907 - start$908;
  int32_t _tmp$905 = _tmp$906 * 2;
  int32_t _tmp$903 = len$904 + _tmp$905;
  moonbit_bytes_t _field$958;
  moonbit_bytes_t data$909;
  int32_t len$910;
  moonbit_string_t _field$957;
  moonbit_string_t str$911;
  int32_t start$912;
  int32_t end$914;
  int32_t start$915;
  int32_t _tmp$913;
  int32_t len$917;
  int32_t end$920;
  int32_t _field$956;
  int32_t start$921;
  int32_t _tmp$919;
  int32_t _tmp$918;
  int32_t _tmp$916;
  moonbit_incref(self$292);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$292, _tmp$903
  );
  _field$958 = self$292->$0;
  data$909 = _field$958;
  len$910 = self$292->$1;
  _field$957 = str$293.$0;
  str$911 = _field$957;
  start$912 = str$293.$1;
  end$914 = str$293.$2;
  start$915 = str$293.$1;
  _tmp$913 = end$914 - start$915;
  moonbit_incref(str$911);
  moonbit_incref(data$909);
  $FixedArray$$blit_from_string(
    data$909, len$910, str$911, start$912, _tmp$913
  );
  len$917 = self$292->$1;
  end$920 = str$293.$2;
  _field$956 = str$293.$1;
  moonbit_decref(str$293.$0);
  start$921 = _field$956;
  _tmp$919 = end$920 - start$921;
  _tmp$918 = _tmp$919 * 2;
  _tmp$916 = len$917 + _tmp$918;
  self$292->$1 = _tmp$916;
  moonbit_decref(self$292);
  return 0;
}

int64_t $String$$offset_of_nth_char$inner(
  moonbit_string_t self$289,
  int32_t i$290,
  int32_t start_offset$291,
  int64_t end_offset$287
) {
  int32_t end_offset$286;
  if (end_offset$287 == 4294967296ll) {
    end_offset$286 = Moonbit_array_length(self$289);
  } else {
    int64_t _Some$288 = end_offset$287;
    end_offset$286 = (int32_t)_Some$288;
  }
  if (i$290 >= 0) {
    return $String$$offset_of_nth_char_forward(
             self$289, i$290, start_offset$291, end_offset$286
           );
  } else {
    int32_t _tmp$902 = -i$290;
    return $String$$offset_of_nth_char_backward(
             self$289, _tmp$902, start_offset$291, end_offset$286
           );
  }
}

int64_t $String$$offset_of_nth_char_forward(
  moonbit_string_t self$284,
  int32_t n$282,
  int32_t start_offset$278,
  int32_t end_offset$279
) {
  if (start_offset$278 >= 0 && start_offset$278 <= end_offset$279) {
    int32_t utf16_offset$280 = start_offset$278;
    int32_t char_count$281 = 0;
    int32_t _tmp$900;
    int32_t _if_result$1029;
    while (1) {
      int32_t _tmp$894 = utf16_offset$280;
      int32_t _if_result$1028;
      if (_tmp$894 < end_offset$279) {
        int32_t _tmp$893 = char_count$281;
        _if_result$1028 = _tmp$893 < n$282;
      } else {
        _if_result$1028 = 0;
      }
      if (_if_result$1028) {
        int32_t _tmp$898 = utf16_offset$280;
        int32_t c$283 = self$284[_tmp$898];
        int32_t _tmp$897;
        if (55296 <= c$283 && c$283 <= 56319) {
          int32_t _tmp$895 = utf16_offset$280;
          utf16_offset$280 = _tmp$895 + 2;
        } else {
          int32_t _tmp$896 = utf16_offset$280;
          utf16_offset$280 = _tmp$896 + 1;
        }
        _tmp$897 = char_count$281;
        char_count$281 = _tmp$897 + 1;
        continue;
      } else {
        moonbit_decref(self$284);
      }
      break;
    }
    _tmp$900 = char_count$281;
    if (_tmp$900 < n$282) {
      _if_result$1029 = 1;
    } else {
      int32_t _tmp$899 = utf16_offset$280;
      _if_result$1029 = _tmp$899 >= end_offset$279;
    }
    if (_if_result$1029) {
      return 4294967296ll;
    } else {
      int32_t _tmp$901 = utf16_offset$280;
      return (int64_t)_tmp$901;
    }
  } else {
    moonbit_decref(self$284);
    return $moonbitlang$core$builtin$abort$3(
             (moonbit_string_t)moonbit_string_literal_3.data,
               (moonbit_string_t)moonbit_string_literal_4.data
           );
  }
}

int64_t $String$$offset_of_nth_char_backward(
  moonbit_string_t self$276,
  int32_t n$274,
  int32_t start_offset$273,
  int32_t end_offset$272
) {
  int32_t char_count$270 = 0;
  int32_t utf16_offset$271 = end_offset$272;
  int32_t _tmp$891;
  int32_t _if_result$1032;
  while (1) {
    int32_t _tmp$884 = utf16_offset$271;
    int32_t _tmp$883 = _tmp$884 - 1;
    int32_t _if_result$1031;
    if (_tmp$883 >= start_offset$273) {
      int32_t _tmp$882 = char_count$270;
      _if_result$1031 = _tmp$882 < n$274;
    } else {
      _if_result$1031 = 0;
    }
    if (_if_result$1031) {
      int32_t _tmp$889 = utf16_offset$271;
      int32_t _tmp$888 = _tmp$889 - 1;
      int32_t c$275 = self$276[_tmp$888];
      int32_t _tmp$887;
      if (56320 <= c$275 && c$275 <= 57343) {
        int32_t _tmp$885 = utf16_offset$271;
        utf16_offset$271 = _tmp$885 - 2;
      } else {
        int32_t _tmp$886 = utf16_offset$271;
        utf16_offset$271 = _tmp$886 - 1;
      }
      _tmp$887 = char_count$270;
      char_count$270 = _tmp$887 + 1;
      continue;
    } else {
      moonbit_decref(self$276);
    }
    break;
  }
  _tmp$891 = char_count$270;
  if (_tmp$891 < n$274) {
    _if_result$1032 = 1;
  } else {
    int32_t _tmp$890 = utf16_offset$271;
    _if_result$1032 = _tmp$890 < start_offset$273;
  }
  if (_if_result$1032) {
    return 4294967296ll;
  } else {
    int32_t _tmp$892 = utf16_offset$271;
    return (int64_t)_tmp$892;
  }
}

int32_t $String$$char_length_ge$inner(
  moonbit_string_t self$262,
  int32_t len$265,
  int32_t start_offset$269,
  int64_t end_offset$260
) {
  int32_t end_offset$259;
  int32_t index$263;
  int32_t count$264;
  if (end_offset$260 == 4294967296ll) {
    end_offset$259 = Moonbit_array_length(self$262);
  } else {
    int64_t _Some$261 = end_offset$260;
    end_offset$259 = (int32_t)_Some$261;
  }
  index$263 = start_offset$269;
  count$264 = 0;
  while (1) {
    if (index$263 < end_offset$259 && count$264 < len$265) {
      int32_t c1$266 = self$262[index$263];
      int32_t _if_result$1034;
      int32_t _tmp$880;
      int32_t _tmp$881;
      if (55296 <= c1$266 && c1$266 <= 56319) {
        int32_t _tmp$876 = index$263 + 1;
        _if_result$1034 = _tmp$876 < end_offset$259;
      } else {
        _if_result$1034 = 0;
      }
      if (_if_result$1034) {
        int32_t _tmp$879 = index$263 + 1;
        int32_t c2$267 = self$262[_tmp$879];
        if (56320 <= c2$267 && c2$267 <= 57343) {
          int32_t _tmp$877 = index$263 + 2;
          int32_t _tmp$878 = count$264 + 1;
          index$263 = _tmp$877;
          count$264 = _tmp$878;
          continue;
        } else {
          $moonbitlang$core$builtin$abort$0(
            (moonbit_string_t)moonbit_string_literal_5.data,
              (moonbit_string_t)moonbit_string_literal_6.data
          );
        }
      }
      _tmp$880 = index$263 + 1;
      _tmp$881 = count$264 + 1;
      index$263 = _tmp$880;
      count$264 = _tmp$881;
      continue;
    } else {
      moonbit_decref(self$262);
      return count$264 >= len$265;
    }
    break;
  }
}

moonbit_string_t $Int$$to_string$inner(int32_t self$243, int32_t radix$242) {
  int32_t is_negative$244;
  uint32_t num$245;
  uint16_t* buffer$246;
  if (radix$242 < 2 || radix$242 > 36) {
    $moonbitlang$core$builtin$abort$0(
      (moonbit_string_t)moonbit_string_literal_7.data,
        (moonbit_string_t)moonbit_string_literal_8.data
    );
  }
  if (self$243 == 0) {
    return (moonbit_string_t)moonbit_string_literal_9.data;
  }
  is_negative$244 = self$243 < 0;
  if (is_negative$244) {
    int32_t _tmp$875 = -self$243;
    num$245 = *(uint32_t*)&_tmp$875;
  } else {
    num$245 = *(uint32_t*)&self$243;
  }
  switch (radix$242) {
    case 10: {
      int32_t digit_len$247 = $moonbitlang$core$builtin$dec_count32(num$245);
      int32_t _tmp$872;
      int32_t total_len$248;
      uint16_t* buffer$249;
      int32_t digit_start$250;
      if (is_negative$244) {
        _tmp$872 = 1;
      } else {
        _tmp$872 = 0;
      }
      total_len$248 = digit_len$247 + _tmp$872;
      buffer$249 = (uint16_t*)moonbit_make_string(total_len$248, 0);
      if (is_negative$244) {
        digit_start$250 = 1;
      } else {
        digit_start$250 = 0;
      }
      moonbit_incref(buffer$249);
      $moonbitlang$core$builtin$int_to_string_dec(
        buffer$249, num$245, digit_start$250, total_len$248
      );
      buffer$246 = buffer$249;
      break;
    }

    case 16: {
      int32_t digit_len$251 = $moonbitlang$core$builtin$hex_count32(num$245);
      int32_t _tmp$873;
      int32_t total_len$252;
      uint16_t* buffer$253;
      int32_t digit_start$254;
      if (is_negative$244) {
        _tmp$873 = 1;
      } else {
        _tmp$873 = 0;
      }
      total_len$252 = digit_len$251 + _tmp$873;
      buffer$253 = (uint16_t*)moonbit_make_string(total_len$252, 0);
      if (is_negative$244) {
        digit_start$254 = 1;
      } else {
        digit_start$254 = 0;
      }
      moonbit_incref(buffer$253);
      $moonbitlang$core$builtin$int_to_string_hex(
        buffer$253, num$245, digit_start$254, total_len$252
      );
      buffer$246 = buffer$253;
      break;
    }
    default: {
      int32_t digit_len$255 =
        $moonbitlang$core$builtin$radix_count32(num$245, radix$242);
      int32_t _tmp$874;
      int32_t total_len$256;
      uint16_t* buffer$257;
      int32_t digit_start$258;
      if (is_negative$244) {
        _tmp$874 = 1;
      } else {
        _tmp$874 = 0;
      }
      total_len$256 = digit_len$255 + _tmp$874;
      buffer$257 = (uint16_t*)moonbit_make_string(total_len$256, 0);
      if (is_negative$244) {
        digit_start$258 = 1;
      } else {
        digit_start$258 = 0;
      }
      moonbit_incref(buffer$257);
      $moonbitlang$core$builtin$int_to_string_generic(
        buffer$257, num$245, digit_start$258, total_len$256, radix$242
      );
      buffer$246 = buffer$257;
      break;
    }
  }
  if (is_negative$244) {
    buffer$246[0] = 45;
  }
  return buffer$246;
}

int32_t $moonbitlang$core$builtin$radix_count32(
  uint32_t value$236,
  int32_t radix$239
) {
  uint32_t num$237;
  uint32_t base$238;
  int32_t count$240;
  if (value$236 == 0u) {
    return 1;
  }
  num$237 = value$236;
  base$238 = *(uint32_t*)&radix$239;
  count$240 = 0;
  while (1) {
    uint32_t _tmp$869 = num$237;
    if (_tmp$869 > 0u) {
      int32_t _tmp$870 = count$240;
      uint32_t _tmp$871;
      count$240 = _tmp$870 + 1;
      _tmp$871 = num$237;
      num$237 = _tmp$871 / base$238;
      continue;
    }
    break;
  }
  return count$240;
}

int32_t $moonbitlang$core$builtin$hex_count32(uint32_t value$234) {
  if (value$234 == 0u) {
    return 1;
  } else {
    int32_t leading_zeros$235 = moonbit_clz32(value$234);
    int32_t _tmp$868 = 31 - leading_zeros$235;
    int32_t _tmp$867 = _tmp$868 / 4;
    return _tmp$867 + 1;
  }
}

int32_t $moonbitlang$core$builtin$dec_count32(uint32_t value$233) {
  if (value$233 >= 100000u) {
    if (value$233 >= 10000000u) {
      if (value$233 >= 1000000000u) {
        return 10;
      } else if (value$233 >= 100000000u) {
        return 9;
      } else {
        return 8;
      }
    } else if (value$233 >= 1000000u) {
      return 7;
    } else {
      return 6;
    }
  } else if (value$233 >= 1000u) {
    if (value$233 >= 10000u) {
      return 5;
    } else {
      return 4;
    }
  } else if (value$233 >= 100u) {
    return 3;
  } else if (value$233 >= 10u) {
    return 2;
  } else {
    return 1;
  }
}

int32_t $moonbitlang$core$builtin$int_to_string_dec(
  uint16_t* buffer$223,
  uint32_t num$211,
  int32_t digit_start$214,
  int32_t total_len$213
) {
  uint32_t num$210 = num$211;
  int32_t offset$212 = total_len$213 - digit_start$214;
  uint32_t _tmp$866;
  int32_t remaining$225;
  int32_t _tmp$847;
  while (1) {
    uint32_t _tmp$810 = num$210;
    if (_tmp$810 >= 10000u) {
      uint32_t _tmp$833 = num$210;
      uint32_t t$215 = _tmp$833 / 10000u;
      uint32_t _tmp$832 = num$210;
      uint32_t _tmp$831 = _tmp$832 % 10000u;
      int32_t r$216 = *(int32_t*)&_tmp$831;
      int32_t d1$217;
      int32_t d2$218;
      int32_t _tmp$811;
      int32_t _tmp$830;
      int32_t _tmp$829;
      int32_t d1_hi$219;
      int32_t _tmp$828;
      int32_t _tmp$827;
      int32_t d1_lo$220;
      int32_t _tmp$826;
      int32_t _tmp$825;
      int32_t d2_hi$221;
      int32_t _tmp$824;
      int32_t _tmp$823;
      int32_t d2_lo$222;
      int32_t _tmp$813;
      int32_t _tmp$812;
      int32_t _tmp$816;
      int32_t _tmp$815;
      int32_t _tmp$814;
      int32_t _tmp$819;
      int32_t _tmp$818;
      int32_t _tmp$817;
      int32_t _tmp$822;
      int32_t _tmp$821;
      int32_t _tmp$820;
      num$210 = t$215;
      d1$217 = r$216 / 100;
      d2$218 = r$216 % 100;
      _tmp$811 = offset$212;
      offset$212 = _tmp$811 - 4;
      _tmp$830 = d1$217 / 10;
      _tmp$829 = 48 + _tmp$830;
      d1_hi$219 = (uint16_t)_tmp$829;
      _tmp$828 = d1$217 % 10;
      _tmp$827 = 48 + _tmp$828;
      d1_lo$220 = (uint16_t)_tmp$827;
      _tmp$826 = d2$218 / 10;
      _tmp$825 = 48 + _tmp$826;
      d2_hi$221 = (uint16_t)_tmp$825;
      _tmp$824 = d2$218 % 10;
      _tmp$823 = 48 + _tmp$824;
      d2_lo$222 = (uint16_t)_tmp$823;
      _tmp$813 = offset$212;
      _tmp$812 = digit_start$214 + _tmp$813;
      buffer$223[_tmp$812] = d1_hi$219;
      _tmp$816 = offset$212;
      _tmp$815 = digit_start$214 + _tmp$816;
      _tmp$814 = _tmp$815 + 1;
      buffer$223[_tmp$814] = d1_lo$220;
      _tmp$819 = offset$212;
      _tmp$818 = digit_start$214 + _tmp$819;
      _tmp$817 = _tmp$818 + 2;
      buffer$223[_tmp$817] = d2_hi$221;
      _tmp$822 = offset$212;
      _tmp$821 = digit_start$214 + _tmp$822;
      _tmp$820 = _tmp$821 + 3;
      buffer$223[_tmp$820] = d2_lo$222;
      continue;
    }
    break;
  }
  _tmp$866 = num$210;
  remaining$225 = *(int32_t*)&_tmp$866;
  while (1) {
    int32_t _tmp$834 = remaining$225;
    if (_tmp$834 >= 100) {
      int32_t _tmp$846 = remaining$225;
      int32_t t$226 = _tmp$846 / 100;
      int32_t _tmp$845 = remaining$225;
      int32_t d$227 = _tmp$845 % 100;
      int32_t _tmp$835;
      int32_t _tmp$844;
      int32_t _tmp$843;
      int32_t d_hi$228;
      int32_t _tmp$842;
      int32_t _tmp$841;
      int32_t d_lo$229;
      int32_t _tmp$837;
      int32_t _tmp$836;
      int32_t _tmp$840;
      int32_t _tmp$839;
      int32_t _tmp$838;
      remaining$225 = t$226;
      _tmp$835 = offset$212;
      offset$212 = _tmp$835 - 2;
      _tmp$844 = d$227 / 10;
      _tmp$843 = 48 + _tmp$844;
      d_hi$228 = (uint16_t)_tmp$843;
      _tmp$842 = d$227 % 10;
      _tmp$841 = 48 + _tmp$842;
      d_lo$229 = (uint16_t)_tmp$841;
      _tmp$837 = offset$212;
      _tmp$836 = digit_start$214 + _tmp$837;
      buffer$223[_tmp$836] = d_hi$228;
      _tmp$840 = offset$212;
      _tmp$839 = digit_start$214 + _tmp$840;
      _tmp$838 = _tmp$839 + 1;
      buffer$223[_tmp$838] = d_lo$229;
      continue;
    }
    break;
  }
  _tmp$847 = remaining$225;
  if (_tmp$847 >= 10) {
    int32_t _tmp$848 = offset$212;
    int32_t _tmp$859;
    int32_t _tmp$858;
    int32_t _tmp$857;
    int32_t d_hi$231;
    int32_t _tmp$856;
    int32_t _tmp$855;
    int32_t _tmp$854;
    int32_t d_lo$232;
    int32_t _tmp$850;
    int32_t _tmp$849;
    int32_t _tmp$853;
    int32_t _tmp$852;
    int32_t _tmp$851;
    offset$212 = _tmp$848 - 2;
    _tmp$859 = remaining$225;
    _tmp$858 = _tmp$859 / 10;
    _tmp$857 = 48 + _tmp$858;
    d_hi$231 = (uint16_t)_tmp$857;
    _tmp$856 = remaining$225;
    _tmp$855 = _tmp$856 % 10;
    _tmp$854 = 48 + _tmp$855;
    d_lo$232 = (uint16_t)_tmp$854;
    _tmp$850 = offset$212;
    _tmp$849 = digit_start$214 + _tmp$850;
    buffer$223[_tmp$849] = d_hi$231;
    _tmp$853 = offset$212;
    _tmp$852 = digit_start$214 + _tmp$853;
    _tmp$851 = _tmp$852 + 1;
    buffer$223[_tmp$851] = d_lo$232;
    moonbit_decref(buffer$223);
  } else {
    int32_t _tmp$860 = offset$212;
    int32_t _tmp$865;
    int32_t _tmp$861;
    int32_t _tmp$864;
    int32_t _tmp$863;
    int32_t _tmp$862;
    offset$212 = _tmp$860 - 1;
    _tmp$865 = offset$212;
    _tmp$861 = digit_start$214 + _tmp$865;
    _tmp$864 = remaining$225;
    _tmp$863 = 48 + _tmp$864;
    _tmp$862 = (uint16_t)_tmp$863;
    buffer$223[_tmp$861] = _tmp$862;
    moonbit_decref(buffer$223);
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int_to_string_generic(
  uint16_t* buffer$205,
  uint32_t num$199,
  int32_t digit_start$197,
  int32_t total_len$196,
  int32_t radix$201
) {
  int32_t offset$195 = total_len$196 - digit_start$197;
  uint32_t n$198 = num$199;
  uint32_t base$200 = *(uint32_t*)&radix$201;
  int32_t _tmp$790 = radix$201 - 1;
  int32_t _tmp$789 = radix$201 & _tmp$790;
  if (_tmp$789 == 0) {
    int32_t shift$202 = moonbit_ctz32(radix$201);
    uint32_t mask$203 = base$200 - 1u;
    while (1) {
      uint32_t _tmp$791 = n$198;
      if (_tmp$791 > 0u) {
        int32_t _tmp$792 = offset$195;
        uint32_t _tmp$799;
        uint32_t _tmp$798;
        int32_t digit$204;
        int32_t _tmp$796;
        int32_t _tmp$793;
        int32_t _tmp$795;
        int32_t _tmp$794;
        uint32_t _tmp$797;
        offset$195 = _tmp$792 - 1;
        _tmp$799 = n$198;
        _tmp$798 = _tmp$799 & mask$203;
        digit$204 = *(int32_t*)&_tmp$798;
        _tmp$796 = offset$195;
        _tmp$793 = digit_start$197 + _tmp$796;
        _tmp$795
        = ((moonbit_string_t)moonbit_string_literal_10.data)[
          digit$204
        ];
        _tmp$794 = (uint16_t)_tmp$795;
        buffer$205[_tmp$793] = _tmp$794;
        _tmp$797 = n$198;
        n$198 = _tmp$797 >> (shift$202 & 31);
        continue;
      } else {
        moonbit_decref(buffer$205);
      }
      break;
    }
  } else {
    while (1) {
      uint32_t _tmp$800 = n$198;
      if (_tmp$800 > 0u) {
        int32_t _tmp$801 = offset$195;
        uint32_t _tmp$809;
        uint32_t q$207;
        uint32_t _tmp$807;
        uint32_t _tmp$808;
        uint32_t _tmp$806;
        int32_t digit$208;
        int32_t _tmp$805;
        int32_t _tmp$802;
        int32_t _tmp$804;
        int32_t _tmp$803;
        offset$195 = _tmp$801 - 1;
        _tmp$809 = n$198;
        q$207 = _tmp$809 / base$200;
        _tmp$807 = n$198;
        _tmp$808 = q$207 * base$200;
        _tmp$806 = _tmp$807 - _tmp$808;
        digit$208 = *(int32_t*)&_tmp$806;
        _tmp$805 = offset$195;
        _tmp$802 = digit_start$197 + _tmp$805;
        _tmp$804
        = ((moonbit_string_t)moonbit_string_literal_10.data)[
          digit$208
        ];
        _tmp$803 = (uint16_t)_tmp$804;
        buffer$205[_tmp$802] = _tmp$803;
        n$198 = q$207;
        continue;
      } else {
        moonbit_decref(buffer$205);
      }
      break;
    }
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int_to_string_hex(
  uint16_t* buffer$192,
  uint32_t num$188,
  int32_t digit_start$186,
  int32_t total_len$185
) {
  int32_t offset$184 = total_len$185 - digit_start$186;
  uint32_t n$187 = num$188;
  int32_t _tmp$784;
  while (1) {
    int32_t _tmp$770 = offset$184;
    if (_tmp$770 >= 2) {
      int32_t _tmp$771 = offset$184;
      uint32_t _tmp$783;
      uint32_t _tmp$782;
      int32_t byte_val$189;
      int32_t hi$190;
      int32_t lo$191;
      int32_t _tmp$775;
      int32_t _tmp$772;
      int32_t _tmp$774;
      int32_t _tmp$773;
      int32_t _tmp$780;
      int32_t _tmp$779;
      int32_t _tmp$776;
      int32_t _tmp$778;
      int32_t _tmp$777;
      uint32_t _tmp$781;
      offset$184 = _tmp$771 - 2;
      _tmp$783 = n$187;
      _tmp$782 = _tmp$783 & 255u;
      byte_val$189 = *(int32_t*)&_tmp$782;
      hi$190 = byte_val$189 / 16;
      lo$191 = byte_val$189 % 16;
      _tmp$775 = offset$184;
      _tmp$772 = digit_start$186 + _tmp$775;
      _tmp$774 = ((moonbit_string_t)moonbit_string_literal_10.data)[hi$190];
      _tmp$773 = (uint16_t)_tmp$774;
      buffer$192[_tmp$772] = _tmp$773;
      _tmp$780 = offset$184;
      _tmp$779 = digit_start$186 + _tmp$780;
      _tmp$776 = _tmp$779 + 1;
      _tmp$778 = ((moonbit_string_t)moonbit_string_literal_10.data)[lo$191];
      _tmp$777 = (uint16_t)_tmp$778;
      buffer$192[_tmp$776] = _tmp$777;
      _tmp$781 = n$187;
      n$187 = _tmp$781 >> 8;
      continue;
    }
    break;
  }
  _tmp$784 = offset$184;
  if (_tmp$784 == 1) {
    uint32_t _tmp$788 = n$187;
    uint32_t _tmp$787 = _tmp$788 & 15u;
    int32_t nibble$194 = *(int32_t*)&_tmp$787;
    int32_t _tmp$786 =
      ((moonbit_string_t)moonbit_string_literal_10.data)[nibble$194];
    int32_t _tmp$785 = (uint16_t)_tmp$786;
    buffer$192[digit_start$186] = _tmp$785;
    moonbit_decref(buffer$192);
  } else {
    moonbit_decref(buffer$192);
  }
  return 0;
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  moonbit_string_t self$183
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$182 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$769;
  moonbit_incref(logger$182);
  _tmp$769
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$182
  };
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
    self$183, _tmp$769
  );
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$182);
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  int32_t self$181
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$180 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$768;
  moonbit_incref(logger$180);
  _tmp$768
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$180
  };
  $$moonbitlang$core$builtin$Show$$Int$$output(self$181, _tmp$768);
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$180);
}

int32_t $StringView$$start_offset(struct $StringView self$179) {
  int32_t _field$959 = self$179.$1;
  moonbit_decref(self$179.$0);
  return _field$959;
}

moonbit_string_t $StringView$$data(struct $StringView self$178) {
  moonbit_string_t _field$960 = self$178.$0;
  return _field$960;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$172,
  moonbit_string_t value$175,
  int32_t start$176,
  int32_t len$177
) {
  void* _try_err$174;
  struct $StringView _tmp$763;
  int32_t _tmp$765 = start$176 + len$177;
  int64_t _tmp$764 = (int64_t)_tmp$765;
  struct moonbit_result_0 _tmp$1042 =
    $String$$sub$inner(value$175, start$176, _tmp$764);
  if (_tmp$1042.tag) {
    struct $StringView const _ok$766 = _tmp$1042.data.ok;
    _tmp$763 = _ok$766;
  } else {
    void* const _err$767 = _tmp$1042.data.err;
    _try_err$174 = _err$767;
    goto $join$173;
  }
  goto $joinlet$1041;
  $join$173:;
  moonbit_decref(_try_err$174);
  moonbit_panic();
  $joinlet$1041:;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    self$172, _tmp$763
  );
  return 0;
}

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$165,
  int32_t start$171,
  int64_t end$167
) {
  int32_t len$164 = Moonbit_array_length(self$165);
  int32_t end$166;
  int32_t start$170;
  if (end$167 == 4294967296ll) {
    end$166 = len$164;
  } else {
    int64_t _Some$168 = end$167;
    int32_t _end$169 = (int32_t)_Some$168;
    if (_end$169 < 0) {
      end$166 = len$164 + _end$169;
    } else {
      end$166 = _end$169;
    }
  }
  if (start$171 < 0) {
    start$170 = len$164 + start$171;
  } else {
    start$170 = start$171;
  }
  if (start$170 >= 0 && start$170 <= end$166 && end$166 <= len$164) {
    int32_t _if_result$1043;
    int32_t _if_result$1045;
    struct $StringView _tmp$761;
    struct moonbit_result_0 _result$1047;
    if (start$170 < len$164) {
      int32_t _p$431 = self$165[start$170];
      _if_result$1043 = 56320 <= _p$431 && _p$431 <= 57343;
    } else {
      _if_result$1043 = 0;
    }
    if (_if_result$1043) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$759;
      struct moonbit_result_0 _result$1044;
      moonbit_decref(self$165);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$759
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$1044.tag = 0;
      _result$1044.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$759;
      return _result$1044;
    }
    if (end$166 < len$164) {
      int32_t _p$434 = self$165[end$166];
      _if_result$1045 = 56320 <= _p$434 && _p$434 <= 57343;
    } else {
      _if_result$1045 = 0;
    }
    if (_if_result$1045) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$760;
      struct moonbit_result_0 _result$1046;
      moonbit_decref(self$165);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$760
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$1046.tag = 0;
      _result$1046.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$760;
      return _result$1046;
    }
    _tmp$761 = (struct $StringView){start$170, end$166, self$165};
    _result$1047.tag = 1;
    _result$1047.data.ok = _tmp$761;
    return _result$1047;
  } else {
    void* moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$762;
    struct moonbit_result_0 _result$1048;
    moonbit_decref(self$165);
    moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$762
    = (struct moonbit_object*)&moonbit_constant_constructor_1 + 1;
    _result$1048.tag = 0;
    _result$1048.data.err
    = moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$762;
    return _result$1048;
  }
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$162,
  moonbit_string_t str$163
) {
  int32_t len$749 = self$162->$1;
  int32_t _tmp$751 = Moonbit_array_length(str$163);
  int32_t _tmp$750 = _tmp$751 * 2;
  int32_t _tmp$748 = len$749 + _tmp$750;
  moonbit_bytes_t _field$962;
  moonbit_bytes_t data$752;
  int32_t len$753;
  int32_t _tmp$754;
  int32_t len$756;
  int32_t _tmp$961;
  int32_t _tmp$758;
  int32_t _tmp$757;
  int32_t _tmp$755;
  moonbit_incref(self$162);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$162, _tmp$748
  );
  _field$962 = self$162->$0;
  data$752 = _field$962;
  len$753 = self$162->$1;
  _tmp$754 = Moonbit_array_length(str$163);
  moonbit_incref(data$752);
  moonbit_incref(str$163);
  $FixedArray$$blit_from_string(data$752, len$753, str$163, 0, _tmp$754);
  len$756 = self$162->$1;
  _tmp$961 = Moonbit_array_length(str$163);
  moonbit_decref(str$163);
  _tmp$758 = _tmp$961;
  _tmp$757 = _tmp$758 * 2;
  _tmp$755 = len$756 + _tmp$757;
  self$162->$1 = _tmp$755;
  moonbit_decref(self$162);
  return 0;
}

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$154,
  int32_t bytes_offset$149,
  moonbit_string_t str$156,
  int32_t str_offset$152,
  int32_t length$150
) {
  int32_t _tmp$747 = length$150 * 2;
  int32_t _tmp$746 = bytes_offset$149 + _tmp$747;
  int32_t e1$148 = _tmp$746 - 1;
  int32_t _tmp$745 = str_offset$152 + length$150;
  int32_t e2$151 = _tmp$745 - 1;
  int32_t len1$153 = Moonbit_array_length(self$154);
  int32_t len2$155 = Moonbit_array_length(str$156);
  if (
    length$150 >= 0
    && bytes_offset$149 >= 0
    && e1$148 < len1$153
    && str_offset$152 >= 0
    && e2$151 < len2$155
  ) {
    int32_t end_str_offset$157 = str_offset$152 + length$150;
    int32_t i$158 = str_offset$152;
    int32_t j$159 = bytes_offset$149;
    while (1) {
      if (i$158 < end_str_offset$157) {
        int32_t _tmp$742 = str$156[i$158];
        uint32_t c$160 = *(uint32_t*)&_tmp$742;
        uint32_t _p$425 = c$160 & 255u;
        int32_t _tmp$738 = *(int32_t*)&_p$425;
        int32_t _tmp$737 = _tmp$738 & 0xff;
        int32_t _tmp$739;
        uint32_t _p$428;
        int32_t _tmp$741;
        int32_t _tmp$740;
        int32_t _tmp$743;
        int32_t _tmp$744;
        if (j$159 < 0 || j$159 >= Moonbit_array_length(self$154)) {
          moonbit_panic();
        }
        self$154[j$159] = _tmp$737;
        _tmp$739 = j$159 + 1;
        _p$428 = c$160 >> 8;
        _tmp$741 = *(int32_t*)&_p$428;
        _tmp$740 = _tmp$741 & 0xff;
        if (_tmp$739 < 0 || _tmp$739 >= Moonbit_array_length(self$154)) {
          moonbit_panic();
        }
        self$154[_tmp$739] = _tmp$740;
        _tmp$743 = i$158 + 1;
        _tmp$744 = j$159 + 2;
        i$158 = _tmp$743;
        j$159 = _tmp$744;
        continue;
      } else {
        moonbit_decref(str$156);
        moonbit_decref(self$154);
      }
      break;
    }
  } else {
    moonbit_decref(str$156);
    moonbit_decref(self$154);
    moonbit_panic();
  }
  return 0;
}

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$116
) {
  int32_t _tmp$706 = Moonbit_array_length(repr$116);
  int64_t _tmp$705 = (int64_t)_tmp$706;
  moonbit_incref(repr$116);
  if ($String$$char_length_ge$inner(repr$116, 1, 0, _tmp$705)) {
    int32_t _tmp$736 = repr$116[0];
    int32_t _x$117 = _tmp$736;
    if (_x$117 == 64) {
      int32_t _tmp$735 = Moonbit_array_length(repr$116);
      int64_t _tmp$734 = (int64_t)_tmp$735;
      int64_t _bind$323;
      int32_t _tmp$732;
      int32_t _tmp$733;
      struct $StringView _x$118;
      int32_t _tmp$731;
      struct $StringView _tmp$730;
      int64_t _bind$120;
      moonbit_incref(repr$116);
      _bind$323 = $String$$offset_of_nth_char$inner(repr$116, 1, 0, _tmp$734);
      if (_bind$323 == 4294967296ll) {
        _tmp$732 = Moonbit_array_length(repr$116);
      } else {
        int64_t _Some$119 = _bind$323;
        _tmp$732 = (int32_t)_Some$119;
      }
      _tmp$733 = Moonbit_array_length(repr$116);
      _x$118 = (struct $StringView){_tmp$732, _tmp$733, repr$116};
      _tmp$731
      = Moonbit_array_length(
        $moonbitlang$core$builtin$parse$$2a$bind$7c$5443
      );
      moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5443);
      _tmp$730
      = (struct $StringView){
        0, _tmp$731, $moonbitlang$core$builtin$parse$$2a$bind$7c$5443
      };
      moonbit_incref(_x$118.$0);
      _bind$120 = $StringView$$find(_x$118, _tmp$730);
      if (_bind$120 == 4294967296ll) {
        moonbit_decref(_x$118.$0);
        moonbit_panic();
      } else {
        int64_t _Some$121 = _bind$120;
        int32_t _pkg_end$122 = (int32_t)_Some$121;
        int64_t _tmp$729 = (int64_t)_pkg_end$122;
        struct $StringView pkg$123;
        int32_t _tmp$728;
        struct $StringView _tmp$727;
        int64_t _bind$124;
        moonbit_incref(_x$118.$0);
        pkg$123 = $StringView$$view$inner(_x$118, 0, _tmp$729);
        _tmp$728
        = Moonbit_array_length(
          $moonbitlang$core$builtin$parse$$2a$bind$7c$5437
        );
        moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5437);
        _tmp$727
        = (struct $StringView){
          0, _tmp$728, $moonbitlang$core$builtin$parse$$2a$bind$7c$5437
        };
        moonbit_incref(_x$118.$0);
        _bind$124 = $StringView$$rev_find(_x$118, _tmp$727);
        if (_bind$124 == 4294967296ll) {
          moonbit_decref(pkg$123.$0);
          moonbit_decref(_x$118.$0);
          moonbit_panic();
        } else {
          int64_t _Some$125 = _bind$124;
          int32_t _start_loc_end$126 = (int32_t)_Some$125;
          int32_t _tmp$707 = _start_loc_end$126 + 1;
          int32_t end$709 = _x$118.$2;
          int32_t start$710 = _x$118.$1;
          int32_t _tmp$708 = end$709 - start$710;
          if (_tmp$707 < _tmp$708) {
            int32_t _tmp$726 = _start_loc_end$126 + 1;
            struct $StringView end_loc$127;
            struct $$3c$StringView$2a$StringView$3e$* _bind$128;
            moonbit_incref(_x$118.$0);
            end_loc$127
            = $StringView$$view$inner(
              _x$118, _tmp$726, 4294967296ll
            );
            _bind$128
            = $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
              end_loc$127
            );
            if (_bind$128 == 0) {
              if (_bind$128) {
                moonbit_decref(_bind$128);
              }
              moonbit_decref(pkg$123.$0);
              moonbit_decref(_x$118.$0);
              moonbit_panic();
            } else {
              struct $$3c$StringView$2a$StringView$3e$* _Some$129 = _bind$128;
              struct $$3c$StringView$2a$StringView$3e$* _x$130 = _Some$129;
              struct $StringView _field$966 =
                (struct $StringView){
                  _x$130->$0_1, _x$130->$0_2, _x$130->$0_0
                };
              struct $StringView _end_line$131 = _field$966;
              struct $StringView _field$965 =
                (struct $StringView){
                  _x$130->$1_1, _x$130->$1_2, _x$130->$1_0
                };
              int32_t _cnt$1023 = Moonbit_object_header(_x$130)->rc;
              struct $StringView _end_column$132;
              int64_t _tmp$725;
              struct $StringView rest$133;
              int32_t _tmp$724;
              struct $StringView _tmp$723;
              int64_t _bind$135;
              if (_cnt$1023 > 1) {
                int32_t _new_cnt$1024;
                moonbit_incref(_field$965.$0);
                moonbit_incref(_end_line$131.$0);
                _new_cnt$1024 = _cnt$1023 - 1;
                Moonbit_object_header(_x$130)->rc = _new_cnt$1024;
              } else if (_cnt$1023 == 1) {
                moonbit_free(_x$130);
              }
              _end_column$132 = _field$965;
              _tmp$725 = (int64_t)_start_loc_end$126;
              rest$133 = $StringView$$view$inner(_x$118, 0, _tmp$725);
              _tmp$724
              = Moonbit_array_length(
                $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              );
              moonbit_incref(
                $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              );
              _tmp$723
              = (struct $StringView){
                0, _tmp$724, $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              };
              moonbit_incref(rest$133.$0);
              _bind$135 = $StringView$$rev_find(rest$133, _tmp$723);
              if (_bind$135 == 4294967296ll) {
                moonbit_decref(rest$133.$0);
                moonbit_decref(_end_column$132.$0);
                moonbit_decref(_end_line$131.$0);
                moonbit_decref(pkg$123.$0);
                goto $join$134;
              } else {
                int64_t _Some$136 = _bind$135;
                int32_t _start_line_end$137 = (int32_t)_Some$136;
                int64_t _tmp$722 = (int64_t)_start_line_end$137;
                struct $StringView _tmp$719;
                int32_t _tmp$721;
                struct $StringView _tmp$720;
                int64_t _bind$138;
                moonbit_incref(rest$133.$0);
                _tmp$719 = $StringView$$view$inner(rest$133, 0, _tmp$722);
                _tmp$721
                = Moonbit_array_length(
                  $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                );
                moonbit_incref(
                  $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                );
                _tmp$720
                = (struct $StringView){
                  0,
                    _tmp$721,
                    $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                };
                _bind$138 = $StringView$$rev_find(_tmp$719, _tmp$720);
                if (_bind$138 == 4294967296ll) {
                  moonbit_decref(rest$133.$0);
                  moonbit_decref(_end_column$132.$0);
                  moonbit_decref(_end_line$131.$0);
                  moonbit_decref(pkg$123.$0);
                  goto $join$134;
                } else {
                  int64_t _Some$139 = _bind$138;
                  int32_t _filename_end$140 = (int32_t)_Some$139;
                  int32_t _tmp$711 = _filename_end$140 + 1;
                  int32_t end$713 = rest$133.$2;
                  int32_t start$714 = rest$133.$1;
                  int32_t _tmp$712 = end$713 - start$714;
                  if (_tmp$711 < _tmp$712) {
                    int32_t _tmp$718 = _filename_end$140 + 1;
                    struct $StringView start_loc$141;
                    struct $$3c$StringView$2a$StringView$3e$* _bind$142;
                    moonbit_incref(rest$133.$0);
                    start_loc$141
                    = $StringView$$view$inner(
                      rest$133, _tmp$718, 4294967296ll
                    );
                    _bind$142
                    = $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
                      start_loc$141
                    );
                    if (_bind$142 == 0) {
                      if (_bind$142) {
                        moonbit_decref(_bind$142);
                      }
                      moonbit_decref(rest$133.$0);
                      moonbit_decref(_end_column$132.$0);
                      moonbit_decref(_end_line$131.$0);
                      moonbit_decref(pkg$123.$0);
                      moonbit_panic();
                    } else {
                      struct $$3c$StringView$2a$StringView$3e$* _Some$143 =
                        _bind$142;
                      struct $$3c$StringView$2a$StringView$3e$* _x$144 =
                        _Some$143;
                      struct $StringView _field$964 =
                        (struct $StringView){
                          _x$144->$0_1, _x$144->$0_2, _x$144->$0_0
                        };
                      struct $StringView _start_line$145 = _field$964;
                      struct $StringView _field$963 =
                        (struct $StringView){
                          _x$144->$1_1, _x$144->$1_2, _x$144->$1_0
                        };
                      int32_t _cnt$1025 = Moonbit_object_header(_x$144)->rc;
                      struct $StringView _start_column$146;
                      int32_t _tmp$715;
                      if (_cnt$1025 > 1) {
                        int32_t _new_cnt$1026;
                        moonbit_incref(_field$963.$0);
                        moonbit_incref(_start_line$145.$0);
                        _new_cnt$1026 = _cnt$1025 - 1;
                        Moonbit_object_header(_x$144)->rc = _new_cnt$1026;
                      } else if (_cnt$1025 == 1) {
                        moonbit_free(_x$144);
                      }
                      _start_column$146 = _field$963;
                      _tmp$715 = _pkg_end$122 + 1;
                      if (_filename_end$140 > _tmp$715) {
                        int32_t _tmp$716 = _pkg_end$122 + 1;
                        int64_t _tmp$717 = (int64_t)_filename_end$140;
                        struct $StringView filename$147 =
                          $StringView$$view$inner(
                            rest$133, _tmp$716, _tmp$717
                          );
                        struct $$moonbitlang$core$builtin$SourceLocRepr* _block$1052 =
                          (struct $$moonbitlang$core$builtin$SourceLocRepr*)moonbit_malloc(
                            sizeof(
                              struct $$moonbitlang$core$builtin$SourceLocRepr
                            )
                          );
                        Moonbit_object_header(_block$1052)->meta
                        = Moonbit_make_regular_object_header(
                          offsetof(
                            struct $$moonbitlang$core$builtin$SourceLocRepr,
                              $0_0
                          )
                          >> 2,
                            6,
                            0
                        );
                        _block$1052->$0_0 = pkg$123.$0;
                        _block$1052->$0_1 = pkg$123.$1;
                        _block$1052->$0_2 = pkg$123.$2;
                        _block$1052->$1_0 = filename$147.$0;
                        _block$1052->$1_1 = filename$147.$1;
                        _block$1052->$1_2 = filename$147.$2;
                        _block$1052->$2_0 = _start_line$145.$0;
                        _block$1052->$2_1 = _start_line$145.$1;
                        _block$1052->$2_2 = _start_line$145.$2;
                        _block$1052->$3_0 = _start_column$146.$0;
                        _block$1052->$3_1 = _start_column$146.$1;
                        _block$1052->$3_2 = _start_column$146.$2;
                        _block$1052->$4_0 = _end_line$131.$0;
                        _block$1052->$4_1 = _end_line$131.$1;
                        _block$1052->$4_2 = _end_line$131.$2;
                        _block$1052->$5_0 = _end_column$132.$0;
                        _block$1052->$5_1 = _end_column$132.$1;
                        _block$1052->$5_2 = _end_column$132.$2;
                        return _block$1052;
                      } else {
                        moonbit_decref(_start_column$146.$0);
                        moonbit_decref(_start_line$145.$0);
                        moonbit_decref(rest$133.$0);
                        moonbit_decref(_end_column$132.$0);
                        moonbit_decref(_end_line$131.$0);
                        moonbit_decref(pkg$123.$0);
                        moonbit_panic();
                      }
                    }
                  } else {
                    moonbit_decref(rest$133.$0);
                    moonbit_decref(_end_column$132.$0);
                    moonbit_decref(_end_line$131.$0);
                    moonbit_decref(pkg$123.$0);
                    moonbit_panic();
                  }
                }
              }
              $join$134:;
              moonbit_panic();
            }
          } else {
            moonbit_decref(pkg$123.$0);
            moonbit_decref(_x$118.$0);
            moonbit_panic();
          }
        }
      }
    } else {
      moonbit_decref(repr$116);
      goto $join$115;
    }
  } else {
    moonbit_decref(repr$116);
    goto $join$115;
  }
  $join$115:;
  moonbit_panic();
}

struct $$3c$StringView$2a$StringView$3e$* $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
  struct $StringView view$112
) {
  int32_t _tmp$704 =
    Moonbit_array_length($moonbitlang$core$builtin$parse$$2a$bind$7c$5404);
  struct $StringView _tmp$703;
  int64_t _bind$111;
  moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5404);
  _tmp$703
  = (struct $StringView){
    0, _tmp$704, $moonbitlang$core$builtin$parse$$2a$bind$7c$5404
  };
  moonbit_incref(view$112.$0);
  _bind$111 = $StringView$$find(view$112, _tmp$703);
  if (_bind$111 == 4294967296ll) {
    moonbit_decref(view$112.$0);
    return 0;
  } else {
    int64_t _Some$113 = _bind$111;
    int32_t _i$114 = (int32_t)_Some$113;
    int32_t _if_result$1053;
    if (_i$114 > 0) {
      int32_t _tmp$694 = _i$114 + 1;
      int32_t end$696 = view$112.$2;
      int32_t start$697 = view$112.$1;
      int32_t _tmp$695 = end$696 - start$697;
      _if_result$1053 = _tmp$694 < _tmp$695;
    } else {
      _if_result$1053 = 0;
    }
    if (_if_result$1053) {
      int64_t _tmp$702 = (int64_t)_i$114;
      struct $StringView _tmp$699;
      int32_t _tmp$701;
      struct $StringView _tmp$700;
      struct $$3c$StringView$2a$StringView$3e$* _tuple$698;
      moonbit_incref(view$112.$0);
      _tmp$699 = $StringView$$view$inner(view$112, 0, _tmp$702);
      _tmp$701 = _i$114 + 1;
      _tmp$700 = $StringView$$view$inner(view$112, _tmp$701, 4294967296ll);
      _tuple$698
      = (struct $$3c$StringView$2a$StringView$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$StringView$3e$)
        );
      Moonbit_object_header(_tuple$698)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $$3c$StringView$2a$StringView$3e$, $0_0) >> 2, 2, 0
      );
      _tuple$698->$0_0 = _tmp$699.$0;
      _tuple$698->$0_1 = _tmp$699.$1;
      _tuple$698->$0_2 = _tmp$699.$2;
      _tuple$698->$1_0 = _tmp$700.$0;
      _tuple$698->$1_1 = _tmp$700.$1;
      _tuple$698->$1_2 = _tmp$700.$2;
      return _tuple$698;
    } else {
      moonbit_decref(view$112.$0);
      return 0;
    }
  }
}

struct $StringView $StringView$$view$inner(
  struct $StringView self$109,
  int32_t start_offset$110,
  int64_t end_offset$107
) {
  int32_t end_offset$106;
  int32_t _if_result$1054;
  if (end_offset$107 == 4294967296ll) {
    int32_t end$692 = self$109.$2;
    int32_t start$693 = self$109.$1;
    end_offset$106 = end$692 - start$693;
  } else {
    int64_t _Some$108 = end_offset$107;
    end_offset$106 = (int32_t)_Some$108;
  }
  if (start_offset$110 >= 0) {
    if (start_offset$110 <= end_offset$106) {
      int32_t end$685 = self$109.$2;
      int32_t start$686 = self$109.$1;
      int32_t _tmp$684 = end$685 - start$686;
      _if_result$1054 = end_offset$106 <= _tmp$684;
    } else {
      _if_result$1054 = 0;
    }
  } else {
    _if_result$1054 = 0;
  }
  if (_if_result$1054) {
    moonbit_string_t _field$968 = self$109.$0;
    moonbit_string_t str$687 = _field$968;
    int32_t start$691 = self$109.$1;
    int32_t _tmp$688 = start$691 + start_offset$110;
    int32_t _field$967 = self$109.$1;
    int32_t start$690 = _field$967;
    int32_t _tmp$689 = start$690 + end_offset$106;
    return (struct $StringView){_tmp$688, _tmp$689, str$687};
  } else {
    moonbit_decref(self$109.$0);
    return $moonbitlang$core$builtin$abort$2(
             (moonbit_string_t)moonbit_string_literal_11.data,
               (moonbit_string_t)moonbit_string_literal_12.data
           );
  }
}

int64_t $StringView$$rev_find(
  struct $StringView self$105,
  struct $StringView str$104
) {
  int32_t end$682 = str$104.$2;
  int32_t start$683 = str$104.$1;
  int32_t _tmp$681 = end$682 - start$683;
  if (_tmp$681 <= 4) {
    return $moonbitlang$core$builtin$brute_force_rev_find(self$105, str$104);
  } else {
    return $moonbitlang$core$builtin$boyer_moore_horspool_rev_find(
             self$105, str$104
           );
  }
}

int64_t $moonbitlang$core$builtin$brute_force_rev_find(
  struct $StringView haystack$95,
  struct $StringView needle$97
) {
  int32_t end$679 = haystack$95.$2;
  int32_t start$680 = haystack$95.$1;
  int32_t haystack_len$94 = end$679 - start$680;
  int32_t end$677 = needle$97.$2;
  int32_t start$678 = needle$97.$1;
  int32_t needle_len$96 = end$677 - start$678;
  if (needle_len$96 > 0) {
    if (haystack_len$94 >= needle_len$96) {
      int32_t _p$402 = 0;
      moonbit_string_t _field$976 = needle$97.$0;
      moonbit_string_t str$674 = _field$976;
      int32_t start$676 = needle$97.$1;
      int32_t _tmp$675 = start$676 + _p$402;
      int32_t _tmp$975 = str$674[_tmp$675];
      int32_t needle_first$98 = _tmp$975;
      int32_t i$99 = haystack_len$94 - needle_len$96;
      while (1) {
        int32_t _tmp$654 = i$99;
        if (_tmp$654 >= 0) {
          int32_t _tmp$661;
          while (1) {
            int32_t _tmp$659 = i$99;
            int32_t _if_result$1057;
            if (_tmp$659 >= 0) {
              int32_t _p$405 = i$99;
              moonbit_string_t _field$974 = haystack$95.$0;
              moonbit_string_t str$656 = _field$974;
              int32_t start$658 = haystack$95.$1;
              int32_t _tmp$657 = start$658 + _p$405;
              int32_t _tmp$973 = str$656[_tmp$657];
              int32_t _tmp$655 = _tmp$973;
              _if_result$1057 = _tmp$655 != needle_first$98;
            } else {
              _if_result$1057 = 0;
            }
            if (_if_result$1057) {
              int32_t _tmp$660 = i$99;
              i$99 = _tmp$660 - 1;
              continue;
            }
            break;
          }
          _tmp$661 = i$99;
          if (_tmp$661 >= 0) {
            int32_t j$101 = 1;
            int32_t _tmp$673;
            while (1) {
              if (j$101 < needle_len$96) {
                int32_t _tmp$670 = i$99;
                int32_t _p$408 = _tmp$670 + j$101;
                moonbit_string_t _field$972 = haystack$95.$0;
                moonbit_string_t str$667 = _field$972;
                int32_t start$669 = haystack$95.$1;
                int32_t _tmp$668 = start$669 + _p$408;
                int32_t _tmp$971 = str$667[_tmp$668];
                int32_t _tmp$662 = _tmp$971;
                moonbit_string_t _field$970 = needle$97.$0;
                moonbit_string_t str$664 = _field$970;
                int32_t start$666 = needle$97.$1;
                int32_t _tmp$665 = start$666 + j$101;
                int32_t _tmp$969 = str$664[_tmp$665];
                int32_t _tmp$663 = _tmp$969;
                int32_t _tmp$671;
                if (_tmp$662 != _tmp$663) {
                  break;
                }
                _tmp$671 = j$101 + 1;
                j$101 = _tmp$671;
                continue;
              } else {
                int32_t _tmp$672;
                moonbit_decref(needle$97.$0);
                moonbit_decref(haystack$95.$0);
                _tmp$672 = i$99;
                return (int64_t)_tmp$672;
              }
              break;
            }
            _tmp$673 = i$99;
            i$99 = _tmp$673 - 1;
          }
          continue;
        } else {
          moonbit_decref(needle$97.$0);
          moonbit_decref(haystack$95.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$97.$0);
      moonbit_decref(haystack$95.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$97.$0);
    moonbit_decref(haystack$95.$0);
    return (int64_t)haystack_len$94;
  }
}

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_rev_find(
  struct $StringView haystack$84,
  struct $StringView needle$86
) {
  int32_t end$652 = haystack$84.$2;
  int32_t start$653 = haystack$84.$1;
  int32_t haystack_len$83 = end$652 - start$653;
  int32_t end$650 = needle$86.$2;
  int32_t start$651 = needle$86.$1;
  int32_t needle_len$85 = end$650 - start$651;
  if (needle_len$85 > 0) {
    if (haystack_len$83 >= needle_len$85) {
      int32_t* skip_table$87 =
        (int32_t*)moonbit_make_int32_array(256, needle_len$85);
      int32_t _tmp$632 = needle_len$85 - 1;
      int32_t i$88 = _tmp$632;
      int32_t _tmp$649;
      int32_t i$90;
      while (1) {
        if (i$88 > 0) {
          moonbit_string_t _field$984 = needle$86.$0;
          moonbit_string_t str$628 = _field$984;
          int32_t start$630 = needle$86.$1;
          int32_t _tmp$629 = start$630 + i$88;
          int32_t _tmp$983 = str$628[_tmp$629];
          int32_t _tmp$627 = _tmp$983;
          int32_t _tmp$626 = _tmp$627 & 255;
          int32_t _tmp$631;
          if (
            _tmp$626 < 0 || _tmp$626 >= Moonbit_array_length(skip_table$87)
          ) {
            moonbit_panic();
          }
          skip_table$87[_tmp$626] = i$88;
          _tmp$631 = i$88 - 1;
          i$88 = _tmp$631;
          continue;
        }
        break;
      }
      _tmp$649 = haystack_len$83 - needle_len$85;
      i$90 = _tmp$649;
      while (1) {
        if (i$90 >= 0) {
          int32_t j$91 = 0;
          moonbit_string_t _field$978;
          moonbit_string_t str$646;
          int32_t start$648;
          int32_t _tmp$647;
          int32_t _tmp$977;
          int32_t _tmp$645;
          int32_t _tmp$644;
          int32_t _tmp$643;
          int32_t _tmp$642;
          while (1) {
            if (j$91 < needle_len$85) {
              int32_t _p$391 = i$90 + j$91;
              moonbit_string_t _field$982 = haystack$84.$0;
              moonbit_string_t str$638 = _field$982;
              int32_t start$640 = haystack$84.$1;
              int32_t _tmp$639 = start$640 + _p$391;
              int32_t _tmp$981 = str$638[_tmp$639];
              int32_t _tmp$633 = _tmp$981;
              moonbit_string_t _field$980 = needle$86.$0;
              moonbit_string_t str$635 = _field$980;
              int32_t start$637 = needle$86.$1;
              int32_t _tmp$636 = start$637 + j$91;
              int32_t _tmp$979 = str$635[_tmp$636];
              int32_t _tmp$634 = _tmp$979;
              int32_t _tmp$641;
              if (_tmp$633 != _tmp$634) {
                break;
              }
              _tmp$641 = j$91 + 1;
              j$91 = _tmp$641;
              continue;
            } else {
              moonbit_decref(skip_table$87);
              moonbit_decref(needle$86.$0);
              moonbit_decref(haystack$84.$0);
              return (int64_t)i$90;
            }
            break;
          }
          _field$978 = haystack$84.$0;
          str$646 = _field$978;
          start$648 = haystack$84.$1;
          _tmp$647 = start$648 + i$90;
          _tmp$977 = str$646[_tmp$647];
          _tmp$645 = _tmp$977;
          _tmp$644 = _tmp$645 & 255;
          if (
            _tmp$644 < 0 || _tmp$644 >= Moonbit_array_length(skip_table$87)
          ) {
            moonbit_panic();
          }
          _tmp$643 = (int32_t)skip_table$87[_tmp$644];
          _tmp$642 = i$90 - _tmp$643;
          i$90 = _tmp$642;
          continue;
        } else {
          moonbit_decref(skip_table$87);
          moonbit_decref(needle$86.$0);
          moonbit_decref(haystack$84.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$86.$0);
      moonbit_decref(haystack$84.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$86.$0);
    moonbit_decref(haystack$84.$0);
    return (int64_t)haystack_len$83;
  }
}

int64_t $StringView$$find(
  struct $StringView self$82,
  struct $StringView str$81
) {
  int32_t end$624 = str$81.$2;
  int32_t start$625 = str$81.$1;
  int32_t _tmp$623 = end$624 - start$625;
  if (_tmp$623 <= 4) {
    return $moonbitlang$core$builtin$brute_force_find(self$82, str$81);
  } else {
    return $moonbitlang$core$builtin$boyer_moore_horspool_find(
             self$82, str$81
           );
  }
}

int64_t $moonbitlang$core$builtin$brute_force_find(
  struct $StringView haystack$71,
  struct $StringView needle$73
) {
  int32_t end$621 = haystack$71.$2;
  int32_t start$622 = haystack$71.$1;
  int32_t haystack_len$70 = end$621 - start$622;
  int32_t end$619 = needle$73.$2;
  int32_t start$620 = needle$73.$1;
  int32_t needle_len$72 = end$619 - start$620;
  if (needle_len$72 > 0) {
    if (haystack_len$70 >= needle_len$72) {
      int32_t _p$372 = 0;
      moonbit_string_t _field$992 = needle$73.$0;
      moonbit_string_t str$616 = _field$992;
      int32_t start$618 = needle$73.$1;
      int32_t _tmp$617 = start$618 + _p$372;
      int32_t _tmp$991 = str$616[_tmp$617];
      int32_t needle_first$74 = _tmp$991;
      int32_t forward_len$75 = haystack_len$70 - needle_len$72;
      int32_t i$76 = 0;
      while (1) {
        int32_t _tmp$596 = i$76;
        if (_tmp$596 <= forward_len$75) {
          int32_t _tmp$603;
          while (1) {
            int32_t _tmp$601 = i$76;
            int32_t _if_result$1064;
            if (_tmp$601 <= forward_len$75) {
              int32_t _p$375 = i$76;
              moonbit_string_t _field$990 = haystack$71.$0;
              moonbit_string_t str$598 = _field$990;
              int32_t start$600 = haystack$71.$1;
              int32_t _tmp$599 = start$600 + _p$375;
              int32_t _tmp$989 = str$598[_tmp$599];
              int32_t _tmp$597 = _tmp$989;
              _if_result$1064 = _tmp$597 != needle_first$74;
            } else {
              _if_result$1064 = 0;
            }
            if (_if_result$1064) {
              int32_t _tmp$602 = i$76;
              i$76 = _tmp$602 + 1;
              continue;
            }
            break;
          }
          _tmp$603 = i$76;
          if (_tmp$603 <= forward_len$75) {
            int32_t j$78 = 1;
            int32_t _tmp$615;
            while (1) {
              if (j$78 < needle_len$72) {
                int32_t _tmp$612 = i$76;
                int32_t _p$378 = _tmp$612 + j$78;
                moonbit_string_t _field$988 = haystack$71.$0;
                moonbit_string_t str$609 = _field$988;
                int32_t start$611 = haystack$71.$1;
                int32_t _tmp$610 = start$611 + _p$378;
                int32_t _tmp$987 = str$609[_tmp$610];
                int32_t _tmp$604 = _tmp$987;
                moonbit_string_t _field$986 = needle$73.$0;
                moonbit_string_t str$606 = _field$986;
                int32_t start$608 = needle$73.$1;
                int32_t _tmp$607 = start$608 + j$78;
                int32_t _tmp$985 = str$606[_tmp$607];
                int32_t _tmp$605 = _tmp$985;
                int32_t _tmp$613;
                if (_tmp$604 != _tmp$605) {
                  break;
                }
                _tmp$613 = j$78 + 1;
                j$78 = _tmp$613;
                continue;
              } else {
                int32_t _tmp$614;
                moonbit_decref(needle$73.$0);
                moonbit_decref(haystack$71.$0);
                _tmp$614 = i$76;
                return (int64_t)_tmp$614;
              }
              break;
            }
            _tmp$615 = i$76;
            i$76 = _tmp$615 + 1;
          }
          continue;
        } else {
          moonbit_decref(needle$73.$0);
          moonbit_decref(haystack$71.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$73.$0);
      moonbit_decref(haystack$71.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$73.$0);
    moonbit_decref(haystack$71.$0);
    return $moonbitlang$core$builtin$brute_force_find$constr$69;
  }
}

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_find(
  struct $StringView haystack$57,
  struct $StringView needle$59
) {
  int32_t end$594 = haystack$57.$2;
  int32_t start$595 = haystack$57.$1;
  int32_t haystack_len$56 = end$594 - start$595;
  int32_t end$592 = needle$59.$2;
  int32_t start$593 = needle$59.$1;
  int32_t needle_len$58 = end$592 - start$593;
  if (needle_len$58 > 0) {
    if (haystack_len$56 >= needle_len$58) {
      int32_t* skip_table$60 =
        (int32_t*)moonbit_make_int32_array(256, needle_len$58);
      int32_t _end4301$61 = needle_len$58 - 1;
      int32_t i$62 = 0;
      int32_t i$64;
      while (1) {
        if (i$62 < _end4301$61) {
          moonbit_string_t _field$1000 = needle$59.$0;
          moonbit_string_t str$570 = _field$1000;
          int32_t start$572 = needle$59.$1;
          int32_t _tmp$571 = start$572 + i$62;
          int32_t _tmp$999 = str$570[_tmp$571];
          int32_t _tmp$569 = _tmp$999;
          int32_t _tmp$566 = _tmp$569 & 255;
          int32_t _tmp$568 = needle_len$58 - 1;
          int32_t _tmp$567 = _tmp$568 - i$62;
          int32_t _tmp$573;
          if (
            _tmp$566 < 0 || _tmp$566 >= Moonbit_array_length(skip_table$60)
          ) {
            moonbit_panic();
          }
          skip_table$60[_tmp$566] = _tmp$567;
          _tmp$573 = i$62 + 1;
          i$62 = _tmp$573;
          continue;
        }
        break;
      }
      i$64 = 0;
      while (1) {
        int32_t _tmp$574 = haystack_len$56 - needle_len$58;
        if (i$64 <= _tmp$574) {
          int32_t _end4307$65 = needle_len$58 - 1;
          int32_t j$66 = 0;
          int32_t _tmp$591;
          int32_t _p$365;
          moonbit_string_t _field$994;
          moonbit_string_t str$588;
          int32_t start$590;
          int32_t _tmp$589;
          int32_t _tmp$993;
          int32_t _tmp$587;
          int32_t _tmp$586;
          int32_t _tmp$585;
          int32_t _tmp$584;
          while (1) {
            if (j$66 <= _end4307$65) {
              int32_t _p$360 = i$64 + j$66;
              moonbit_string_t _field$998 = haystack$57.$0;
              moonbit_string_t str$580 = _field$998;
              int32_t start$582 = haystack$57.$1;
              int32_t _tmp$581 = start$582 + _p$360;
              int32_t _tmp$997 = str$580[_tmp$581];
              int32_t _tmp$575 = _tmp$997;
              moonbit_string_t _field$996 = needle$59.$0;
              moonbit_string_t str$577 = _field$996;
              int32_t start$579 = needle$59.$1;
              int32_t _tmp$578 = start$579 + j$66;
              int32_t _tmp$995 = str$577[_tmp$578];
              int32_t _tmp$576 = _tmp$995;
              int32_t _tmp$583;
              if (_tmp$575 != _tmp$576) {
                break;
              }
              _tmp$583 = j$66 + 1;
              j$66 = _tmp$583;
              continue;
            } else {
              moonbit_decref(skip_table$60);
              moonbit_decref(needle$59.$0);
              moonbit_decref(haystack$57.$0);
              return (int64_t)i$64;
            }
            break;
          }
          _tmp$591 = i$64 + needle_len$58;
          _p$365 = _tmp$591 - 1;
          _field$994 = haystack$57.$0;
          str$588 = _field$994;
          start$590 = haystack$57.$1;
          _tmp$589 = start$590 + _p$365;
          _tmp$993 = str$588[_tmp$589];
          _tmp$587 = _tmp$993;
          _tmp$586 = _tmp$587 & 255;
          if (
            _tmp$586 < 0 || _tmp$586 >= Moonbit_array_length(skip_table$60)
          ) {
            moonbit_panic();
          }
          _tmp$585 = (int32_t)skip_table$60[_tmp$586];
          _tmp$584 = i$64 + _tmp$585;
          i$64 = _tmp$584;
          continue;
        } else {
          moonbit_decref(skip_table$60);
          moonbit_decref(needle$59.$0);
          moonbit_decref(haystack$57.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$59.$0);
      moonbit_decref(haystack$57.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$59.$0);
    moonbit_decref(haystack$57.$0);
    return $moonbitlang$core$builtin$boyer_moore_horspool_find$constr$55;
  }
}

int32_t $StringView$$unsafe_charcode_at(
  struct $StringView self$53,
  int32_t index$54
) {
  moonbit_string_t _field$1003 = self$53.$0;
  moonbit_string_t str$563 = _field$1003;
  int32_t _field$1002 = self$53.$1;
  int32_t start$565 = _field$1002;
  int32_t _tmp$564 = start$565 + index$54;
  int32_t _tmp$1001 = str$563[_tmp$564];
  moonbit_decref(str$563);
  return _tmp$1001;
}

int32_t $StringView$$length(struct $StringView self$52) {
  int32_t end$561 = self$52.$2;
  int32_t _field$1004 = self$52.$1;
  int32_t start$562;
  moonbit_decref(self$52.$0);
  start$562 = _field$1004;
  return end$561 - start$562;
}

int32_t $Int$$is_trailing_surrogate(int32_t self$51) {
  return 56320 <= self$51 && self$51 <= 57343;
}

int32_t $Int$$is_leading_surrogate(int32_t self$50) {
  return 55296 <= self$50 && self$50 <= 56319;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$47,
  int32_t ch$49
) {
  int32_t len$556 = self$47->$1;
  int32_t _tmp$555 = len$556 + 4;
  moonbit_bytes_t _field$1005;
  moonbit_bytes_t data$559;
  int32_t len$560;
  int32_t inc$48;
  int32_t len$558;
  int32_t _tmp$557;
  moonbit_incref(self$47);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$47, _tmp$555
  );
  _field$1005 = self$47->$0;
  data$559 = _field$1005;
  len$560 = self$47->$1;
  moonbit_incref(data$559);
  inc$48 = $FixedArray$$set_utf16le_char(data$559, len$560, ch$49);
  len$558 = self$47->$1;
  _tmp$557 = len$558 + inc$48;
  self$47->$1 = _tmp$557;
  moonbit_decref(self$47);
  return 0;
}

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$42,
  int32_t required$43
) {
  moonbit_bytes_t _field$1009 = self$42->$0;
  moonbit_bytes_t data$554 = _field$1009;
  int32_t _tmp$1008 = Moonbit_array_length(data$554);
  int32_t current_len$41 = _tmp$1008;
  int32_t enough_space$44;
  int32_t _tmp$553;
  moonbit_bytes_t new_data$46;
  moonbit_bytes_t _field$1007;
  moonbit_bytes_t data$551;
  int32_t len$552;
  moonbit_bytes_t _old$1006;
  if (required$43 <= current_len$41) {
    moonbit_decref(self$42);
    return 0;
  }
  enough_space$44 = current_len$41;
  while (1) {
    int32_t _tmp$549 = enough_space$44;
    if (_tmp$549 < required$43) {
      int32_t _tmp$550 = enough_space$44;
      enough_space$44 = _tmp$550 * 2;
      continue;
    }
    break;
  }
  _tmp$553 = enough_space$44;
  new_data$46 = (moonbit_bytes_t)moonbit_make_bytes(_tmp$553, 0);
  _field$1007 = self$42->$0;
  data$551 = _field$1007;
  len$552 = self$42->$1;
  moonbit_incref(data$551);
  moonbit_incref(new_data$46);
  $FixedArray$$unsafe_blit$0(new_data$46, 0, data$551, 0, len$552);
  _old$1006 = self$42->$0;
  moonbit_decref(_old$1006);
  self$42->$0 = new_data$46;
  moonbit_decref(self$42);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default() {
  return 0;
}

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$36,
  int32_t offset$37,
  int32_t value$35
) {
  int32_t _tmp$548 = value$35;
  uint32_t code$34 = *(uint32_t*)&_tmp$548;
  if (code$34 < 65536u) {
    uint32_t _p$334 = code$34 & 255u;
    int32_t _tmp$531 = *(int32_t*)&_p$334;
    int32_t _tmp$530 = _tmp$531 & 0xff;
    int32_t _tmp$532;
    uint32_t _p$337;
    int32_t _tmp$534;
    int32_t _tmp$533;
    if (offset$37 < 0 || offset$37 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[offset$37] = _tmp$530;
    _tmp$532 = offset$37 + 1;
    _p$337 = code$34 >> 8;
    _tmp$534 = *(int32_t*)&_p$337;
    _tmp$533 = _tmp$534 & 0xff;
    if (_tmp$532 < 0 || _tmp$532 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[_tmp$532] = _tmp$533;
    moonbit_decref(self$36);
    return 2;
  } else if (code$34 < 1114112u) {
    uint32_t hi$38 = code$34 - 65536u;
    uint32_t _tmp$547 = hi$38 >> 10;
    uint32_t lo$39 = _tmp$547 | 55296u;
    uint32_t _tmp$546 = hi$38 & 1023u;
    uint32_t hi$40 = _tmp$546 | 56320u;
    uint32_t _p$340 = lo$39 & 255u;
    int32_t _tmp$536 = *(int32_t*)&_p$340;
    int32_t _tmp$535 = _tmp$536 & 0xff;
    int32_t _tmp$537;
    uint32_t _p$343;
    int32_t _tmp$539;
    int32_t _tmp$538;
    int32_t _tmp$540;
    uint32_t _p$346;
    int32_t _tmp$542;
    int32_t _tmp$541;
    int32_t _tmp$543;
    uint32_t _p$349;
    int32_t _tmp$545;
    int32_t _tmp$544;
    if (offset$37 < 0 || offset$37 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[offset$37] = _tmp$535;
    _tmp$537 = offset$37 + 1;
    _p$343 = lo$39 >> 8;
    _tmp$539 = *(int32_t*)&_p$343;
    _tmp$538 = _tmp$539 & 0xff;
    if (_tmp$537 < 0 || _tmp$537 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[_tmp$537] = _tmp$538;
    _tmp$540 = offset$37 + 2;
    _p$346 = hi$40 & 255u;
    _tmp$542 = *(int32_t*)&_p$346;
    _tmp$541 = _tmp$542 & 0xff;
    if (_tmp$540 < 0 || _tmp$540 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[_tmp$540] = _tmp$541;
    _tmp$543 = offset$37 + 3;
    _p$349 = hi$40 >> 8;
    _tmp$545 = *(int32_t*)&_p$349;
    _tmp$544 = _tmp$545 & 0xff;
    if (_tmp$543 < 0 || _tmp$543 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[_tmp$543] = _tmp$544;
    moonbit_decref(self$36);
    return 4;
  } else {
    moonbit_decref(self$36);
    return $moonbitlang$core$builtin$abort$1(
             (moonbit_string_t)moonbit_string_literal_13.data,
               (moonbit_string_t)moonbit_string_literal_14.data
           );
  }
}

int32_t $UInt$$to_byte(uint32_t self$33) {
  int32_t _tmp$529 = *(int32_t*)&self$33;
  return _tmp$529 & 0xff;
}

uint32_t $Char$$to_uint(int32_t self$32) {
  int32_t _tmp$528 = self$32;
  return *(uint32_t*)&_tmp$528;
}

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$31
) {
  moonbit_bytes_t _field$1011 = self$31->$0;
  moonbit_bytes_t data$527 = _field$1011;
  moonbit_bytes_t _tmp$524;
  int32_t _field$1010;
  int32_t len$526;
  int64_t _tmp$525;
  moonbit_incref(data$527);
  _tmp$524 = data$527;
  _field$1010 = self$31->$1;
  moonbit_decref(self$31);
  len$526 = _field$1010;
  _tmp$525 = (int64_t)len$526;
  return $Bytes$$to_unchecked_string$inner(_tmp$524, 0, _tmp$525);
}

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$26,
  int32_t offset$30,
  int64_t length$28
) {
  int32_t len$25 = Moonbit_array_length(self$26);
  int32_t length$27;
  int32_t _if_result$1070;
  if (length$28 == 4294967296ll) {
    length$27 = len$25 - offset$30;
  } else {
    int64_t _Some$29 = length$28;
    length$27 = (int32_t)_Some$29;
  }
  if (offset$30 >= 0) {
    if (length$27 >= 0) {
      int32_t _tmp$523 = offset$30 + length$27;
      _if_result$1070 = _tmp$523 <= len$25;
    } else {
      _if_result$1070 = 0;
    }
  } else {
    _if_result$1070 = 0;
  }
  if (_if_result$1070) {
    return $moonbitlang$core$builtin$unsafe_sub_string(
             self$26, offset$30, length$27
           );
  } else {
    moonbit_decref(self$26);
    moonbit_panic();
  }
}

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$23
) {
  int32_t initial$22;
  moonbit_bytes_t data$24;
  struct $$moonbitlang$core$builtin$StringBuilder* _block$1071;
  if (size_hint$23 < 1) {
    initial$22 = 1;
  } else {
    initial$22 = size_hint$23;
  }
  data$24 = (moonbit_bytes_t)moonbit_make_bytes(initial$22, 0);
  _block$1071
  = (struct $$moonbitlang$core$builtin$StringBuilder*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$builtin$StringBuilder)
    );
  Moonbit_object_header(_block$1071)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $$moonbitlang$core$builtin$StringBuilder, $0) >> 2, 1, 0
  );
  _block$1071->$0 = data$24;
  _block$1071->$1 = 0;
  return _block$1071;
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
        int32_t _tmp$514 = dst_offset$15 + i$17;
        int32_t _tmp$516 = src_offset$16 + i$17;
        int32_t _tmp$515;
        int32_t _tmp$517;
        if (_tmp$516 < 0 || _tmp$516 >= Moonbit_array_length(src$14)) {
          moonbit_panic();
        }
        _tmp$515 = (int32_t)src$14[_tmp$516];
        if (_tmp$514 < 0 || _tmp$514 >= Moonbit_array_length(dst$13)) {
          moonbit_panic();
        }
        dst$13[_tmp$514] = _tmp$515;
        _tmp$517 = i$17 + 1;
        i$17 = _tmp$517;
        continue;
      } else {
        moonbit_decref(src$14);
        moonbit_decref(dst$13);
      }
      break;
    }
  } else {
    int32_t _tmp$522 = len$18 - 1;
    int32_t i$20 = _tmp$522;
    while (1) {
      if (i$20 >= 0) {
        int32_t _tmp$518 = dst_offset$15 + i$20;
        int32_t _tmp$520 = src_offset$16 + i$20;
        int32_t _tmp$519;
        int32_t _tmp$521;
        if (_tmp$520 < 0 || _tmp$520 >= Moonbit_array_length(src$14)) {
          moonbit_panic();
        }
        _tmp$519 = (int32_t)src$14[_tmp$520];
        if (_tmp$518 < 0 || _tmp$518 >= Moonbit_array_length(dst$13)) {
          moonbit_panic();
        }
        dst$13[_tmp$518] = _tmp$519;
        _tmp$521 = i$20 - 1;
        i$20 = _tmp$521;
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
  moonbit_string_t _tmp$512 =
    moonbit_add_string(
      string$11, (moonbit_string_t)moonbit_string_literal_15.data
    );
  moonbit_string_t _tmp$513 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$12);
  moonbit_string_t _tmp$511 = moonbit_add_string(_tmp$512, _tmp$513);
  moonbit_string_t _tmp$510 =
    moonbit_add_string(
      _tmp$511, (moonbit_string_t)moonbit_string_literal_16.data
    );
  return $moonbitlang$core$abort$abort$3(_tmp$510);
}

struct $StringView $moonbitlang$core$builtin$abort$2(
  moonbit_string_t string$9,
  moonbit_string_t loc$10
) {
  moonbit_string_t _tmp$508 =
    moonbit_add_string(
      string$9, (moonbit_string_t)moonbit_string_literal_15.data
    );
  moonbit_string_t _tmp$509 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$10);
  moonbit_string_t _tmp$507 = moonbit_add_string(_tmp$508, _tmp$509);
  moonbit_string_t _tmp$506 =
    moonbit_add_string(
      _tmp$507, (moonbit_string_t)moonbit_string_literal_16.data
    );
  return $moonbitlang$core$abort$abort$2(_tmp$506);
}

int32_t $moonbitlang$core$builtin$abort$1(
  moonbit_string_t string$7,
  moonbit_string_t loc$8
) {
  moonbit_string_t _tmp$504 =
    moonbit_add_string(
      string$7, (moonbit_string_t)moonbit_string_literal_15.data
    );
  moonbit_string_t _tmp$505 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$8);
  moonbit_string_t _tmp$503 = moonbit_add_string(_tmp$504, _tmp$505);
  moonbit_string_t _tmp$502 =
    moonbit_add_string(
      _tmp$503, (moonbit_string_t)moonbit_string_literal_16.data
    );
  return $moonbitlang$core$abort$abort$1(_tmp$502);
}

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$5,
  moonbit_string_t loc$6
) {
  moonbit_string_t _tmp$500 =
    moonbit_add_string(
      string$5, (moonbit_string_t)moonbit_string_literal_15.data
    );
  moonbit_string_t _tmp$501 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$6);
  moonbit_string_t _tmp$499 = moonbit_add_string(_tmp$500, _tmp$501);
  moonbit_string_t _tmp$498 =
    moonbit_add_string(
      _tmp$499, (moonbit_string_t)moonbit_string_literal_16.data
    );
  $moonbitlang$core$abort$abort$0(_tmp$498);
  return 0;
}

int64_t $moonbitlang$core$abort$abort$3(moonbit_string_t msg$4) {
  moonbit_println(msg$4);
  moonbit_decref(msg$4);
  moonbit_panic();
}

struct $StringView $moonbitlang$core$abort$abort$2(moonbit_string_t msg$3) {
  moonbit_println(msg$3);
  moonbit_decref(msg$3);
  moonbit_panic();
}

int32_t $moonbitlang$core$abort$abort$1(moonbit_string_t msg$2) {
  moonbit_println(msg$2);
  moonbit_decref(msg$2);
  moonbit_panic();
}

int32_t $moonbitlang$core$abort$abort$0(moonbit_string_t msg$1) {
  moonbit_println(msg$1);
  moonbit_decref(msg$1);
  moonbit_panic();
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$481,
  int32_t _param$480
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$479 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$481;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
    _self$479, _param$480
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$478,
  struct $StringView _param$477
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$476 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$478;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    _self$476, _param$477
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$475,
  moonbit_string_t _param$472,
  int32_t _param$473,
  int32_t _param$474
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$471 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$475;
  $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
    _self$471, _param$472, _param$473, _param$474
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$470,
  moonbit_string_t _param$469
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$468 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$470;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
    _self$468, _param$469
  );
  return 0;
}

void moonbit_init() {
  $moonbitlang$core$builtin$boyer_moore_horspool_find$constr$55 = (int64_t)0;
  $moonbitlang$core$builtin$brute_force_find$constr$69 = (int64_t)0;
}

int main(int argc, char** argv) {
  int32_t _p$457;
  int32_t _p$458;
  int64_t _bind$317;
  int32_t _p$461;
  int32_t _p$462;
  int64_t _bind$320;
  moonbit_runtime_init(argc, argv);
  moonbit_init();
  _p$457 = 10;
  _p$458 = 2;
  if (_p$458 == 0) {
    _bind$317 = 4294967296ll;
  } else {
    int32_t _tmp$489 = _p$457 / _p$458;
    _bind$317 = (int64_t)_tmp$489;
  }
  if (_bind$317 == 4294967296ll) {
    $moonbitlang$core$builtin$println$0(
      (moonbit_string_t)moonbit_string_literal_17.data
    );
  } else {
    int64_t _Some$318 = _bind$317;
    int32_t _v$319 = (int32_t)_Some$318;
    moonbit_string_t _tmp$488 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(10);
    moonbit_string_t _tmp$486 =
      moonbit_add_string(
        _tmp$488, (moonbit_string_t)moonbit_string_literal_18.data
      );
    moonbit_string_t _tmp$487 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(2);
    moonbit_string_t _tmp$485 = moonbit_add_string(_tmp$486, _tmp$487);
    moonbit_string_t _tmp$483 =
      moonbit_add_string(
        _tmp$485, (moonbit_string_t)moonbit_string_literal_19.data
      );
    moonbit_string_t _tmp$484 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(_v$319);
    moonbit_string_t _tmp$482 = moonbit_add_string(_tmp$483, _tmp$484);
    $moonbitlang$core$builtin$println$0(_tmp$482);
  }
  _p$461 = 10;
  _p$462 = 0;
  if (_p$462 == 0) {
    _bind$320 = 4294967296ll;
  } else {
    int32_t _tmp$497 = _p$461 / _p$462;
    _bind$320 = (int64_t)_tmp$497;
  }
  if (_bind$320 == 4294967296ll) {
    $moonbitlang$core$builtin$println$0(
      (moonbit_string_t)moonbit_string_literal_17.data
    );
  } else {
    int64_t _Some$321 = _bind$320;
    int32_t _v$322 = (int32_t)_Some$321;
    moonbit_string_t _tmp$496 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(10);
    moonbit_string_t _tmp$494 =
      moonbit_add_string(
        _tmp$496, (moonbit_string_t)moonbit_string_literal_18.data
      );
    moonbit_string_t _tmp$495 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(0);
    moonbit_string_t _tmp$493 = moonbit_add_string(_tmp$494, _tmp$495);
    moonbit_string_t _tmp$491 =
      moonbit_add_string(
        _tmp$493, (moonbit_string_t)moonbit_string_literal_19.data
      );
    moonbit_string_t _tmp$492 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(_v$322);
    moonbit_string_t _tmp$490 = moonbit_add_string(_tmp$491, _tmp$492);
    $moonbitlang$core$builtin$println$0(_tmp$490);
  }
  return 0;
}