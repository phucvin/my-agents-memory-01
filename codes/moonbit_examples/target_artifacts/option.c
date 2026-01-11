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
  int32_t a$289,
  int32_t b$288
);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$286,
  struct $$moonbitlang$core$builtin$Logger logger$287
);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$249,
  struct $$moonbitlang$core$builtin$Logger logger$285
);

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$247);

moonbit_string_t $$moonbitlang$core$builtin$Show$$String$$to_string(
  moonbit_string_t self$246
);

int32_t $$moonbitlang$core$builtin$Show$$Int$$output(
  int32_t self$245,
  struct $$moonbitlang$core$builtin$Logger logger$244
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$242,
  struct $StringView str$243
);

moonbit_string_t $Int$$to_string$inner(int32_t self$226, int32_t radix$225);

int32_t $moonbitlang$core$builtin$radix_count32(
  uint32_t value$219,
  int32_t radix$222
);

int32_t $moonbitlang$core$builtin$hex_count32(uint32_t value$217);

int32_t $moonbitlang$core$builtin$dec_count32(uint32_t value$216);

int32_t $moonbitlang$core$builtin$int_to_string_dec(
  uint16_t* buffer$206,
  uint32_t num$194,
  int32_t digit_start$197,
  int32_t total_len$196
);

int32_t $moonbitlang$core$builtin$int_to_string_generic(
  uint16_t* buffer$188,
  uint32_t num$182,
  int32_t digit_start$180,
  int32_t total_len$179,
  int32_t radix$184
);

int32_t $moonbitlang$core$builtin$int_to_string_hex(
  uint16_t* buffer$175,
  uint32_t num$171,
  int32_t digit_start$169,
  int32_t total_len$168
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  moonbit_string_t self$166
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  int32_t self$164
);

int32_t $StringView$$start_offset(struct $StringView self$162);

int32_t $StringView$$length(struct $StringView self$161);

moonbit_string_t $StringView$$data(struct $StringView self$160);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$154,
  moonbit_string_t value$157,
  int32_t start$158,
  int32_t len$159
);

struct moonbit_result_0 $String$$sub(
  moonbit_string_t self$152,
  int64_t start$opt$150,
  int64_t end$153
);

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$142,
  int32_t start$148,
  int64_t end$144
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$139,
  moonbit_string_t str$140
);

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$131,
  int32_t bytes_offset$126,
  moonbit_string_t str$133,
  int32_t str_offset$129,
  int32_t length$127
);

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$48
);

int32_t $String$$unsafe_charcode_at(moonbit_string_t self$45, int32_t idx$46);

int32_t $Int$$is_trailing_surrogate(int32_t self$44);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$41,
  int32_t ch$43
);

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$36,
  int32_t required$37
);

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default();

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$30,
  int32_t offset$31,
  int32_t value$29
);

int32_t $UInt$$to_byte(uint32_t self$27);

uint32_t $Char$$to_uint(int32_t self$26);

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$25
);

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$20,
  int32_t offset$24,
  int64_t length$22
);

#define $moonbitlang$core$builtin$unsafe_sub_string moonbit_unsafe_bytes_sub_string

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$17
);

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
  void* _obj_ptr$463,
  int32_t _param$462
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$460,
  struct $StringView _param$459
);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$457,
  moonbit_string_t _param$454,
  int32_t _param$455,
  int32_t _param$456
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$452,
  moonbit_string_t _param$451
);

struct { int32_t rc; uint32_t meta; uint16_t const data[22];
} const moonbit_string_literal_8 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 21),
    67, 97, 110, 110, 111, 116, 32, 100, 105, 118, 105, 100, 101, 32,
    98, 121, 32, 122, 101, 114, 111, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[7];
} const moonbit_string_literal_6 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 6),
    10, 32, 32, 97, 116, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[31];
} const moonbit_string_literal_0 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 30),
    114, 97, 100, 105, 120, 32, 109, 117, 115, 116, 32, 98, 101, 32,
    98, 101, 116, 119, 101, 101, 110, 32, 50, 32, 97, 110, 100, 32, 51,
    54, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_2 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 48, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[18];
} const moonbit_string_literal_4 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 17),
    67, 104, 97, 114, 32, 111, 117, 116, 32, 111, 102, 32, 114, 97, 110,
    103, 101, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[4];
} const moonbit_string_literal_9 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 3),
    32, 47, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[49];
} const moonbit_string_literal_5 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 48),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 98, 121,
    116, 101, 115, 46, 109, 98, 116, 58, 50, 57, 56, 58, 53, 45, 50,
    57, 56, 58, 51, 49, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[53];
} const moonbit_string_literal_1 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 52),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 116, 111,
    95, 115, 116, 114, 105, 110, 103, 46, 109, 98, 116, 58, 50, 51, 57,
    58, 53, 45, 50, 51, 57, 58, 52, 52, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[37];
} const moonbit_string_literal_3 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 36),
    48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 100, 101, 102,
    103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115,
    116, 117, 118, 119, 120, 121, 122, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_7 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 10, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[4];
} const moonbit_string_literal_10 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 3),
    32, 61, 32, 0
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

