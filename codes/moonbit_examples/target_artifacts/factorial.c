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

int32_t $username$moonbit_examples$cmd$factorial$factorial(int32_t n$317);

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
  void* _obj_ptr$469,
  int32_t _param$468
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$466,
  struct $StringView _param$465
);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$463,
  moonbit_string_t _param$460,
  int32_t _param$461,
  int32_t _param$462
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$458,
  moonbit_string_t _param$457
);

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

struct { int32_t rc; uint32_t meta; uint16_t const data[5];
} const moonbit_string_literal_18 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 4),
    32, 105, 115, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[14];
} const moonbit_string_literal_17 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 13),
    70, 97, 99, 116, 111, 114, 105, 97, 108, 32, 111, 102, 32, 0
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

int32_t $username$moonbit_examples$cmd$factorial$factorial(int32_t n$317) {
  int32_t result$315 = 1;
  int32_t i$316 = 1;
  while (1) {
    if (i$316 <= n$317) {
      int32_t _tmp$924 = result$315;
      int32_t _tmp$925;
      result$315 = _tmp$924 * i$316;
      _tmp$925 = i$316 + 1;
      i$316 = _tmp$925;
      continue;
    }
    break;
  }
  return result$315;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$313,
  struct $$moonbitlang$core$builtin$Logger logger$314
) {
  moonbit_string_t _tmp$923 = self$313;
  struct $$moonbitlang$core$builtin$SourceLocRepr* _tmp$922 =
    $$moonbitlang$core$builtin$SourceLocRepr$$parse(_tmp$923);
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
    _tmp$922, logger$314
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$299,
  struct $$moonbitlang$core$builtin$Logger logger$312
) {
  struct $StringView _field$934 =
    (struct $StringView){self$299->$0_1, self$299->$0_2, self$299->$0_0};
  struct $StringView pkg$298 = _field$934;
  int32_t _tmp$921 =
    Moonbit_array_length($moonbitlang$core$builtin$output$$2a$bind$7c$8193);
  struct $StringView _tmp$920;
  int64_t _bind$300;
  struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$* _bind$301;
  struct $StringView _field$933;
  struct $StringView _module_name$308;
  void* _field$932;
  int32_t _cnt$991;
  void* _package_name$309;
  struct $StringView _field$930;
  struct $StringView filename$903;
  struct $StringView _field$929;
  struct $StringView start_line$904;
  struct $StringView _field$928;
  struct $StringView start_column$905;
  struct $StringView _field$927;
  struct $StringView end_line$906;
  struct $StringView _field$926;
  int32_t _cnt$995;
  struct $StringView end_column$907;
  struct $$moonbitlang$core$builtin$Logger _bind$902;
  moonbit_incref($moonbitlang$core$builtin$output$$2a$bind$7c$8193);
  _tmp$920
  = (struct $StringView){
    0, _tmp$921, $moonbitlang$core$builtin$output$$2a$bind$7c$8193
  };
  moonbit_incref(pkg$298.$0);
  moonbit_incref(pkg$298.$0);
  _bind$300 = $StringView$$find(pkg$298, _tmp$920);
  if (_bind$300 == 4294967296ll) {
    void* None$908 =
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
    _bind$301->$1 = None$908;
  } else {
    int64_t _Some$302 = _bind$300;
    int32_t _first_slash$303 = (int32_t)_Some$302;
    int32_t _tmp$919 = _first_slash$303 + 1;
    struct $StringView _tmp$916;
    int32_t _tmp$918;
    struct $StringView _tmp$917;
    int64_t _bind$304;
    moonbit_incref(pkg$298.$0);
    _tmp$916 = $StringView$$view$inner(pkg$298, _tmp$919, 4294967296ll);
    _tmp$918
    = Moonbit_array_length(
      $moonbitlang$core$builtin$output$$2a$bind$7c$8187
    );
    moonbit_incref($moonbitlang$core$builtin$output$$2a$bind$7c$8187);
    _tmp$917
    = (struct $StringView){
      0, _tmp$918, $moonbitlang$core$builtin$output$$2a$bind$7c$8187
    };
    _bind$304 = $StringView$$find(_tmp$916, _tmp$917);
    if (_bind$304 == 4294967296ll) {
      void* None$909 =
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
      _bind$301->$1 = None$909;
    } else {
      int64_t _Some$305 = _bind$304;
      int32_t _second_slash$306 = (int32_t)_Some$305;
      int32_t _tmp$915 = _first_slash$303 + 1;
      int32_t module_name_end$307 = _tmp$915 + _second_slash$306;
      int64_t _tmp$914 = (int64_t)module_name_end$307;
      struct $StringView _tmp$910;
      int32_t _tmp$913;
      struct $StringView _tmp$912;
      void* Some$911;
      moonbit_incref(pkg$298.$0);
      _tmp$910 = $StringView$$view$inner(pkg$298, 0, _tmp$914);
      _tmp$913 = module_name_end$307 + 1;
      _tmp$912 = $StringView$$view$inner(pkg$298, _tmp$913, 4294967296ll);
      Some$911
      = (void*)moonbit_malloc(sizeof(struct $Option$3c$StringView$3e$$Some));
      Moonbit_object_header(Some$911)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $Option$3c$StringView$3e$$Some, $0_0) >> 2, 1, 1
      );
      ((struct $Option$3c$StringView$3e$$Some*)Some$911)->$0_0 = _tmp$912.$0;
      ((struct $Option$3c$StringView$3e$$Some*)Some$911)->$0_1 = _tmp$912.$1;
      ((struct $Option$3c$StringView$3e$$Some*)Some$911)->$0_2 = _tmp$912.$2;
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
      _bind$301->$0_0 = _tmp$910.$0;
      _bind$301->$0_1 = _tmp$910.$1;
      _bind$301->$0_2 = _tmp$910.$2;
      _bind$301->$1 = Some$911;
    }
  }
  _field$933
  = (struct $StringView){
    _bind$301->$0_1, _bind$301->$0_2, _bind$301->$0_0
  };
  _module_name$308 = _field$933;
  _field$932 = _bind$301->$1;
  _cnt$991 = Moonbit_object_header(_bind$301)->rc;
  if (_cnt$991 > 1) {
    int32_t _new_cnt$992;
    moonbit_incref(_field$932);
    moonbit_incref(_module_name$308.$0);
    _new_cnt$992 = _cnt$991 - 1;
    Moonbit_object_header(_bind$301)->rc = _new_cnt$992;
  } else if (_cnt$991 == 1) {
    moonbit_free(_bind$301);
  }
  _package_name$309 = _field$932;
  switch (Moonbit_object_tag(_package_name$309)) {
    case 1: {
      struct $Option$3c$StringView$3e$$Some* _Some$310 =
        (struct $Option$3c$StringView$3e$$Some*)_package_name$309;
      struct $StringView _field$931 =
        (struct $StringView){
          _Some$310->$0_1, _Some$310->$0_2, _Some$310->$0_0
        };
      int32_t _cnt$993 = Moonbit_object_header(_Some$310)->rc;
      struct $StringView _pkg_name$311;
      struct $$moonbitlang$core$builtin$Logger _bind$901;
      if (_cnt$993 > 1) {
        int32_t _new_cnt$994;
        moonbit_incref(_field$931.$0);
        _new_cnt$994 = _cnt$993 - 1;
        Moonbit_object_header(_Some$310)->rc = _new_cnt$994;
      } else if (_cnt$993 == 1) {
        moonbit_free(_Some$310);
      }
      _pkg_name$311 = _field$931;
      if (logger$312.$1) {
        moonbit_incref(logger$312.$1);
      }
      logger$312.$0->$method_2(logger$312.$1, _pkg_name$311);
      _bind$901 = logger$312;
      if (_bind$901.$1) {
        moonbit_incref(_bind$901.$1);
      }
      _bind$901.$0->$method_3(_bind$901.$1, 47);
      break;
    }
    default: {
      moonbit_decref(_package_name$309);
      break;
    }
  }
  _field$930
  = (struct $StringView){
    self$299->$1_1, self$299->$1_2, self$299->$1_0
  };
  filename$903 = _field$930;
  moonbit_incref(filename$903.$0);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_2(logger$312.$1, filename$903);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_3(logger$312.$1, 58);
  _field$929
  = (struct $StringView){
    self$299->$2_1, self$299->$2_2, self$299->$2_0
  };
  start_line$904 = _field$929;
  moonbit_incref(start_line$904.$0);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_2(logger$312.$1, start_line$904);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_3(logger$312.$1, 58);
  _field$928
  = (struct $StringView){
    self$299->$3_1, self$299->$3_2, self$299->$3_0
  };
  start_column$905 = _field$928;
  moonbit_incref(start_column$905.$0);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_2(logger$312.$1, start_column$905);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_3(logger$312.$1, 45);
  _field$927
  = (struct $StringView){
    self$299->$4_1, self$299->$4_2, self$299->$4_0
  };
  end_line$906 = _field$927;
  moonbit_incref(end_line$906.$0);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_2(logger$312.$1, end_line$906);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_3(logger$312.$1, 58);
  _field$926
  = (struct $StringView){
    self$299->$5_1, self$299->$5_2, self$299->$5_0
  };
  _cnt$995 = Moonbit_object_header(self$299)->rc;
  if (_cnt$995 > 1) {
    int32_t _new_cnt$1001;
    moonbit_incref(_field$926.$0);
    _new_cnt$1001 = _cnt$995 - 1;
    Moonbit_object_header(self$299)->rc = _new_cnt$1001;
  } else if (_cnt$995 == 1) {
    struct $StringView _field$1000 =
      (struct $StringView){self$299->$4_1, self$299->$4_2, self$299->$4_0};
    struct $StringView _field$999;
    struct $StringView _field$998;
    struct $StringView _field$997;
    struct $StringView _field$996;
    moonbit_decref(_field$1000.$0);
    _field$999
    = (struct $StringView){
      self$299->$3_1, self$299->$3_2, self$299->$3_0
    };
    moonbit_decref(_field$999.$0);
    _field$998
    = (struct $StringView){
      self$299->$2_1, self$299->$2_2, self$299->$2_0
    };
    moonbit_decref(_field$998.$0);
    _field$997
    = (struct $StringView){
      self$299->$1_1, self$299->$1_2, self$299->$1_0
    };
    moonbit_decref(_field$997.$0);
    _field$996
    = (struct $StringView){
      self$299->$0_1, self$299->$0_2, self$299->$0_0
    };
    moonbit_decref(_field$996.$0);
    moonbit_free(self$299);
  }
  end_column$907 = _field$926;
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_2(logger$312.$1, end_column$907);
  if (logger$312.$1) {
    moonbit_incref(logger$312.$1);
  }
  logger$312.$0->$method_3(logger$312.$1, 64);
  _bind$902 = logger$312;
  _bind$902.$0->$method_2(_bind$902.$1, _module_name$308);
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
  moonbit_string_t _tmp$900 = $Int$$to_string$inner(self$295, 10);
  logger$294.$0->$method_0(logger$294.$1, _tmp$900);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$292,
  struct $StringView str$293
) {
  int32_t len$882 = self$292->$1;
  int32_t end$885 = str$293.$2;
  int32_t start$886 = str$293.$1;
  int32_t _tmp$884 = end$885 - start$886;
  int32_t _tmp$883 = _tmp$884 * 2;
  int32_t _tmp$881 = len$882 + _tmp$883;
  moonbit_bytes_t _field$937;
  moonbit_bytes_t data$887;
  int32_t len$888;
  moonbit_string_t _field$936;
  moonbit_string_t str$889;
  int32_t start$890;
  int32_t end$892;
  int32_t start$893;
  int32_t _tmp$891;
  int32_t len$895;
  int32_t end$898;
  int32_t _field$935;
  int32_t start$899;
  int32_t _tmp$897;
  int32_t _tmp$896;
  int32_t _tmp$894;
  moonbit_incref(self$292);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$292, _tmp$881
  );
  _field$937 = self$292->$0;
  data$887 = _field$937;
  len$888 = self$292->$1;
  _field$936 = str$293.$0;
  str$889 = _field$936;
  start$890 = str$293.$1;
  end$892 = str$293.$2;
  start$893 = str$293.$1;
  _tmp$891 = end$892 - start$893;
  moonbit_incref(str$889);
  moonbit_incref(data$887);
  $FixedArray$$blit_from_string(
    data$887, len$888, str$889, start$890, _tmp$891
  );
  len$895 = self$292->$1;
  end$898 = str$293.$2;
  _field$935 = str$293.$1;
  moonbit_decref(str$293.$0);
  start$899 = _field$935;
  _tmp$897 = end$898 - start$899;
  _tmp$896 = _tmp$897 * 2;
  _tmp$894 = len$895 + _tmp$896;
  self$292->$1 = _tmp$894;
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
    int32_t _tmp$880 = -i$290;
    return $String$$offset_of_nth_char_backward(
             self$289, _tmp$880, start_offset$291, end_offset$286
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
    int32_t _tmp$878;
    int32_t _if_result$1009;
    while (1) {
      int32_t _tmp$872 = utf16_offset$280;
      int32_t _if_result$1008;
      if (_tmp$872 < end_offset$279) {
        int32_t _tmp$871 = char_count$281;
        _if_result$1008 = _tmp$871 < n$282;
      } else {
        _if_result$1008 = 0;
      }
      if (_if_result$1008) {
        int32_t _tmp$876 = utf16_offset$280;
        int32_t c$283 = self$284[_tmp$876];
        int32_t _tmp$875;
        if (55296 <= c$283 && c$283 <= 56319) {
          int32_t _tmp$873 = utf16_offset$280;
          utf16_offset$280 = _tmp$873 + 2;
        } else {
          int32_t _tmp$874 = utf16_offset$280;
          utf16_offset$280 = _tmp$874 + 1;
        }
        _tmp$875 = char_count$281;
        char_count$281 = _tmp$875 + 1;
        continue;
      } else {
        moonbit_decref(self$284);
      }
      break;
    }
    _tmp$878 = char_count$281;
    if (_tmp$878 < n$282) {
      _if_result$1009 = 1;
    } else {
      int32_t _tmp$877 = utf16_offset$280;
      _if_result$1009 = _tmp$877 >= end_offset$279;
    }
    if (_if_result$1009) {
      return 4294967296ll;
    } else {
      int32_t _tmp$879 = utf16_offset$280;
      return (int64_t)_tmp$879;
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
  int32_t _tmp$869;
  int32_t _if_result$1012;
  while (1) {
    int32_t _tmp$862 = utf16_offset$271;
    int32_t _tmp$861 = _tmp$862 - 1;
    int32_t _if_result$1011;
    if (_tmp$861 >= start_offset$273) {
      int32_t _tmp$860 = char_count$270;
      _if_result$1011 = _tmp$860 < n$274;
    } else {
      _if_result$1011 = 0;
    }
    if (_if_result$1011) {
      int32_t _tmp$867 = utf16_offset$271;
      int32_t _tmp$866 = _tmp$867 - 1;
      int32_t c$275 = self$276[_tmp$866];
      int32_t _tmp$865;
      if (56320 <= c$275 && c$275 <= 57343) {
        int32_t _tmp$863 = utf16_offset$271;
        utf16_offset$271 = _tmp$863 - 2;
      } else {
        int32_t _tmp$864 = utf16_offset$271;
        utf16_offset$271 = _tmp$864 - 1;
      }
      _tmp$865 = char_count$270;
      char_count$270 = _tmp$865 + 1;
      continue;
    } else {
      moonbit_decref(self$276);
    }
    break;
  }
  _tmp$869 = char_count$270;
  if (_tmp$869 < n$274) {
    _if_result$1012 = 1;
  } else {
    int32_t _tmp$868 = utf16_offset$271;
    _if_result$1012 = _tmp$868 < start_offset$273;
  }
  if (_if_result$1012) {
    return 4294967296ll;
  } else {
    int32_t _tmp$870 = utf16_offset$271;
    return (int64_t)_tmp$870;
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
      int32_t _if_result$1014;
      int32_t _tmp$858;
      int32_t _tmp$859;
      if (55296 <= c1$266 && c1$266 <= 56319) {
        int32_t _tmp$854 = index$263 + 1;
        _if_result$1014 = _tmp$854 < end_offset$259;
      } else {
        _if_result$1014 = 0;
      }
      if (_if_result$1014) {
        int32_t _tmp$857 = index$263 + 1;
        int32_t c2$267 = self$262[_tmp$857];
        if (56320 <= c2$267 && c2$267 <= 57343) {
          int32_t _tmp$855 = index$263 + 2;
          int32_t _tmp$856 = count$264 + 1;
          index$263 = _tmp$855;
          count$264 = _tmp$856;
          continue;
        } else {
          $moonbitlang$core$builtin$abort$0(
            (moonbit_string_t)moonbit_string_literal_5.data,
              (moonbit_string_t)moonbit_string_literal_6.data
          );
        }
      }
      _tmp$858 = index$263 + 1;
      _tmp$859 = count$264 + 1;
      index$263 = _tmp$858;
      count$264 = _tmp$859;
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
    int32_t _tmp$853 = -self$243;
    num$245 = *(uint32_t*)&_tmp$853;
  } else {
    num$245 = *(uint32_t*)&self$243;
  }
  switch (radix$242) {
    case 10: {
      int32_t digit_len$247 = $moonbitlang$core$builtin$dec_count32(num$245);
      int32_t _tmp$850;
      int32_t total_len$248;
      uint16_t* buffer$249;
      int32_t digit_start$250;
      if (is_negative$244) {
        _tmp$850 = 1;
      } else {
        _tmp$850 = 0;
      }
      total_len$248 = digit_len$247 + _tmp$850;
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
      int32_t _tmp$851;
      int32_t total_len$252;
      uint16_t* buffer$253;
      int32_t digit_start$254;
      if (is_negative$244) {
        _tmp$851 = 1;
      } else {
        _tmp$851 = 0;
      }
      total_len$252 = digit_len$251 + _tmp$851;
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
      int32_t _tmp$852;
      int32_t total_len$256;
      uint16_t* buffer$257;
      int32_t digit_start$258;
      if (is_negative$244) {
        _tmp$852 = 1;
      } else {
        _tmp$852 = 0;
      }
      total_len$256 = digit_len$255 + _tmp$852;
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
    uint32_t _tmp$847 = num$237;
    if (_tmp$847 > 0u) {
      int32_t _tmp$848 = count$240;
      uint32_t _tmp$849;
      count$240 = _tmp$848 + 1;
      _tmp$849 = num$237;
      num$237 = _tmp$849 / base$238;
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
    int32_t _tmp$846 = 31 - leading_zeros$235;
    int32_t _tmp$845 = _tmp$846 / 4;
    return _tmp$845 + 1;
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
  uint32_t _tmp$844;
  int32_t remaining$225;
  int32_t _tmp$825;
  while (1) {
    uint32_t _tmp$788 = num$210;
    if (_tmp$788 >= 10000u) {
      uint32_t _tmp$811 = num$210;
      uint32_t t$215 = _tmp$811 / 10000u;
      uint32_t _tmp$810 = num$210;
      uint32_t _tmp$809 = _tmp$810 % 10000u;
      int32_t r$216 = *(int32_t*)&_tmp$809;
      int32_t d1$217;
      int32_t d2$218;
      int32_t _tmp$789;
      int32_t _tmp$808;
      int32_t _tmp$807;
      int32_t d1_hi$219;
      int32_t _tmp$806;
      int32_t _tmp$805;
      int32_t d1_lo$220;
      int32_t _tmp$804;
      int32_t _tmp$803;
      int32_t d2_hi$221;
      int32_t _tmp$802;
      int32_t _tmp$801;
      int32_t d2_lo$222;
      int32_t _tmp$791;
      int32_t _tmp$790;
      int32_t _tmp$794;
      int32_t _tmp$793;
      int32_t _tmp$792;
      int32_t _tmp$797;
      int32_t _tmp$796;
      int32_t _tmp$795;
      int32_t _tmp$800;
      int32_t _tmp$799;
      int32_t _tmp$798;
      num$210 = t$215;
      d1$217 = r$216 / 100;
      d2$218 = r$216 % 100;
      _tmp$789 = offset$212;
      offset$212 = _tmp$789 - 4;
      _tmp$808 = d1$217 / 10;
      _tmp$807 = 48 + _tmp$808;
      d1_hi$219 = (uint16_t)_tmp$807;
      _tmp$806 = d1$217 % 10;
      _tmp$805 = 48 + _tmp$806;
      d1_lo$220 = (uint16_t)_tmp$805;
      _tmp$804 = d2$218 / 10;
      _tmp$803 = 48 + _tmp$804;
      d2_hi$221 = (uint16_t)_tmp$803;
      _tmp$802 = d2$218 % 10;
      _tmp$801 = 48 + _tmp$802;
      d2_lo$222 = (uint16_t)_tmp$801;
      _tmp$791 = offset$212;
      _tmp$790 = digit_start$214 + _tmp$791;
      buffer$223[_tmp$790] = d1_hi$219;
      _tmp$794 = offset$212;
      _tmp$793 = digit_start$214 + _tmp$794;
      _tmp$792 = _tmp$793 + 1;
      buffer$223[_tmp$792] = d1_lo$220;
      _tmp$797 = offset$212;
      _tmp$796 = digit_start$214 + _tmp$797;
      _tmp$795 = _tmp$796 + 2;
      buffer$223[_tmp$795] = d2_hi$221;
      _tmp$800 = offset$212;
      _tmp$799 = digit_start$214 + _tmp$800;
      _tmp$798 = _tmp$799 + 3;
      buffer$223[_tmp$798] = d2_lo$222;
      continue;
    }
    break;
  }
  _tmp$844 = num$210;
  remaining$225 = *(int32_t*)&_tmp$844;
  while (1) {
    int32_t _tmp$812 = remaining$225;
    if (_tmp$812 >= 100) {
      int32_t _tmp$824 = remaining$225;
      int32_t t$226 = _tmp$824 / 100;
      int32_t _tmp$823 = remaining$225;
      int32_t d$227 = _tmp$823 % 100;
      int32_t _tmp$813;
      int32_t _tmp$822;
      int32_t _tmp$821;
      int32_t d_hi$228;
      int32_t _tmp$820;
      int32_t _tmp$819;
      int32_t d_lo$229;
      int32_t _tmp$815;
      int32_t _tmp$814;
      int32_t _tmp$818;
      int32_t _tmp$817;
      int32_t _tmp$816;
      remaining$225 = t$226;
      _tmp$813 = offset$212;
      offset$212 = _tmp$813 - 2;
      _tmp$822 = d$227 / 10;
      _tmp$821 = 48 + _tmp$822;
      d_hi$228 = (uint16_t)_tmp$821;
      _tmp$820 = d$227 % 10;
      _tmp$819 = 48 + _tmp$820;
      d_lo$229 = (uint16_t)_tmp$819;
      _tmp$815 = offset$212;
      _tmp$814 = digit_start$214 + _tmp$815;
      buffer$223[_tmp$814] = d_hi$228;
      _tmp$818 = offset$212;
      _tmp$817 = digit_start$214 + _tmp$818;
      _tmp$816 = _tmp$817 + 1;
      buffer$223[_tmp$816] = d_lo$229;
      continue;
    }
    break;
  }
  _tmp$825 = remaining$225;
  if (_tmp$825 >= 10) {
    int32_t _tmp$826 = offset$212;
    int32_t _tmp$837;
    int32_t _tmp$836;
    int32_t _tmp$835;
    int32_t d_hi$231;
    int32_t _tmp$834;
    int32_t _tmp$833;
    int32_t _tmp$832;
    int32_t d_lo$232;
    int32_t _tmp$828;
    int32_t _tmp$827;
    int32_t _tmp$831;
    int32_t _tmp$830;
    int32_t _tmp$829;
    offset$212 = _tmp$826 - 2;
    _tmp$837 = remaining$225;
    _tmp$836 = _tmp$837 / 10;
    _tmp$835 = 48 + _tmp$836;
    d_hi$231 = (uint16_t)_tmp$835;
    _tmp$834 = remaining$225;
    _tmp$833 = _tmp$834 % 10;
    _tmp$832 = 48 + _tmp$833;
    d_lo$232 = (uint16_t)_tmp$832;
    _tmp$828 = offset$212;
    _tmp$827 = digit_start$214 + _tmp$828;
    buffer$223[_tmp$827] = d_hi$231;
    _tmp$831 = offset$212;
    _tmp$830 = digit_start$214 + _tmp$831;
    _tmp$829 = _tmp$830 + 1;
    buffer$223[_tmp$829] = d_lo$232;
    moonbit_decref(buffer$223);
  } else {
    int32_t _tmp$838 = offset$212;
    int32_t _tmp$843;
    int32_t _tmp$839;
    int32_t _tmp$842;
    int32_t _tmp$841;
    int32_t _tmp$840;
    offset$212 = _tmp$838 - 1;
    _tmp$843 = offset$212;
    _tmp$839 = digit_start$214 + _tmp$843;
    _tmp$842 = remaining$225;
    _tmp$841 = 48 + _tmp$842;
    _tmp$840 = (uint16_t)_tmp$841;
    buffer$223[_tmp$839] = _tmp$840;
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
  int32_t _tmp$768 = radix$201 - 1;
  int32_t _tmp$767 = radix$201 & _tmp$768;
  if (_tmp$767 == 0) {
    int32_t shift$202 = moonbit_ctz32(radix$201);
    uint32_t mask$203 = base$200 - 1u;
    while (1) {
      uint32_t _tmp$769 = n$198;
      if (_tmp$769 > 0u) {
        int32_t _tmp$770 = offset$195;
        uint32_t _tmp$777;
        uint32_t _tmp$776;
        int32_t digit$204;
        int32_t _tmp$774;
        int32_t _tmp$771;
        int32_t _tmp$773;
        int32_t _tmp$772;
        uint32_t _tmp$775;
        offset$195 = _tmp$770 - 1;
        _tmp$777 = n$198;
        _tmp$776 = _tmp$777 & mask$203;
        digit$204 = *(int32_t*)&_tmp$776;
        _tmp$774 = offset$195;
        _tmp$771 = digit_start$197 + _tmp$774;
        _tmp$773
        = ((moonbit_string_t)moonbit_string_literal_10.data)[
          digit$204
        ];
        _tmp$772 = (uint16_t)_tmp$773;
        buffer$205[_tmp$771] = _tmp$772;
        _tmp$775 = n$198;
        n$198 = _tmp$775 >> (shift$202 & 31);
        continue;
      } else {
        moonbit_decref(buffer$205);
      }
      break;
    }
  } else {
    while (1) {
      uint32_t _tmp$778 = n$198;
      if (_tmp$778 > 0u) {
        int32_t _tmp$779 = offset$195;
        uint32_t _tmp$787;
        uint32_t q$207;
        uint32_t _tmp$785;
        uint32_t _tmp$786;
        uint32_t _tmp$784;
        int32_t digit$208;
        int32_t _tmp$783;
        int32_t _tmp$780;
        int32_t _tmp$782;
        int32_t _tmp$781;
        offset$195 = _tmp$779 - 1;
        _tmp$787 = n$198;
        q$207 = _tmp$787 / base$200;
        _tmp$785 = n$198;
        _tmp$786 = q$207 * base$200;
        _tmp$784 = _tmp$785 - _tmp$786;
        digit$208 = *(int32_t*)&_tmp$784;
        _tmp$783 = offset$195;
        _tmp$780 = digit_start$197 + _tmp$783;
        _tmp$782
        = ((moonbit_string_t)moonbit_string_literal_10.data)[
          digit$208
        ];
        _tmp$781 = (uint16_t)_tmp$782;
        buffer$205[_tmp$780] = _tmp$781;
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
  int32_t _tmp$762;
  while (1) {
    int32_t _tmp$748 = offset$184;
    if (_tmp$748 >= 2) {
      int32_t _tmp$749 = offset$184;
      uint32_t _tmp$761;
      uint32_t _tmp$760;
      int32_t byte_val$189;
      int32_t hi$190;
      int32_t lo$191;
      int32_t _tmp$753;
      int32_t _tmp$750;
      int32_t _tmp$752;
      int32_t _tmp$751;
      int32_t _tmp$758;
      int32_t _tmp$757;
      int32_t _tmp$754;
      int32_t _tmp$756;
      int32_t _tmp$755;
      uint32_t _tmp$759;
      offset$184 = _tmp$749 - 2;
      _tmp$761 = n$187;
      _tmp$760 = _tmp$761 & 255u;
      byte_val$189 = *(int32_t*)&_tmp$760;
      hi$190 = byte_val$189 / 16;
      lo$191 = byte_val$189 % 16;
      _tmp$753 = offset$184;
      _tmp$750 = digit_start$186 + _tmp$753;
      _tmp$752 = ((moonbit_string_t)moonbit_string_literal_10.data)[hi$190];
      _tmp$751 = (uint16_t)_tmp$752;
      buffer$192[_tmp$750] = _tmp$751;
      _tmp$758 = offset$184;
      _tmp$757 = digit_start$186 + _tmp$758;
      _tmp$754 = _tmp$757 + 1;
      _tmp$756 = ((moonbit_string_t)moonbit_string_literal_10.data)[lo$191];
      _tmp$755 = (uint16_t)_tmp$756;
      buffer$192[_tmp$754] = _tmp$755;
      _tmp$759 = n$187;
      n$187 = _tmp$759 >> 8;
      continue;
    }
    break;
  }
  _tmp$762 = offset$184;
  if (_tmp$762 == 1) {
    uint32_t _tmp$766 = n$187;
    uint32_t _tmp$765 = _tmp$766 & 15u;
    int32_t nibble$194 = *(int32_t*)&_tmp$765;
    int32_t _tmp$764 =
      ((moonbit_string_t)moonbit_string_literal_10.data)[nibble$194];
    int32_t _tmp$763 = (uint16_t)_tmp$764;
    buffer$192[digit_start$186] = _tmp$763;
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
  struct $$moonbitlang$core$builtin$Logger _tmp$747;
  moonbit_incref(logger$182);
  _tmp$747
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$182
  };
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
    self$183, _tmp$747
  );
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$182);
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  int32_t self$181
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$180 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$746;
  moonbit_incref(logger$180);
  _tmp$746
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$180
  };
  $$moonbitlang$core$builtin$Show$$Int$$output(self$181, _tmp$746);
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$180);
}

int32_t $StringView$$start_offset(struct $StringView self$179) {
  int32_t _field$938 = self$179.$1;
  moonbit_decref(self$179.$0);
  return _field$938;
}

moonbit_string_t $StringView$$data(struct $StringView self$178) {
  moonbit_string_t _field$939 = self$178.$0;
  return _field$939;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$172,
  moonbit_string_t value$175,
  int32_t start$176,
  int32_t len$177
) {
  void* _try_err$174;
  struct $StringView _tmp$741;
  int32_t _tmp$743 = start$176 + len$177;
  int64_t _tmp$742 = (int64_t)_tmp$743;
  struct moonbit_result_0 _tmp$1022 =
    $String$$sub$inner(value$175, start$176, _tmp$742);
  if (_tmp$1022.tag) {
    struct $StringView const _ok$744 = _tmp$1022.data.ok;
    _tmp$741 = _ok$744;
  } else {
    void* const _err$745 = _tmp$1022.data.err;
    _try_err$174 = _err$745;
    goto $join$173;
  }
  goto $joinlet$1021;
  $join$173:;
  moonbit_decref(_try_err$174);
  moonbit_panic();
  $joinlet$1021:;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    self$172, _tmp$741
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
    int32_t _if_result$1023;
    int32_t _if_result$1025;
    struct $StringView _tmp$739;
    struct moonbit_result_0 _result$1027;
    if (start$170 < len$164) {
      int32_t _p$427 = self$165[start$170];
      _if_result$1023 = 56320 <= _p$427 && _p$427 <= 57343;
    } else {
      _if_result$1023 = 0;
    }
    if (_if_result$1023) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$737;
      struct moonbit_result_0 _result$1024;
      moonbit_decref(self$165);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$737
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$1024.tag = 0;
      _result$1024.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$737;
      return _result$1024;
    }
    if (end$166 < len$164) {
      int32_t _p$430 = self$165[end$166];
      _if_result$1025 = 56320 <= _p$430 && _p$430 <= 57343;
    } else {
      _if_result$1025 = 0;
    }
    if (_if_result$1025) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$738;
      struct moonbit_result_0 _result$1026;
      moonbit_decref(self$165);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$738
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$1026.tag = 0;
      _result$1026.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$738;
      return _result$1026;
    }
    _tmp$739 = (struct $StringView){start$170, end$166, self$165};
    _result$1027.tag = 1;
    _result$1027.data.ok = _tmp$739;
    return _result$1027;
  } else {
    void* moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$740;
    struct moonbit_result_0 _result$1028;
    moonbit_decref(self$165);
    moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$740
    = (struct moonbit_object*)&moonbit_constant_constructor_1 + 1;
    _result$1028.tag = 0;
    _result$1028.data.err
    = moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$740;
    return _result$1028;
  }
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$162,
  moonbit_string_t str$163
) {
  int32_t len$727 = self$162->$1;
  int32_t _tmp$729 = Moonbit_array_length(str$163);
  int32_t _tmp$728 = _tmp$729 * 2;
  int32_t _tmp$726 = len$727 + _tmp$728;
  moonbit_bytes_t _field$941;
  moonbit_bytes_t data$730;
  int32_t len$731;
  int32_t _tmp$732;
  int32_t len$734;
  int32_t _tmp$940;
  int32_t _tmp$736;
  int32_t _tmp$735;
  int32_t _tmp$733;
  moonbit_incref(self$162);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$162, _tmp$726
  );
  _field$941 = self$162->$0;
  data$730 = _field$941;
  len$731 = self$162->$1;
  _tmp$732 = Moonbit_array_length(str$163);
  moonbit_incref(data$730);
  moonbit_incref(str$163);
  $FixedArray$$blit_from_string(data$730, len$731, str$163, 0, _tmp$732);
  len$734 = self$162->$1;
  _tmp$940 = Moonbit_array_length(str$163);
  moonbit_decref(str$163);
  _tmp$736 = _tmp$940;
  _tmp$735 = _tmp$736 * 2;
  _tmp$733 = len$734 + _tmp$735;
  self$162->$1 = _tmp$733;
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
  int32_t _tmp$725 = length$150 * 2;
  int32_t _tmp$724 = bytes_offset$149 + _tmp$725;
  int32_t e1$148 = _tmp$724 - 1;
  int32_t _tmp$723 = str_offset$152 + length$150;
  int32_t e2$151 = _tmp$723 - 1;
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
        int32_t _tmp$720 = str$156[i$158];
        uint32_t c$160 = *(uint32_t*)&_tmp$720;
        uint32_t _p$421 = c$160 & 255u;
        int32_t _tmp$716 = *(int32_t*)&_p$421;
        int32_t _tmp$715 = _tmp$716 & 0xff;
        int32_t _tmp$717;
        uint32_t _p$424;
        int32_t _tmp$719;
        int32_t _tmp$718;
        int32_t _tmp$721;
        int32_t _tmp$722;
        if (j$159 < 0 || j$159 >= Moonbit_array_length(self$154)) {
          moonbit_panic();
        }
        self$154[j$159] = _tmp$715;
        _tmp$717 = j$159 + 1;
        _p$424 = c$160 >> 8;
        _tmp$719 = *(int32_t*)&_p$424;
        _tmp$718 = _tmp$719 & 0xff;
        if (_tmp$717 < 0 || _tmp$717 >= Moonbit_array_length(self$154)) {
          moonbit_panic();
        }
        self$154[_tmp$717] = _tmp$718;
        _tmp$721 = i$158 + 1;
        _tmp$722 = j$159 + 2;
        i$158 = _tmp$721;
        j$159 = _tmp$722;
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
  int32_t _tmp$684 = Moonbit_array_length(repr$116);
  int64_t _tmp$683 = (int64_t)_tmp$684;
  moonbit_incref(repr$116);
  if ($String$$char_length_ge$inner(repr$116, 1, 0, _tmp$683)) {
    int32_t _tmp$714 = repr$116[0];
    int32_t _x$117 = _tmp$714;
    if (_x$117 == 64) {
      int32_t _tmp$713 = Moonbit_array_length(repr$116);
      int64_t _tmp$712 = (int64_t)_tmp$713;
      int64_t _bind$319;
      int32_t _tmp$710;
      int32_t _tmp$711;
      struct $StringView _x$118;
      int32_t _tmp$709;
      struct $StringView _tmp$708;
      int64_t _bind$120;
      moonbit_incref(repr$116);
      _bind$319 = $String$$offset_of_nth_char$inner(repr$116, 1, 0, _tmp$712);
      if (_bind$319 == 4294967296ll) {
        _tmp$710 = Moonbit_array_length(repr$116);
      } else {
        int64_t _Some$119 = _bind$319;
        _tmp$710 = (int32_t)_Some$119;
      }
      _tmp$711 = Moonbit_array_length(repr$116);
      _x$118 = (struct $StringView){_tmp$710, _tmp$711, repr$116};
      _tmp$709
      = Moonbit_array_length(
        $moonbitlang$core$builtin$parse$$2a$bind$7c$5443
      );
      moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5443);
      _tmp$708
      = (struct $StringView){
        0, _tmp$709, $moonbitlang$core$builtin$parse$$2a$bind$7c$5443
      };
      moonbit_incref(_x$118.$0);
      _bind$120 = $StringView$$find(_x$118, _tmp$708);
      if (_bind$120 == 4294967296ll) {
        moonbit_decref(_x$118.$0);
        moonbit_panic();
      } else {
        int64_t _Some$121 = _bind$120;
        int32_t _pkg_end$122 = (int32_t)_Some$121;
        int64_t _tmp$707 = (int64_t)_pkg_end$122;
        struct $StringView pkg$123;
        int32_t _tmp$706;
        struct $StringView _tmp$705;
        int64_t _bind$124;
        moonbit_incref(_x$118.$0);
        pkg$123 = $StringView$$view$inner(_x$118, 0, _tmp$707);
        _tmp$706
        = Moonbit_array_length(
          $moonbitlang$core$builtin$parse$$2a$bind$7c$5437
        );
        moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5437);
        _tmp$705
        = (struct $StringView){
          0, _tmp$706, $moonbitlang$core$builtin$parse$$2a$bind$7c$5437
        };
        moonbit_incref(_x$118.$0);
        _bind$124 = $StringView$$rev_find(_x$118, _tmp$705);
        if (_bind$124 == 4294967296ll) {
          moonbit_decref(pkg$123.$0);
          moonbit_decref(_x$118.$0);
          moonbit_panic();
        } else {
          int64_t _Some$125 = _bind$124;
          int32_t _start_loc_end$126 = (int32_t)_Some$125;
          int32_t _tmp$685 = _start_loc_end$126 + 1;
          int32_t end$687 = _x$118.$2;
          int32_t start$688 = _x$118.$1;
          int32_t _tmp$686 = end$687 - start$688;
          if (_tmp$685 < _tmp$686) {
            int32_t _tmp$704 = _start_loc_end$126 + 1;
            struct $StringView end_loc$127;
            struct $$3c$StringView$2a$StringView$3e$* _bind$128;
            moonbit_incref(_x$118.$0);
            end_loc$127
            = $StringView$$view$inner(
              _x$118, _tmp$704, 4294967296ll
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
              struct $StringView _field$945 =
                (struct $StringView){
                  _x$130->$0_1, _x$130->$0_2, _x$130->$0_0
                };
              struct $StringView _end_line$131 = _field$945;
              struct $StringView _field$944 =
                (struct $StringView){
                  _x$130->$1_1, _x$130->$1_2, _x$130->$1_0
                };
              int32_t _cnt$1002 = Moonbit_object_header(_x$130)->rc;
              struct $StringView _end_column$132;
              int64_t _tmp$703;
              struct $StringView rest$133;
              int32_t _tmp$702;
              struct $StringView _tmp$701;
              int64_t _bind$135;
              if (_cnt$1002 > 1) {
                int32_t _new_cnt$1003;
                moonbit_incref(_field$944.$0);
                moonbit_incref(_end_line$131.$0);
                _new_cnt$1003 = _cnt$1002 - 1;
                Moonbit_object_header(_x$130)->rc = _new_cnt$1003;
              } else if (_cnt$1002 == 1) {
                moonbit_free(_x$130);
              }
              _end_column$132 = _field$944;
              _tmp$703 = (int64_t)_start_loc_end$126;
              rest$133 = $StringView$$view$inner(_x$118, 0, _tmp$703);
              _tmp$702
              = Moonbit_array_length(
                $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              );
              moonbit_incref(
                $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              );
              _tmp$701
              = (struct $StringView){
                0, _tmp$702, $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              };
              moonbit_incref(rest$133.$0);
              _bind$135 = $StringView$$rev_find(rest$133, _tmp$701);
              if (_bind$135 == 4294967296ll) {
                moonbit_decref(rest$133.$0);
                moonbit_decref(_end_column$132.$0);
                moonbit_decref(_end_line$131.$0);
                moonbit_decref(pkg$123.$0);
                goto $join$134;
              } else {
                int64_t _Some$136 = _bind$135;
                int32_t _start_line_end$137 = (int32_t)_Some$136;
                int64_t _tmp$700 = (int64_t)_start_line_end$137;
                struct $StringView _tmp$697;
                int32_t _tmp$699;
                struct $StringView _tmp$698;
                int64_t _bind$138;
                moonbit_incref(rest$133.$0);
                _tmp$697 = $StringView$$view$inner(rest$133, 0, _tmp$700);
                _tmp$699
                = Moonbit_array_length(
                  $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                );
                moonbit_incref(
                  $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                );
                _tmp$698
                = (struct $StringView){
                  0,
                    _tmp$699,
                    $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                };
                _bind$138 = $StringView$$rev_find(_tmp$697, _tmp$698);
                if (_bind$138 == 4294967296ll) {
                  moonbit_decref(rest$133.$0);
                  moonbit_decref(_end_column$132.$0);
                  moonbit_decref(_end_line$131.$0);
                  moonbit_decref(pkg$123.$0);
                  goto $join$134;
                } else {
                  int64_t _Some$139 = _bind$138;
                  int32_t _filename_end$140 = (int32_t)_Some$139;
                  int32_t _tmp$689 = _filename_end$140 + 1;
                  int32_t end$691 = rest$133.$2;
                  int32_t start$692 = rest$133.$1;
                  int32_t _tmp$690 = end$691 - start$692;
                  if (_tmp$689 < _tmp$690) {
                    int32_t _tmp$696 = _filename_end$140 + 1;
                    struct $StringView start_loc$141;
                    struct $$3c$StringView$2a$StringView$3e$* _bind$142;
                    moonbit_incref(rest$133.$0);
                    start_loc$141
                    = $StringView$$view$inner(
                      rest$133, _tmp$696, 4294967296ll
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
                      struct $StringView _field$943 =
                        (struct $StringView){
                          _x$144->$0_1, _x$144->$0_2, _x$144->$0_0
                        };
                      struct $StringView _start_line$145 = _field$943;
                      struct $StringView _field$942 =
                        (struct $StringView){
                          _x$144->$1_1, _x$144->$1_2, _x$144->$1_0
                        };
                      int32_t _cnt$1004 = Moonbit_object_header(_x$144)->rc;
                      struct $StringView _start_column$146;
                      int32_t _tmp$693;
                      if (_cnt$1004 > 1) {
                        int32_t _new_cnt$1005;
                        moonbit_incref(_field$942.$0);
                        moonbit_incref(_start_line$145.$0);
                        _new_cnt$1005 = _cnt$1004 - 1;
                        Moonbit_object_header(_x$144)->rc = _new_cnt$1005;
                      } else if (_cnt$1004 == 1) {
                        moonbit_free(_x$144);
                      }
                      _start_column$146 = _field$942;
                      _tmp$693 = _pkg_end$122 + 1;
                      if (_filename_end$140 > _tmp$693) {
                        int32_t _tmp$694 = _pkg_end$122 + 1;
                        int64_t _tmp$695 = (int64_t)_filename_end$140;
                        struct $StringView filename$147 =
                          $StringView$$view$inner(
                            rest$133, _tmp$694, _tmp$695
                          );
                        struct $$moonbitlang$core$builtin$SourceLocRepr* _block$1032 =
                          (struct $$moonbitlang$core$builtin$SourceLocRepr*)moonbit_malloc(
                            sizeof(
                              struct $$moonbitlang$core$builtin$SourceLocRepr
                            )
                          );
                        Moonbit_object_header(_block$1032)->meta
                        = Moonbit_make_regular_object_header(
                          offsetof(
                            struct $$moonbitlang$core$builtin$SourceLocRepr,
                              $0_0
                          )
                          >> 2,
                            6,
                            0
                        );
                        _block$1032->$0_0 = pkg$123.$0;
                        _block$1032->$0_1 = pkg$123.$1;
                        _block$1032->$0_2 = pkg$123.$2;
                        _block$1032->$1_0 = filename$147.$0;
                        _block$1032->$1_1 = filename$147.$1;
                        _block$1032->$1_2 = filename$147.$2;
                        _block$1032->$2_0 = _start_line$145.$0;
                        _block$1032->$2_1 = _start_line$145.$1;
                        _block$1032->$2_2 = _start_line$145.$2;
                        _block$1032->$3_0 = _start_column$146.$0;
                        _block$1032->$3_1 = _start_column$146.$1;
                        _block$1032->$3_2 = _start_column$146.$2;
                        _block$1032->$4_0 = _end_line$131.$0;
                        _block$1032->$4_1 = _end_line$131.$1;
                        _block$1032->$4_2 = _end_line$131.$2;
                        _block$1032->$5_0 = _end_column$132.$0;
                        _block$1032->$5_1 = _end_column$132.$1;
                        _block$1032->$5_2 = _end_column$132.$2;
                        return _block$1032;
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
  int32_t _tmp$682 =
    Moonbit_array_length($moonbitlang$core$builtin$parse$$2a$bind$7c$5404);
  struct $StringView _tmp$681;
  int64_t _bind$111;
  moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5404);
  _tmp$681
  = (struct $StringView){
    0, _tmp$682, $moonbitlang$core$builtin$parse$$2a$bind$7c$5404
  };
  moonbit_incref(view$112.$0);
  _bind$111 = $StringView$$find(view$112, _tmp$681);
  if (_bind$111 == 4294967296ll) {
    moonbit_decref(view$112.$0);
    return 0;
  } else {
    int64_t _Some$113 = _bind$111;
    int32_t _i$114 = (int32_t)_Some$113;
    int32_t _if_result$1033;
    if (_i$114 > 0) {
      int32_t _tmp$672 = _i$114 + 1;
      int32_t end$674 = view$112.$2;
      int32_t start$675 = view$112.$1;
      int32_t _tmp$673 = end$674 - start$675;
      _if_result$1033 = _tmp$672 < _tmp$673;
    } else {
      _if_result$1033 = 0;
    }
    if (_if_result$1033) {
      int64_t _tmp$680 = (int64_t)_i$114;
      struct $StringView _tmp$677;
      int32_t _tmp$679;
      struct $StringView _tmp$678;
      struct $$3c$StringView$2a$StringView$3e$* _tuple$676;
      moonbit_incref(view$112.$0);
      _tmp$677 = $StringView$$view$inner(view$112, 0, _tmp$680);
      _tmp$679 = _i$114 + 1;
      _tmp$678 = $StringView$$view$inner(view$112, _tmp$679, 4294967296ll);
      _tuple$676
      = (struct $$3c$StringView$2a$StringView$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$StringView$3e$)
        );
      Moonbit_object_header(_tuple$676)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $$3c$StringView$2a$StringView$3e$, $0_0) >> 2, 2, 0
      );
      _tuple$676->$0_0 = _tmp$677.$0;
      _tuple$676->$0_1 = _tmp$677.$1;
      _tuple$676->$0_2 = _tmp$677.$2;
      _tuple$676->$1_0 = _tmp$678.$0;
      _tuple$676->$1_1 = _tmp$678.$1;
      _tuple$676->$1_2 = _tmp$678.$2;
      return _tuple$676;
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
  int32_t _if_result$1034;
  if (end_offset$107 == 4294967296ll) {
    int32_t end$670 = self$109.$2;
    int32_t start$671 = self$109.$1;
    end_offset$106 = end$670 - start$671;
  } else {
    int64_t _Some$108 = end_offset$107;
    end_offset$106 = (int32_t)_Some$108;
  }
  if (start_offset$110 >= 0) {
    if (start_offset$110 <= end_offset$106) {
      int32_t end$663 = self$109.$2;
      int32_t start$664 = self$109.$1;
      int32_t _tmp$662 = end$663 - start$664;
      _if_result$1034 = end_offset$106 <= _tmp$662;
    } else {
      _if_result$1034 = 0;
    }
  } else {
    _if_result$1034 = 0;
  }
  if (_if_result$1034) {
    moonbit_string_t _field$947 = self$109.$0;
    moonbit_string_t str$665 = _field$947;
    int32_t start$669 = self$109.$1;
    int32_t _tmp$666 = start$669 + start_offset$110;
    int32_t _field$946 = self$109.$1;
    int32_t start$668 = _field$946;
    int32_t _tmp$667 = start$668 + end_offset$106;
    return (struct $StringView){_tmp$666, _tmp$667, str$665};
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
  int32_t end$660 = str$104.$2;
  int32_t start$661 = str$104.$1;
  int32_t _tmp$659 = end$660 - start$661;
  if (_tmp$659 <= 4) {
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
  int32_t end$657 = haystack$95.$2;
  int32_t start$658 = haystack$95.$1;
  int32_t haystack_len$94 = end$657 - start$658;
  int32_t end$655 = needle$97.$2;
  int32_t start$656 = needle$97.$1;
  int32_t needle_len$96 = end$655 - start$656;
  if (needle_len$96 > 0) {
    if (haystack_len$94 >= needle_len$96) {
      int32_t _p$398 = 0;
      moonbit_string_t _field$955 = needle$97.$0;
      moonbit_string_t str$652 = _field$955;
      int32_t start$654 = needle$97.$1;
      int32_t _tmp$653 = start$654 + _p$398;
      int32_t _tmp$954 = str$652[_tmp$653];
      int32_t needle_first$98 = _tmp$954;
      int32_t i$99 = haystack_len$94 - needle_len$96;
      while (1) {
        int32_t _tmp$632 = i$99;
        if (_tmp$632 >= 0) {
          int32_t _tmp$639;
          while (1) {
            int32_t _tmp$637 = i$99;
            int32_t _if_result$1037;
            if (_tmp$637 >= 0) {
              int32_t _p$401 = i$99;
              moonbit_string_t _field$953 = haystack$95.$0;
              moonbit_string_t str$634 = _field$953;
              int32_t start$636 = haystack$95.$1;
              int32_t _tmp$635 = start$636 + _p$401;
              int32_t _tmp$952 = str$634[_tmp$635];
              int32_t _tmp$633 = _tmp$952;
              _if_result$1037 = _tmp$633 != needle_first$98;
            } else {
              _if_result$1037 = 0;
            }
            if (_if_result$1037) {
              int32_t _tmp$638 = i$99;
              i$99 = _tmp$638 - 1;
              continue;
            }
            break;
          }
          _tmp$639 = i$99;
          if (_tmp$639 >= 0) {
            int32_t j$101 = 1;
            int32_t _tmp$651;
            while (1) {
              if (j$101 < needle_len$96) {
                int32_t _tmp$648 = i$99;
                int32_t _p$404 = _tmp$648 + j$101;
                moonbit_string_t _field$951 = haystack$95.$0;
                moonbit_string_t str$645 = _field$951;
                int32_t start$647 = haystack$95.$1;
                int32_t _tmp$646 = start$647 + _p$404;
                int32_t _tmp$950 = str$645[_tmp$646];
                int32_t _tmp$640 = _tmp$950;
                moonbit_string_t _field$949 = needle$97.$0;
                moonbit_string_t str$642 = _field$949;
                int32_t start$644 = needle$97.$1;
                int32_t _tmp$643 = start$644 + j$101;
                int32_t _tmp$948 = str$642[_tmp$643];
                int32_t _tmp$641 = _tmp$948;
                int32_t _tmp$649;
                if (_tmp$640 != _tmp$641) {
                  break;
                }
                _tmp$649 = j$101 + 1;
                j$101 = _tmp$649;
                continue;
              } else {
                int32_t _tmp$650;
                moonbit_decref(needle$97.$0);
                moonbit_decref(haystack$95.$0);
                _tmp$650 = i$99;
                return (int64_t)_tmp$650;
              }
              break;
            }
            _tmp$651 = i$99;
            i$99 = _tmp$651 - 1;
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
  int32_t end$630 = haystack$84.$2;
  int32_t start$631 = haystack$84.$1;
  int32_t haystack_len$83 = end$630 - start$631;
  int32_t end$628 = needle$86.$2;
  int32_t start$629 = needle$86.$1;
  int32_t needle_len$85 = end$628 - start$629;
  if (needle_len$85 > 0) {
    if (haystack_len$83 >= needle_len$85) {
      int32_t* skip_table$87 =
        (int32_t*)moonbit_make_int32_array(256, needle_len$85);
      int32_t _tmp$610 = needle_len$85 - 1;
      int32_t i$88 = _tmp$610;
      int32_t _tmp$627;
      int32_t i$90;
      while (1) {
        if (i$88 > 0) {
          moonbit_string_t _field$963 = needle$86.$0;
          moonbit_string_t str$606 = _field$963;
          int32_t start$608 = needle$86.$1;
          int32_t _tmp$607 = start$608 + i$88;
          int32_t _tmp$962 = str$606[_tmp$607];
          int32_t _tmp$605 = _tmp$962;
          int32_t _tmp$604 = _tmp$605 & 255;
          int32_t _tmp$609;
          if (
            _tmp$604 < 0 || _tmp$604 >= Moonbit_array_length(skip_table$87)
          ) {
            moonbit_panic();
          }
          skip_table$87[_tmp$604] = i$88;
          _tmp$609 = i$88 - 1;
          i$88 = _tmp$609;
          continue;
        }
        break;
      }
      _tmp$627 = haystack_len$83 - needle_len$85;
      i$90 = _tmp$627;
      while (1) {
        if (i$90 >= 0) {
          int32_t j$91 = 0;
          moonbit_string_t _field$957;
          moonbit_string_t str$624;
          int32_t start$626;
          int32_t _tmp$625;
          int32_t _tmp$956;
          int32_t _tmp$623;
          int32_t _tmp$622;
          int32_t _tmp$621;
          int32_t _tmp$620;
          while (1) {
            if (j$91 < needle_len$85) {
              int32_t _p$387 = i$90 + j$91;
              moonbit_string_t _field$961 = haystack$84.$0;
              moonbit_string_t str$616 = _field$961;
              int32_t start$618 = haystack$84.$1;
              int32_t _tmp$617 = start$618 + _p$387;
              int32_t _tmp$960 = str$616[_tmp$617];
              int32_t _tmp$611 = _tmp$960;
              moonbit_string_t _field$959 = needle$86.$0;
              moonbit_string_t str$613 = _field$959;
              int32_t start$615 = needle$86.$1;
              int32_t _tmp$614 = start$615 + j$91;
              int32_t _tmp$958 = str$613[_tmp$614];
              int32_t _tmp$612 = _tmp$958;
              int32_t _tmp$619;
              if (_tmp$611 != _tmp$612) {
                break;
              }
              _tmp$619 = j$91 + 1;
              j$91 = _tmp$619;
              continue;
            } else {
              moonbit_decref(skip_table$87);
              moonbit_decref(needle$86.$0);
              moonbit_decref(haystack$84.$0);
              return (int64_t)i$90;
            }
            break;
          }
          _field$957 = haystack$84.$0;
          str$624 = _field$957;
          start$626 = haystack$84.$1;
          _tmp$625 = start$626 + i$90;
          _tmp$956 = str$624[_tmp$625];
          _tmp$623 = _tmp$956;
          _tmp$622 = _tmp$623 & 255;
          if (
            _tmp$622 < 0 || _tmp$622 >= Moonbit_array_length(skip_table$87)
          ) {
            moonbit_panic();
          }
          _tmp$621 = (int32_t)skip_table$87[_tmp$622];
          _tmp$620 = i$90 - _tmp$621;
          i$90 = _tmp$620;
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
  int32_t end$602 = str$81.$2;
  int32_t start$603 = str$81.$1;
  int32_t _tmp$601 = end$602 - start$603;
  if (_tmp$601 <= 4) {
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
  int32_t end$599 = haystack$71.$2;
  int32_t start$600 = haystack$71.$1;
  int32_t haystack_len$70 = end$599 - start$600;
  int32_t end$597 = needle$73.$2;
  int32_t start$598 = needle$73.$1;
  int32_t needle_len$72 = end$597 - start$598;
  if (needle_len$72 > 0) {
    if (haystack_len$70 >= needle_len$72) {
      int32_t _p$368 = 0;
      moonbit_string_t _field$971 = needle$73.$0;
      moonbit_string_t str$594 = _field$971;
      int32_t start$596 = needle$73.$1;
      int32_t _tmp$595 = start$596 + _p$368;
      int32_t _tmp$970 = str$594[_tmp$595];
      int32_t needle_first$74 = _tmp$970;
      int32_t forward_len$75 = haystack_len$70 - needle_len$72;
      int32_t i$76 = 0;
      while (1) {
        int32_t _tmp$574 = i$76;
        if (_tmp$574 <= forward_len$75) {
          int32_t _tmp$581;
          while (1) {
            int32_t _tmp$579 = i$76;
            int32_t _if_result$1044;
            if (_tmp$579 <= forward_len$75) {
              int32_t _p$371 = i$76;
              moonbit_string_t _field$969 = haystack$71.$0;
              moonbit_string_t str$576 = _field$969;
              int32_t start$578 = haystack$71.$1;
              int32_t _tmp$577 = start$578 + _p$371;
              int32_t _tmp$968 = str$576[_tmp$577];
              int32_t _tmp$575 = _tmp$968;
              _if_result$1044 = _tmp$575 != needle_first$74;
            } else {
              _if_result$1044 = 0;
            }
            if (_if_result$1044) {
              int32_t _tmp$580 = i$76;
              i$76 = _tmp$580 + 1;
              continue;
            }
            break;
          }
          _tmp$581 = i$76;
          if (_tmp$581 <= forward_len$75) {
            int32_t j$78 = 1;
            int32_t _tmp$593;
            while (1) {
              if (j$78 < needle_len$72) {
                int32_t _tmp$590 = i$76;
                int32_t _p$374 = _tmp$590 + j$78;
                moonbit_string_t _field$967 = haystack$71.$0;
                moonbit_string_t str$587 = _field$967;
                int32_t start$589 = haystack$71.$1;
                int32_t _tmp$588 = start$589 + _p$374;
                int32_t _tmp$966 = str$587[_tmp$588];
                int32_t _tmp$582 = _tmp$966;
                moonbit_string_t _field$965 = needle$73.$0;
                moonbit_string_t str$584 = _field$965;
                int32_t start$586 = needle$73.$1;
                int32_t _tmp$585 = start$586 + j$78;
                int32_t _tmp$964 = str$584[_tmp$585];
                int32_t _tmp$583 = _tmp$964;
                int32_t _tmp$591;
                if (_tmp$582 != _tmp$583) {
                  break;
                }
                _tmp$591 = j$78 + 1;
                j$78 = _tmp$591;
                continue;
              } else {
                int32_t _tmp$592;
                moonbit_decref(needle$73.$0);
                moonbit_decref(haystack$71.$0);
                _tmp$592 = i$76;
                return (int64_t)_tmp$592;
              }
              break;
            }
            _tmp$593 = i$76;
            i$76 = _tmp$593 + 1;
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
  int32_t end$572 = haystack$57.$2;
  int32_t start$573 = haystack$57.$1;
  int32_t haystack_len$56 = end$572 - start$573;
  int32_t end$570 = needle$59.$2;
  int32_t start$571 = needle$59.$1;
  int32_t needle_len$58 = end$570 - start$571;
  if (needle_len$58 > 0) {
    if (haystack_len$56 >= needle_len$58) {
      int32_t* skip_table$60 =
        (int32_t*)moonbit_make_int32_array(256, needle_len$58);
      int32_t _end4301$61 = needle_len$58 - 1;
      int32_t i$62 = 0;
      int32_t i$64;
      while (1) {
        if (i$62 < _end4301$61) {
          moonbit_string_t _field$979 = needle$59.$0;
          moonbit_string_t str$548 = _field$979;
          int32_t start$550 = needle$59.$1;
          int32_t _tmp$549 = start$550 + i$62;
          int32_t _tmp$978 = str$548[_tmp$549];
          int32_t _tmp$547 = _tmp$978;
          int32_t _tmp$544 = _tmp$547 & 255;
          int32_t _tmp$546 = needle_len$58 - 1;
          int32_t _tmp$545 = _tmp$546 - i$62;
          int32_t _tmp$551;
          if (
            _tmp$544 < 0 || _tmp$544 >= Moonbit_array_length(skip_table$60)
          ) {
            moonbit_panic();
          }
          skip_table$60[_tmp$544] = _tmp$545;
          _tmp$551 = i$62 + 1;
          i$62 = _tmp$551;
          continue;
        }
        break;
      }
      i$64 = 0;
      while (1) {
        int32_t _tmp$552 = haystack_len$56 - needle_len$58;
        if (i$64 <= _tmp$552) {
          int32_t _end4307$65 = needle_len$58 - 1;
          int32_t j$66 = 0;
          int32_t _tmp$569;
          int32_t _p$361;
          moonbit_string_t _field$973;
          moonbit_string_t str$566;
          int32_t start$568;
          int32_t _tmp$567;
          int32_t _tmp$972;
          int32_t _tmp$565;
          int32_t _tmp$564;
          int32_t _tmp$563;
          int32_t _tmp$562;
          while (1) {
            if (j$66 <= _end4307$65) {
              int32_t _p$356 = i$64 + j$66;
              moonbit_string_t _field$977 = haystack$57.$0;
              moonbit_string_t str$558 = _field$977;
              int32_t start$560 = haystack$57.$1;
              int32_t _tmp$559 = start$560 + _p$356;
              int32_t _tmp$976 = str$558[_tmp$559];
              int32_t _tmp$553 = _tmp$976;
              moonbit_string_t _field$975 = needle$59.$0;
              moonbit_string_t str$555 = _field$975;
              int32_t start$557 = needle$59.$1;
              int32_t _tmp$556 = start$557 + j$66;
              int32_t _tmp$974 = str$555[_tmp$556];
              int32_t _tmp$554 = _tmp$974;
              int32_t _tmp$561;
              if (_tmp$553 != _tmp$554) {
                break;
              }
              _tmp$561 = j$66 + 1;
              j$66 = _tmp$561;
              continue;
            } else {
              moonbit_decref(skip_table$60);
              moonbit_decref(needle$59.$0);
              moonbit_decref(haystack$57.$0);
              return (int64_t)i$64;
            }
            break;
          }
          _tmp$569 = i$64 + needle_len$58;
          _p$361 = _tmp$569 - 1;
          _field$973 = haystack$57.$0;
          str$566 = _field$973;
          start$568 = haystack$57.$1;
          _tmp$567 = start$568 + _p$361;
          _tmp$972 = str$566[_tmp$567];
          _tmp$565 = _tmp$972;
          _tmp$564 = _tmp$565 & 255;
          if (
            _tmp$564 < 0 || _tmp$564 >= Moonbit_array_length(skip_table$60)
          ) {
            moonbit_panic();
          }
          _tmp$563 = (int32_t)skip_table$60[_tmp$564];
          _tmp$562 = i$64 + _tmp$563;
          i$64 = _tmp$562;
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
  moonbit_string_t _field$982 = self$53.$0;
  moonbit_string_t str$541 = _field$982;
  int32_t _field$981 = self$53.$1;
  int32_t start$543 = _field$981;
  int32_t _tmp$542 = start$543 + index$54;
  int32_t _tmp$980 = str$541[_tmp$542];
  moonbit_decref(str$541);
  return _tmp$980;
}

int32_t $StringView$$length(struct $StringView self$52) {
  int32_t end$539 = self$52.$2;
  int32_t _field$983 = self$52.$1;
  int32_t start$540;
  moonbit_decref(self$52.$0);
  start$540 = _field$983;
  return end$539 - start$540;
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
  int32_t len$534 = self$47->$1;
  int32_t _tmp$533 = len$534 + 4;
  moonbit_bytes_t _field$984;
  moonbit_bytes_t data$537;
  int32_t len$538;
  int32_t inc$48;
  int32_t len$536;
  int32_t _tmp$535;
  moonbit_incref(self$47);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$47, _tmp$533
  );
  _field$984 = self$47->$0;
  data$537 = _field$984;
  len$538 = self$47->$1;
  moonbit_incref(data$537);
  inc$48 = $FixedArray$$set_utf16le_char(data$537, len$538, ch$49);
  len$536 = self$47->$1;
  _tmp$535 = len$536 + inc$48;
  self$47->$1 = _tmp$535;
  moonbit_decref(self$47);
  return 0;
}

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$42,
  int32_t required$43
) {
  moonbit_bytes_t _field$988 = self$42->$0;
  moonbit_bytes_t data$532 = _field$988;
  int32_t _tmp$987 = Moonbit_array_length(data$532);
  int32_t current_len$41 = _tmp$987;
  int32_t enough_space$44;
  int32_t _tmp$531;
  moonbit_bytes_t new_data$46;
  moonbit_bytes_t _field$986;
  moonbit_bytes_t data$529;
  int32_t len$530;
  moonbit_bytes_t _old$985;
  if (required$43 <= current_len$41) {
    moonbit_decref(self$42);
    return 0;
  }
  enough_space$44 = current_len$41;
  while (1) {
    int32_t _tmp$527 = enough_space$44;
    if (_tmp$527 < required$43) {
      int32_t _tmp$528 = enough_space$44;
      enough_space$44 = _tmp$528 * 2;
      continue;
    }
    break;
  }
  _tmp$531 = enough_space$44;
  new_data$46 = (moonbit_bytes_t)moonbit_make_bytes(_tmp$531, 0);
  _field$986 = self$42->$0;
  data$529 = _field$986;
  len$530 = self$42->$1;
  moonbit_incref(data$529);
  moonbit_incref(new_data$46);
  $FixedArray$$unsafe_blit$0(new_data$46, 0, data$529, 0, len$530);
  _old$985 = self$42->$0;
  moonbit_decref(_old$985);
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
  int32_t _tmp$526 = value$35;
  uint32_t code$34 = *(uint32_t*)&_tmp$526;
  if (code$34 < 65536u) {
    uint32_t _p$330 = code$34 & 255u;
    int32_t _tmp$509 = *(int32_t*)&_p$330;
    int32_t _tmp$508 = _tmp$509 & 0xff;
    int32_t _tmp$510;
    uint32_t _p$333;
    int32_t _tmp$512;
    int32_t _tmp$511;
    if (offset$37 < 0 || offset$37 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[offset$37] = _tmp$508;
    _tmp$510 = offset$37 + 1;
    _p$333 = code$34 >> 8;
    _tmp$512 = *(int32_t*)&_p$333;
    _tmp$511 = _tmp$512 & 0xff;
    if (_tmp$510 < 0 || _tmp$510 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[_tmp$510] = _tmp$511;
    moonbit_decref(self$36);
    return 2;
  } else if (code$34 < 1114112u) {
    uint32_t hi$38 = code$34 - 65536u;
    uint32_t _tmp$525 = hi$38 >> 10;
    uint32_t lo$39 = _tmp$525 | 55296u;
    uint32_t _tmp$524 = hi$38 & 1023u;
    uint32_t hi$40 = _tmp$524 | 56320u;
    uint32_t _p$336 = lo$39 & 255u;
    int32_t _tmp$514 = *(int32_t*)&_p$336;
    int32_t _tmp$513 = _tmp$514 & 0xff;
    int32_t _tmp$515;
    uint32_t _p$339;
    int32_t _tmp$517;
    int32_t _tmp$516;
    int32_t _tmp$518;
    uint32_t _p$342;
    int32_t _tmp$520;
    int32_t _tmp$519;
    int32_t _tmp$521;
    uint32_t _p$345;
    int32_t _tmp$523;
    int32_t _tmp$522;
    if (offset$37 < 0 || offset$37 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[offset$37] = _tmp$513;
    _tmp$515 = offset$37 + 1;
    _p$339 = lo$39 >> 8;
    _tmp$517 = *(int32_t*)&_p$339;
    _tmp$516 = _tmp$517 & 0xff;
    if (_tmp$515 < 0 || _tmp$515 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[_tmp$515] = _tmp$516;
    _tmp$518 = offset$37 + 2;
    _p$342 = hi$40 & 255u;
    _tmp$520 = *(int32_t*)&_p$342;
    _tmp$519 = _tmp$520 & 0xff;
    if (_tmp$518 < 0 || _tmp$518 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[_tmp$518] = _tmp$519;
    _tmp$521 = offset$37 + 3;
    _p$345 = hi$40 >> 8;
    _tmp$523 = *(int32_t*)&_p$345;
    _tmp$522 = _tmp$523 & 0xff;
    if (_tmp$521 < 0 || _tmp$521 >= Moonbit_array_length(self$36)) {
      moonbit_panic();
    }
    self$36[_tmp$521] = _tmp$522;
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
  int32_t _tmp$507 = *(int32_t*)&self$33;
  return _tmp$507 & 0xff;
}

uint32_t $Char$$to_uint(int32_t self$32) {
  int32_t _tmp$506 = self$32;
  return *(uint32_t*)&_tmp$506;
}

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$31
) {
  moonbit_bytes_t _field$990 = self$31->$0;
  moonbit_bytes_t data$505 = _field$990;
  moonbit_bytes_t _tmp$502;
  int32_t _field$989;
  int32_t len$504;
  int64_t _tmp$503;
  moonbit_incref(data$505);
  _tmp$502 = data$505;
  _field$989 = self$31->$1;
  moonbit_decref(self$31);
  len$504 = _field$989;
  _tmp$503 = (int64_t)len$504;
  return $Bytes$$to_unchecked_string$inner(_tmp$502, 0, _tmp$503);
}

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$26,
  int32_t offset$30,
  int64_t length$28
) {
  int32_t len$25 = Moonbit_array_length(self$26);
  int32_t length$27;
  int32_t _if_result$1050;
  if (length$28 == 4294967296ll) {
    length$27 = len$25 - offset$30;
  } else {
    int64_t _Some$29 = length$28;
    length$27 = (int32_t)_Some$29;
  }
  if (offset$30 >= 0) {
    if (length$27 >= 0) {
      int32_t _tmp$501 = offset$30 + length$27;
      _if_result$1050 = _tmp$501 <= len$25;
    } else {
      _if_result$1050 = 0;
    }
  } else {
    _if_result$1050 = 0;
  }
  if (_if_result$1050) {
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
  struct $$moonbitlang$core$builtin$StringBuilder* _block$1051;
  if (size_hint$23 < 1) {
    initial$22 = 1;
  } else {
    initial$22 = size_hint$23;
  }
  data$24 = (moonbit_bytes_t)moonbit_make_bytes(initial$22, 0);
  _block$1051
  = (struct $$moonbitlang$core$builtin$StringBuilder*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$builtin$StringBuilder)
    );
  Moonbit_object_header(_block$1051)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $$moonbitlang$core$builtin$StringBuilder, $0) >> 2, 1, 0
  );
  _block$1051->$0 = data$24;
  _block$1051->$1 = 0;
  return _block$1051;
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
        int32_t _tmp$492 = dst_offset$15 + i$17;
        int32_t _tmp$494 = src_offset$16 + i$17;
        int32_t _tmp$493;
        int32_t _tmp$495;
        if (_tmp$494 < 0 || _tmp$494 >= Moonbit_array_length(src$14)) {
          moonbit_panic();
        }
        _tmp$493 = (int32_t)src$14[_tmp$494];
        if (_tmp$492 < 0 || _tmp$492 >= Moonbit_array_length(dst$13)) {
          moonbit_panic();
        }
        dst$13[_tmp$492] = _tmp$493;
        _tmp$495 = i$17 + 1;
        i$17 = _tmp$495;
        continue;
      } else {
        moonbit_decref(src$14);
        moonbit_decref(dst$13);
      }
      break;
    }
  } else {
    int32_t _tmp$500 = len$18 - 1;
    int32_t i$20 = _tmp$500;
    while (1) {
      if (i$20 >= 0) {
        int32_t _tmp$496 = dst_offset$15 + i$20;
        int32_t _tmp$498 = src_offset$16 + i$20;
        int32_t _tmp$497;
        int32_t _tmp$499;
        if (_tmp$498 < 0 || _tmp$498 >= Moonbit_array_length(src$14)) {
          moonbit_panic();
        }
        _tmp$497 = (int32_t)src$14[_tmp$498];
        if (_tmp$496 < 0 || _tmp$496 >= Moonbit_array_length(dst$13)) {
          moonbit_panic();
        }
        dst$13[_tmp$496] = _tmp$497;
        _tmp$499 = i$20 - 1;
        i$20 = _tmp$499;
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
  moonbit_string_t _tmp$490 =
    moonbit_add_string(
      string$11, (moonbit_string_t)moonbit_string_literal_15.data
    );
  moonbit_string_t _tmp$491 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$12);
  moonbit_string_t _tmp$489 = moonbit_add_string(_tmp$490, _tmp$491);
  moonbit_string_t _tmp$488 =
    moonbit_add_string(
      _tmp$489, (moonbit_string_t)moonbit_string_literal_16.data
    );
  return $moonbitlang$core$abort$abort$3(_tmp$488);
}

struct $StringView $moonbitlang$core$builtin$abort$2(
  moonbit_string_t string$9,
  moonbit_string_t loc$10
) {
  moonbit_string_t _tmp$486 =
    moonbit_add_string(
      string$9, (moonbit_string_t)moonbit_string_literal_15.data
    );
  moonbit_string_t _tmp$487 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$10);
  moonbit_string_t _tmp$485 = moonbit_add_string(_tmp$486, _tmp$487);
  moonbit_string_t _tmp$484 =
    moonbit_add_string(
      _tmp$485, (moonbit_string_t)moonbit_string_literal_16.data
    );
  return $moonbitlang$core$abort$abort$2(_tmp$484);
}

int32_t $moonbitlang$core$builtin$abort$1(
  moonbit_string_t string$7,
  moonbit_string_t loc$8
) {
  moonbit_string_t _tmp$482 =
    moonbit_add_string(
      string$7, (moonbit_string_t)moonbit_string_literal_15.data
    );
  moonbit_string_t _tmp$483 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$8);
  moonbit_string_t _tmp$481 = moonbit_add_string(_tmp$482, _tmp$483);
  moonbit_string_t _tmp$480 =
    moonbit_add_string(
      _tmp$481, (moonbit_string_t)moonbit_string_literal_16.data
    );
  return $moonbitlang$core$abort$abort$1(_tmp$480);
}

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$5,
  moonbit_string_t loc$6
) {
  moonbit_string_t _tmp$478 =
    moonbit_add_string(
      string$5, (moonbit_string_t)moonbit_string_literal_15.data
    );
  moonbit_string_t _tmp$479 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$6);
  moonbit_string_t _tmp$477 = moonbit_add_string(_tmp$478, _tmp$479);
  moonbit_string_t _tmp$476 =
    moonbit_add_string(
      _tmp$477, (moonbit_string_t)moonbit_string_literal_16.data
    );
  $moonbitlang$core$abort$abort$0(_tmp$476);
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
  void* _obj_ptr$469,
  int32_t _param$468
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$467 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$469;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
    _self$467, _param$468
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$466,
  struct $StringView _param$465
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$464 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$466;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    _self$464, _param$465
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$463,
  moonbit_string_t _param$460,
  int32_t _param$461,
  int32_t _param$462
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$459 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$463;
  $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
    _self$459, _param$460, _param$461, _param$462
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$458,
  moonbit_string_t _param$457
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$456 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$458;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
    _self$456, _param$457
  );
  return 0;
}

void moonbit_init() {
  $moonbitlang$core$builtin$boyer_moore_horspool_find$constr$55 = (int64_t)0;
  $moonbitlang$core$builtin$brute_force_find$constr$69 = (int64_t)0;
}

int main(int argc, char** argv) {
  moonbit_string_t _tmp$475;
  moonbit_string_t _tmp$474;
  moonbit_string_t _tmp$471;
  int32_t _tmp$473;
  moonbit_string_t _tmp$472;
  moonbit_string_t _tmp$470;
  moonbit_runtime_init(argc, argv);
  moonbit_init();
  _tmp$475 = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(5);
  _tmp$474
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_17.data, _tmp$475
  );
  _tmp$471
  = moonbit_add_string(
    _tmp$474, (moonbit_string_t)moonbit_string_literal_18.data
  );
  _tmp$473 = $username$moonbit_examples$cmd$factorial$factorial(5);
  _tmp$472
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
    _tmp$473
  );
  _tmp$470 = moonbit_add_string(_tmp$471, _tmp$472);
  $moonbitlang$core$builtin$println$0(_tmp$470);
  return 0;
}