int64_t $username$moonbit_examples$cmd$option$safe_divide(
  int32_t a$289,
  int32_t b$288
) {
  if (b$288 == 0) {
    return 4294967296ll;
  } else {
    int32_t _tmp$821 = a$289 / b$288;
    return (int64_t)_tmp$821;
  }
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$286,
  struct $$moonbitlang$core$builtin$Logger logger$287
) {
  moonbit_string_t _tmp$820 = self$286;
  struct $$moonbitlang$core$builtin$SourceLocRepr* _tmp$819 =
    $$moonbitlang$core$builtin$SourceLocRepr$$parse(_tmp$820);
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
    _tmp$819, logger$287
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$249,
  struct $$moonbitlang$core$builtin$Logger logger$285
) {
  struct $StringView _field$831 =
    (struct $StringView){self$249->$0_1, self$249->$0_2, self$249->$0_0};
  struct $StringView pkg$248 = _field$831;
  moonbit_string_t _field$830 = pkg$248.$0;
  moonbit_string_t _data$250 = _field$830;
  int32_t _start$251 = pkg$248.$1;
  int32_t end$817 = pkg$248.$2;
  int32_t start$818 = pkg$248.$1;
  int32_t _tmp$816 = end$817 - start$818;
  int32_t _end$252 = _start$251 + _tmp$816;
  int32_t _cursor$253 = _start$251;
  int32_t accept_state$254 = -1;
  int32_t match_end$255 = -1;
  int32_t match_tag_saver_0$256 = -1;
  int32_t tag_0$257 = -1;
  struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$* _bind$258;
  struct $StringView _field$829;
  struct $StringView _module_name$281;
  void* _field$828;
  int32_t _cnt$850;
  void* _package_name$282;
  struct $StringView _field$826;
  struct $StringView filename$779;
  struct $StringView _field$825;
  struct $StringView start_line$780;
  struct $StringView _field$824;
  struct $StringView start_column$781;
  struct $StringView _field$823;
  struct $StringView end_line$782;
  struct $StringView _field$822;
  int32_t _cnt$854;
  struct $StringView end_column$783;
  struct $$moonbitlang$core$builtin$Logger _bind$778;
  moonbit_incref(_data$250);
  moonbit_incref(pkg$248.$0);
  while (1) {
    int32_t _tmp$798 = _cursor$253;
    if (_tmp$798 < _end$252) {
      int32_t _p$412 = _cursor$253;
      int32_t next_char$268 = _data$250[_p$412];
      int32_t _tmp$799 = _cursor$253;
      _cursor$253 = _tmp$799 + 1;
      if (next_char$268 < 55296) {
        if (next_char$268 < 47) {
          goto $join$266;
        } else if (next_char$268 > 47) {
          goto $join$266;
        } else {
          while (1) {
            int32_t _tmp$800;
            tag_0$257 = _cursor$253;
            _tmp$800 = _cursor$253;
            if (_tmp$800 < _end$252) {
              int32_t _p$415 = _cursor$253;
              int32_t next_char$271 = _data$250[_p$415];
              int32_t _tmp$801 = _cursor$253;
              _cursor$253 = _tmp$801 + 1;
              if (next_char$271 < 55296) {
                if (next_char$271 < 47) {
                  goto $join$269;
                } else if (next_char$271 > 47) {
                  goto $join$269;
                } else {
                  while (1) {
                    int32_t _tmp$802 = _cursor$253;
                    if (_tmp$802 < _end$252) {
                      int32_t _p$418 = _cursor$253;
                      int32_t next_char$274 = _data$250[_p$418];
                      int32_t _tmp$803 = _cursor$253;
                      _cursor$253 = _tmp$803 + 1;
                      if (next_char$274 < 56319) {
                        if (next_char$274 < 55296) {
                          goto $join$272;
                        } else {
                          int32_t _tmp$804 = _cursor$253;
                          if (_tmp$804 < _end$252) {
                            int32_t _p$421 = _cursor$253;
                            int32_t next_char$275 = _data$250[_p$421];
                            int32_t _tmp$805 = _cursor$253;
                            _cursor$253 = _tmp$805 + 1;
                            if (next_char$275 < 56320) {
                              goto $join$259;
                            } else if (next_char$275 > 65535) {
                              goto $join$259;
                            } else {
                              continue;
                            }
                          } else {
                            goto $join$259;
                          }
                        }
                      } else if (next_char$274 > 56319) {
                        if (next_char$274 < 65536) {
                          goto $join$272;
                        } else {
                          goto $join$259;
                        }
                      } else {
                        int32_t _tmp$806 = _cursor$253;
                        if (_tmp$806 < _end$252) {
                          int32_t _p$424 = _cursor$253;
                          int32_t next_char$276 = _data$250[_p$424];
                          int32_t _tmp$807 = _cursor$253;
                          _cursor$253 = _tmp$807 + 1;
                          if (next_char$276 < 56320) {
                            goto $join$259;
                          } else if (next_char$276 > 57343) {
                            goto $join$259;
                          } else {
                            continue;
                          }
                        } else {
                          goto $join$259;
                        }
                      }
                      goto $joinlet$867;
                      $join$272:;
                      continue;
                      $joinlet$867:;
                    } else {
                      match_tag_saver_0$256 = tag_0$257;
                      accept_state$254 = 0;
                      match_end$255 = _cursor$253;
                      goto $join$259;
                    }
                    break;
                  }
                }
              } else if (next_char$271 > 56318) {
                if (next_char$271 < 57344) {
                  int32_t _tmp$808 = _cursor$253;
                  if (_tmp$808 < _end$252) {
                    int32_t _p$427 = _cursor$253;
                    int32_t next_char$277 = _data$250[_p$427];
                    int32_t _tmp$809 = _cursor$253;
                    _cursor$253 = _tmp$809 + 1;
                    if (next_char$277 < 56320) {
                      goto $join$259;
                    } else if (next_char$277 > 57343) {
                      goto $join$259;
                    } else {
                      continue;
                    }
                  } else {
                    goto $join$259;
                  }
                } else if (next_char$271 > 65535) {
                  goto $join$259;
                } else {
                  goto $join$269;
                }
              } else {
                int32_t _tmp$810 = _cursor$253;
                if (_tmp$810 < _end$252) {
                  int32_t _p$430 = _cursor$253;
                  int32_t next_char$278 = _data$250[_p$430];
                  int32_t _tmp$811 = _cursor$253;
                  _cursor$253 = _tmp$811 + 1;
                  if (next_char$278 < 56320) {
                    goto $join$259;
                  } else if (next_char$278 > 65535) {
                    goto $join$259;
                  } else {
                    continue;
                  }
                } else {
                  goto $join$259;
                }
              }
              goto $joinlet$865;
              $join$269:;
              continue;
              $joinlet$865:;
            } else {
              goto $join$259;
            }
            break;
          }
        }
      } else if (next_char$268 > 56318) {
        if (next_char$268 < 57344) {
          int32_t _tmp$812 = _cursor$253;
          if (_tmp$812 < _end$252) {
            int32_t _p$433 = _cursor$253;
            int32_t next_char$279 = _data$250[_p$433];
            int32_t _tmp$813 = _cursor$253;
            _cursor$253 = _tmp$813 + 1;
            if (next_char$279 < 56320) {
              goto $join$259;
            } else if (next_char$279 > 57343) {
              goto $join$259;
            } else {
              continue;
            }
          } else {
            goto $join$259;
          }
        } else if (next_char$268 > 65535) {
          goto $join$259;
        } else {
          goto $join$266;
        }
      } else {
        int32_t _tmp$814 = _cursor$253;
        if (_tmp$814 < _end$252) {
          int32_t _p$436 = _cursor$253;
          int32_t next_char$280 = _data$250[_p$436];
          int32_t _tmp$815 = _cursor$253;
          _cursor$253 = _tmp$815 + 1;
          if (next_char$280 < 56320) {
            goto $join$259;
          } else if (next_char$280 > 65535) {
            goto $join$259;
          } else {
            continue;
          }
        } else {
          goto $join$259;
        }
      }
      goto $joinlet$863;
      $join$266:;
      continue;
      $joinlet$863:;
    } else {
      goto $join$259;
    }
    break;
  }
  goto $joinlet$861;
  $join$259:;
  switch (accept_state$254) {
    case 0: {
      void* _try_err$262;
      struct $StringView package_name$260;
      int32_t _tmp$794;
      int32_t _tmp$793;
      int64_t _tmp$790;
      int32_t _tmp$792;
      int64_t _tmp$791;
      struct moonbit_result_0 _tmp$869;
      void* _try_err$265;
      struct $StringView module_name$263;
      int64_t _tmp$785;
      int32_t _tmp$787;
      int64_t _tmp$786;
      struct moonbit_result_0 _tmp$871;
      void* Some$784;
      moonbit_decref(pkg$248.$0);
      _tmp$794 = match_tag_saver_0$256;
      _tmp$793 = _tmp$794 + 1;
      _tmp$790 = (int64_t)_tmp$793;
      _tmp$792 = match_end$255;
      _tmp$791 = (int64_t)_tmp$792;
      moonbit_incref(_data$250);
      _tmp$869 = $String$$sub(_data$250, _tmp$790, _tmp$791);
      if (_tmp$869.tag) {
        struct $StringView const _ok$795 = _tmp$869.data.ok;
        package_name$260 = _ok$795;
      } else {
        void* const _err$796 = _tmp$869.data.err;
        _try_err$262 = _err$796;
        goto $join$261;
      }
      goto $joinlet$868;
      $join$261:;
      moonbit_decref(_try_err$262);
      moonbit_panic();
      $joinlet$868:;
      _tmp$785 = (int64_t)_start$251;
      _tmp$787 = match_tag_saver_0$256;
      _tmp$786 = (int64_t)_tmp$787;
      _tmp$871 = $String$$sub(_data$250, _tmp$785, _tmp$786);
      if (_tmp$871.tag) {
        struct $StringView const _ok$788 = _tmp$871.data.ok;
        module_name$263 = _ok$788;
      } else {
        void* const _err$789 = _tmp$871.data.err;
        _try_err$265 = _err$789;
        goto $join$264;
      }
      goto $joinlet$870;
      $join$264:;
      moonbit_decref(_try_err$265);
      moonbit_panic();
      $joinlet$870:;
      Some$784
      = (void*)moonbit_malloc(sizeof(struct $Option$3c$StringView$3e$$Some));
      Moonbit_object_header(Some$784)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $Option$3c$StringView$3e$$Some, $0_0) >> 2, 1, 1
      );
      ((struct $Option$3c$StringView$3e$$Some*)Some$784)->$0_0
      = package_name$260.$0;
      ((struct $Option$3c$StringView$3e$$Some*)Some$784)->$0_1
      = package_name$260.$1;
      ((struct $Option$3c$StringView$3e$$Some*)Some$784)->$0_2
      = package_name$260.$2;
      _bind$258
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$258)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$258->$0_0 = module_name$263.$0;
      _bind$258->$0_1 = module_name$263.$1;
      _bind$258->$0_2 = module_name$263.$2;
      _bind$258->$1 = Some$784;
      break;
    }
    default: {
      void* None$797;
      moonbit_decref(_data$250);
      None$797 = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _bind$258
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$258)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$258->$0_0 = pkg$248.$0;
      _bind$258->$0_1 = pkg$248.$1;
      _bind$258->$0_2 = pkg$248.$2;
      _bind$258->$1 = None$797;
      break;
    }
  }
  $joinlet$861:;
  _field$829
  = (struct $StringView){
    _bind$258->$0_1, _bind$258->$0_2, _bind$258->$0_0
  };
  _module_name$281 = _field$829;
  _field$828 = _bind$258->$1;
  _cnt$850 = Moonbit_object_header(_bind$258)->rc;
  if (_cnt$850 > 1) {
    int32_t _new_cnt$851 = _cnt$850 - 1;
    Moonbit_object_header(_bind$258)->rc = _new_cnt$851;
    moonbit_incref(_field$828);
    moonbit_incref(_module_name$281.$0);
  } else if (_cnt$850 == 1) {
    moonbit_free(_bind$258);
  }
  _package_name$282 = _field$828;
  switch (Moonbit_object_tag(_package_name$282)) {
    case 1: {
      struct $Option$3c$StringView$3e$$Some* _Some$283 =
        (struct $Option$3c$StringView$3e$$Some*)_package_name$282;
      struct $StringView _field$827 =
        (struct $StringView){
          _Some$283->$0_1, _Some$283->$0_2, _Some$283->$0_0
        };
      int32_t _cnt$852 = Moonbit_object_header(_Some$283)->rc;
      struct $StringView _pkg_name$284;
      struct $$moonbitlang$core$builtin$Logger _bind$777;
      if (_cnt$852 > 1) {
        int32_t _new_cnt$853 = _cnt$852 - 1;
        Moonbit_object_header(_Some$283)->rc = _new_cnt$853;
        moonbit_incref(_field$827.$0);
      } else if (_cnt$852 == 1) {
        moonbit_free(_Some$283);
      }
      _pkg_name$284 = _field$827;
      if (logger$285.$1) {
        moonbit_incref(logger$285.$1);
      }
      logger$285.$0->$method_2(logger$285.$1, _pkg_name$284);
      _bind$777 = logger$285;
      if (_bind$777.$1) {
        moonbit_incref(_bind$777.$1);
      }
      _bind$777.$0->$method_3(_bind$777.$1, 47);
      break;
    }
    default: {
      moonbit_decref(_package_name$282);
      break;
    }
  }
  _field$826
  = (struct $StringView){
    self$249->$1_1, self$249->$1_2, self$249->$1_0
  };
  filename$779 = _field$826;
  moonbit_incref(filename$779.$0);
  if (logger$285.$1) {
    moonbit_incref(logger$285.$1);
  }
  logger$285.$0->$method_2(logger$285.$1, filename$779);
  if (logger$285.$1) {
    moonbit_incref(logger$285.$1);
  }
  logger$285.$0->$method_3(logger$285.$1, 58);
  _field$825
  = (struct $StringView){
    self$249->$2_1, self$249->$2_2, self$249->$2_0
  };
  start_line$780 = _field$825;
  moonbit_incref(start_line$780.$0);
  if (logger$285.$1) {
    moonbit_incref(logger$285.$1);
  }
  logger$285.$0->$method_2(logger$285.$1, start_line$780);
  if (logger$285.$1) {
    moonbit_incref(logger$285.$1);
  }
  logger$285.$0->$method_3(logger$285.$1, 58);
  _field$824
  = (struct $StringView){
    self$249->$3_1, self$249->$3_2, self$249->$3_0
  };
  start_column$781 = _field$824;
  moonbit_incref(start_column$781.$0);
  if (logger$285.$1) {
    moonbit_incref(logger$285.$1);
  }
  logger$285.$0->$method_2(logger$285.$1, start_column$781);
  if (logger$285.$1) {
    moonbit_incref(logger$285.$1);
  }
  logger$285.$0->$method_3(logger$285.$1, 45);
  _field$823
  = (struct $StringView){
    self$249->$4_1, self$249->$4_2, self$249->$4_0
  };
  end_line$782 = _field$823;
  moonbit_incref(end_line$782.$0);
  if (logger$285.$1) {
    moonbit_incref(logger$285.$1);
  }
  logger$285.$0->$method_2(logger$285.$1, end_line$782);
  if (logger$285.$1) {
    moonbit_incref(logger$285.$1);
  }
  logger$285.$0->$method_3(logger$285.$1, 58);
  _field$822
  = (struct $StringView){
    self$249->$5_1, self$249->$5_2, self$249->$5_0
  };
  _cnt$854 = Moonbit_object_header(self$249)->rc;
  if (_cnt$854 > 1) {
    int32_t _new_cnt$860 = _cnt$854 - 1;
    Moonbit_object_header(self$249)->rc = _new_cnt$860;
    moonbit_incref(_field$822.$0);
  } else if (_cnt$854 == 1) {
    struct $StringView _field$859 =
      (struct $StringView){self$249->$4_1, self$249->$4_2, self$249->$4_0};
    struct $StringView _field$858;
    struct $StringView _field$857;
    struct $StringView _field$856;
    struct $StringView _field$855;
    moonbit_decref(_field$859.$0);
    _field$858
    = (struct $StringView){
      self$249->$3_1, self$249->$3_2, self$249->$3_0
    };
    moonbit_decref(_field$858.$0);
    _field$857
    = (struct $StringView){
      self$249->$2_1, self$249->$2_2, self$249->$2_0
    };
    moonbit_decref(_field$857.$0);
    _field$856
    = (struct $StringView){
      self$249->$1_1, self$249->$1_2, self$249->$1_0
    };
    moonbit_decref(_field$856.$0);
    _field$855
    = (struct $StringView){
      self$249->$0_1, self$249->$0_2, self$249->$0_0
    };
    moonbit_decref(_field$855.$0);
    moonbit_free(self$249);
  }
  end_column$783 = _field$822;
  if (logger$285.$1) {
    moonbit_incref(logger$285.$1);
  }
  logger$285.$0->$method_2(logger$285.$1, end_column$783);
  if (logger$285.$1) {
    moonbit_incref(logger$285.$1);
  }
  logger$285.$0->$method_3(logger$285.$1, 64);
  _bind$778 = logger$285;
  _bind$778.$0->$method_2(_bind$778.$1, _module_name$281);
  return 0;
}

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$247) {
  moonbit_println(input$247);
  moonbit_decref(input$247);
  return 0;
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$String$$to_string(
  moonbit_string_t self$246
) {
  return self$246;
}

int32_t $$moonbitlang$core$builtin$Show$$Int$$output(
  int32_t self$245,
  struct $$moonbitlang$core$builtin$Logger logger$244
) {
  moonbit_string_t _tmp$776 = $Int$$to_string$inner(self$245, 10);
  logger$244.$0->$method_0(logger$244.$1, _tmp$776);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$242,
  struct $StringView str$243
) {
  int32_t len$758 = self$242->$1;
  int32_t end$761 = str$243.$2;
  int32_t start$762 = str$243.$1;
  int32_t _tmp$760 = end$761 - start$762;
  int32_t _tmp$759 = _tmp$760 * 2;
  int32_t _tmp$757 = len$758 + _tmp$759;
  moonbit_bytes_t _field$834;
  moonbit_bytes_t data$763;
  int32_t len$764;
  moonbit_string_t _field$833;
  moonbit_string_t str$765;
  int32_t start$766;
  int32_t end$768;
  int32_t start$769;
  int32_t _tmp$767;
  int32_t len$771;
  int32_t end$774;
  int32_t _field$832;
  int32_t start$775;
  int32_t _tmp$773;
  int32_t _tmp$772;
  int32_t _tmp$770;
  moonbit_incref(self$242);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$242, _tmp$757
  );
  _field$834 = self$242->$0;
  data$763 = _field$834;
  len$764 = self$242->$1;
  _field$833 = str$243.$0;
  str$765 = _field$833;
  start$766 = str$243.$1;
  end$768 = str$243.$2;
  start$769 = str$243.$1;
  _tmp$767 = end$768 - start$769;
  moonbit_incref(str$765);
  moonbit_incref(data$763);
  $FixedArray$$blit_from_string(
    data$763, len$764, str$765, start$766, _tmp$767
  );
  len$771 = self$242->$1;
  end$774 = str$243.$2;
  _field$832 = str$243.$1;
  moonbit_decref(str$243.$0);
  start$775 = _field$832;
  _tmp$773 = end$774 - start$775;
  _tmp$772 = _tmp$773 * 2;
  _tmp$770 = len$771 + _tmp$772;
  self$242->$1 = _tmp$770;
  moonbit_decref(self$242);
  return 0;
}

moonbit_string_t $Int$$to_string$inner(int32_t self$226, int32_t radix$225) {
  int32_t is_negative$227;
  uint32_t num$228;
  uint16_t* buffer$229;
  if (radix$225 < 2 || radix$225 > 36) {
    $moonbitlang$core$builtin$abort$0(
      (moonbit_string_t)moonbit_string_literal_0.data,
        (moonbit_string_t)moonbit_string_literal_1.data
    );
  }
  if (self$226 == 0) {
    return (moonbit_string_t)moonbit_string_literal_2.data;
  }
  is_negative$227 = self$226 < 0;
  if (is_negative$227) {
    int32_t _tmp$756 = -self$226;
    num$228 = *(uint32_t*)&_tmp$756;
  } else {
    num$228 = *(uint32_t*)&self$226;
  }
  switch (radix$225) {
    case 10: {
      int32_t digit_len$230 = $moonbitlang$core$builtin$dec_count32(num$228);
      int32_t _tmp$753;
      int32_t total_len$231;
      uint16_t* buffer$232;
      int32_t digit_start$233;
      if (is_negative$227) {
        _tmp$753 = 1;
      } else {
        _tmp$753 = 0;
      }
      total_len$231 = digit_len$230 + _tmp$753;
      buffer$232 = (uint16_t*)moonbit_make_string(total_len$231, 0);
      if (is_negative$227) {
        digit_start$233 = 1;
      } else {
        digit_start$233 = 0;
      }
      moonbit_incref(buffer$232);
      $moonbitlang$core$builtin$int_to_string_dec(
        buffer$232, num$228, digit_start$233, total_len$231
      );
      buffer$229 = buffer$232;
      break;
    }

    case 16: {
      int32_t digit_len$234 = $moonbitlang$core$builtin$hex_count32(num$228);
      int32_t _tmp$754;
      int32_t total_len$235;
      uint16_t* buffer$236;
      int32_t digit_start$237;
      if (is_negative$227) {
        _tmp$754 = 1;
      } else {
        _tmp$754 = 0;
      }
      total_len$235 = digit_len$234 + _tmp$754;
      buffer$236 = (uint16_t*)moonbit_make_string(total_len$235, 0);
      if (is_negative$227) {
        digit_start$237 = 1;
      } else {
        digit_start$237 = 0;
      }
      moonbit_incref(buffer$236);
      $moonbitlang$core$builtin$int_to_string_hex(
        buffer$236, num$228, digit_start$237, total_len$235
      );
      buffer$229 = buffer$236;
      break;
    }
    default: {
      int32_t digit_len$238 =
        $moonbitlang$core$builtin$radix_count32(num$228, radix$225);
      int32_t _tmp$755;
      int32_t total_len$239;
      uint16_t* buffer$240;
      int32_t digit_start$241;
      if (is_negative$227) {
        _tmp$755 = 1;
      } else {
        _tmp$755 = 0;
      }
      total_len$239 = digit_len$238 + _tmp$755;
      buffer$240 = (uint16_t*)moonbit_make_string(total_len$239, 0);
      if (is_negative$227) {
        digit_start$241 = 1;
      } else {
        digit_start$241 = 0;
      }
      moonbit_incref(buffer$240);
      $moonbitlang$core$builtin$int_to_string_generic(
        buffer$240, num$228, digit_start$241, total_len$239, radix$225
      );
      buffer$229 = buffer$240;
      break;
    }
  }
  if (is_negative$227) {
    buffer$229[0] = 45;
  }
  return buffer$229;
}

int32_t $moonbitlang$core$builtin$radix_count32(
  uint32_t value$219,
  int32_t radix$222
) {
  uint32_t num$220;
  uint32_t base$221;
  int32_t count$223;
  if (value$219 == 0u) {
    return 1;
  }
  num$220 = value$219;
  base$221 = *(uint32_t*)&radix$222;
  count$223 = 0;
  while (1) {
    uint32_t _tmp$750 = num$220;
    if (_tmp$750 > 0u) {
      int32_t _tmp$751 = count$223;
      uint32_t _tmp$752;
      count$223 = _tmp$751 + 1;
      _tmp$752 = num$220;
      num$220 = _tmp$752 / base$221;
      continue;
    }
    break;
  }
  return count$223;
}

int32_t $moonbitlang$core$builtin$hex_count32(uint32_t value$217) {
  if (value$217 == 0u) {
    return 1;
  } else {
    int32_t leading_zeros$218 = moonbit_clz32(value$217);
    int32_t _tmp$749 = 31 - leading_zeros$218;
    int32_t _tmp$748 = _tmp$749 / 4;
    return _tmp$748 + 1;
  }
}

int32_t $moonbitlang$core$builtin$dec_count32(uint32_t value$216) {
  if (value$216 >= 100000u) {
    if (value$216 >= 10000000u) {
      if (value$216 >= 1000000000u) {
        return 10;
      } else if (value$216 >= 100000000u) {
        return 9;
      } else {
        return 8;
      }
    } else if (value$216 >= 1000000u) {
      return 7;
    } else {
      return 6;
    }
  } else if (value$216 >= 1000u) {
    if (value$216 >= 10000u) {
      return 5;
    } else {
      return 4;
    }
  } else if (value$216 >= 100u) {
    return 3;
  } else if (value$216 >= 10u) {
    return 2;
  } else {
    return 1;
  }
}

int32_t $moonbitlang$core$builtin$int_to_string_dec(
  uint16_t* buffer$206,
  uint32_t num$194,
  int32_t digit_start$197,
  int32_t total_len$196
) {
  uint32_t num$193 = num$194;
  int32_t offset$195 = total_len$196 - digit_start$197;
  uint32_t _tmp$747;
  int32_t remaining$208;
  int32_t _tmp$728;
  while (1) {
    uint32_t _tmp$691 = num$193;
    if (_tmp$691 >= 10000u) {
      uint32_t _tmp$714 = num$193;
      uint32_t t$198 = _tmp$714 / 10000u;
      uint32_t _tmp$713 = num$193;
      uint32_t _tmp$712 = _tmp$713 % 10000u;
      int32_t r$199 = *(int32_t*)&_tmp$712;
      int32_t d1$200;
      int32_t d2$201;
      int32_t _tmp$692;
      int32_t _tmp$711;
      int32_t _tmp$710;
      int32_t d1_hi$202;
      int32_t _tmp$709;
      int32_t _tmp$708;
      int32_t d1_lo$203;
      int32_t _tmp$707;
      int32_t _tmp$706;
      int32_t d2_hi$204;
      int32_t _tmp$705;
      int32_t _tmp$704;
      int32_t d2_lo$205;
      int32_t _tmp$694;
      int32_t _tmp$693;
      int32_t _tmp$697;
      int32_t _tmp$696;
      int32_t _tmp$695;
      int32_t _tmp$700;
      int32_t _tmp$699;
      int32_t _tmp$698;
      int32_t _tmp$703;
      int32_t _tmp$702;
      int32_t _tmp$701;
      num$193 = t$198;
      d1$200 = r$199 / 100;
      d2$201 = r$199 % 100;
      _tmp$692 = offset$195;
      offset$195 = _tmp$692 - 4;
      _tmp$711 = d1$200 / 10;
      _tmp$710 = 48 + _tmp$711;
      d1_hi$202 = (uint16_t)_tmp$710;
      _tmp$709 = d1$200 % 10;
      _tmp$708 = 48 + _tmp$709;
      d1_lo$203 = (uint16_t)_tmp$708;
      _tmp$707 = d2$201 / 10;
      _tmp$706 = 48 + _tmp$707;
      d2_hi$204 = (uint16_t)_tmp$706;
      _tmp$705 = d2$201 % 10;
      _tmp$704 = 48 + _tmp$705;
      d2_lo$205 = (uint16_t)_tmp$704;
      _tmp$694 = offset$195;
      _tmp$693 = digit_start$197 + _tmp$694;
      buffer$206[_tmp$693] = d1_hi$202;
      _tmp$697 = offset$195;
      _tmp$696 = digit_start$197 + _tmp$697;
      _tmp$695 = _tmp$696 + 1;
      buffer$206[_tmp$695] = d1_lo$203;
      _tmp$700 = offset$195;
      _tmp$699 = digit_start$197 + _tmp$700;
      _tmp$698 = _tmp$699 + 2;
      buffer$206[_tmp$698] = d2_hi$204;
      _tmp$703 = offset$195;
      _tmp$702 = digit_start$197 + _tmp$703;
      _tmp$701 = _tmp$702 + 3;
      buffer$206[_tmp$701] = d2_lo$205;
      continue;
    }
    break;
  }
  _tmp$747 = num$193;
  remaining$208 = *(int32_t*)&_tmp$747;
  while (1) {
    int32_t _tmp$715 = remaining$208;
    if (_tmp$715 >= 100) {
      int32_t _tmp$727 = remaining$208;
      int32_t t$209 = _tmp$727 / 100;
      int32_t _tmp$726 = remaining$208;
      int32_t d$210 = _tmp$726 % 100;
      int32_t _tmp$716;
      int32_t _tmp$725;
      int32_t _tmp$724;
      int32_t d_hi$211;
      int32_t _tmp$723;
      int32_t _tmp$722;
      int32_t d_lo$212;
      int32_t _tmp$718;
      int32_t _tmp$717;
      int32_t _tmp$721;
      int32_t _tmp$720;
      int32_t _tmp$719;
      remaining$208 = t$209;
      _tmp$716 = offset$195;
      offset$195 = _tmp$716 - 2;
      _tmp$725 = d$210 / 10;
      _tmp$724 = 48 + _tmp$725;
      d_hi$211 = (uint16_t)_tmp$724;
      _tmp$723 = d$210 % 10;
      _tmp$722 = 48 + _tmp$723;
      d_lo$212 = (uint16_t)_tmp$722;
      _tmp$718 = offset$195;
      _tmp$717 = digit_start$197 + _tmp$718;
      buffer$206[_tmp$717] = d_hi$211;
      _tmp$721 = offset$195;
      _tmp$720 = digit_start$197 + _tmp$721;
      _tmp$719 = _tmp$720 + 1;
      buffer$206[_tmp$719] = d_lo$212;
      continue;
    }
    break;
  }
  _tmp$728 = remaining$208;
  if (_tmp$728 >= 10) {
    int32_t _tmp$729 = offset$195;
    int32_t _tmp$740;
    int32_t _tmp$739;
    int32_t _tmp$738;
    int32_t d_hi$214;
    int32_t _tmp$737;
    int32_t _tmp$736;
    int32_t _tmp$735;
    int32_t d_lo$215;
    int32_t _tmp$731;
    int32_t _tmp$730;
    int32_t _tmp$734;
    int32_t _tmp$733;
    int32_t _tmp$732;
    offset$195 = _tmp$729 - 2;
    _tmp$740 = remaining$208;
    _tmp$739 = _tmp$740 / 10;
    _tmp$738 = 48 + _tmp$739;
    d_hi$214 = (uint16_t)_tmp$738;
    _tmp$737 = remaining$208;
    _tmp$736 = _tmp$737 % 10;
    _tmp$735 = 48 + _tmp$736;
    d_lo$215 = (uint16_t)_tmp$735;
    _tmp$731 = offset$195;
    _tmp$730 = digit_start$197 + _tmp$731;
    buffer$206[_tmp$730] = d_hi$214;
    _tmp$734 = offset$195;
    _tmp$733 = digit_start$197 + _tmp$734;
    _tmp$732 = _tmp$733 + 1;
    buffer$206[_tmp$732] = d_lo$215;
    moonbit_decref(buffer$206);
  } else {
    int32_t _tmp$741 = offset$195;
    int32_t _tmp$746;
    int32_t _tmp$742;
    int32_t _tmp$745;
    int32_t _tmp$744;
    int32_t _tmp$743;
    offset$195 = _tmp$741 - 1;
    _tmp$746 = offset$195;
    _tmp$742 = digit_start$197 + _tmp$746;
    _tmp$745 = remaining$208;
    _tmp$744 = 48 + _tmp$745;
    _tmp$743 = (uint16_t)_tmp$744;
    buffer$206[_tmp$742] = _tmp$743;
    moonbit_decref(buffer$206);
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int_to_string_generic(
  uint16_t* buffer$188,
  uint32_t num$182,
  int32_t digit_start$180,
  int32_t total_len$179,
  int32_t radix$184
) {
  int32_t offset$178 = total_len$179 - digit_start$180;
  uint32_t n$181 = num$182;
  uint32_t base$183 = *(uint32_t*)&radix$184;
  int32_t _tmp$671 = radix$184 - 1;
  int32_t _tmp$670 = radix$184 & _tmp$671;
  if (_tmp$670 == 0) {
    int32_t shift$185 = moonbit_ctz32(radix$184);
    uint32_t mask$186 = base$183 - 1u;
    while (1) {
      uint32_t _tmp$672 = n$181;
      if (_tmp$672 > 0u) {
        int32_t _tmp$673 = offset$178;
        uint32_t _tmp$680;
        uint32_t _tmp$679;
        int32_t digit$187;
        int32_t _tmp$677;
        int32_t _tmp$674;
        int32_t _tmp$676;
        int32_t _tmp$675;
        uint32_t _tmp$678;
        offset$178 = _tmp$673 - 1;
        _tmp$680 = n$181;
        _tmp$679 = _tmp$680 & mask$186;
        digit$187 = *(int32_t*)&_tmp$679;
        _tmp$677 = offset$178;
        _tmp$674 = digit_start$180 + _tmp$677;
        _tmp$676
        = ((moonbit_string_t)moonbit_string_literal_3.data)[
          digit$187
        ];
        _tmp$675 = (uint16_t)_tmp$676;
        buffer$188[_tmp$674] = _tmp$675;
        _tmp$678 = n$181;
        n$181 = _tmp$678 >> (shift$185 & 31);
        continue;
      } else {
        moonbit_decref(buffer$188);
      }
      break;
    }
  } else {
    while (1) {
      uint32_t _tmp$681 = n$181;
      if (_tmp$681 > 0u) {
        int32_t _tmp$682 = offset$178;
        uint32_t _tmp$690;
        uint32_t q$190;
        uint32_t _tmp$688;
        uint32_t _tmp$689;
        uint32_t _tmp$687;
        int32_t digit$191;
        int32_t _tmp$686;
        int32_t _tmp$683;
        int32_t _tmp$685;
        int32_t _tmp$684;
        offset$178 = _tmp$682 - 1;
        _tmp$690 = n$181;
        q$190 = _tmp$690 / base$183;
        _tmp$688 = n$181;
        _tmp$689 = q$190 * base$183;
        _tmp$687 = _tmp$688 - _tmp$689;
        digit$191 = *(int32_t*)&_tmp$687;
        _tmp$686 = offset$178;
        _tmp$683 = digit_start$180 + _tmp$686;
        _tmp$685
        = ((moonbit_string_t)moonbit_string_literal_3.data)[
          digit$191
        ];
        _tmp$684 = (uint16_t)_tmp$685;
        buffer$188[_tmp$683] = _tmp$684;
        n$181 = q$190;
        continue;
      } else {
        moonbit_decref(buffer$188);
      }
      break;
    }
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int_to_string_hex(
  uint16_t* buffer$175,
  uint32_t num$171,
  int32_t digit_start$169,
  int32_t total_len$168
) {
  int32_t offset$167 = total_len$168 - digit_start$169;
  uint32_t n$170 = num$171;
  int32_t _tmp$665;
  while (1) {
    int32_t _tmp$651 = offset$167;
    if (_tmp$651 >= 2) {
      int32_t _tmp$652 = offset$167;
      uint32_t _tmp$664;
      uint32_t _tmp$663;
      int32_t byte_val$172;
      int32_t hi$173;
      int32_t lo$174;
      int32_t _tmp$656;
      int32_t _tmp$653;
      int32_t _tmp$655;
      int32_t _tmp$654;
      int32_t _tmp$661;
      int32_t _tmp$660;
      int32_t _tmp$657;
      int32_t _tmp$659;
      int32_t _tmp$658;
      uint32_t _tmp$662;
      offset$167 = _tmp$652 - 2;
      _tmp$664 = n$170;
      _tmp$663 = _tmp$664 & 255u;
      byte_val$172 = *(int32_t*)&_tmp$663;
      hi$173 = byte_val$172 / 16;
      lo$174 = byte_val$172 % 16;
      _tmp$656 = offset$167;
      _tmp$653 = digit_start$169 + _tmp$656;
      _tmp$655 = ((moonbit_string_t)moonbit_string_literal_3.data)[hi$173];
      _tmp$654 = (uint16_t)_tmp$655;
      buffer$175[_tmp$653] = _tmp$654;
      _tmp$661 = offset$167;
      _tmp$660 = digit_start$169 + _tmp$661;
      _tmp$657 = _tmp$660 + 1;
      _tmp$659 = ((moonbit_string_t)moonbit_string_literal_3.data)[lo$174];
      _tmp$658 = (uint16_t)_tmp$659;
      buffer$175[_tmp$657] = _tmp$658;
      _tmp$662 = n$170;
      n$170 = _tmp$662 >> 8;
      continue;
    }
    break;
  }
  _tmp$665 = offset$167;
  if (_tmp$665 == 1) {
    uint32_t _tmp$669 = n$170;
    uint32_t _tmp$668 = _tmp$669 & 15u;
    int32_t nibble$177 = *(int32_t*)&_tmp$668;
    int32_t _tmp$667 =
      ((moonbit_string_t)moonbit_string_literal_3.data)[nibble$177];
    int32_t _tmp$666 = (uint16_t)_tmp$667;
    buffer$175[digit_start$169] = _tmp$666;
    moonbit_decref(buffer$175);
  } else {
    moonbit_decref(buffer$175);
  }
  return 0;
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  moonbit_string_t self$166
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$165 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$650;
  moonbit_incref(logger$165);
  _tmp$650
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$165
  };
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
    self$166, _tmp$650
  );
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$165);
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  int32_t self$164
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$163 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$649;
  moonbit_incref(logger$163);
  _tmp$649
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$163
  };
  $$moonbitlang$core$builtin$Show$$Int$$output(self$164, _tmp$649);
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$163);
}

int32_t $StringView$$start_offset(struct $StringView self$162) {
  int32_t _field$835 = self$162.$1;
  moonbit_decref(self$162.$0);
  return _field$835;
}

int32_t $StringView$$length(struct $StringView self$161) {
  int32_t end$647 = self$161.$2;
  int32_t _field$836 = self$161.$1;
  int32_t start$648;
  moonbit_decref(self$161.$0);
  start$648 = _field$836;
  return end$647 - start$648;
}

moonbit_string_t $StringView$$data(struct $StringView self$160) {
  moonbit_string_t _field$837 = self$160.$0;
  return _field$837;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$154,
  moonbit_string_t value$157,
  int32_t start$158,
  int32_t len$159
) {
  void* _try_err$156;
  struct $StringView _tmp$642;
  int32_t _tmp$644 = start$158 + len$159;
  int64_t _tmp$643 = (int64_t)_tmp$644;
  struct moonbit_result_0 _tmp$879 =
    $String$$sub$inner(value$157, start$158, _tmp$643);
  if (_tmp$879.tag) {
    struct $StringView const _ok$645 = _tmp$879.data.ok;
    _tmp$642 = _ok$645;
  } else {
    void* const _err$646 = _tmp$879.data.err;
    _try_err$156 = _err$646;
    goto $join$155;
  }
  goto $joinlet$878;
  $join$155:;
  moonbit_decref(_try_err$156);
  moonbit_panic();
  $joinlet$878:;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    self$154, _tmp$642
  );
  return 0;
}

struct moonbit_result_0 $String$$sub(
  moonbit_string_t self$152,
  int64_t start$opt$150,
  int64_t end$153
) {
  int32_t start$149;
  if (start$opt$150 == 4294967296ll) {
    start$149 = 0;
  } else {
    int64_t _Some$151 = start$opt$150;
    start$149 = (int32_t)_Some$151;
  }
  return $String$$sub$inner(self$152, start$149, end$153);
}

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$142,
  int32_t start$148,
  int64_t end$144
) {
  int32_t len$141 = Moonbit_array_length(self$142);
  int32_t end$143;
  int32_t start$147;
  if (end$144 == 4294967296ll) {
    end$143 = len$141;
  } else {
    int64_t _Some$145 = end$144;
    int32_t _end$146 = (int32_t)_Some$145;
    if (_end$146 < 0) {
      end$143 = len$141 + _end$146;
    } else {
      end$143 = _end$146;
    }
  }
  if (start$148 < 0) {
    start$147 = len$141 + start$148;
  } else {
    start$147 = start$148;
  }
  if (start$147 >= 0 && start$147 <= end$143 && end$143 <= len$141) {
    int32_t _if_result$880;
    int32_t _if_result$882;
    struct $StringView _tmp$640;
    struct moonbit_result_0 _result$884;
    if (start$147 < len$141) {
      int32_t _p$388 = self$142[start$147];
      _if_result$880 = 56320 <= _p$388 && _p$388 <= 57343;
    } else {
      _if_result$880 = 0;
    }
    if (_if_result$880) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$638;
      struct moonbit_result_0 _result$881;
      moonbit_decref(self$142);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$638
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$881.tag = 0;
      _result$881.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$638;
      return _result$881;
    }
    if (end$143 < len$141) {
      int32_t _p$391 = self$142[end$143];
      _if_result$882 = 56320 <= _p$391 && _p$391 <= 57343;
    } else {
      _if_result$882 = 0;
    }
    if (_if_result$882) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$639;
      struct moonbit_result_0 _result$883;
      moonbit_decref(self$142);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$639
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$883.tag = 0;
      _result$883.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$639;
      return _result$883;
    }
    _tmp$640 = (struct $StringView){start$147, end$143, self$142};
    _result$884.tag = 1;
    _result$884.data.ok = _tmp$640;
    return _result$884;
  } else {
    void* moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$641;
    struct moonbit_result_0 _result$885;
    moonbit_decref(self$142);
    moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$641
    = (struct moonbit_object*)&moonbit_constant_constructor_1 + 1;
    _result$885.tag = 0;
    _result$885.data.err
    = moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$641;
    return _result$885;
  }
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$139,
  moonbit_string_t str$140
) {
  int32_t len$628 = self$139->$1;
  int32_t _tmp$630 = Moonbit_array_length(str$140);
  int32_t _tmp$629 = _tmp$630 * 2;
  int32_t _tmp$627 = len$628 + _tmp$629;
  moonbit_bytes_t _field$839;
  moonbit_bytes_t data$631;
  int32_t len$632;
  int32_t _tmp$633;
  int32_t len$635;
  int32_t _tmp$838;
  int32_t _tmp$637;
  int32_t _tmp$636;
  int32_t _tmp$634;
  moonbit_incref(self$139);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$139, _tmp$627
  );
  _field$839 = self$139->$0;
  data$631 = _field$839;
  len$632 = self$139->$1;
  _tmp$633 = Moonbit_array_length(str$140);
  moonbit_incref(data$631);
  moonbit_incref(str$140);
  $FixedArray$$blit_from_string(data$631, len$632, str$140, 0, _tmp$633);
  len$635 = self$139->$1;
  _tmp$838 = Moonbit_array_length(str$140);
  moonbit_decref(str$140);
  _tmp$637 = _tmp$838;
  _tmp$636 = _tmp$637 * 2;
  _tmp$634 = len$635 + _tmp$636;
  self$139->$1 = _tmp$634;
  moonbit_decref(self$139);
  return 0;
}

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$131,
  int32_t bytes_offset$126,
  moonbit_string_t str$133,
  int32_t str_offset$129,
  int32_t length$127
) {
  int32_t _tmp$626 = length$127 * 2;
  int32_t _tmp$625 = bytes_offset$126 + _tmp$626;
  int32_t e1$125 = _tmp$625 - 1;
  int32_t _tmp$624 = str_offset$129 + length$127;
  int32_t e2$128 = _tmp$624 - 1;
  int32_t len1$130 = Moonbit_array_length(self$131);
  int32_t len2$132 = Moonbit_array_length(str$133);
  if (
    length$127 >= 0
    && bytes_offset$126 >= 0
    && e1$125 < len1$130
    && str_offset$129 >= 0
    && e2$128 < len2$132
  ) {
    int32_t end_str_offset$134 = str_offset$129 + length$127;
    int32_t i$135 = str_offset$129;
    int32_t j$136 = bytes_offset$126;
    while (1) {
      if (i$135 < end_str_offset$134) {
        int32_t _tmp$621 = str$133[i$135];
        uint32_t c$137 = *(uint32_t*)&_tmp$621;
        uint32_t _p$382 = c$137 & 255u;
        int32_t _tmp$617 = *(int32_t*)&_p$382;
        int32_t _tmp$616 = _tmp$617 & 0xff;
        int32_t _tmp$618;
        uint32_t _p$385;
        int32_t _tmp$620;
        int32_t _tmp$619;
        int32_t _tmp$622;
        int32_t _tmp$623;
        if (j$136 < 0 || j$136 >= Moonbit_array_length(self$131)) {
          moonbit_panic();
        }
        self$131[j$136] = _tmp$616;
        _tmp$618 = j$136 + 1;
        _p$385 = c$137 >> 8;
        _tmp$620 = *(int32_t*)&_p$385;
        _tmp$619 = _tmp$620 & 0xff;
        if (_tmp$618 < 0 || _tmp$618 >= Moonbit_array_length(self$131)) {
          moonbit_panic();
        }
        self$131[_tmp$618] = _tmp$619;
        _tmp$622 = i$135 + 1;
        _tmp$623 = j$136 + 2;
        i$135 = _tmp$622;
        j$136 = _tmp$623;
        continue;
      } else {
        moonbit_decref(str$133);
        moonbit_decref(self$131);
      }
      break;
    }
  } else {
    moonbit_decref(str$133);
    moonbit_decref(self$131);
    moonbit_panic();
  }
  return 0;
}

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$48
) {
  int32_t _tmp$615 = Moonbit_array_length(repr$48);
  struct $StringView _bind$47 = (struct $StringView){0, _tmp$615, repr$48};
  moonbit_string_t _field$841 = _bind$47.$0;
  moonbit_string_t _data$49 = _field$841;
  int32_t _start$50 = _bind$47.$1;
  int32_t end$613 = _bind$47.$2;
  int32_t _field$840 = _bind$47.$1;
  int32_t start$614 = _field$840;
  int32_t _tmp$612 = end$613 - start$614;
  int32_t _end$51 = _start$50 + _tmp$612;
  int32_t _cursor$52 = _start$50;
  int32_t accept_state$53 = -1;
  int32_t match_end$54 = -1;
  int32_t match_tag_saver_0$55 = -1;
  int32_t match_tag_saver_1$56 = -1;
  int32_t match_tag_saver_2$57 = -1;
  int32_t match_tag_saver_3$58 = -1;
  int32_t match_tag_saver_4$59 = -1;
  int32_t tag_0$60 = -1;
  int32_t tag_1$61 = -1;
  int32_t tag_1_1$62 = -1;
  int32_t tag_1_2$63 = -1;
  int32_t tag_3$64 = -1;
  int32_t tag_2$65 = -1;
  int32_t tag_2_1$66 = -1;
  int32_t tag_4$67 = -1;
  int32_t join_dispatch_19$88;
  int32_t _tmp$602 = _cursor$52;
  int32_t dispatch_19$89;
  if (_tmp$602 < _end$51) {
    int32_t _p$328 = _cursor$52;
    int32_t next_char$117 = _data$49[_p$328];
    int32_t _tmp$603 = _cursor$52;
    _cursor$52 = _tmp$603 + 1;
    if (next_char$117 < 65) {
      if (next_char$117 < 64) {
        goto $join$68;
      } else {
        while (1) {
          int32_t _tmp$604;
          tag_0$60 = _cursor$52;
          _tmp$604 = _cursor$52;
          if (_tmp$604 < _end$51) {
            int32_t _p$331 = _cursor$52;
            int32_t next_char$120 = _data$49[_p$331];
            int32_t _tmp$605 = _cursor$52;
            _cursor$52 = _tmp$605 + 1;
            if (next_char$120 < 55296) {
              if (next_char$120 < 58) {
                goto $join$118;
              } else if (next_char$120 > 58) {
                goto $join$118;
              } else {
                int32_t _tmp$606 = _cursor$52;
                if (_tmp$606 < _end$51) {
                  int32_t _p$334 = _cursor$52;
                  int32_t next_char$122 = _data$49[_p$334];
                  int32_t _tmp$607 = _cursor$52;
                  _cursor$52 = _tmp$607 + 1;
                  if (next_char$122 < 56319) {
                    if (next_char$122 < 55296) {
                      goto $join$121;
                    } else {
                      join_dispatch_19$88 = 7;
                      goto $join$87;
                    }
                  } else if (next_char$122 > 56319) {
                    if (next_char$122 < 65536) {
                      goto $join$121;
                    } else {
                      goto $join$68;
                    }
                  } else {
                    join_dispatch_19$88 = 8;
                    goto $join$87;
                  }
                  $join$121:;
                  join_dispatch_19$88 = 0;
                  goto $join$87;
                } else {
                  goto $join$68;
                }
              }
            } else if (next_char$120 > 56318) {
              if (next_char$120 < 57344) {
                int32_t _tmp$608 = _cursor$52;
                if (_tmp$608 < _end$51) {
                  int32_t _p$337 = _cursor$52;
                  int32_t next_char$123 = _data$49[_p$337];
                  int32_t _tmp$609 = _cursor$52;
                  _cursor$52 = _tmp$609 + 1;
                  if (next_char$123 < 56320) {
                    goto $join$68;
                  } else if (next_char$123 > 57343) {
                    goto $join$68;
                  } else {
                    continue;
                  }
                } else {
                  goto $join$68;
                }
              } else if (next_char$120 > 65535) {
                goto $join$68;
              } else {
                goto $join$118;
              }
            } else {
              int32_t _tmp$610 = _cursor$52;
              if (_tmp$610 < _end$51) {
                int32_t _p$340 = _cursor$52;
                int32_t next_char$124 = _data$49[_p$340];
                int32_t _tmp$611 = _cursor$52;
                _cursor$52 = _tmp$611 + 1;
                if (next_char$124 < 56320) {
                  goto $join$68;
                } else if (next_char$124 > 65535) {
                  goto $join$68;
                } else {
                  continue;
                }
              } else {
                goto $join$68;
              }
            }
            $join$118:;
            continue;
          } else {
            goto $join$68;
          }
          break;
        }
      }
    } else {
      goto $join$68;
    }
  } else {
    goto $join$68;
  }
  $join$87:;
  dispatch_19$89 = join_dispatch_19$88;
  $loop_label_19$92:;
  while (1) {
    int32_t _tmp$576;
    switch (dispatch_19$89) {
      case 3: {
        int32_t _tmp$578;
        tag_1_2$63 = tag_1_1$62;
        tag_1_1$62 = tag_1$61;
        tag_1$61 = _cursor$52;
        _tmp$578 = _cursor$52;
        if (_tmp$578 < _end$51) {
          int32_t _p$343 = _cursor$52;
          int32_t next_char$96 = _data$49[_p$343];
          int32_t _tmp$579 = _cursor$52;
          _cursor$52 = _tmp$579 + 1;
          if (next_char$96 < 55296) {
            if (next_char$96 < 58) {
              if (next_char$96 < 48) {
                goto $join$95;
              } else {
                int32_t _tmp$580;
                tag_1$61 = _cursor$52;
                tag_2_1$66 = tag_2$65;
                tag_2$65 = _cursor$52;
                tag_3$64 = _cursor$52;
                _tmp$580 = _cursor$52;
                if (_tmp$580 < _end$51) {
                  int32_t _p$346 = _cursor$52;
                  int32_t next_char$98 = _data$49[_p$346];
                  int32_t _tmp$581 = _cursor$52;
                  _cursor$52 = _tmp$581 + 1;
                  if (next_char$98 < 59) {
                    if (next_char$98 < 46) {
                      if (next_char$98 < 45) {
                        goto $join$97;
                      } else {
                        goto $join$90;
                      }
                    } else if (next_char$98 > 47) {
                      if (next_char$98 < 58) {
                        dispatch_19$89 = 6;
                        goto $loop_label_19$92;
                      } else {
                        dispatch_19$89 = 3;
                        goto $loop_label_19$92;
                      }
                    } else {
                      goto $join$97;
                    }
                  } else if (next_char$98 > 55295) {
                    if (next_char$98 < 57344) {
                      if (next_char$98 < 56319) {
                        dispatch_19$89 = 7;
                        goto $loop_label_19$92;
                      } else {
                        dispatch_19$89 = 8;
                        goto $loop_label_19$92;
                      }
                    } else if (next_char$98 > 65535) {
                      goto $join$68;
                    } else {
                      goto $join$97;
                    }
                  } else {
                    goto $join$97;
                  }
                  $join$97:;
                  dispatch_19$89 = 0;
                  goto $loop_label_19$92;
                } else {
                  goto $join$68;
                }
              }
            } else if (next_char$96 > 58) {
              goto $join$95;
            } else {
              dispatch_19$89 = 1;
              goto $loop_label_19$92;
            }
          } else if (next_char$96 > 56318) {
            if (next_char$96 < 57344) {
              dispatch_19$89 = 8;
              goto $loop_label_19$92;
            } else if (next_char$96 > 65535) {
              goto $join$68;
            } else {
              goto $join$95;
            }
          } else {
            dispatch_19$89 = 7;
            goto $loop_label_19$92;
          }
          $join$95:;
          dispatch_19$89 = 0;
          goto $loop_label_19$92;
        } else {
          goto $join$68;
        }
        break;
      }

      case 2: {
        int32_t _tmp$582;
        tag_1$61 = _cursor$52;
        tag_2$65 = _cursor$52;
        _tmp$582 = _cursor$52;
        if (_tmp$582 < _end$51) {
          int32_t _p$349 = _cursor$52;
          int32_t next_char$100 = _data$49[_p$349];
          int32_t _tmp$583 = _cursor$52;
          _cursor$52 = _tmp$583 + 1;
          if (next_char$100 < 55296) {
            if (next_char$100 < 58) {
              if (next_char$100 < 48) {
                goto $join$99;
              } else {
                dispatch_19$89 = 2;
                goto $loop_label_19$92;
              }
            } else if (next_char$100 > 58) {
              goto $join$99;
            } else {
              dispatch_19$89 = 3;
              goto $loop_label_19$92;
            }
          } else if (next_char$100 > 56318) {
            if (next_char$100 < 57344) {
              dispatch_19$89 = 8;
              goto $loop_label_19$92;
            } else if (next_char$100 > 65535) {
              goto $join$68;
            } else {
              goto $join$99;
            }
          } else {
            dispatch_19$89 = 7;
            goto $loop_label_19$92;
          }
          $join$99:;
          dispatch_19$89 = 0;
          goto $loop_label_19$92;
        } else {
          goto $join$68;
        }
        break;
      }

      case 0: {
        int32_t _tmp$584;
        tag_1$61 = _cursor$52;
        _tmp$584 = _cursor$52;
        if (_tmp$584 < _end$51) {
          int32_t _p$352 = _cursor$52;
          int32_t next_char$102 = _data$49[_p$352];
          int32_t _tmp$585 = _cursor$52;
          _cursor$52 = _tmp$585 + 1;
          if (next_char$102 < 55296) {
            if (next_char$102 < 58) {
              goto $join$101;
            } else if (next_char$102 > 58) {
              goto $join$101;
            } else {
              dispatch_19$89 = 1;
              goto $loop_label_19$92;
            }
          } else if (next_char$102 > 56318) {
            if (next_char$102 < 57344) {
              dispatch_19$89 = 8;
              goto $loop_label_19$92;
            } else if (next_char$102 > 65535) {
              goto $join$68;
            } else {
              goto $join$101;
            }
          } else {
            dispatch_19$89 = 7;
            goto $loop_label_19$92;
          }
          $join$101:;
          dispatch_19$89 = 0;
          goto $loop_label_19$92;
        } else {
          goto $join$68;
        }
        break;
      }

      case 8: {
        int32_t _tmp$586 = _cursor$52;
        if (_tmp$586 < _end$51) {
          int32_t _p$355 = _cursor$52;
          int32_t next_char$103 = _data$49[_p$355];
          int32_t _tmp$587 = _cursor$52;
          _cursor$52 = _tmp$587 + 1;
          if (next_char$103 < 56320) {
            goto $join$68;
          } else if (next_char$103 > 57343) {
            goto $join$68;
          } else {
            dispatch_19$89 = 0;
            goto $loop_label_19$92;
          }
        } else {
          goto $join$68;
        }
        break;
      }

      case 4: {
        int32_t _tmp$588;
        tag_1$61 = _cursor$52;
        tag_4$67 = _cursor$52;
        _tmp$588 = _cursor$52;
        if (_tmp$588 < _end$51) {
          int32_t _p$358 = _cursor$52;
          int32_t next_char$105 = _data$49[_p$358];
          int32_t _tmp$589 = _cursor$52;
          _cursor$52 = _tmp$589 + 1;
          if (next_char$105 < 55296) {
            if (next_char$105 < 58) {
              if (next_char$105 < 48) {
                goto $join$104;
              } else {
                dispatch_19$89 = 4;
                goto $loop_label_19$92;
              }
            } else if (next_char$105 > 58) {
              goto $join$104;
            } else {
              int32_t _tmp$590;
              tag_1_2$63 = tag_1_1$62;
              tag_1_1$62 = tag_1$61;
              tag_1$61 = _cursor$52;
              _tmp$590 = _cursor$52;
              if (_tmp$590 < _end$51) {
                int32_t _p$361 = _cursor$52;
                int32_t next_char$107 = _data$49[_p$361];
                int32_t _tmp$591 = _cursor$52;
                _cursor$52 = _tmp$591 + 1;
                if (next_char$107 < 55296) {
                  if (next_char$107 < 58) {
                    if (next_char$107 < 48) {
                      goto $join$106;
                    } else {
                      int32_t _tmp$592;
                      tag_1$61 = _cursor$52;
                      tag_2_1$66 = tag_2$65;
                      tag_2$65 = _cursor$52;
                      _tmp$592 = _cursor$52;
                      if (_tmp$592 < _end$51) {
                        int32_t _p$364 = _cursor$52;
                        int32_t next_char$109 = _data$49[_p$364];
                        int32_t _tmp$593 = _cursor$52;
                        _cursor$52 = _tmp$593 + 1;
                        if (next_char$109 < 55296) {
                          if (next_char$109 < 58) {
                            if (next_char$109 < 48) {
                              goto $join$108;
                            } else {
                              dispatch_19$89 = 5;
                              goto $loop_label_19$92;
                            }
                          } else if (next_char$109 > 58) {
                            goto $join$108;
                          } else {
                            dispatch_19$89 = 3;
                            goto $loop_label_19$92;
                          }
                        } else if (next_char$109 > 56318) {
                          if (next_char$109 < 57344) {
                            dispatch_19$89 = 8;
                            goto $loop_label_19$92;
                          } else if (next_char$109 > 65535) {
                            goto $join$68;
                          } else {
                            goto $join$108;
                          }
                        } else {
                          dispatch_19$89 = 7;
                          goto $loop_label_19$92;
                        }
                        $join$108:;
                        dispatch_19$89 = 0;
                        goto $loop_label_19$92;
                      } else {
                        goto $join$94;
                      }
                    }
                  } else if (next_char$107 > 58) {
                    goto $join$106;
                  } else {
                    dispatch_19$89 = 1;
                    goto $loop_label_19$92;
                  }
                } else if (next_char$107 > 56318) {
                  if (next_char$107 < 57344) {
                    dispatch_19$89 = 8;
                    goto $loop_label_19$92;
                  } else if (next_char$107 > 65535) {
                    goto $join$68;
                  } else {
                    goto $join$106;
                  }
                } else {
                  dispatch_19$89 = 7;
                  goto $loop_label_19$92;
                }
                $join$106:;
                dispatch_19$89 = 0;
                goto $loop_label_19$92;
              } else {
                goto $join$68;
              }
            }
          } else if (next_char$105 > 56318) {
            if (next_char$105 < 57344) {
              dispatch_19$89 = 8;
              goto $loop_label_19$92;
            } else if (next_char$105 > 65535) {
              goto $join$68;
            } else {
              goto $join$104;
            }
          } else {
            dispatch_19$89 = 7;
            goto $loop_label_19$92;
          }
          $join$104:;
          dispatch_19$89 = 0;
          goto $loop_label_19$92;
        } else {
          goto $join$68;
        }
        break;
      }

      case 5: {
        int32_t _tmp$594;
        tag_1$61 = _cursor$52;
        tag_2$65 = _cursor$52;
        _tmp$594 = _cursor$52;
        if (_tmp$594 < _end$51) {
          int32_t _p$367 = _cursor$52;
          int32_t next_char$111 = _data$49[_p$367];
          int32_t _tmp$595 = _cursor$52;
          _cursor$52 = _tmp$595 + 1;
          if (next_char$111 < 55296) {
            if (next_char$111 < 58) {
              if (next_char$111 < 48) {
                goto $join$110;
              } else {
                dispatch_19$89 = 5;
                goto $loop_label_19$92;
              }
            } else if (next_char$111 > 58) {
              goto $join$110;
            } else {
              dispatch_19$89 = 3;
              goto $loop_label_19$92;
            }
          } else if (next_char$111 > 56318) {
            if (next_char$111 < 57344) {
              dispatch_19$89 = 8;
              goto $loop_label_19$92;
            } else if (next_char$111 > 65535) {
              goto $join$68;
            } else {
              goto $join$110;
            }
          } else {
            dispatch_19$89 = 7;
            goto $loop_label_19$92;
          }
          $join$110:;
          dispatch_19$89 = 0;
          goto $loop_label_19$92;
        } else {
          goto $join$94;
        }
        break;
      }

      case 6: {
        int32_t _tmp$596;
        tag_1$61 = _cursor$52;
        tag_2$65 = _cursor$52;
        tag_3$64 = _cursor$52;
        _tmp$596 = _cursor$52;
        if (_tmp$596 < _end$51) {
          int32_t _p$370 = _cursor$52;
          int32_t next_char$113 = _data$49[_p$370];
          int32_t _tmp$597 = _cursor$52;
          _cursor$52 = _tmp$597 + 1;
          if (next_char$113 < 59) {
            if (next_char$113 < 46) {
              if (next_char$113 < 45) {
                goto $join$112;
              } else {
                goto $join$90;
              }
            } else if (next_char$113 > 47) {
              if (next_char$113 < 58) {
                dispatch_19$89 = 6;
                goto $loop_label_19$92;
              } else {
                dispatch_19$89 = 3;
                goto $loop_label_19$92;
              }
            } else {
              goto $join$112;
            }
          } else if (next_char$113 > 55295) {
            if (next_char$113 < 57344) {
              if (next_char$113 < 56319) {
                dispatch_19$89 = 7;
                goto $loop_label_19$92;
              } else {
                dispatch_19$89 = 8;
                goto $loop_label_19$92;
              }
            } else if (next_char$113 > 65535) {
              goto $join$68;
            } else {
              goto $join$112;
            }
          } else {
            goto $join$112;
          }
          $join$112:;
          dispatch_19$89 = 0;
          goto $loop_label_19$92;
        } else {
          goto $join$68;
        }
        break;
      }

      case 7: {
        int32_t _tmp$598 = _cursor$52;
        if (_tmp$598 < _end$51) {
          int32_t _p$373 = _cursor$52;
          int32_t next_char$114 = _data$49[_p$373];
          int32_t _tmp$599 = _cursor$52;
          _cursor$52 = _tmp$599 + 1;
          if (next_char$114 < 56320) {
            goto $join$68;
          } else if (next_char$114 > 65535) {
            goto $join$68;
          } else {
            dispatch_19$89 = 0;
            goto $loop_label_19$92;
          }
        } else {
          goto $join$68;
        }
        break;
      }

      case 1: {
        int32_t _tmp$600;
        tag_1_1$62 = tag_1$61;
        tag_1$61 = _cursor$52;
        _tmp$600 = _cursor$52;
        if (_tmp$600 < _end$51) {
          int32_t _p$376 = _cursor$52;
          int32_t next_char$116 = _data$49[_p$376];
          int32_t _tmp$601 = _cursor$52;
          _cursor$52 = _tmp$601 + 1;
          if (next_char$116 < 55296) {
            if (next_char$116 < 58) {
              if (next_char$116 < 48) {
                goto $join$115;
              } else {
                dispatch_19$89 = 2;
                goto $loop_label_19$92;
              }
            } else if (next_char$116 > 58) {
              goto $join$115;
            } else {
              dispatch_19$89 = 1;
              goto $loop_label_19$92;
            }
          } else if (next_char$116 > 56318) {
            if (next_char$116 < 57344) {
              dispatch_19$89 = 8;
              goto $loop_label_19$92;
            } else if (next_char$116 > 65535) {
              goto $join$68;
            } else {
              goto $join$115;
            }
          } else {
            dispatch_19$89 = 7;
            goto $loop_label_19$92;
          }
          $join$115:;
          dispatch_19$89 = 0;
          goto $loop_label_19$92;
        } else {
          goto $join$68;
        }
        break;
      }
      default: {
        goto $join$68;
        break;
      }
    }
    $join$94:;
    tag_1$61 = tag_1_2$63;
    tag_2$65 = tag_2_1$66;
    match_tag_saver_0$55 = tag_0$60;
    match_tag_saver_1$56 = tag_1$61;
    match_tag_saver_2$57 = tag_2$65;
    match_tag_saver_3$58 = tag_3$64;
    match_tag_saver_4$59 = tag_4$67;
    accept_state$53 = 0;
    match_end$54 = _cursor$52;
    goto $join$68;
    $join$90:;
    tag_1_1$62 = tag_1_2$63;
    tag_1$61 = _cursor$52;
    tag_2$65 = tag_2_1$66;
    _tmp$576 = _cursor$52;
    if (_tmp$576 < _end$51) {
      int32_t _p$379 = _cursor$52;
      int32_t next_char$93 = _data$49[_p$379];
      int32_t _tmp$577 = _cursor$52;
      _cursor$52 = _tmp$577 + 1;
      if (next_char$93 < 55296) {
        if (next_char$93 < 58) {
          if (next_char$93 < 48) {
            goto $join$91;
          } else {
            dispatch_19$89 = 4;
            continue;
          }
        } else if (next_char$93 > 58) {
          goto $join$91;
        } else {
          dispatch_19$89 = 1;
          continue;
        }
      } else if (next_char$93 > 56318) {
        if (next_char$93 < 57344) {
          dispatch_19$89 = 8;
          continue;
        } else if (next_char$93 > 65535) {
          goto $join$68;
        } else {
          goto $join$91;
        }
      } else {
        dispatch_19$89 = 7;
        continue;
      }
      $join$91:;
      dispatch_19$89 = 0;
      continue;
    } else {
      goto $join$68;
    }
    break;
  }
  $join$68:;
  switch (accept_state$53) {
    case 0: {
      void* _try_err$71;
      struct $StringView start_line$69;
      int32_t _tmp$573 = match_tag_saver_1$56;
      int32_t _tmp$572 = _tmp$573 + 1;
      int64_t _tmp$569 = (int64_t)_tmp$572;
      int32_t _tmp$571 = match_tag_saver_2$57;
      int64_t _tmp$570 = (int64_t)_tmp$571;
      struct moonbit_result_0 _tmp$907;
      void* _try_err$74;
      struct $StringView start_column$72;
      int32_t _tmp$566;
      int32_t _tmp$565;
      int64_t _tmp$562;
      int32_t _tmp$564;
      int64_t _tmp$563;
      struct moonbit_result_0 _tmp$909;
      void* _try_err$77;
      struct $StringView pkg$75;
      int32_t _tmp$559;
      int64_t _tmp$556;
      int32_t _tmp$558;
      int64_t _tmp$557;
      struct moonbit_result_0 _tmp$911;
      void* _try_err$80;
      struct $StringView filename$78;
      int32_t _tmp$553;
      int32_t _tmp$552;
      int64_t _tmp$549;
      int32_t _tmp$551;
      int64_t _tmp$550;
      struct moonbit_result_0 _tmp$913;
      void* _try_err$83;
      struct $StringView end_line$81;
      int32_t _tmp$546;
      int32_t _tmp$545;
      int64_t _tmp$542;
      int32_t _tmp$544;
      int64_t _tmp$543;
      struct moonbit_result_0 _tmp$915;
      void* _try_err$86;
      struct $StringView end_column$84;
      int32_t _tmp$539;
      int32_t _tmp$538;
      int64_t _tmp$535;
      int32_t _tmp$537;
      int64_t _tmp$536;
      struct moonbit_result_0 _tmp$917;
      struct $$moonbitlang$core$builtin$SourceLocRepr* _block$918;
      moonbit_incref(_data$49);
      _tmp$907 = $String$$sub(_data$49, _tmp$569, _tmp$570);
      if (_tmp$907.tag) {
        struct $StringView const _ok$574 = _tmp$907.data.ok;
        start_line$69 = _ok$574;
      } else {
        void* const _err$575 = _tmp$907.data.err;
        _try_err$71 = _err$575;
        goto $join$70;
      }
      goto $joinlet$906;
      $join$70:;
      moonbit_decref(_try_err$71);
      moonbit_panic();
      $joinlet$906:;
      _tmp$566 = match_tag_saver_2$57;
      _tmp$565 = _tmp$566 + 1;
      _tmp$562 = (int64_t)_tmp$565;
      _tmp$564 = match_tag_saver_3$58;
      _tmp$563 = (int64_t)_tmp$564;
      moonbit_incref(_data$49);
      _tmp$909 = $String$$sub(_data$49, _tmp$562, _tmp$563);
      if (_tmp$909.tag) {
        struct $StringView const _ok$567 = _tmp$909.data.ok;
        start_column$72 = _ok$567;
      } else {
        void* const _err$568 = _tmp$909.data.err;
        _try_err$74 = _err$568;
        goto $join$73;
      }
      goto $joinlet$908;
      $join$73:;
      moonbit_decref(_try_err$74);
      moonbit_panic();
      $joinlet$908:;
      _tmp$559 = _start$50 + 1;
      _tmp$556 = (int64_t)_tmp$559;
      _tmp$558 = match_tag_saver_0$55;
      _tmp$557 = (int64_t)_tmp$558;
      moonbit_incref(_data$49);
      _tmp$911 = $String$$sub(_data$49, _tmp$556, _tmp$557);
      if (_tmp$911.tag) {
        struct $StringView const _ok$560 = _tmp$911.data.ok;
        pkg$75 = _ok$560;
      } else {
        void* const _err$561 = _tmp$911.data.err;
        _try_err$77 = _err$561;
        goto $join$76;
      }
      goto $joinlet$910;
      $join$76:;
      moonbit_decref(_try_err$77);
      moonbit_panic();
      $joinlet$910:;
      _tmp$553 = match_tag_saver_0$55;
      _tmp$552 = _tmp$553 + 1;
      _tmp$549 = (int64_t)_tmp$552;
      _tmp$551 = match_tag_saver_1$56;
      _tmp$550 = (int64_t)_tmp$551;
      moonbit_incref(_data$49);
      _tmp$913 = $String$$sub(_data$49, _tmp$549, _tmp$550);
      if (_tmp$913.tag) {
        struct $StringView const _ok$554 = _tmp$913.data.ok;
        filename$78 = _ok$554;
      } else {
        void* const _err$555 = _tmp$913.data.err;
        _try_err$80 = _err$555;
        goto $join$79;
      }
      goto $joinlet$912;
      $join$79:;
      moonbit_decref(_try_err$80);
      moonbit_panic();
      $joinlet$912:;
      _tmp$546 = match_tag_saver_3$58;
      _tmp$545 = _tmp$546 + 1;
      _tmp$542 = (int64_t)_tmp$545;
      _tmp$544 = match_tag_saver_4$59;
      _tmp$543 = (int64_t)_tmp$544;
      moonbit_incref(_data$49);
      _tmp$915 = $String$$sub(_data$49, _tmp$542, _tmp$543);
      if (_tmp$915.tag) {
        struct $StringView const _ok$547 = _tmp$915.data.ok;
        end_line$81 = _ok$547;
      } else {
        void* const _err$548 = _tmp$915.data.err;
        _try_err$83 = _err$548;
        goto $join$82;
      }
      goto $joinlet$914;
      $join$82:;
      moonbit_decref(_try_err$83);
      moonbit_panic();
      $joinlet$914:;
      _tmp$539 = match_tag_saver_4$59;
      _tmp$538 = _tmp$539 + 1;
      _tmp$535 = (int64_t)_tmp$538;
      _tmp$537 = match_end$54;
      _tmp$536 = (int64_t)_tmp$537;
      _tmp$917 = $String$$sub(_data$49, _tmp$535, _tmp$536);
      if (_tmp$917.tag) {
        struct $StringView const _ok$540 = _tmp$917.data.ok;
        end_column$84 = _ok$540;
      } else {
        void* const _err$541 = _tmp$917.data.err;
        _try_err$86 = _err$541;
        goto $join$85;
      }
      goto $joinlet$916;
      $join$85:;
      moonbit_decref(_try_err$86);
      moonbit_panic();
      $joinlet$916:;
      _block$918
      = (struct $$moonbitlang$core$builtin$SourceLocRepr*)moonbit_malloc(
          sizeof(struct $$moonbitlang$core$builtin$SourceLocRepr)
        );
      Moonbit_object_header(_block$918)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $$moonbitlang$core$builtin$SourceLocRepr, $0_0) >> 2,
          6,
          0
      );
      _block$918->$0_0 = pkg$75.$0;
      _block$918->$0_1 = pkg$75.$1;
      _block$918->$0_2 = pkg$75.$2;
      _block$918->$1_0 = filename$78.$0;
      _block$918->$1_1 = filename$78.$1;
      _block$918->$1_2 = filename$78.$2;
      _block$918->$2_0 = start_line$69.$0;
      _block$918->$2_1 = start_line$69.$1;
      _block$918->$2_2 = start_line$69.$2;
      _block$918->$3_0 = start_column$72.$0;
      _block$918->$3_1 = start_column$72.$1;
      _block$918->$3_2 = start_column$72.$2;
      _block$918->$4_0 = end_line$81.$0;
      _block$918->$4_1 = end_line$81.$1;
      _block$918->$4_2 = end_line$81.$2;
      _block$918->$5_0 = end_column$84.$0;
      _block$918->$5_1 = end_column$84.$1;
      _block$918->$5_2 = end_column$84.$2;
      return _block$918;
      break;
    }
    default: {
      moonbit_decref(_data$49);
      moonbit_panic();
      break;
    }
  }
}

int32_t $String$$unsafe_charcode_at(moonbit_string_t self$45, int32_t idx$46) {
  int32_t _tmp$842 = self$45[idx$46];
  moonbit_decref(self$45);
  return _tmp$842;
}

int32_t $Int$$is_trailing_surrogate(int32_t self$44) {
  return 56320 <= self$44 && self$44 <= 57343;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$41,
  int32_t ch$43
) {
  int32_t len$530 = self$41->$1;
  int32_t _tmp$529 = len$530 + 4;
  moonbit_bytes_t _field$843;
  moonbit_bytes_t data$533;
  int32_t len$534;
  int32_t inc$42;
  int32_t len$532;
  int32_t _tmp$531;
  moonbit_incref(self$41);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$41, _tmp$529
  );
  _field$843 = self$41->$0;
  data$533 = _field$843;
  len$534 = self$41->$1;
  moonbit_incref(data$533);
  inc$42 = $FixedArray$$set_utf16le_char(data$533, len$534, ch$43);
  len$532 = self$41->$1;
  _tmp$531 = len$532 + inc$42;
  self$41->$1 = _tmp$531;
  moonbit_decref(self$41);
  return 0;
}

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$36,
  int32_t required$37
) {
  moonbit_bytes_t _field$847 = self$36->$0;
  moonbit_bytes_t data$528 = _field$847;
  int32_t _tmp$846 = Moonbit_array_length(data$528);
  int32_t current_len$35 = _tmp$846;
  int32_t enough_space$38;
  int32_t _tmp$527;
  moonbit_bytes_t new_data$40;
  moonbit_bytes_t _field$845;
  moonbit_bytes_t data$525;
  int32_t len$526;
  moonbit_bytes_t _old$844;
  if (required$37 <= current_len$35) {
    moonbit_decref(self$36);
    return 0;
  }
  enough_space$38 = current_len$35;
  while (1) {
    int32_t _tmp$523 = enough_space$38;
    if (_tmp$523 < required$37) {
      int32_t _tmp$524 = enough_space$38;
      enough_space$38 = _tmp$524 * 2;
      continue;
    }
    break;
  }
  _tmp$527 = enough_space$38;
  new_data$40 = (moonbit_bytes_t)moonbit_make_bytes(_tmp$527, 0);
  _field$845 = self$36->$0;
  data$525 = _field$845;
  len$526 = self$36->$1;
  moonbit_incref(data$525);
  moonbit_incref(new_data$40);
  $FixedArray$$unsafe_blit$0(new_data$40, 0, data$525, 0, len$526);
  _old$844 = self$36->$0;
  moonbit_decref(_old$844);
  self$36->$0 = new_data$40;
  moonbit_decref(self$36);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default() {
  return 0;
}

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$30,
  int32_t offset$31,
  int32_t value$29
) {
  int32_t _tmp$522 = value$29;
  uint32_t code$28 = *(uint32_t*)&_tmp$522;
  if (code$28 < 65536u) {
    uint32_t _p$302 = code$28 & 255u;
    int32_t _tmp$505 = *(int32_t*)&_p$302;
    int32_t _tmp$504 = _tmp$505 & 0xff;
    int32_t _tmp$506;
    uint32_t _p$305;
    int32_t _tmp$508;
    int32_t _tmp$507;
    if (offset$31 < 0 || offset$31 >= Moonbit_array_length(self$30)) {
      moonbit_panic();
    }
    self$30[offset$31] = _tmp$504;
    _tmp$506 = offset$31 + 1;
    _p$305 = code$28 >> 8;
    _tmp$508 = *(int32_t*)&_p$305;
    _tmp$507 = _tmp$508 & 0xff;
    if (_tmp$506 < 0 || _tmp$506 >= Moonbit_array_length(self$30)) {
      moonbit_panic();
    }
    self$30[_tmp$506] = _tmp$507;
    moonbit_decref(self$30);
    return 2;
  } else if (code$28 < 1114112u) {
    uint32_t hi$32 = code$28 - 65536u;
    uint32_t _tmp$521 = hi$32 >> 10;
    uint32_t lo$33 = _tmp$521 | 55296u;
    uint32_t _tmp$520 = hi$32 & 1023u;
    uint32_t hi$34 = _tmp$520 | 56320u;
    uint32_t _p$308 = lo$33 & 255u;
    int32_t _tmp$510 = *(int32_t*)&_p$308;
    int32_t _tmp$509 = _tmp$510 & 0xff;
    int32_t _tmp$511;
    uint32_t _p$311;
    int32_t _tmp$513;
    int32_t _tmp$512;
    int32_t _tmp$514;
    uint32_t _p$314;
    int32_t _tmp$516;
    int32_t _tmp$515;
    int32_t _tmp$517;
    uint32_t _p$317;
    int32_t _tmp$519;
    int32_t _tmp$518;
    if (offset$31 < 0 || offset$31 >= Moonbit_array_length(self$30)) {
      moonbit_panic();
    }
    self$30[offset$31] = _tmp$509;
    _tmp$511 = offset$31 + 1;
    _p$311 = lo$33 >> 8;
    _tmp$513 = *(int32_t*)&_p$311;
    _tmp$512 = _tmp$513 & 0xff;
    if (_tmp$511 < 0 || _tmp$511 >= Moonbit_array_length(self$30)) {
      moonbit_panic();
    }
    self$30[_tmp$511] = _tmp$512;
    _tmp$514 = offset$31 + 2;
    _p$314 = hi$34 & 255u;
    _tmp$516 = *(int32_t*)&_p$314;
    _tmp$515 = _tmp$516 & 0xff;
    if (_tmp$514 < 0 || _tmp$514 >= Moonbit_array_length(self$30)) {
      moonbit_panic();
    }
    self$30[_tmp$514] = _tmp$515;
    _tmp$517 = offset$31 + 3;
    _p$317 = hi$34 >> 8;
    _tmp$519 = *(int32_t*)&_p$317;
    _tmp$518 = _tmp$519 & 0xff;
    if (_tmp$517 < 0 || _tmp$517 >= Moonbit_array_length(self$30)) {
      moonbit_panic();
    }
    self$30[_tmp$517] = _tmp$518;
    moonbit_decref(self$30);
    return 4;
  } else {
    moonbit_decref(self$30);
    return $moonbitlang$core$builtin$abort$1(
             (moonbit_string_t)moonbit_string_literal_4.data,
               (moonbit_string_t)moonbit_string_literal_5.data
           );
  }
}

int32_t $UInt$$to_byte(uint32_t self$27) {
  int32_t _tmp$503 = *(int32_t*)&self$27;
  return _tmp$503 & 0xff;
}

uint32_t $Char$$to_uint(int32_t self$26) {
  int32_t _tmp$502 = self$26;
  return *(uint32_t*)&_tmp$502;
}

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$25
) {
  moonbit_bytes_t _field$849 = self$25->$0;
  moonbit_bytes_t data$501 = _field$849;
  moonbit_bytes_t _tmp$498;
  int32_t _field$848;
  int32_t len$500;
  int64_t _tmp$499;
  moonbit_incref(data$501);
  _tmp$498 = data$501;
  _field$848 = self$25->$1;
  moonbit_decref(self$25);
  len$500 = _field$848;
  _tmp$499 = (int64_t)len$500;
  return $Bytes$$to_unchecked_string$inner(_tmp$498, 0, _tmp$499);
}

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$20,
  int32_t offset$24,
  int64_t length$22
) {
  int32_t len$19 = Moonbit_array_length(self$20);
  int32_t length$21;
  int32_t _if_result$920;
  if (length$22 == 4294967296ll) {
    length$21 = len$19 - offset$24;
  } else {
    int64_t _Some$23 = length$22;
    length$21 = (int32_t)_Some$23;
  }
  if (offset$24 >= 0) {
    if (length$21 >= 0) {
      int32_t _tmp$497 = offset$24 + length$21;
      _if_result$920 = _tmp$497 <= len$19;
    } else {
      _if_result$920 = 0;
    }
  } else {
    _if_result$920 = 0;
  }
  if (_if_result$920) {
    return $moonbitlang$core$builtin$unsafe_sub_string(
             self$20, offset$24, length$21
           );
  } else {
    moonbit_decref(self$20);
    moonbit_panic();
  }
}

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$17
) {
  int32_t initial$16;
  moonbit_bytes_t data$18;
  struct $$moonbitlang$core$builtin$StringBuilder* _block$921;
  if (size_hint$17 < 1) {
    initial$16 = 1;
  } else {
    initial$16 = size_hint$17;
  }
  data$18 = (moonbit_bytes_t)moonbit_make_bytes(initial$16, 0);
  _block$921
  = (struct $$moonbitlang$core$builtin$StringBuilder*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$builtin$StringBuilder)
    );
  Moonbit_object_header(_block$921)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $$moonbitlang$core$builtin$StringBuilder, $0) >> 2, 1, 0
  );
  _block$921->$0 = data$18;
  _block$921->$1 = 0;
  return _block$921;
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
        int32_t _tmp$488 = dst_offset$9 + i$11;
        int32_t _tmp$490 = src_offset$10 + i$11;
        int32_t _tmp$489;
        int32_t _tmp$491;
        if (_tmp$490 < 0 || _tmp$490 >= Moonbit_array_length(src$8)) {
          moonbit_panic();
        }
        _tmp$489 = (int32_t)src$8[_tmp$490];
        if (_tmp$488 < 0 || _tmp$488 >= Moonbit_array_length(dst$7)) {
          moonbit_panic();
        }
        dst$7[_tmp$488] = _tmp$489;
        _tmp$491 = i$11 + 1;
        i$11 = _tmp$491;
        continue;
      } else {
        moonbit_decref(src$8);
        moonbit_decref(dst$7);
      }
      break;
    }
  } else {
    int32_t _tmp$496 = len$12 - 1;
    int32_t i$14 = _tmp$496;
    while (1) {
      if (i$14 >= 0) {
        int32_t _tmp$492 = dst_offset$9 + i$14;
        int32_t _tmp$494 = src_offset$10 + i$14;
        int32_t _tmp$493;
        int32_t _tmp$495;
        if (_tmp$494 < 0 || _tmp$494 >= Moonbit_array_length(src$8)) {
          moonbit_panic();
        }
        _tmp$493 = (int32_t)src$8[_tmp$494];
        if (_tmp$492 < 0 || _tmp$492 >= Moonbit_array_length(dst$7)) {
          moonbit_panic();
        }
        dst$7[_tmp$492] = _tmp$493;
        _tmp$495 = i$14 - 1;
        i$14 = _tmp$495;
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
  moonbit_string_t _tmp$486 =
    moonbit_add_string(
      string$5, (moonbit_string_t)moonbit_string_literal_6.data
    );
  moonbit_string_t _tmp$487 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$6);
  moonbit_string_t _tmp$485 = moonbit_add_string(_tmp$486, _tmp$487);
  moonbit_string_t _tmp$484 =
    moonbit_add_string(
      _tmp$485, (moonbit_string_t)moonbit_string_literal_7.data
    );
  return $moonbitlang$core$abort$abort$1(_tmp$484);
}

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$3,
  moonbit_string_t loc$4
) {
  moonbit_string_t _tmp$482 =
    moonbit_add_string(
      string$3, (moonbit_string_t)moonbit_string_literal_6.data
    );
  moonbit_string_t _tmp$483 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(loc$4);
  moonbit_string_t _tmp$481 = moonbit_add_string(_tmp$482, _tmp$483);
  moonbit_string_t _tmp$480 =
    moonbit_add_string(
      _tmp$481, (moonbit_string_t)moonbit_string_literal_7.data
    );
  $moonbitlang$core$abort$abort$0(_tmp$480);
  return 0;
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
  void* _obj_ptr$463,
  int32_t _param$462
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$461 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$463;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
    _self$461, _param$462
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$460,
  struct $StringView _param$459
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$458 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$460;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    _self$458, _param$459
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$457,
  moonbit_string_t _param$454,
  int32_t _param$455,
  int32_t _param$456
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$453 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$457;
  $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
    _self$453, _param$454, _param$455, _param$456
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$452,
  moonbit_string_t _param$451
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$450 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$452;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
    _self$450, _param$451
  );
  return 0;
}

void moonbit_init() {

}

int main(int argc, char** argv) {
  int32_t _p$439;
  int32_t _p$440;
  int64_t _bind$290;
  int32_t _p$443;
  int32_t _p$444;
  int64_t _bind$293;
  moonbit_runtime_init(argc, argv);
  moonbit_init();
  _p$439 = 10;
  _p$440 = 2;
  if (_p$440 == 0) {
    _bind$290 = 4294967296ll;
  } else {
    int32_t _tmp$471 = _p$439 / _p$440;
    _bind$290 = (int64_t)_tmp$471;
  }
  if (_bind$290 == 4294967296ll) {
    $moonbitlang$core$builtin$println$0(
      (moonbit_string_t)moonbit_string_literal_8.data
    );
  } else {
    int64_t _Some$291 = _bind$290;
    int32_t _v$292 = (int32_t)_Some$291;
    moonbit_string_t _tmp$470 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(10);
    moonbit_string_t _tmp$468 =
      moonbit_add_string(
        _tmp$470, (moonbit_string_t)moonbit_string_literal_9.data
      );
    moonbit_string_t _tmp$469 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(2);
    moonbit_string_t _tmp$467 = moonbit_add_string(_tmp$468, _tmp$469);
    moonbit_string_t _tmp$465 =
      moonbit_add_string(
        _tmp$467, (moonbit_string_t)moonbit_string_literal_10.data
      );
    moonbit_string_t _tmp$466 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(_v$292);
    moonbit_string_t _tmp$464 = moonbit_add_string(_tmp$465, _tmp$466);
    $moonbitlang$core$builtin$println$0(_tmp$464);
  }
  _p$443 = 10;
  _p$444 = 0;
  if (_p$444 == 0) {
    _bind$293 = 4294967296ll;
  } else {
    int32_t _tmp$479 = _p$443 / _p$444;
    _bind$293 = (int64_t)_tmp$479;
  }
  if (_bind$293 == 4294967296ll) {
    $moonbitlang$core$builtin$println$0(
      (moonbit_string_t)moonbit_string_literal_8.data
    );
  } else {
    int64_t _Some$294 = _bind$293;
    int32_t _v$295 = (int32_t)_Some$294;
    moonbit_string_t _tmp$478 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(10);
    moonbit_string_t _tmp$476 =
      moonbit_add_string(
        _tmp$478, (moonbit_string_t)moonbit_string_literal_9.data
      );
    moonbit_string_t _tmp$477 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(0);
    moonbit_string_t _tmp$475 = moonbit_add_string(_tmp$476, _tmp$477);
    moonbit_string_t _tmp$473 =
      moonbit_add_string(
        _tmp$475, (moonbit_string_t)moonbit_string_literal_10.data
      );
    moonbit_string_t _tmp$474 =
      $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(_v$295);
    moonbit_string_t _tmp$472 = moonbit_add_string(_tmp$473, _tmp$474);
    $moonbitlang$core$builtin$println$0(_tmp$472);
  }
  return 0;
}