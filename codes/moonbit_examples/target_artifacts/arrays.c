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

struct $ArrayView$$iter$7c$Int$7c$$$2a$p$fn$1$2d$cap;

struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$;

struct $$moonbitlang$core$builtin$Array$3c$Int$3e$;

struct $Ref$3c$Int$3e$;

struct $Result$3c$StringView$2a$$moonbitlang$core$builtin$CreatingViewError$3e$$Ok;

struct $StringView;

struct $$moonbitlang$core$builtin$Logger;

struct $$moonbitlang$core$builtin$SourceLocRepr;

struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$;

struct $Option$3c$StringView$3e$$Some;

struct $Result$3c$StringView$2a$$moonbitlang$core$builtin$CreatingViewError$3e$$Err;

struct $$moonbitlang$core$builtin$Logger$static_method_table;

struct $$moonbitlang$core$builtin$StringBuilder;

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$;

struct $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger {
  struct $$moonbitlang$core$builtin$Logger$static_method_table* $0;
  void* $1;

};

struct $ArrayView$$iter$7c$Int$7c$$$2a$p$fn$1$2d$cap {
  int64_t(* code)(struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$*);
  int32_t $0_1;
  int32_t $0_2;
  int32_t* $0_0;
  struct $Ref$3c$Int$3e$* $1;

};

struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$ {
  int32_t $0_1;
  int32_t $0_2;
  moonbit_string_t $0_0;
  void* $1;

};

struct $$moonbitlang$core$builtin$Array$3c$Int$3e$ {
  int32_t $1;
  int32_t* $0;

};

struct $Ref$3c$Int$3e$ {
  int32_t $0;

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

struct $$moonbitlang$core$builtin$Logger {
  struct $$moonbitlang$core$builtin$Logger$static_method_table* $0;
  void* $1;

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

struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ {
  int32_t $1;
  int32_t $2;
  int32_t* $0;

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

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$ {
  int64_t(* code)(struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$*);

};

struct moonbit_result_0 {
  int tag;
  union { struct $StringView ok; void* err;  } data;

};

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$342,
  struct $$moonbitlang$core$builtin$Logger logger$343
);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$305,
  struct $$moonbitlang$core$builtin$Logger logger$341
);

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$303);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$Array$$output$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$302,
  struct $$moonbitlang$core$builtin$Logger logger$301
);

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$Array$$iter$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$300
);

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$ArrayView$$iter$0(
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ self$298
);

int64_t $ArrayView$$iter$7c$Int$7c$$$2a$p$fn$1(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* _env$851
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$String$$to_string(
  moonbit_string_t self$296
);

int32_t $$moonbitlang$core$builtin$Show$$Int$$output(
  int32_t self$295,
  struct $$moonbitlang$core$builtin$Logger logger$294
);

int64_t $$moonbitlang$core$builtin$Iter$$next$0(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* self$293
);

int32_t $$moonbitlang$core$builtin$Array$$push$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$289,
  int32_t value$291
);

int32_t $$moonbitlang$core$builtin$Array$$realloc$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$287
);

int32_t $$moonbitlang$core$builtin$Array$$resize_buffer$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$283,
  int32_t new_capacity$281
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$278,
  struct $StringView str$279
);

int32_t $$moonbitlang$core$builtin$ArrayView$$length$0(
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ self$277
);

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$Iter$$new$0(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* f$276
);

moonbit_string_t $Int$$to_string$inner(int32_t self$260, int32_t radix$259);

int32_t $moonbitlang$core$builtin$radix_count32(
  uint32_t value$253,
  int32_t radix$256
);

int32_t $moonbitlang$core$builtin$hex_count32(uint32_t value$251);

int32_t $moonbitlang$core$builtin$dec_count32(uint32_t value$250);

int32_t $moonbitlang$core$builtin$int_to_string_dec(
  uint16_t* buffer$240,
  uint32_t num$228,
  int32_t digit_start$231,
  int32_t total_len$230
);

int32_t $moonbitlang$core$builtin$int_to_string_generic(
  uint16_t* buffer$222,
  uint32_t num$216,
  int32_t digit_start$214,
  int32_t total_len$213,
  int32_t radix$218
);

int32_t $moonbitlang$core$builtin$int_to_string_hex(
  uint16_t* buffer$209,
  uint32_t num$205,
  int32_t digit_start$203,
  int32_t total_len$202
);

int32_t $$moonbitlang$core$builtin$Logger$$write_iter$inner$0(
  struct $$moonbitlang$core$builtin$Logger self$186,
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* iter$190,
  moonbit_string_t prefix$187,
  moonbit_string_t suffix$200,
  moonbit_string_t sep$193,
  int32_t trailing$188
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(
  moonbit_string_t self$185
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  int32_t self$183
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$181
);

int32_t $StringView$$start_offset(struct $StringView self$179);

int32_t $StringView$$length(struct $StringView self$178);

moonbit_string_t $StringView$$data(struct $StringView self$177);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$171,
  moonbit_string_t value$174,
  int32_t start$175,
  int32_t len$176
);

struct moonbit_result_0 $String$$sub(
  moonbit_string_t self$169,
  int64_t start$opt$167,
  int64_t end$170
);

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$159,
  int32_t start$165,
  int64_t end$161
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$156,
  moonbit_string_t str$157
);

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$148,
  int32_t bytes_offset$143,
  moonbit_string_t str$150,
  int32_t str_offset$146,
  int32_t length$144
);

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$65
);

int32_t* $$moonbitlang$core$builtin$Array$$buffer$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$63
);

int32_t $String$$unsafe_charcode_at(moonbit_string_t self$61, int32_t idx$62);

int32_t $Int$$is_trailing_surrogate(int32_t self$60);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$57,
  int32_t ch$59
);

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$52,
  int32_t required$53
);

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default();

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$46,
  int32_t offset$47,
  int32_t value$45
);

int32_t $UInt$$to_byte(uint32_t self$43);

uint32_t $Char$$to_uint(int32_t self$42);

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$41
);

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$36,
  int32_t offset$40,
  int64_t length$38
);

#define $moonbitlang$core$builtin$unsafe_sub_string moonbit_unsafe_bytes_sub_string

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$33
);

int32_t $$moonbitlang$core$builtin$UninitializedArray$$unsafe_blit$0(
  int32_t* dst$27,
  int32_t dst_offset$28,
  int32_t* src$29,
  int32_t src_offset$30,
  int32_t len$31
);

int32_t $FixedArray$$unsafe_blit$1(
  int32_t* dst$18,
  int32_t dst_offset$20,
  int32_t* src$19,
  int32_t src_offset$21,
  int32_t len$23
);

int32_t $FixedArray$$unsafe_blit$0(
  moonbit_bytes_t dst$9,
  int32_t dst_offset$11,
  moonbit_bytes_t src$10,
  int32_t src_offset$12,
  int32_t len$14
);

int32_t $moonbitlang$core$builtin$abort$1(
  moonbit_string_t string$7,
  moonbit_string_t loc$8
);

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$5,
  moonbit_string_t loc$6
);

int32_t $$moonbitlang$core$builtin$Logger$$write_object$0(
  struct $$moonbitlang$core$builtin$Logger self$4,
  int32_t obj$3
);

int32_t $moonbitlang$core$abort$abort$1(moonbit_string_t msg$2);

int32_t $moonbitlang$core$abort$abort$0(moonbit_string_t msg$1);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$521,
  int32_t _param$520
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$518,
  struct $StringView _param$517
);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$515,
  moonbit_string_t _param$512,
  int32_t _param$513,
  int32_t _param$514
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$510,
  moonbit_string_t _param$509
);

struct { int32_t rc; uint32_t meta; uint16_t const data[3];
} const moonbit_string_literal_2 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 2),
    44, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[7];
} const moonbit_string_literal_9 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 6),
    10, 32, 32, 97, 116, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[31];
} const moonbit_string_literal_3 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 30),
    114, 97, 100, 105, 120, 32, 109, 117, 115, 116, 32, 98, 101, 32,
    98, 101, 116, 119, 101, 101, 110, 32, 50, 32, 97, 110, 100, 32, 51,
    54, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[17];
} const moonbit_string_literal_11 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 16),
    79, 114, 105, 103, 105, 110, 97, 108, 32, 97, 114, 114, 97, 121,
    58, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[16];
} const moonbit_string_literal_13 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 15),
    68, 111, 117, 98, 108, 101, 100, 32, 97, 114, 114, 97, 121, 58, 32,
    0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_5 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 48, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[18];
} const moonbit_string_literal_7 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 17),
    67, 104, 97, 114, 32, 111, 117, 116, 32, 111, 102, 32, 114, 97, 110,
    103, 101, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[24];
} const moonbit_string_literal_12 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 23),
    83, 117, 109, 32, 111, 102, 32, 97, 114, 114, 97, 121, 32, 101, 108,
    101, 109, 101, 110, 116, 115, 58, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_1 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 93, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[49];
} const moonbit_string_literal_8 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 48),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 98, 121,
    116, 101, 115, 46, 109, 98, 116, 58, 50, 57, 56, 58, 53, 45, 50,
    57, 56, 58, 51, 49, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[53];
} const moonbit_string_literal_4 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 52),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 116, 111,
    95, 115, 116, 114, 105, 110, 103, 46, 109, 98, 116, 58, 50, 51, 57,
    58, 53, 45, 50, 51, 57, 58, 52, 52, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_0 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 91, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[37];
} const moonbit_string_literal_6 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 36),
    48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 100, 101, 102,
    103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115,
    116, 117, 118, 119, 120, 121, 122, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_10 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 10, 0};

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

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$342,
  struct $$moonbitlang$core$builtin$Logger logger$343
) {
  moonbit_string_t _tmp$910 = self$342;
  struct $$moonbitlang$core$builtin$SourceLocRepr* _tmp$909 =
    $$moonbitlang$core$builtin$SourceLocRepr$$parse(_tmp$910);
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
    _tmp$909, logger$343
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$305,
  struct $$moonbitlang$core$builtin$Logger logger$341
) {
  struct $StringView _field$920 =
    (struct $StringView){self$305->$0_1, self$305->$0_2, self$305->$0_0};
  struct $StringView pkg$304 = _field$920;
  moonbit_string_t _field$919 = pkg$304.$0;
  moonbit_string_t _data$306 = _field$919;
  int32_t _start$307 = pkg$304.$1;
  int32_t end$907 = pkg$304.$2;
  int32_t start$908 = pkg$304.$1;
  int32_t _tmp$906 = end$907 - start$908;
  int32_t _end$308 = _start$307 + _tmp$906;
  int32_t _cursor$309 = _start$307;
  int32_t accept_state$310 = -1;
  int32_t match_end$311 = -1;
  int32_t match_tag_saver_0$312 = -1;
  int32_t tag_0$313 = -1;
  struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$* _bind$314;
  struct $StringView _field$918;
  struct $StringView _module_name$337;
  void* _field$917;
  int32_t _cnt$957;
  void* _package_name$338;
  struct $StringView _field$915;
  struct $StringView filename$869;
  struct $StringView _field$914;
  struct $StringView start_line$870;
  struct $StringView _field$913;
  struct $StringView start_column$871;
  struct $StringView _field$912;
  struct $StringView end_line$872;
  struct $StringView _field$911;
  int32_t _cnt$961;
  struct $StringView end_column$873;
  struct $$moonbitlang$core$builtin$Logger _bind$868;
  moonbit_incref(_data$306);
  moonbit_incref(pkg$304.$0);
  while (1) {
    int32_t _tmp$888 = _cursor$309;
    if (_tmp$888 < _end$308) {
      int32_t _p$478 = _cursor$309;
      int32_t next_char$324 = _data$306[_p$478];
      int32_t _tmp$889 = _cursor$309;
      _cursor$309 = _tmp$889 + 1;
      if (next_char$324 < 55296) {
        if (next_char$324 < 47) {
          goto $join$322;
        } else if (next_char$324 > 47) {
          goto $join$322;
        } else {
          while (1) {
            int32_t _tmp$890;
            tag_0$313 = _cursor$309;
            _tmp$890 = _cursor$309;
            if (_tmp$890 < _end$308) {
              int32_t _p$481 = _cursor$309;
              int32_t next_char$327 = _data$306[_p$481];
              int32_t _tmp$891 = _cursor$309;
              _cursor$309 = _tmp$891 + 1;
              if (next_char$327 < 55296) {
                if (next_char$327 < 47) {
                  goto $join$325;
                } else if (next_char$327 > 47) {
                  goto $join$325;
                } else {
                  while (1) {
                    int32_t _tmp$892 = _cursor$309;
                    if (_tmp$892 < _end$308) {
                      int32_t _p$484 = _cursor$309;
                      int32_t next_char$330 = _data$306[_p$484];
                      int32_t _tmp$893 = _cursor$309;
                      _cursor$309 = _tmp$893 + 1;
                      if (next_char$330 < 56319) {
                        if (next_char$330 < 55296) {
                          goto $join$328;
                        } else {
                          int32_t _tmp$894 = _cursor$309;
                          if (_tmp$894 < _end$308) {
                            int32_t _p$487 = _cursor$309;
                            int32_t next_char$331 = _data$306[_p$487];
                            int32_t _tmp$895 = _cursor$309;
                            _cursor$309 = _tmp$895 + 1;
                            if (next_char$331 < 56320) {
                              goto $join$315;
                            } else if (next_char$331 > 65535) {
                              goto $join$315;
                            } else {
                              continue;
                            }
                          } else {
                            goto $join$315;
                          }
                        }
                      } else if (next_char$330 > 56319) {
                        if (next_char$330 < 65536) {
                          goto $join$328;
                        } else {
                          goto $join$315;
                        }
                      } else {
                        int32_t _tmp$896 = _cursor$309;
                        if (_tmp$896 < _end$308) {
                          int32_t _p$490 = _cursor$309;
                          int32_t next_char$332 = _data$306[_p$490];
                          int32_t _tmp$897 = _cursor$309;
                          _cursor$309 = _tmp$897 + 1;
                          if (next_char$332 < 56320) {
                            goto $join$315;
                          } else if (next_char$332 > 57343) {
                            goto $join$315;
                          } else {
                            continue;
                          }
                        } else {
                          goto $join$315;
                        }
                      }
                      goto $joinlet$980;
                      $join$328:;
                      continue;
                      $joinlet$980:;
                    } else {
                      match_tag_saver_0$312 = tag_0$313;
                      accept_state$310 = 0;
                      match_end$311 = _cursor$309;
                      goto $join$315;
                    }
                    break;
                  }
                }
              } else if (next_char$327 > 56318) {
                if (next_char$327 < 57344) {
                  int32_t _tmp$898 = _cursor$309;
                  if (_tmp$898 < _end$308) {
                    int32_t _p$493 = _cursor$309;
                    int32_t next_char$333 = _data$306[_p$493];
                    int32_t _tmp$899 = _cursor$309;
                    _cursor$309 = _tmp$899 + 1;
                    if (next_char$333 < 56320) {
                      goto $join$315;
                    } else if (next_char$333 > 57343) {
                      goto $join$315;
                    } else {
                      continue;
                    }
                  } else {
                    goto $join$315;
                  }
                } else if (next_char$327 > 65535) {
                  goto $join$315;
                } else {
                  goto $join$325;
                }
              } else {
                int32_t _tmp$900 = _cursor$309;
                if (_tmp$900 < _end$308) {
                  int32_t _p$496 = _cursor$309;
                  int32_t next_char$334 = _data$306[_p$496];
                  int32_t _tmp$901 = _cursor$309;
                  _cursor$309 = _tmp$901 + 1;
                  if (next_char$334 < 56320) {
                    goto $join$315;
                  } else if (next_char$334 > 65535) {
                    goto $join$315;
                  } else {
                    continue;
                  }
                } else {
                  goto $join$315;
                }
              }
              goto $joinlet$978;
              $join$325:;
              continue;
              $joinlet$978:;
            } else {
              goto $join$315;
            }
            break;
          }
        }
      } else if (next_char$324 > 56318) {
        if (next_char$324 < 57344) {
          int32_t _tmp$902 = _cursor$309;
          if (_tmp$902 < _end$308) {
            int32_t _p$499 = _cursor$309;
            int32_t next_char$335 = _data$306[_p$499];
            int32_t _tmp$903 = _cursor$309;
            _cursor$309 = _tmp$903 + 1;
            if (next_char$335 < 56320) {
              goto $join$315;
            } else if (next_char$335 > 57343) {
              goto $join$315;
            } else {
              continue;
            }
          } else {
            goto $join$315;
          }
        } else if (next_char$324 > 65535) {
          goto $join$315;
        } else {
          goto $join$322;
        }
      } else {
        int32_t _tmp$904 = _cursor$309;
        if (_tmp$904 < _end$308) {
          int32_t _p$502 = _cursor$309;
          int32_t next_char$336 = _data$306[_p$502];
          int32_t _tmp$905 = _cursor$309;
          _cursor$309 = _tmp$905 + 1;
          if (next_char$336 < 56320) {
            goto $join$315;
          } else if (next_char$336 > 65535) {
            goto $join$315;
          } else {
            continue;
          }
        } else {
          goto $join$315;
        }
      }
      goto $joinlet$976;
      $join$322:;
      continue;
      $joinlet$976:;
    } else {
      goto $join$315;
    }
    break;
  }
  goto $joinlet$974;
  $join$315:;
  switch (accept_state$310) {
    case 0: {
      void* _try_err$318;
      struct $StringView package_name$316;
      int32_t _tmp$884;
      int32_t _tmp$883;
      int64_t _tmp$880;
      int32_t _tmp$882;
      int64_t _tmp$881;
      struct moonbit_result_0 _tmp$982;
      void* _try_err$321;
      struct $StringView module_name$319;
      int64_t _tmp$875;
      int32_t _tmp$877;
      int64_t _tmp$876;
      struct moonbit_result_0 _tmp$984;
      void* Some$874;
      moonbit_decref(pkg$304.$0);
      _tmp$884 = match_tag_saver_0$312;
      _tmp$883 = _tmp$884 + 1;
      _tmp$880 = (int64_t)_tmp$883;
      _tmp$882 = match_end$311;
      _tmp$881 = (int64_t)_tmp$882;
      moonbit_incref(_data$306);
      _tmp$982 = $String$$sub(_data$306, _tmp$880, _tmp$881);
      if (_tmp$982.tag) {
        struct $StringView const _ok$885 = _tmp$982.data.ok;
        package_name$316 = _ok$885;
      } else {
        void* const _err$886 = _tmp$982.data.err;
        _try_err$318 = _err$886;
        goto $join$317;
      }
      goto $joinlet$981;
      $join$317:;
      moonbit_decref(_try_err$318);
      moonbit_panic();
      $joinlet$981:;
      _tmp$875 = (int64_t)_start$307;
      _tmp$877 = match_tag_saver_0$312;
      _tmp$876 = (int64_t)_tmp$877;
      _tmp$984 = $String$$sub(_data$306, _tmp$875, _tmp$876);
      if (_tmp$984.tag) {
        struct $StringView const _ok$878 = _tmp$984.data.ok;
        module_name$319 = _ok$878;
      } else {
        void* const _err$879 = _tmp$984.data.err;
        _try_err$321 = _err$879;
        goto $join$320;
      }
      goto $joinlet$983;
      $join$320:;
      moonbit_decref(_try_err$321);
      moonbit_panic();
      $joinlet$983:;
      Some$874
      = (void*)moonbit_malloc(sizeof(struct $Option$3c$StringView$3e$$Some));
      Moonbit_object_header(Some$874)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $Option$3c$StringView$3e$$Some, $0_0) >> 2, 1, 1
      );
      ((struct $Option$3c$StringView$3e$$Some*)Some$874)->$0_0
      = package_name$316.$0;
      ((struct $Option$3c$StringView$3e$$Some*)Some$874)->$0_1
      = package_name$316.$1;
      ((struct $Option$3c$StringView$3e$$Some*)Some$874)->$0_2
      = package_name$316.$2;
      _bind$314
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$314)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$314->$0_0 = module_name$319.$0;
      _bind$314->$0_1 = module_name$319.$1;
      _bind$314->$0_2 = module_name$319.$2;
      _bind$314->$1 = Some$874;
      break;
    }
    default: {
      void* None$887;
      moonbit_decref(_data$306);
      None$887 = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _bind$314
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$314)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$314->$0_0 = pkg$304.$0;
      _bind$314->$0_1 = pkg$304.$1;
      _bind$314->$0_2 = pkg$304.$2;
      _bind$314->$1 = None$887;
      break;
    }
  }
  $joinlet$974:;
  _field$918
  = (struct $StringView){
    _bind$314->$0_1, _bind$314->$0_2, _bind$314->$0_0
  };
  _module_name$337 = _field$918;
  _field$917 = _bind$314->$1;
  _cnt$957 = Moonbit_object_header(_bind$314)->rc;
  if (_cnt$957 > 1) {
    int32_t _new_cnt$958 = _cnt$957 - 1;
    Moonbit_object_header(_bind$314)->rc = _new_cnt$958;
    moonbit_incref(_field$917);
    moonbit_incref(_module_name$337.$0);
  } else if (_cnt$957 == 1) {
    moonbit_free(_bind$314);
  }
  _package_name$338 = _field$917;
  switch (Moonbit_object_tag(_package_name$338)) {
    case 1: {
      struct $Option$3c$StringView$3e$$Some* _Some$339 =
        (struct $Option$3c$StringView$3e$$Some*)_package_name$338;
      struct $StringView _field$916 =
        (struct $StringView){
          _Some$339->$0_1, _Some$339->$0_2, _Some$339->$0_0
        };
      int32_t _cnt$959 = Moonbit_object_header(_Some$339)->rc;
      struct $StringView _pkg_name$340;
      struct $$moonbitlang$core$builtin$Logger _bind$867;
      if (_cnt$959 > 1) {
        int32_t _new_cnt$960 = _cnt$959 - 1;
        Moonbit_object_header(_Some$339)->rc = _new_cnt$960;
        moonbit_incref(_field$916.$0);
      } else if (_cnt$959 == 1) {
        moonbit_free(_Some$339);
      }
      _pkg_name$340 = _field$916;
      if (logger$341.$1) {
        moonbit_incref(logger$341.$1);
      }
      logger$341.$0->$method_2(logger$341.$1, _pkg_name$340);
      _bind$867 = logger$341;
      if (_bind$867.$1) {
        moonbit_incref(_bind$867.$1);
      }
      _bind$867.$0->$method_3(_bind$867.$1, 47);
      break;
    }
    default: {
      moonbit_decref(_package_name$338);
      break;
    }
  }
  _field$915
  = (struct $StringView){
    self$305->$1_1, self$305->$1_2, self$305->$1_0
  };
  filename$869 = _field$915;
  moonbit_incref(filename$869.$0);
  if (logger$341.$1) {
    moonbit_incref(logger$341.$1);
  }
  logger$341.$0->$method_2(logger$341.$1, filename$869);
  if (logger$341.$1) {
    moonbit_incref(logger$341.$1);
  }
  logger$341.$0->$method_3(logger$341.$1, 58);
  _field$914
  = (struct $StringView){
    self$305->$2_1, self$305->$2_2, self$305->$2_0
  };
  start_line$870 = _field$914;
  moonbit_incref(start_line$870.$0);
  if (logger$341.$1) {
    moonbit_incref(logger$341.$1);
  }
  logger$341.$0->$method_2(logger$341.$1, start_line$870);
  if (logger$341.$1) {
    moonbit_incref(logger$341.$1);
  }
  logger$341.$0->$method_3(logger$341.$1, 58);
  _field$913
  = (struct $StringView){
    self$305->$3_1, self$305->$3_2, self$305->$3_0
  };
  start_column$871 = _field$913;
  moonbit_incref(start_column$871.$0);
  if (logger$341.$1) {
    moonbit_incref(logger$341.$1);
  }
  logger$341.$0->$method_2(logger$341.$1, start_column$871);
  if (logger$341.$1) {
    moonbit_incref(logger$341.$1);
  }
  logger$341.$0->$method_3(logger$341.$1, 45);
  _field$912
  = (struct $StringView){
    self$305->$4_1, self$305->$4_2, self$305->$4_0
  };
  end_line$872 = _field$912;
  moonbit_incref(end_line$872.$0);
  if (logger$341.$1) {
    moonbit_incref(logger$341.$1);
  }
  logger$341.$0->$method_2(logger$341.$1, end_line$872);
  if (logger$341.$1) {
    moonbit_incref(logger$341.$1);
  }
  logger$341.$0->$method_3(logger$341.$1, 58);
  _field$911
  = (struct $StringView){
    self$305->$5_1, self$305->$5_2, self$305->$5_0
  };
  _cnt$961 = Moonbit_object_header(self$305)->rc;
  if (_cnt$961 > 1) {
    int32_t _new_cnt$967 = _cnt$961 - 1;
    Moonbit_object_header(self$305)->rc = _new_cnt$967;
    moonbit_incref(_field$911.$0);
  } else if (_cnt$961 == 1) {
    struct $StringView _field$966 =
      (struct $StringView){self$305->$4_1, self$305->$4_2, self$305->$4_0};
    struct $StringView _field$965;
    struct $StringView _field$964;
    struct $StringView _field$963;
    struct $StringView _field$962;
    moonbit_decref(_field$966.$0);
    _field$965
    = (struct $StringView){
      self$305->$3_1, self$305->$3_2, self$305->$3_0
    };
    moonbit_decref(_field$965.$0);
    _field$964
    = (struct $StringView){
      self$305->$2_1, self$305->$2_2, self$305->$2_0
    };
    moonbit_decref(_field$964.$0);
    _field$963
    = (struct $StringView){
      self$305->$1_1, self$305->$1_2, self$305->$1_0
    };
    moonbit_decref(_field$963.$0);
    _field$962
    = (struct $StringView){
      self$305->$0_1, self$305->$0_2, self$305->$0_0
    };
    moonbit_decref(_field$962.$0);
    moonbit_free(self$305);
  }
  end_column$873 = _field$911;
  if (logger$341.$1) {
    moonbit_incref(logger$341.$1);
  }
  logger$341.$0->$method_2(logger$341.$1, end_column$873);
  if (logger$341.$1) {
    moonbit_incref(logger$341.$1);
  }
  logger$341.$0->$method_3(logger$341.$1, 64);
  _bind$868 = logger$341;
  _bind$868.$0->$method_2(_bind$868.$1, _module_name$337);
  return 0;
}

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$303) {
  moonbit_println(input$303);
  moonbit_decref(input$303);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$Array$$output$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$302,
  struct $$moonbitlang$core$builtin$Logger logger$301
) {
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* _tmp$866 =
    $$moonbitlang$core$builtin$Array$$iter$0(self$302);
  $$moonbitlang$core$builtin$Logger$$write_iter$inner$0(
    logger$301,
      _tmp$866,
      (moonbit_string_t)moonbit_string_literal_0.data,
      (moonbit_string_t)moonbit_string_literal_1.data,
      (moonbit_string_t)moonbit_string_literal_2.data,
      0
  );
  return 0;
}

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$Array$$iter$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$300
) {
  int32_t* _field$922 = self$300->$0;
  int32_t* buf$864 = _field$922;
  int32_t _field$921 = self$300->$1;
  int32_t _cnt$968 = Moonbit_object_header(self$300)->rc;
  int32_t len$865;
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ _tmp$863;
  if (_cnt$968 > 1) {
    int32_t _new_cnt$969 = _cnt$968 - 1;
    Moonbit_object_header(self$300)->rc = _new_cnt$969;
    moonbit_incref(buf$864);
  } else if (_cnt$968 == 1) {
    moonbit_free(self$300);
  }
  len$865 = _field$921;
  _tmp$863
  = (struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$){
    0, len$865, buf$864
  };
  return $$moonbitlang$core$builtin$ArrayView$$iter$0(_tmp$863);
}

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$ArrayView$$iter$0(
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ self$298
) {
  struct $Ref$3c$Int$3e$* i$297 =
    (struct $Ref$3c$Int$3e$*)moonbit_malloc(sizeof(struct $Ref$3c$Int$3e$));
  struct $ArrayView$$iter$7c$Int$7c$$$2a$p$fn$1$2d$cap* _closure$985;
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* _p$467;
  Moonbit_object_header(i$297)->meta
  = Moonbit_make_regular_object_header(
    sizeof(struct $Ref$3c$Int$3e$) >> 2, 0, 0
  );
  i$297->$0 = 0;
  _closure$985
  = (struct $ArrayView$$iter$7c$Int$7c$$$2a$p$fn$1$2d$cap*)moonbit_malloc(
      sizeof(struct $ArrayView$$iter$7c$Int$7c$$$2a$p$fn$1$2d$cap)
    );
  Moonbit_object_header(_closure$985)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $ArrayView$$iter$7c$Int$7c$$$2a$p$fn$1$2d$cap, $0_0) >> 2,
      2,
      0
  );
  _closure$985->code = &$ArrayView$$iter$7c$Int$7c$$$2a$p$fn$1;
  _closure$985->$0_0 = self$298.$0;
  _closure$985->$0_1 = self$298.$1;
  _closure$985->$0_2 = self$298.$2;
  _closure$985->$1 = i$297;
  _p$467 = (struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$*)_closure$985;
  return _p$467;
}

int64_t $ArrayView$$iter$7c$Int$7c$$$2a$p$fn$1(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* _env$851
) {
  struct $ArrayView$$iter$7c$Int$7c$$$2a$p$fn$1$2d$cap* _casted_env$852 =
    (struct $ArrayView$$iter$7c$Int$7c$$$2a$p$fn$1$2d$cap*)_env$851;
  struct $Ref$3c$Int$3e$* _field$927 = _casted_env$852->$1;
  struct $Ref$3c$Int$3e$* i$297 = _field$927;
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ _field$926 =
    (struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$){
      _casted_env$852->$0_1, _casted_env$852->$0_2, _casted_env$852->$0_0
    };
  int32_t _cnt$970 = Moonbit_object_header(_casted_env$852)->rc;
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ self$298;
  int32_t val$853;
  int32_t end$855;
  int32_t start$856;
  int32_t _tmp$854;
  if (_cnt$970 > 1) {
    int32_t _new_cnt$971 = _cnt$970 - 1;
    Moonbit_object_header(_casted_env$852)->rc = _new_cnt$971;
    moonbit_incref(i$297);
    moonbit_incref(_field$926.$0);
  } else if (_cnt$970 == 1) {
    moonbit_free(_casted_env$852);
  }
  self$298 = _field$926;
  val$853 = i$297->$0;
  end$855 = self$298.$2;
  start$856 = self$298.$1;
  _tmp$854 = end$855 - start$856;
  if (val$853 < _tmp$854) {
    int32_t* _field$925 = self$298.$0;
    int32_t* buf$859 = _field$925;
    int32_t _field$924 = self$298.$1;
    int32_t start$861 = _field$924;
    int32_t val$862 = i$297->$0;
    int32_t _tmp$860 = start$861 + val$862;
    int32_t _tmp$923 = (int32_t)buf$859[_tmp$860];
    int32_t elem$299;
    int32_t val$858;
    int32_t _tmp$857;
    moonbit_decref(buf$859);
    elem$299 = _tmp$923;
    val$858 = i$297->$0;
    _tmp$857 = val$858 + 1;
    i$297->$0 = _tmp$857;
    moonbit_decref(i$297);
    return (int64_t)elem$299;
  } else {
    moonbit_decref(self$298.$0);
    moonbit_decref(i$297);
    return 4294967296ll;
  }
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
  moonbit_string_t _tmp$850 = $Int$$to_string$inner(self$295, 10);
  logger$294.$0->$method_0(logger$294.$1, _tmp$850);
  return 0;
}

int64_t $$moonbitlang$core$builtin$Iter$$next$0(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* self$293
) {
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* _func$292 = self$293;
  return _func$292->code(_func$292);
}

int32_t $$moonbitlang$core$builtin$Array$$push$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$289,
  int32_t value$291
) {
  int32_t len$845 = self$289->$1;
  int32_t* _field$930 = self$289->$0;
  int32_t* buf$847 = _field$930;
  int32_t _tmp$929 = Moonbit_array_length(buf$847);
  int32_t _tmp$846 = _tmp$929;
  int32_t length$290;
  int32_t* _field$928;
  int32_t* buf$848;
  int32_t _tmp$849;
  if (len$845 == _tmp$846) {
    moonbit_incref(self$289);
    $$moonbitlang$core$builtin$Array$$realloc$0(self$289);
  }
  length$290 = self$289->$1;
  _field$928 = self$289->$0;
  buf$848 = _field$928;
  buf$848[length$290] = value$291;
  _tmp$849 = length$290 + 1;
  self$289->$1 = _tmp$849;
  moonbit_decref(self$289);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Array$$realloc$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$287
) {
  int32_t old_cap$286 = self$287->$1;
  int32_t new_cap$288;
  if (old_cap$286 == 0) {
    new_cap$288 = 8;
  } else {
    new_cap$288 = old_cap$286 * 2;
  }
  $$moonbitlang$core$builtin$Array$$resize_buffer$0(self$287, new_cap$288);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Array$$resize_buffer$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$283,
  int32_t new_capacity$281
) {
  int32_t* new_buf$280 =
    (int32_t*)moonbit_make_int32_array_raw(new_capacity$281);
  int32_t* _field$932 = self$283->$0;
  int32_t* old_buf$282 = _field$932;
  int32_t old_cap$284 = Moonbit_array_length(old_buf$282);
  int32_t copy_len$285;
  int32_t* _old$931;
  if (old_cap$284 < new_capacity$281) {
    copy_len$285 = old_cap$284;
  } else {
    copy_len$285 = new_capacity$281;
  }
  moonbit_incref(old_buf$282);
  moonbit_incref(new_buf$280);
  $$moonbitlang$core$builtin$UninitializedArray$$unsafe_blit$0(
    new_buf$280, 0, old_buf$282, 0, copy_len$285
  );
  _old$931 = self$283->$0;
  moonbit_decref(_old$931);
  self$283->$0 = new_buf$280;
  moonbit_decref(self$283);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$278,
  struct $StringView str$279
) {
  int32_t len$827 = self$278->$1;
  int32_t end$830 = str$279.$2;
  int32_t start$831 = str$279.$1;
  int32_t _tmp$829 = end$830 - start$831;
  int32_t _tmp$828 = _tmp$829 * 2;
  int32_t _tmp$826 = len$827 + _tmp$828;
  moonbit_bytes_t _field$935;
  moonbit_bytes_t data$832;
  int32_t len$833;
  moonbit_string_t _field$934;
  moonbit_string_t str$834;
  int32_t start$835;
  int32_t end$837;
  int32_t start$838;
  int32_t _tmp$836;
  int32_t len$840;
  int32_t end$843;
  int32_t _field$933;
  int32_t start$844;
  int32_t _tmp$842;
  int32_t _tmp$841;
  int32_t _tmp$839;
  moonbit_incref(self$278);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$278, _tmp$826
  );
  _field$935 = self$278->$0;
  data$832 = _field$935;
  len$833 = self$278->$1;
  _field$934 = str$279.$0;
  str$834 = _field$934;
  start$835 = str$279.$1;
  end$837 = str$279.$2;
  start$838 = str$279.$1;
  _tmp$836 = end$837 - start$838;
  moonbit_incref(str$834);
  moonbit_incref(data$832);
  $FixedArray$$blit_from_string(
    data$832, len$833, str$834, start$835, _tmp$836
  );
  len$840 = self$278->$1;
  end$843 = str$279.$2;
  _field$933 = str$279.$1;
  moonbit_decref(str$279.$0);
  start$844 = _field$933;
  _tmp$842 = end$843 - start$844;
  _tmp$841 = _tmp$842 * 2;
  _tmp$839 = len$840 + _tmp$841;
  self$278->$1 = _tmp$839;
  moonbit_decref(self$278);
  return 0;
}

int32_t $$moonbitlang$core$builtin$ArrayView$$length$0(
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ self$277
) {
  int32_t end$824 = self$277.$2;
  int32_t _field$936 = self$277.$1;
  int32_t start$825;
  moonbit_decref(self$277.$0);
  start$825 = _field$936;
  return end$824 - start$825;
}

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$Iter$$new$0(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* f$276
) {
  return f$276;
}

moonbit_string_t $Int$$to_string$inner(int32_t self$260, int32_t radix$259) {
  int32_t is_negative$261;
  uint32_t num$262;
  uint16_t* buffer$263;
  if (radix$259 < 2 || radix$259 > 36) {
    $moonbitlang$core$builtin$abort$1(
      (moonbit_string_t)moonbit_string_literal_3.data,
        (moonbit_string_t)moonbit_string_literal_4.data
    );
  }
  if (self$260 == 0) {
    return (moonbit_string_t)moonbit_string_literal_5.data;
  }
  is_negative$261 = self$260 < 0;
  if (is_negative$261) {
    int32_t _tmp$823 = -self$260;
    num$262 = *(uint32_t*)&_tmp$823;
  } else {
    num$262 = *(uint32_t*)&self$260;
  }
  switch (radix$259) {
    case 10: {
      int32_t digit_len$264 = $moonbitlang$core$builtin$dec_count32(num$262);
      int32_t _tmp$820;
      int32_t total_len$265;
      uint16_t* buffer$266;
      int32_t digit_start$267;
      if (is_negative$261) {
        _tmp$820 = 1;
      } else {
        _tmp$820 = 0;
      }
      total_len$265 = digit_len$264 + _tmp$820;
      buffer$266 = (uint16_t*)moonbit_make_string(total_len$265, 0);
      if (is_negative$261) {
        digit_start$267 = 1;
      } else {
        digit_start$267 = 0;
      }
      moonbit_incref(buffer$266);
      $moonbitlang$core$builtin$int_to_string_dec(
        buffer$266, num$262, digit_start$267, total_len$265
      );
      buffer$263 = buffer$266;
      break;
    }

    case 16: {
      int32_t digit_len$268 = $moonbitlang$core$builtin$hex_count32(num$262);
      int32_t _tmp$821;
      int32_t total_len$269;
      uint16_t* buffer$270;
      int32_t digit_start$271;
      if (is_negative$261) {
        _tmp$821 = 1;
      } else {
        _tmp$821 = 0;
      }
      total_len$269 = digit_len$268 + _tmp$821;
      buffer$270 = (uint16_t*)moonbit_make_string(total_len$269, 0);
      if (is_negative$261) {
        digit_start$271 = 1;
      } else {
        digit_start$271 = 0;
      }
      moonbit_incref(buffer$270);
      $moonbitlang$core$builtin$int_to_string_hex(
        buffer$270, num$262, digit_start$271, total_len$269
      );
      buffer$263 = buffer$270;
      break;
    }
    default: {
      int32_t digit_len$272 =
        $moonbitlang$core$builtin$radix_count32(num$262, radix$259);
      int32_t _tmp$822;
      int32_t total_len$273;
      uint16_t* buffer$274;
      int32_t digit_start$275;
      if (is_negative$261) {
        _tmp$822 = 1;
      } else {
        _tmp$822 = 0;
      }
      total_len$273 = digit_len$272 + _tmp$822;
      buffer$274 = (uint16_t*)moonbit_make_string(total_len$273, 0);
      if (is_negative$261) {
        digit_start$275 = 1;
      } else {
        digit_start$275 = 0;
      }
      moonbit_incref(buffer$274);
      $moonbitlang$core$builtin$int_to_string_generic(
        buffer$274, num$262, digit_start$275, total_len$273, radix$259
      );
      buffer$263 = buffer$274;
      break;
    }
  }
  if (is_negative$261) {
    buffer$263[0] = 45;
  }
  return buffer$263;
}

int32_t $moonbitlang$core$builtin$radix_count32(
  uint32_t value$253,
  int32_t radix$256
) {
  uint32_t num$254;
  uint32_t base$255;
  int32_t count$257;
  if (value$253 == 0u) {
    return 1;
  }
  num$254 = value$253;
  base$255 = *(uint32_t*)&radix$256;
  count$257 = 0;
  while (1) {
    uint32_t _tmp$817 = num$254;
    if (_tmp$817 > 0u) {
      int32_t _tmp$818 = count$257;
      uint32_t _tmp$819;
      count$257 = _tmp$818 + 1;
      _tmp$819 = num$254;
      num$254 = _tmp$819 / base$255;
      continue;
    }
    break;
  }
  return count$257;
}

int32_t $moonbitlang$core$builtin$hex_count32(uint32_t value$251) {
  if (value$251 == 0u) {
    return 1;
  } else {
    int32_t leading_zeros$252 = moonbit_clz32(value$251);
    int32_t _tmp$816 = 31 - leading_zeros$252;
    int32_t _tmp$815 = _tmp$816 / 4;
    return _tmp$815 + 1;
  }
}

int32_t $moonbitlang$core$builtin$dec_count32(uint32_t value$250) {
  if (value$250 >= 100000u) {
    if (value$250 >= 10000000u) {
      if (value$250 >= 1000000000u) {
        return 10;
      } else if (value$250 >= 100000000u) {
        return 9;
      } else {
        return 8;
      }
    } else if (value$250 >= 1000000u) {
      return 7;
    } else {
      return 6;
    }
  } else if (value$250 >= 1000u) {
    if (value$250 >= 10000u) {
      return 5;
    } else {
      return 4;
    }
  } else if (value$250 >= 100u) {
    return 3;
  } else if (value$250 >= 10u) {
    return 2;
  } else {
    return 1;
  }
}

int32_t $moonbitlang$core$builtin$int_to_string_dec(
  uint16_t* buffer$240,
  uint32_t num$228,
  int32_t digit_start$231,
  int32_t total_len$230
) {
  uint32_t num$227 = num$228;
  int32_t offset$229 = total_len$230 - digit_start$231;
  uint32_t _tmp$814;
  int32_t remaining$242;
  int32_t _tmp$795;
  while (1) {
    uint32_t _tmp$758 = num$227;
    if (_tmp$758 >= 10000u) {
      uint32_t _tmp$781 = num$227;
      uint32_t t$232 = _tmp$781 / 10000u;
      uint32_t _tmp$780 = num$227;
      uint32_t _tmp$779 = _tmp$780 % 10000u;
      int32_t r$233 = *(int32_t*)&_tmp$779;
      int32_t d1$234;
      int32_t d2$235;
      int32_t _tmp$759;
      int32_t _tmp$778;
      int32_t _tmp$777;
      int32_t d1_hi$236;
      int32_t _tmp$776;
      int32_t _tmp$775;
      int32_t d1_lo$237;
      int32_t _tmp$774;
      int32_t _tmp$773;
      int32_t d2_hi$238;
      int32_t _tmp$772;
      int32_t _tmp$771;
      int32_t d2_lo$239;
      int32_t _tmp$761;
      int32_t _tmp$760;
      int32_t _tmp$764;
      int32_t _tmp$763;
      int32_t _tmp$762;
      int32_t _tmp$767;
      int32_t _tmp$766;
      int32_t _tmp$765;
      int32_t _tmp$770;
      int32_t _tmp$769;
      int32_t _tmp$768;
      num$227 = t$232;
      d1$234 = r$233 / 100;
      d2$235 = r$233 % 100;
      _tmp$759 = offset$229;
      offset$229 = _tmp$759 - 4;
      _tmp$778 = d1$234 / 10;
      _tmp$777 = 48 + _tmp$778;
      d1_hi$236 = (uint16_t)_tmp$777;
      _tmp$776 = d1$234 % 10;
      _tmp$775 = 48 + _tmp$776;
      d1_lo$237 = (uint16_t)_tmp$775;
      _tmp$774 = d2$235 / 10;
      _tmp$773 = 48 + _tmp$774;
      d2_hi$238 = (uint16_t)_tmp$773;
      _tmp$772 = d2$235 % 10;
      _tmp$771 = 48 + _tmp$772;
      d2_lo$239 = (uint16_t)_tmp$771;
      _tmp$761 = offset$229;
      _tmp$760 = digit_start$231 + _tmp$761;
      buffer$240[_tmp$760] = d1_hi$236;
      _tmp$764 = offset$229;
      _tmp$763 = digit_start$231 + _tmp$764;
      _tmp$762 = _tmp$763 + 1;
      buffer$240[_tmp$762] = d1_lo$237;
      _tmp$767 = offset$229;
      _tmp$766 = digit_start$231 + _tmp$767;
      _tmp$765 = _tmp$766 + 2;
      buffer$240[_tmp$765] = d2_hi$238;
      _tmp$770 = offset$229;
      _tmp$769 = digit_start$231 + _tmp$770;
      _tmp$768 = _tmp$769 + 3;
      buffer$240[_tmp$768] = d2_lo$239;
      continue;
    }
    break;
  }
  _tmp$814 = num$227;
  remaining$242 = *(int32_t*)&_tmp$814;
  while (1) {
    int32_t _tmp$782 = remaining$242;
    if (_tmp$782 >= 100) {
      int32_t _tmp$794 = remaining$242;
      int32_t t$243 = _tmp$794 / 100;
      int32_t _tmp$793 = remaining$242;
      int32_t d$244 = _tmp$793 % 100;
      int32_t _tmp$783;
      int32_t _tmp$792;
      int32_t _tmp$791;
      int32_t d_hi$245;
      int32_t _tmp$790;
      int32_t _tmp$789;
      int32_t d_lo$246;
      int32_t _tmp$785;
      int32_t _tmp$784;
      int32_t _tmp$788;
      int32_t _tmp$787;
      int32_t _tmp$786;
      remaining$242 = t$243;
      _tmp$783 = offset$229;
      offset$229 = _tmp$783 - 2;
      _tmp$792 = d$244 / 10;
      _tmp$791 = 48 + _tmp$792;
      d_hi$245 = (uint16_t)_tmp$791;
      _tmp$790 = d$244 % 10;
      _tmp$789 = 48 + _tmp$790;
      d_lo$246 = (uint16_t)_tmp$789;
      _tmp$785 = offset$229;
      _tmp$784 = digit_start$231 + _tmp$785;
      buffer$240[_tmp$784] = d_hi$245;
      _tmp$788 = offset$229;
      _tmp$787 = digit_start$231 + _tmp$788;
      _tmp$786 = _tmp$787 + 1;
      buffer$240[_tmp$786] = d_lo$246;
      continue;
    }
    break;
  }
  _tmp$795 = remaining$242;
  if (_tmp$795 >= 10) {
    int32_t _tmp$796 = offset$229;
    int32_t _tmp$807;
    int32_t _tmp$806;
    int32_t _tmp$805;
    int32_t d_hi$248;
    int32_t _tmp$804;
    int32_t _tmp$803;
    int32_t _tmp$802;
    int32_t d_lo$249;
    int32_t _tmp$798;
    int32_t _tmp$797;
    int32_t _tmp$801;
    int32_t _tmp$800;
    int32_t _tmp$799;
    offset$229 = _tmp$796 - 2;
    _tmp$807 = remaining$242;
    _tmp$806 = _tmp$807 / 10;
    _tmp$805 = 48 + _tmp$806;
    d_hi$248 = (uint16_t)_tmp$805;
    _tmp$804 = remaining$242;
    _tmp$803 = _tmp$804 % 10;
    _tmp$802 = 48 + _tmp$803;
    d_lo$249 = (uint16_t)_tmp$802;
    _tmp$798 = offset$229;
    _tmp$797 = digit_start$231 + _tmp$798;
    buffer$240[_tmp$797] = d_hi$248;
    _tmp$801 = offset$229;
    _tmp$800 = digit_start$231 + _tmp$801;
    _tmp$799 = _tmp$800 + 1;
    buffer$240[_tmp$799] = d_lo$249;
    moonbit_decref(buffer$240);
  } else {
    int32_t _tmp$808 = offset$229;
    int32_t _tmp$813;
    int32_t _tmp$809;
    int32_t _tmp$812;
    int32_t _tmp$811;
    int32_t _tmp$810;
    offset$229 = _tmp$808 - 1;
    _tmp$813 = offset$229;
    _tmp$809 = digit_start$231 + _tmp$813;
    _tmp$812 = remaining$242;
    _tmp$811 = 48 + _tmp$812;
    _tmp$810 = (uint16_t)_tmp$811;
    buffer$240[_tmp$809] = _tmp$810;
    moonbit_decref(buffer$240);
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int_to_string_generic(
  uint16_t* buffer$222,
  uint32_t num$216,
  int32_t digit_start$214,
  int32_t total_len$213,
  int32_t radix$218
) {
  int32_t offset$212 = total_len$213 - digit_start$214;
  uint32_t n$215 = num$216;
  uint32_t base$217 = *(uint32_t*)&radix$218;
  int32_t _tmp$738 = radix$218 - 1;
  int32_t _tmp$737 = radix$218 & _tmp$738;
  if (_tmp$737 == 0) {
    int32_t shift$219 = moonbit_ctz32(radix$218);
    uint32_t mask$220 = base$217 - 1u;
    while (1) {
      uint32_t _tmp$739 = n$215;
      if (_tmp$739 > 0u) {
        int32_t _tmp$740 = offset$212;
        uint32_t _tmp$747;
        uint32_t _tmp$746;
        int32_t digit$221;
        int32_t _tmp$744;
        int32_t _tmp$741;
        int32_t _tmp$743;
        int32_t _tmp$742;
        uint32_t _tmp$745;
        offset$212 = _tmp$740 - 1;
        _tmp$747 = n$215;
        _tmp$746 = _tmp$747 & mask$220;
        digit$221 = *(int32_t*)&_tmp$746;
        _tmp$744 = offset$212;
        _tmp$741 = digit_start$214 + _tmp$744;
        _tmp$743
        = ((moonbit_string_t)moonbit_string_literal_6.data)[
          digit$221
        ];
        _tmp$742 = (uint16_t)_tmp$743;
        buffer$222[_tmp$741] = _tmp$742;
        _tmp$745 = n$215;
        n$215 = _tmp$745 >> (shift$219 & 31);
        continue;
      } else {
        moonbit_decref(buffer$222);
      }
      break;
    }
  } else {
    while (1) {
      uint32_t _tmp$748 = n$215;
      if (_tmp$748 > 0u) {
        int32_t _tmp$749 = offset$212;
        uint32_t _tmp$757;
        uint32_t q$224;
        uint32_t _tmp$755;
        uint32_t _tmp$756;
        uint32_t _tmp$754;
        int32_t digit$225;
        int32_t _tmp$753;
        int32_t _tmp$750;
        int32_t _tmp$752;
        int32_t _tmp$751;
        offset$212 = _tmp$749 - 1;
        _tmp$757 = n$215;
        q$224 = _tmp$757 / base$217;
        _tmp$755 = n$215;
        _tmp$756 = q$224 * base$217;
        _tmp$754 = _tmp$755 - _tmp$756;
        digit$225 = *(int32_t*)&_tmp$754;
        _tmp$753 = offset$212;
        _tmp$750 = digit_start$214 + _tmp$753;
        _tmp$752
        = ((moonbit_string_t)moonbit_string_literal_6.data)[
          digit$225
        ];
        _tmp$751 = (uint16_t)_tmp$752;
        buffer$222[_tmp$750] = _tmp$751;
        n$215 = q$224;
        continue;
      } else {
        moonbit_decref(buffer$222);
      }
      break;
    }
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int_to_string_hex(
  uint16_t* buffer$209,
  uint32_t num$205,
  int32_t digit_start$203,
  int32_t total_len$202
) {
  int32_t offset$201 = total_len$202 - digit_start$203;
  uint32_t n$204 = num$205;
  int32_t _tmp$732;
  while (1) {
    int32_t _tmp$718 = offset$201;
    if (_tmp$718 >= 2) {
      int32_t _tmp$719 = offset$201;
      uint32_t _tmp$731;
      uint32_t _tmp$730;
      int32_t byte_val$206;
      int32_t hi$207;
      int32_t lo$208;
      int32_t _tmp$723;
      int32_t _tmp$720;
      int32_t _tmp$722;
      int32_t _tmp$721;
      int32_t _tmp$728;
      int32_t _tmp$727;
      int32_t _tmp$724;
      int32_t _tmp$726;
      int32_t _tmp$725;
      uint32_t _tmp$729;
      offset$201 = _tmp$719 - 2;
      _tmp$731 = n$204;
      _tmp$730 = _tmp$731 & 255u;
      byte_val$206 = *(int32_t*)&_tmp$730;
      hi$207 = byte_val$206 / 16;
      lo$208 = byte_val$206 % 16;
      _tmp$723 = offset$201;
      _tmp$720 = digit_start$203 + _tmp$723;
      _tmp$722 = ((moonbit_string_t)moonbit_string_literal_6.data)[hi$207];
      _tmp$721 = (uint16_t)_tmp$722;
      buffer$209[_tmp$720] = _tmp$721;
      _tmp$728 = offset$201;
      _tmp$727 = digit_start$203 + _tmp$728;
      _tmp$724 = _tmp$727 + 1;
      _tmp$726 = ((moonbit_string_t)moonbit_string_literal_6.data)[lo$208];
      _tmp$725 = (uint16_t)_tmp$726;
      buffer$209[_tmp$724] = _tmp$725;
      _tmp$729 = n$204;
      n$204 = _tmp$729 >> 8;
      continue;
    }
    break;
  }
  _tmp$732 = offset$201;
  if (_tmp$732 == 1) {
    uint32_t _tmp$736 = n$204;
    uint32_t _tmp$735 = _tmp$736 & 15u;
    int32_t nibble$211 = *(int32_t*)&_tmp$735;
    int32_t _tmp$734 =
      ((moonbit_string_t)moonbit_string_literal_6.data)[nibble$211];
    int32_t _tmp$733 = (uint16_t)_tmp$734;
    buffer$209[digit_start$203] = _tmp$733;
    moonbit_decref(buffer$209);
  } else {
    moonbit_decref(buffer$209);
  }
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$write_iter$inner$0(
  struct $$moonbitlang$core$builtin$Logger self$186,
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* iter$190,
  moonbit_string_t prefix$187,
  moonbit_string_t suffix$200,
  moonbit_string_t sep$193,
  int32_t trailing$188
) {
  if (self$186.$1) {
    moonbit_incref(self$186.$1);
  }
  self$186.$0->$method_0(self$186.$1, prefix$187);
  if (trailing$188) {
    while (1) {
      int64_t _bind$189;
      moonbit_incref(iter$190);
      _bind$189 = $$moonbitlang$core$builtin$Iter$$next$0(iter$190);
      if (_bind$189 == 4294967296ll) {
        moonbit_decref(sep$193);
        moonbit_decref(iter$190);
      } else {
        int64_t _Some$191 = _bind$189;
        int32_t _x$192 = (int32_t)_Some$191;
        if (self$186.$1) {
          moonbit_incref(self$186.$1);
        }
        $$moonbitlang$core$builtin$Logger$$write_object$0(self$186, _x$192);
        moonbit_incref(sep$193);
        if (self$186.$1) {
          moonbit_incref(self$186.$1);
        }
        self$186.$0->$method_0(self$186.$1, sep$193);
        continue;
      }
      break;
    }
  } else {
    int32_t first$195 = 1;
    while (1) {
      int64_t _bind$196;
      moonbit_incref(iter$190);
      _bind$196 = $$moonbitlang$core$builtin$Iter$$next$0(iter$190);
      if (_bind$196 == 4294967296ll) {
        moonbit_decref(sep$193);
        moonbit_decref(iter$190);
      } else {
        int64_t _Some$197 = _bind$196;
        int32_t _x$198 = (int32_t)_Some$197;
        if (first$195) {
          first$195 = 0;
        } else {
          moonbit_incref(sep$193);
          if (self$186.$1) {
            moonbit_incref(self$186.$1);
          }
          self$186.$0->$method_0(self$186.$1, sep$193);
        }
        if (self$186.$1) {
          moonbit_incref(self$186.$1);
        }
        $$moonbitlang$core$builtin$Logger$$write_object$0(self$186, _x$198);
        continue;
      }
      break;
    }
  }
  self$186.$0->$method_0(self$186.$1, suffix$200);
  return 0;
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(
  moonbit_string_t self$185
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$184 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$717;
  moonbit_incref(logger$184);
  _tmp$717
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$184
  };
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
    self$185, _tmp$717
  );
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$184);
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  int32_t self$183
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$182 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$716;
  moonbit_incref(logger$182);
  _tmp$716
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$182
  };
  $$moonbitlang$core$builtin$Show$$Int$$output(self$183, _tmp$716);
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$182);
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$181
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$180 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$715;
  moonbit_incref(logger$180);
  _tmp$715
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$180
  };
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$Array$$output$0(
    self$181, _tmp$715
  );
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$180);
}

int32_t $StringView$$start_offset(struct $StringView self$179) {
  int32_t _field$937 = self$179.$1;
  moonbit_decref(self$179.$0);
  return _field$937;
}

int32_t $StringView$$length(struct $StringView self$178) {
  int32_t end$713 = self$178.$2;
  int32_t _field$938 = self$178.$1;
  int32_t start$714;
  moonbit_decref(self$178.$0);
  start$714 = _field$938;
  return end$713 - start$714;
}

moonbit_string_t $StringView$$data(struct $StringView self$177) {
  moonbit_string_t _field$939 = self$177.$0;
  return _field$939;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$171,
  moonbit_string_t value$174,
  int32_t start$175,
  int32_t len$176
) {
  void* _try_err$173;
  struct $StringView _tmp$708;
  int32_t _tmp$710 = start$175 + len$176;
  int64_t _tmp$709 = (int64_t)_tmp$710;
  struct moonbit_result_0 _tmp$995 =
    $String$$sub$inner(value$174, start$175, _tmp$709);
  if (_tmp$995.tag) {
    struct $StringView const _ok$711 = _tmp$995.data.ok;
    _tmp$708 = _ok$711;
  } else {
    void* const _err$712 = _tmp$995.data.err;
    _try_err$173 = _err$712;
    goto $join$172;
  }
  goto $joinlet$994;
  $join$172:;
  moonbit_decref(_try_err$173);
  moonbit_panic();
  $joinlet$994:;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    self$171, _tmp$708
  );
  return 0;
}

struct moonbit_result_0 $String$$sub(
  moonbit_string_t self$169,
  int64_t start$opt$167,
  int64_t end$170
) {
  int32_t start$166;
  if (start$opt$167 == 4294967296ll) {
    start$166 = 0;
  } else {
    int64_t _Some$168 = start$opt$167;
    start$166 = (int32_t)_Some$168;
  }
  return $String$$sub$inner(self$169, start$166, end$170);
}

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$159,
  int32_t start$165,
  int64_t end$161
) {
  int32_t len$158 = Moonbit_array_length(self$159);
  int32_t end$160;
  int32_t start$164;
  if (end$161 == 4294967296ll) {
    end$160 = len$158;
  } else {
    int64_t _Some$162 = end$161;
    int32_t _end$163 = (int32_t)_Some$162;
    if (_end$163 < 0) {
      end$160 = len$158 + _end$163;
    } else {
      end$160 = _end$163;
    }
  }
  if (start$165 < 0) {
    start$164 = len$158 + start$165;
  } else {
    start$164 = start$165;
  }
  if (start$164 >= 0 && start$164 <= end$160 && end$160 <= len$158) {
    int32_t _if_result$996;
    int32_t _if_result$998;
    struct $StringView _tmp$706;
    struct moonbit_result_0 _result$1000;
    if (start$164 < len$158) {
      int32_t _p$447 = self$159[start$164];
      _if_result$996 = 56320 <= _p$447 && _p$447 <= 57343;
    } else {
      _if_result$996 = 0;
    }
    if (_if_result$996) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$704;
      struct moonbit_result_0 _result$997;
      moonbit_decref(self$159);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$704
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$997.tag = 0;
      _result$997.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$704;
      return _result$997;
    }
    if (end$160 < len$158) {
      int32_t _p$450 = self$159[end$160];
      _if_result$998 = 56320 <= _p$450 && _p$450 <= 57343;
    } else {
      _if_result$998 = 0;
    }
    if (_if_result$998) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$705;
      struct moonbit_result_0 _result$999;
      moonbit_decref(self$159);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$705
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$999.tag = 0;
      _result$999.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$705;
      return _result$999;
    }
    _tmp$706 = (struct $StringView){start$164, end$160, self$159};
    _result$1000.tag = 1;
    _result$1000.data.ok = _tmp$706;
    return _result$1000;
  } else {
    void* moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$707;
    struct moonbit_result_0 _result$1001;
    moonbit_decref(self$159);
    moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$707
    = (struct moonbit_object*)&moonbit_constant_constructor_1 + 1;
    _result$1001.tag = 0;
    _result$1001.data.err
    = moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$707;
    return _result$1001;
  }
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$156,
  moonbit_string_t str$157
) {
  int32_t len$694 = self$156->$1;
  int32_t _tmp$696 = Moonbit_array_length(str$157);
  int32_t _tmp$695 = _tmp$696 * 2;
  int32_t _tmp$693 = len$694 + _tmp$695;
  moonbit_bytes_t _field$941;
  moonbit_bytes_t data$697;
  int32_t len$698;
  int32_t _tmp$699;
  int32_t len$701;
  int32_t _tmp$940;
  int32_t _tmp$703;
  int32_t _tmp$702;
  int32_t _tmp$700;
  moonbit_incref(self$156);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$156, _tmp$693
  );
  _field$941 = self$156->$0;
  data$697 = _field$941;
  len$698 = self$156->$1;
  _tmp$699 = Moonbit_array_length(str$157);
  moonbit_incref(data$697);
  moonbit_incref(str$157);
  $FixedArray$$blit_from_string(data$697, len$698, str$157, 0, _tmp$699);
  len$701 = self$156->$1;
  _tmp$940 = Moonbit_array_length(str$157);
  moonbit_decref(str$157);
  _tmp$703 = _tmp$940;
  _tmp$702 = _tmp$703 * 2;
  _tmp$700 = len$701 + _tmp$702;
  self$156->$1 = _tmp$700;
  moonbit_decref(self$156);
  return 0;
}

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$148,
  int32_t bytes_offset$143,
  moonbit_string_t str$150,
  int32_t str_offset$146,
  int32_t length$144
) {
  int32_t _tmp$692 = length$144 * 2;
  int32_t _tmp$691 = bytes_offset$143 + _tmp$692;
  int32_t e1$142 = _tmp$691 - 1;
  int32_t _tmp$690 = str_offset$146 + length$144;
  int32_t e2$145 = _tmp$690 - 1;
  int32_t len1$147 = Moonbit_array_length(self$148);
  int32_t len2$149 = Moonbit_array_length(str$150);
  if (
    length$144 >= 0
    && bytes_offset$143 >= 0
    && e1$142 < len1$147
    && str_offset$146 >= 0
    && e2$145 < len2$149
  ) {
    int32_t end_str_offset$151 = str_offset$146 + length$144;
    int32_t i$152 = str_offset$146;
    int32_t j$153 = bytes_offset$143;
    while (1) {
      if (i$152 < end_str_offset$151) {
        int32_t _tmp$687 = str$150[i$152];
        uint32_t c$154 = *(uint32_t*)&_tmp$687;
        uint32_t _p$441 = c$154 & 255u;
        int32_t _tmp$683 = *(int32_t*)&_p$441;
        int32_t _tmp$682 = _tmp$683 & 0xff;
        int32_t _tmp$684;
        uint32_t _p$444;
        int32_t _tmp$686;
        int32_t _tmp$685;
        int32_t _tmp$688;
        int32_t _tmp$689;
        if (j$153 < 0 || j$153 >= Moonbit_array_length(self$148)) {
          moonbit_panic();
        }
        self$148[j$153] = _tmp$682;
        _tmp$684 = j$153 + 1;
        _p$444 = c$154 >> 8;
        _tmp$686 = *(int32_t*)&_p$444;
        _tmp$685 = _tmp$686 & 0xff;
        if (_tmp$684 < 0 || _tmp$684 >= Moonbit_array_length(self$148)) {
          moonbit_panic();
        }
        self$148[_tmp$684] = _tmp$685;
        _tmp$688 = i$152 + 1;
        _tmp$689 = j$153 + 2;
        i$152 = _tmp$688;
        j$153 = _tmp$689;
        continue;
      } else {
        moonbit_decref(str$150);
        moonbit_decref(self$148);
      }
      break;
    }
  } else {
    moonbit_decref(str$150);
    moonbit_decref(self$148);
    moonbit_panic();
  }
  return 0;
}

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$65
) {
  int32_t _tmp$681 = Moonbit_array_length(repr$65);
  struct $StringView _bind$64 = (struct $StringView){0, _tmp$681, repr$65};
  moonbit_string_t _field$943 = _bind$64.$0;
  moonbit_string_t _data$66 = _field$943;
  int32_t _start$67 = _bind$64.$1;
  int32_t end$679 = _bind$64.$2;
  int32_t _field$942 = _bind$64.$1;
  int32_t start$680 = _field$942;
  int32_t _tmp$678 = end$679 - start$680;
  int32_t _end$68 = _start$67 + _tmp$678;
  int32_t _cursor$69 = _start$67;
  int32_t accept_state$70 = -1;
  int32_t match_end$71 = -1;
  int32_t match_tag_saver_0$72 = -1;
  int32_t match_tag_saver_1$73 = -1;
  int32_t match_tag_saver_2$74 = -1;
  int32_t match_tag_saver_3$75 = -1;
  int32_t match_tag_saver_4$76 = -1;
  int32_t tag_0$77 = -1;
  int32_t tag_1$78 = -1;
  int32_t tag_1_1$79 = -1;
  int32_t tag_1_2$80 = -1;
  int32_t tag_3$81 = -1;
  int32_t tag_2$82 = -1;
  int32_t tag_2_1$83 = -1;
  int32_t tag_4$84 = -1;
  int32_t join_dispatch_19$105;
  int32_t _tmp$668 = _cursor$69;
  int32_t dispatch_19$106;
  if (_tmp$668 < _end$68) {
    int32_t _p$387 = _cursor$69;
    int32_t next_char$134 = _data$66[_p$387];
    int32_t _tmp$669 = _cursor$69;
    _cursor$69 = _tmp$669 + 1;
    if (next_char$134 < 65) {
      if (next_char$134 < 64) {
        goto $join$85;
      } else {
        while (1) {
          int32_t _tmp$670;
          tag_0$77 = _cursor$69;
          _tmp$670 = _cursor$69;
          if (_tmp$670 < _end$68) {
            int32_t _p$390 = _cursor$69;
            int32_t next_char$137 = _data$66[_p$390];
            int32_t _tmp$671 = _cursor$69;
            _cursor$69 = _tmp$671 + 1;
            if (next_char$137 < 55296) {
              if (next_char$137 < 58) {
                goto $join$135;
              } else if (next_char$137 > 58) {
                goto $join$135;
              } else {
                int32_t _tmp$672 = _cursor$69;
                if (_tmp$672 < _end$68) {
                  int32_t _p$393 = _cursor$69;
                  int32_t next_char$139 = _data$66[_p$393];
                  int32_t _tmp$673 = _cursor$69;
                  _cursor$69 = _tmp$673 + 1;
                  if (next_char$139 < 56319) {
                    if (next_char$139 < 55296) {
                      goto $join$138;
                    } else {
                      join_dispatch_19$105 = 7;
                      goto $join$104;
                    }
                  } else if (next_char$139 > 56319) {
                    if (next_char$139 < 65536) {
                      goto $join$138;
                    } else {
                      goto $join$85;
                    }
                  } else {
                    join_dispatch_19$105 = 8;
                    goto $join$104;
                  }
                  $join$138:;
                  join_dispatch_19$105 = 0;
                  goto $join$104;
                } else {
                  goto $join$85;
                }
              }
            } else if (next_char$137 > 56318) {
              if (next_char$137 < 57344) {
                int32_t _tmp$674 = _cursor$69;
                if (_tmp$674 < _end$68) {
                  int32_t _p$396 = _cursor$69;
                  int32_t next_char$140 = _data$66[_p$396];
                  int32_t _tmp$675 = _cursor$69;
                  _cursor$69 = _tmp$675 + 1;
                  if (next_char$140 < 56320) {
                    goto $join$85;
                  } else if (next_char$140 > 57343) {
                    goto $join$85;
                  } else {
                    continue;
                  }
                } else {
                  goto $join$85;
                }
              } else if (next_char$137 > 65535) {
                goto $join$85;
              } else {
                goto $join$135;
              }
            } else {
              int32_t _tmp$676 = _cursor$69;
              if (_tmp$676 < _end$68) {
                int32_t _p$399 = _cursor$69;
                int32_t next_char$141 = _data$66[_p$399];
                int32_t _tmp$677 = _cursor$69;
                _cursor$69 = _tmp$677 + 1;
                if (next_char$141 < 56320) {
                  goto $join$85;
                } else if (next_char$141 > 65535) {
                  goto $join$85;
                } else {
                  continue;
                }
              } else {
                goto $join$85;
              }
            }
            $join$135:;
            continue;
          } else {
            goto $join$85;
          }
          break;
        }
      }
    } else {
      goto $join$85;
    }
  } else {
    goto $join$85;
  }
  $join$104:;
  dispatch_19$106 = join_dispatch_19$105;
  $loop_label_19$109:;
  while (1) {
    int32_t _tmp$642;
    switch (dispatch_19$106) {
      case 3: {
        int32_t _tmp$644;
        tag_1_2$80 = tag_1_1$79;
        tag_1_1$79 = tag_1$78;
        tag_1$78 = _cursor$69;
        _tmp$644 = _cursor$69;
        if (_tmp$644 < _end$68) {
          int32_t _p$402 = _cursor$69;
          int32_t next_char$113 = _data$66[_p$402];
          int32_t _tmp$645 = _cursor$69;
          _cursor$69 = _tmp$645 + 1;
          if (next_char$113 < 55296) {
            if (next_char$113 < 58) {
              if (next_char$113 < 48) {
                goto $join$112;
              } else {
                int32_t _tmp$646;
                tag_1$78 = _cursor$69;
                tag_2_1$83 = tag_2$82;
                tag_2$82 = _cursor$69;
                tag_3$81 = _cursor$69;
                _tmp$646 = _cursor$69;
                if (_tmp$646 < _end$68) {
                  int32_t _p$405 = _cursor$69;
                  int32_t next_char$115 = _data$66[_p$405];
                  int32_t _tmp$647 = _cursor$69;
                  _cursor$69 = _tmp$647 + 1;
                  if (next_char$115 < 59) {
                    if (next_char$115 < 46) {
                      if (next_char$115 < 45) {
                        goto $join$114;
                      } else {
                        goto $join$107;
                      }
                    } else if (next_char$115 > 47) {
                      if (next_char$115 < 58) {
                        dispatch_19$106 = 6;
                        goto $loop_label_19$109;
                      } else {
                        dispatch_19$106 = 3;
                        goto $loop_label_19$109;
                      }
                    } else {
                      goto $join$114;
                    }
                  } else if (next_char$115 > 55295) {
                    if (next_char$115 < 57344) {
                      if (next_char$115 < 56319) {
                        dispatch_19$106 = 7;
                        goto $loop_label_19$109;
                      } else {
                        dispatch_19$106 = 8;
                        goto $loop_label_19$109;
                      }
                    } else if (next_char$115 > 65535) {
                      goto $join$85;
                    } else {
                      goto $join$114;
                    }
                  } else {
                    goto $join$114;
                  }
                  $join$114:;
                  dispatch_19$106 = 0;
                  goto $loop_label_19$109;
                } else {
                  goto $join$85;
                }
              }
            } else if (next_char$113 > 58) {
              goto $join$112;
            } else {
              dispatch_19$106 = 1;
              goto $loop_label_19$109;
            }
          } else if (next_char$113 > 56318) {
            if (next_char$113 < 57344) {
              dispatch_19$106 = 8;
              goto $loop_label_19$109;
            } else if (next_char$113 > 65535) {
              goto $join$85;
            } else {
              goto $join$112;
            }
          } else {
            dispatch_19$106 = 7;
            goto $loop_label_19$109;
          }
          $join$112:;
          dispatch_19$106 = 0;
          goto $loop_label_19$109;
        } else {
          goto $join$85;
        }
        break;
      }

      case 2: {
        int32_t _tmp$648;
        tag_1$78 = _cursor$69;
        tag_2$82 = _cursor$69;
        _tmp$648 = _cursor$69;
        if (_tmp$648 < _end$68) {
          int32_t _p$408 = _cursor$69;
          int32_t next_char$117 = _data$66[_p$408];
          int32_t _tmp$649 = _cursor$69;
          _cursor$69 = _tmp$649 + 1;
          if (next_char$117 < 55296) {
            if (next_char$117 < 58) {
              if (next_char$117 < 48) {
                goto $join$116;
              } else {
                dispatch_19$106 = 2;
                goto $loop_label_19$109;
              }
            } else if (next_char$117 > 58) {
              goto $join$116;
            } else {
              dispatch_19$106 = 3;
              goto $loop_label_19$109;
            }
          } else if (next_char$117 > 56318) {
            if (next_char$117 < 57344) {
              dispatch_19$106 = 8;
              goto $loop_label_19$109;
            } else if (next_char$117 > 65535) {
              goto $join$85;
            } else {
              goto $join$116;
            }
          } else {
            dispatch_19$106 = 7;
            goto $loop_label_19$109;
          }
          $join$116:;
          dispatch_19$106 = 0;
          goto $loop_label_19$109;
        } else {
          goto $join$85;
        }
        break;
      }

      case 0: {
        int32_t _tmp$650;
        tag_1$78 = _cursor$69;
        _tmp$650 = _cursor$69;
        if (_tmp$650 < _end$68) {
          int32_t _p$411 = _cursor$69;
          int32_t next_char$119 = _data$66[_p$411];
          int32_t _tmp$651 = _cursor$69;
          _cursor$69 = _tmp$651 + 1;
          if (next_char$119 < 55296) {
            if (next_char$119 < 58) {
              goto $join$118;
            } else if (next_char$119 > 58) {
              goto $join$118;
            } else {
              dispatch_19$106 = 1;
              goto $loop_label_19$109;
            }
          } else if (next_char$119 > 56318) {
            if (next_char$119 < 57344) {
              dispatch_19$106 = 8;
              goto $loop_label_19$109;
            } else if (next_char$119 > 65535) {
              goto $join$85;
            } else {
              goto $join$118;
            }
          } else {
            dispatch_19$106 = 7;
            goto $loop_label_19$109;
          }
          $join$118:;
          dispatch_19$106 = 0;
          goto $loop_label_19$109;
        } else {
          goto $join$85;
        }
        break;
      }

      case 8: {
        int32_t _tmp$652 = _cursor$69;
        if (_tmp$652 < _end$68) {
          int32_t _p$414 = _cursor$69;
          int32_t next_char$120 = _data$66[_p$414];
          int32_t _tmp$653 = _cursor$69;
          _cursor$69 = _tmp$653 + 1;
          if (next_char$120 < 56320) {
            goto $join$85;
          } else if (next_char$120 > 57343) {
            goto $join$85;
          } else {
            dispatch_19$106 = 0;
            goto $loop_label_19$109;
          }
        } else {
          goto $join$85;
        }
        break;
      }

      case 4: {
        int32_t _tmp$654;
        tag_1$78 = _cursor$69;
        tag_4$84 = _cursor$69;
        _tmp$654 = _cursor$69;
        if (_tmp$654 < _end$68) {
          int32_t _p$417 = _cursor$69;
          int32_t next_char$122 = _data$66[_p$417];
          int32_t _tmp$655 = _cursor$69;
          _cursor$69 = _tmp$655 + 1;
          if (next_char$122 < 55296) {
            if (next_char$122 < 58) {
              if (next_char$122 < 48) {
                goto $join$121;
              } else {
                dispatch_19$106 = 4;
                goto $loop_label_19$109;
              }
            } else if (next_char$122 > 58) {
              goto $join$121;
            } else {
              int32_t _tmp$656;
              tag_1_2$80 = tag_1_1$79;
              tag_1_1$79 = tag_1$78;
              tag_1$78 = _cursor$69;
              _tmp$656 = _cursor$69;
              if (_tmp$656 < _end$68) {
                int32_t _p$420 = _cursor$69;
                int32_t next_char$124 = _data$66[_p$420];
                int32_t _tmp$657 = _cursor$69;
                _cursor$69 = _tmp$657 + 1;
                if (next_char$124 < 55296) {
                  if (next_char$124 < 58) {
                    if (next_char$124 < 48) {
                      goto $join$123;
                    } else {
                      int32_t _tmp$658;
                      tag_1$78 = _cursor$69;
                      tag_2_1$83 = tag_2$82;
                      tag_2$82 = _cursor$69;
                      _tmp$658 = _cursor$69;
                      if (_tmp$658 < _end$68) {
                        int32_t _p$423 = _cursor$69;
                        int32_t next_char$126 = _data$66[_p$423];
                        int32_t _tmp$659 = _cursor$69;
                        _cursor$69 = _tmp$659 + 1;
                        if (next_char$126 < 55296) {
                          if (next_char$126 < 58) {
                            if (next_char$126 < 48) {
                              goto $join$125;
                            } else {
                              dispatch_19$106 = 5;
                              goto $loop_label_19$109;
                            }
                          } else if (next_char$126 > 58) {
                            goto $join$125;
                          } else {
                            dispatch_19$106 = 3;
                            goto $loop_label_19$109;
                          }
                        } else if (next_char$126 > 56318) {
                          if (next_char$126 < 57344) {
                            dispatch_19$106 = 8;
                            goto $loop_label_19$109;
                          } else if (next_char$126 > 65535) {
                            goto $join$85;
                          } else {
                            goto $join$125;
                          }
                        } else {
                          dispatch_19$106 = 7;
                          goto $loop_label_19$109;
                        }
                        $join$125:;
                        dispatch_19$106 = 0;
                        goto $loop_label_19$109;
                      } else {
                        goto $join$111;
                      }
                    }
                  } else if (next_char$124 > 58) {
                    goto $join$123;
                  } else {
                    dispatch_19$106 = 1;
                    goto $loop_label_19$109;
                  }
                } else if (next_char$124 > 56318) {
                  if (next_char$124 < 57344) {
                    dispatch_19$106 = 8;
                    goto $loop_label_19$109;
                  } else if (next_char$124 > 65535) {
                    goto $join$85;
                  } else {
                    goto $join$123;
                  }
                } else {
                  dispatch_19$106 = 7;
                  goto $loop_label_19$109;
                }
                $join$123:;
                dispatch_19$106 = 0;
                goto $loop_label_19$109;
              } else {
                goto $join$85;
              }
            }
          } else if (next_char$122 > 56318) {
            if (next_char$122 < 57344) {
              dispatch_19$106 = 8;
              goto $loop_label_19$109;
            } else if (next_char$122 > 65535) {
              goto $join$85;
            } else {
              goto $join$121;
            }
          } else {
            dispatch_19$106 = 7;
            goto $loop_label_19$109;
          }
          $join$121:;
          dispatch_19$106 = 0;
          goto $loop_label_19$109;
        } else {
          goto $join$85;
        }
        break;
      }

      case 5: {
        int32_t _tmp$660;
        tag_1$78 = _cursor$69;
        tag_2$82 = _cursor$69;
        _tmp$660 = _cursor$69;
        if (_tmp$660 < _end$68) {
          int32_t _p$426 = _cursor$69;
          int32_t next_char$128 = _data$66[_p$426];
          int32_t _tmp$661 = _cursor$69;
          _cursor$69 = _tmp$661 + 1;
          if (next_char$128 < 55296) {
            if (next_char$128 < 58) {
              if (next_char$128 < 48) {
                goto $join$127;
              } else {
                dispatch_19$106 = 5;
                goto $loop_label_19$109;
              }
            } else if (next_char$128 > 58) {
              goto $join$127;
            } else {
              dispatch_19$106 = 3;
              goto $loop_label_19$109;
            }
          } else if (next_char$128 > 56318) {
            if (next_char$128 < 57344) {
              dispatch_19$106 = 8;
              goto $loop_label_19$109;
            } else if (next_char$128 > 65535) {
              goto $join$85;
            } else {
              goto $join$127;
            }
          } else {
            dispatch_19$106 = 7;
            goto $loop_label_19$109;
          }
          $join$127:;
          dispatch_19$106 = 0;
          goto $loop_label_19$109;
        } else {
          goto $join$111;
        }
        break;
      }

      case 6: {
        int32_t _tmp$662;
        tag_1$78 = _cursor$69;
        tag_2$82 = _cursor$69;
        tag_3$81 = _cursor$69;
        _tmp$662 = _cursor$69;
        if (_tmp$662 < _end$68) {
          int32_t _p$429 = _cursor$69;
          int32_t next_char$130 = _data$66[_p$429];
          int32_t _tmp$663 = _cursor$69;
          _cursor$69 = _tmp$663 + 1;
          if (next_char$130 < 59) {
            if (next_char$130 < 46) {
              if (next_char$130 < 45) {
                goto $join$129;
              } else {
                goto $join$107;
              }
            } else if (next_char$130 > 47) {
              if (next_char$130 < 58) {
                dispatch_19$106 = 6;
                goto $loop_label_19$109;
              } else {
                dispatch_19$106 = 3;
                goto $loop_label_19$109;
              }
            } else {
              goto $join$129;
            }
          } else if (next_char$130 > 55295) {
            if (next_char$130 < 57344) {
              if (next_char$130 < 56319) {
                dispatch_19$106 = 7;
                goto $loop_label_19$109;
              } else {
                dispatch_19$106 = 8;
                goto $loop_label_19$109;
              }
            } else if (next_char$130 > 65535) {
              goto $join$85;
            } else {
              goto $join$129;
            }
          } else {
            goto $join$129;
          }
          $join$129:;
          dispatch_19$106 = 0;
          goto $loop_label_19$109;
        } else {
          goto $join$85;
        }
        break;
      }

      case 7: {
        int32_t _tmp$664 = _cursor$69;
        if (_tmp$664 < _end$68) {
          int32_t _p$432 = _cursor$69;
          int32_t next_char$131 = _data$66[_p$432];
          int32_t _tmp$665 = _cursor$69;
          _cursor$69 = _tmp$665 + 1;
          if (next_char$131 < 56320) {
            goto $join$85;
          } else if (next_char$131 > 65535) {
            goto $join$85;
          } else {
            dispatch_19$106 = 0;
            goto $loop_label_19$109;
          }
        } else {
          goto $join$85;
        }
        break;
      }

      case 1: {
        int32_t _tmp$666;
        tag_1_1$79 = tag_1$78;
        tag_1$78 = _cursor$69;
        _tmp$666 = _cursor$69;
        if (_tmp$666 < _end$68) {
          int32_t _p$435 = _cursor$69;
          int32_t next_char$133 = _data$66[_p$435];
          int32_t _tmp$667 = _cursor$69;
          _cursor$69 = _tmp$667 + 1;
          if (next_char$133 < 55296) {
            if (next_char$133 < 58) {
              if (next_char$133 < 48) {
                goto $join$132;
              } else {
                dispatch_19$106 = 2;
                goto $loop_label_19$109;
              }
            } else if (next_char$133 > 58) {
              goto $join$132;
            } else {
              dispatch_19$106 = 1;
              goto $loop_label_19$109;
            }
          } else if (next_char$133 > 56318) {
            if (next_char$133 < 57344) {
              dispatch_19$106 = 8;
              goto $loop_label_19$109;
            } else if (next_char$133 > 65535) {
              goto $join$85;
            } else {
              goto $join$132;
            }
          } else {
            dispatch_19$106 = 7;
            goto $loop_label_19$109;
          }
          $join$132:;
          dispatch_19$106 = 0;
          goto $loop_label_19$109;
        } else {
          goto $join$85;
        }
        break;
      }
      default: {
        goto $join$85;
        break;
      }
    }
    $join$111:;
    tag_1$78 = tag_1_2$80;
    tag_2$82 = tag_2_1$83;
    match_tag_saver_0$72 = tag_0$77;
    match_tag_saver_1$73 = tag_1$78;
    match_tag_saver_2$74 = tag_2$82;
    match_tag_saver_3$75 = tag_3$81;
    match_tag_saver_4$76 = tag_4$84;
    accept_state$70 = 0;
    match_end$71 = _cursor$69;
    goto $join$85;
    $join$107:;
    tag_1_1$79 = tag_1_2$80;
    tag_1$78 = _cursor$69;
    tag_2$82 = tag_2_1$83;
    _tmp$642 = _cursor$69;
    if (_tmp$642 < _end$68) {
      int32_t _p$438 = _cursor$69;
      int32_t next_char$110 = _data$66[_p$438];
      int32_t _tmp$643 = _cursor$69;
      _cursor$69 = _tmp$643 + 1;
      if (next_char$110 < 55296) {
        if (next_char$110 < 58) {
          if (next_char$110 < 48) {
            goto $join$108;
          } else {
            dispatch_19$106 = 4;
            continue;
          }
        } else if (next_char$110 > 58) {
          goto $join$108;
        } else {
          dispatch_19$106 = 1;
          continue;
        }
      } else if (next_char$110 > 56318) {
        if (next_char$110 < 57344) {
          dispatch_19$106 = 8;
          continue;
        } else if (next_char$110 > 65535) {
          goto $join$85;
        } else {
          goto $join$108;
        }
      } else {
        dispatch_19$106 = 7;
        continue;
      }
      $join$108:;
      dispatch_19$106 = 0;
      continue;
    } else {
      goto $join$85;
    }
    break;
  }
  $join$85:;
  switch (accept_state$70) {
    case 0: {
      void* _try_err$88;
      struct $StringView start_line$86;
      int32_t _tmp$639 = match_tag_saver_1$73;
      int32_t _tmp$638 = _tmp$639 + 1;
      int64_t _tmp$635 = (int64_t)_tmp$638;
      int32_t _tmp$637 = match_tag_saver_2$74;
      int64_t _tmp$636 = (int64_t)_tmp$637;
      struct moonbit_result_0 _tmp$1023;
      void* _try_err$91;
      struct $StringView start_column$89;
      int32_t _tmp$632;
      int32_t _tmp$631;
      int64_t _tmp$628;
      int32_t _tmp$630;
      int64_t _tmp$629;
      struct moonbit_result_0 _tmp$1025;
      void* _try_err$94;
      struct $StringView pkg$92;
      int32_t _tmp$625;
      int64_t _tmp$622;
      int32_t _tmp$624;
      int64_t _tmp$623;
      struct moonbit_result_0 _tmp$1027;
      void* _try_err$97;
      struct $StringView filename$95;
      int32_t _tmp$619;
      int32_t _tmp$618;
      int64_t _tmp$615;
      int32_t _tmp$617;
      int64_t _tmp$616;
      struct moonbit_result_0 _tmp$1029;
      void* _try_err$100;
      struct $StringView end_line$98;
      int32_t _tmp$612;
      int32_t _tmp$611;
      int64_t _tmp$608;
      int32_t _tmp$610;
      int64_t _tmp$609;
      struct moonbit_result_0 _tmp$1031;
      void* _try_err$103;
      struct $StringView end_column$101;
      int32_t _tmp$605;
      int32_t _tmp$604;
      int64_t _tmp$601;
      int32_t _tmp$603;
      int64_t _tmp$602;
      struct moonbit_result_0 _tmp$1033;
      struct $$moonbitlang$core$builtin$SourceLocRepr* _block$1034;
      moonbit_incref(_data$66);
      _tmp$1023 = $String$$sub(_data$66, _tmp$635, _tmp$636);
      if (_tmp$1023.tag) {
        struct $StringView const _ok$640 = _tmp$1023.data.ok;
        start_line$86 = _ok$640;
      } else {
        void* const _err$641 = _tmp$1023.data.err;
        _try_err$88 = _err$641;
        goto $join$87;
      }
      goto $joinlet$1022;
      $join$87:;
      moonbit_decref(_try_err$88);
      moonbit_panic();
      $joinlet$1022:;
      _tmp$632 = match_tag_saver_2$74;
      _tmp$631 = _tmp$632 + 1;
      _tmp$628 = (int64_t)_tmp$631;
      _tmp$630 = match_tag_saver_3$75;
      _tmp$629 = (int64_t)_tmp$630;
      moonbit_incref(_data$66);
      _tmp$1025 = $String$$sub(_data$66, _tmp$628, _tmp$629);
      if (_tmp$1025.tag) {
        struct $StringView const _ok$633 = _tmp$1025.data.ok;
        start_column$89 = _ok$633;
      } else {
        void* const _err$634 = _tmp$1025.data.err;
        _try_err$91 = _err$634;
        goto $join$90;
      }
      goto $joinlet$1024;
      $join$90:;
      moonbit_decref(_try_err$91);
      moonbit_panic();
      $joinlet$1024:;
      _tmp$625 = _start$67 + 1;
      _tmp$622 = (int64_t)_tmp$625;
      _tmp$624 = match_tag_saver_0$72;
      _tmp$623 = (int64_t)_tmp$624;
      moonbit_incref(_data$66);
      _tmp$1027 = $String$$sub(_data$66, _tmp$622, _tmp$623);
      if (_tmp$1027.tag) {
        struct $StringView const _ok$626 = _tmp$1027.data.ok;
        pkg$92 = _ok$626;
      } else {
        void* const _err$627 = _tmp$1027.data.err;
        _try_err$94 = _err$627;
        goto $join$93;
      }
      goto $joinlet$1026;
      $join$93:;
      moonbit_decref(_try_err$94);
      moonbit_panic();
      $joinlet$1026:;
      _tmp$619 = match_tag_saver_0$72;
      _tmp$618 = _tmp$619 + 1;
      _tmp$615 = (int64_t)_tmp$618;
      _tmp$617 = match_tag_saver_1$73;
      _tmp$616 = (int64_t)_tmp$617;
      moonbit_incref(_data$66);
      _tmp$1029 = $String$$sub(_data$66, _tmp$615, _tmp$616);
      if (_tmp$1029.tag) {
        struct $StringView const _ok$620 = _tmp$1029.data.ok;
        filename$95 = _ok$620;
      } else {
        void* const _err$621 = _tmp$1029.data.err;
        _try_err$97 = _err$621;
        goto $join$96;
      }
      goto $joinlet$1028;
      $join$96:;
      moonbit_decref(_try_err$97);
      moonbit_panic();
      $joinlet$1028:;
      _tmp$612 = match_tag_saver_3$75;
      _tmp$611 = _tmp$612 + 1;
      _tmp$608 = (int64_t)_tmp$611;
      _tmp$610 = match_tag_saver_4$76;
      _tmp$609 = (int64_t)_tmp$610;
      moonbit_incref(_data$66);
      _tmp$1031 = $String$$sub(_data$66, _tmp$608, _tmp$609);
      if (_tmp$1031.tag) {
        struct $StringView const _ok$613 = _tmp$1031.data.ok;
        end_line$98 = _ok$613;
      } else {
        void* const _err$614 = _tmp$1031.data.err;
        _try_err$100 = _err$614;
        goto $join$99;
      }
      goto $joinlet$1030;
      $join$99:;
      moonbit_decref(_try_err$100);
      moonbit_panic();
      $joinlet$1030:;
      _tmp$605 = match_tag_saver_4$76;
      _tmp$604 = _tmp$605 + 1;
      _tmp$601 = (int64_t)_tmp$604;
      _tmp$603 = match_end$71;
      _tmp$602 = (int64_t)_tmp$603;
      _tmp$1033 = $String$$sub(_data$66, _tmp$601, _tmp$602);
      if (_tmp$1033.tag) {
        struct $StringView const _ok$606 = _tmp$1033.data.ok;
        end_column$101 = _ok$606;
      } else {
        void* const _err$607 = _tmp$1033.data.err;
        _try_err$103 = _err$607;
        goto $join$102;
      }
      goto $joinlet$1032;
      $join$102:;
      moonbit_decref(_try_err$103);
      moonbit_panic();
      $joinlet$1032:;
      _block$1034
      = (struct $$moonbitlang$core$builtin$SourceLocRepr*)moonbit_malloc(
          sizeof(struct $$moonbitlang$core$builtin$SourceLocRepr)
        );
      Moonbit_object_header(_block$1034)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $$moonbitlang$core$builtin$SourceLocRepr, $0_0) >> 2,
          6,
          0
      );
      _block$1034->$0_0 = pkg$92.$0;
      _block$1034->$0_1 = pkg$92.$1;
      _block$1034->$0_2 = pkg$92.$2;
      _block$1034->$1_0 = filename$95.$0;
      _block$1034->$1_1 = filename$95.$1;
      _block$1034->$1_2 = filename$95.$2;
      _block$1034->$2_0 = start_line$86.$0;
      _block$1034->$2_1 = start_line$86.$1;
      _block$1034->$2_2 = start_line$86.$2;
      _block$1034->$3_0 = start_column$89.$0;
      _block$1034->$3_1 = start_column$89.$1;
      _block$1034->$3_2 = start_column$89.$2;
      _block$1034->$4_0 = end_line$98.$0;
      _block$1034->$4_1 = end_line$98.$1;
      _block$1034->$4_2 = end_line$98.$2;
      _block$1034->$5_0 = end_column$101.$0;
      _block$1034->$5_1 = end_column$101.$1;
      _block$1034->$5_2 = end_column$101.$2;
      return _block$1034;
      break;
    }
    default: {
      moonbit_decref(_data$66);
      moonbit_panic();
      break;
    }
  }
}

int32_t* $$moonbitlang$core$builtin$Array$$buffer$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$63
) {
  int32_t* _field$944 = self$63->$0;
  int32_t _cnt$972 = Moonbit_object_header(self$63)->rc;
  if (_cnt$972 > 1) {
    int32_t _new_cnt$973 = _cnt$972 - 1;
    Moonbit_object_header(self$63)->rc = _new_cnt$973;
    moonbit_incref(_field$944);
  } else if (_cnt$972 == 1) {
    moonbit_free(self$63);
  }
  return _field$944;
}

int32_t $String$$unsafe_charcode_at(moonbit_string_t self$61, int32_t idx$62) {
  int32_t _tmp$945 = self$61[idx$62];
  moonbit_decref(self$61);
  return _tmp$945;
}

int32_t $Int$$is_trailing_surrogate(int32_t self$60) {
  return 56320 <= self$60 && self$60 <= 57343;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$57,
  int32_t ch$59
) {
  int32_t len$596 = self$57->$1;
  int32_t _tmp$595 = len$596 + 4;
  moonbit_bytes_t _field$946;
  moonbit_bytes_t data$599;
  int32_t len$600;
  int32_t inc$58;
  int32_t len$598;
  int32_t _tmp$597;
  moonbit_incref(self$57);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$57, _tmp$595
  );
  _field$946 = self$57->$0;
  data$599 = _field$946;
  len$600 = self$57->$1;
  moonbit_incref(data$599);
  inc$58 = $FixedArray$$set_utf16le_char(data$599, len$600, ch$59);
  len$598 = self$57->$1;
  _tmp$597 = len$598 + inc$58;
  self$57->$1 = _tmp$597;
  moonbit_decref(self$57);
  return 0;
}

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$52,
  int32_t required$53
) {
  moonbit_bytes_t _field$950 = self$52->$0;
  moonbit_bytes_t data$594 = _field$950;
  int32_t _tmp$949 = Moonbit_array_length(data$594);
  int32_t current_len$51 = _tmp$949;
  int32_t enough_space$54;
  int32_t _tmp$593;
  moonbit_bytes_t new_data$56;
  moonbit_bytes_t _field$948;
  moonbit_bytes_t data$591;
  int32_t len$592;
  moonbit_bytes_t _old$947;
  if (required$53 <= current_len$51) {
    moonbit_decref(self$52);
    return 0;
  }
  enough_space$54 = current_len$51;
  while (1) {
    int32_t _tmp$589 = enough_space$54;
    if (_tmp$589 < required$53) {
      int32_t _tmp$590 = enough_space$54;
      enough_space$54 = _tmp$590 * 2;
      continue;
    }
    break;
  }
  _tmp$593 = enough_space$54;
  new_data$56 = (moonbit_bytes_t)moonbit_make_bytes(_tmp$593, 0);
  _field$948 = self$52->$0;
  data$591 = _field$948;
  len$592 = self$52->$1;
  moonbit_incref(data$591);
  moonbit_incref(new_data$56);
  $FixedArray$$unsafe_blit$0(new_data$56, 0, data$591, 0, len$592);
  _old$947 = self$52->$0;
  moonbit_decref(_old$947);
  self$52->$0 = new_data$56;
  moonbit_decref(self$52);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default() {
  return 0;
}

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$46,
  int32_t offset$47,
  int32_t value$45
) {
  int32_t _tmp$588 = value$45;
  uint32_t code$44 = *(uint32_t*)&_tmp$588;
  if (code$44 < 65536u) {
    uint32_t _p$361 = code$44 & 255u;
    int32_t _tmp$571 = *(int32_t*)&_p$361;
    int32_t _tmp$570 = _tmp$571 & 0xff;
    int32_t _tmp$572;
    uint32_t _p$364;
    int32_t _tmp$574;
    int32_t _tmp$573;
    if (offset$47 < 0 || offset$47 >= Moonbit_array_length(self$46)) {
      moonbit_panic();
    }
    self$46[offset$47] = _tmp$570;
    _tmp$572 = offset$47 + 1;
    _p$364 = code$44 >> 8;
    _tmp$574 = *(int32_t*)&_p$364;
    _tmp$573 = _tmp$574 & 0xff;
    if (_tmp$572 < 0 || _tmp$572 >= Moonbit_array_length(self$46)) {
      moonbit_panic();
    }
    self$46[_tmp$572] = _tmp$573;
    moonbit_decref(self$46);
    return 2;
  } else if (code$44 < 1114112u) {
    uint32_t hi$48 = code$44 - 65536u;
    uint32_t _tmp$587 = hi$48 >> 10;
    uint32_t lo$49 = _tmp$587 | 55296u;
    uint32_t _tmp$586 = hi$48 & 1023u;
    uint32_t hi$50 = _tmp$586 | 56320u;
    uint32_t _p$367 = lo$49 & 255u;
    int32_t _tmp$576 = *(int32_t*)&_p$367;
    int32_t _tmp$575 = _tmp$576 & 0xff;
    int32_t _tmp$577;
    uint32_t _p$370;
    int32_t _tmp$579;
    int32_t _tmp$578;
    int32_t _tmp$580;
    uint32_t _p$373;
    int32_t _tmp$582;
    int32_t _tmp$581;
    int32_t _tmp$583;
    uint32_t _p$376;
    int32_t _tmp$585;
    int32_t _tmp$584;
    if (offset$47 < 0 || offset$47 >= Moonbit_array_length(self$46)) {
      moonbit_panic();
    }
    self$46[offset$47] = _tmp$575;
    _tmp$577 = offset$47 + 1;
    _p$370 = lo$49 >> 8;
    _tmp$579 = *(int32_t*)&_p$370;
    _tmp$578 = _tmp$579 & 0xff;
    if (_tmp$577 < 0 || _tmp$577 >= Moonbit_array_length(self$46)) {
      moonbit_panic();
    }
    self$46[_tmp$577] = _tmp$578;
    _tmp$580 = offset$47 + 2;
    _p$373 = hi$50 & 255u;
    _tmp$582 = *(int32_t*)&_p$373;
    _tmp$581 = _tmp$582 & 0xff;
    if (_tmp$580 < 0 || _tmp$580 >= Moonbit_array_length(self$46)) {
      moonbit_panic();
    }
    self$46[_tmp$580] = _tmp$581;
    _tmp$583 = offset$47 + 3;
    _p$376 = hi$50 >> 8;
    _tmp$585 = *(int32_t*)&_p$376;
    _tmp$584 = _tmp$585 & 0xff;
    if (_tmp$583 < 0 || _tmp$583 >= Moonbit_array_length(self$46)) {
      moonbit_panic();
    }
    self$46[_tmp$583] = _tmp$584;
    moonbit_decref(self$46);
    return 4;
  } else {
    moonbit_decref(self$46);
    return $moonbitlang$core$builtin$abort$0(
             (moonbit_string_t)moonbit_string_literal_7.data,
               (moonbit_string_t)moonbit_string_literal_8.data
           );
  }
}

int32_t $UInt$$to_byte(uint32_t self$43) {
  int32_t _tmp$569 = *(int32_t*)&self$43;
  return _tmp$569 & 0xff;
}

uint32_t $Char$$to_uint(int32_t self$42) {
  int32_t _tmp$568 = self$42;
  return *(uint32_t*)&_tmp$568;
}

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$41
) {
  moonbit_bytes_t _field$952 = self$41->$0;
  moonbit_bytes_t data$567 = _field$952;
  moonbit_bytes_t _tmp$564;
  int32_t _field$951;
  int32_t len$566;
  int64_t _tmp$565;
  moonbit_incref(data$567);
  _tmp$564 = data$567;
  _field$951 = self$41->$1;
  moonbit_decref(self$41);
  len$566 = _field$951;
  _tmp$565 = (int64_t)len$566;
  return $Bytes$$to_unchecked_string$inner(_tmp$564, 0, _tmp$565);
}

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$36,
  int32_t offset$40,
  int64_t length$38
) {
  int32_t len$35 = Moonbit_array_length(self$36);
  int32_t length$37;
  int32_t _if_result$1036;
  if (length$38 == 4294967296ll) {
    length$37 = len$35 - offset$40;
  } else {
    int64_t _Some$39 = length$38;
    length$37 = (int32_t)_Some$39;
  }
  if (offset$40 >= 0) {
    if (length$37 >= 0) {
      int32_t _tmp$563 = offset$40 + length$37;
      _if_result$1036 = _tmp$563 <= len$35;
    } else {
      _if_result$1036 = 0;
    }
  } else {
    _if_result$1036 = 0;
  }
  if (_if_result$1036) {
    return $moonbitlang$core$builtin$unsafe_sub_string(
             self$36, offset$40, length$37
           );
  } else {
    moonbit_decref(self$36);
    moonbit_panic();
  }
}

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$33
) {
  int32_t initial$32;
  moonbit_bytes_t data$34;
  struct $$moonbitlang$core$builtin$StringBuilder* _block$1037;
  if (size_hint$33 < 1) {
    initial$32 = 1;
  } else {
    initial$32 = size_hint$33;
  }
  data$34 = (moonbit_bytes_t)moonbit_make_bytes(initial$32, 0);
  _block$1037
  = (struct $$moonbitlang$core$builtin$StringBuilder*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$builtin$StringBuilder)
    );
  Moonbit_object_header(_block$1037)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $$moonbitlang$core$builtin$StringBuilder, $0) >> 2, 1, 0
  );
  _block$1037->$0 = data$34;
  _block$1037->$1 = 0;
  return _block$1037;
}

int32_t $$moonbitlang$core$builtin$UninitializedArray$$unsafe_blit$0(
  int32_t* dst$27,
  int32_t dst_offset$28,
  int32_t* src$29,
  int32_t src_offset$30,
  int32_t len$31
) {
  $FixedArray$$unsafe_blit$1(
    dst$27, dst_offset$28, src$29, src_offset$30, len$31
  );
  return 0;
}

int32_t $FixedArray$$unsafe_blit$1(
  int32_t* dst$18,
  int32_t dst_offset$20,
  int32_t* src$19,
  int32_t src_offset$21,
  int32_t len$23
) {
  if (dst$18 == src$19 && dst_offset$20 < src_offset$21) {
    int32_t i$22 = 0;
    while (1) {
      if (i$22 < len$23) {
        int32_t _tmp$554 = dst_offset$20 + i$22;
        int32_t _tmp$556 = src_offset$21 + i$22;
        int32_t _tmp$555;
        int32_t _tmp$557;
        if (_tmp$556 < 0 || _tmp$556 >= Moonbit_array_length(src$19)) {
          moonbit_panic();
        }
        _tmp$555 = (int32_t)src$19[_tmp$556];
        if (_tmp$554 < 0 || _tmp$554 >= Moonbit_array_length(dst$18)) {
          moonbit_panic();
        }
        dst$18[_tmp$554] = _tmp$555;
        _tmp$557 = i$22 + 1;
        i$22 = _tmp$557;
        continue;
      } else {
        moonbit_decref(src$19);
        moonbit_decref(dst$18);
      }
      break;
    }
  } else {
    int32_t _tmp$562 = len$23 - 1;
    int32_t i$25 = _tmp$562;
    while (1) {
      if (i$25 >= 0) {
        int32_t _tmp$558 = dst_offset$20 + i$25;
        int32_t _tmp$560 = src_offset$21 + i$25;
        int32_t _tmp$559;
        int32_t _tmp$561;
        if (_tmp$560 < 0 || _tmp$560 >= Moonbit_array_length(src$19)) {
          moonbit_panic();
        }
        _tmp$559 = (int32_t)src$19[_tmp$560];
        if (_tmp$558 < 0 || _tmp$558 >= Moonbit_array_length(dst$18)) {
          moonbit_panic();
        }
        dst$18[_tmp$558] = _tmp$559;
        _tmp$561 = i$25 - 1;
        i$25 = _tmp$561;
        continue;
      } else {
        moonbit_decref(src$19);
        moonbit_decref(dst$18);
      }
      break;
    }
  }
  return 0;
}

int32_t $FixedArray$$unsafe_blit$0(
  moonbit_bytes_t dst$9,
  int32_t dst_offset$11,
  moonbit_bytes_t src$10,
  int32_t src_offset$12,
  int32_t len$14
) {
  if (dst$9 == src$10 && dst_offset$11 < src_offset$12) {
    int32_t i$13 = 0;
    while (1) {
      if (i$13 < len$14) {
        int32_t _tmp$545 = dst_offset$11 + i$13;
        int32_t _tmp$547 = src_offset$12 + i$13;
        int32_t _tmp$546;
        int32_t _tmp$548;
        if (_tmp$547 < 0 || _tmp$547 >= Moonbit_array_length(src$10)) {
          moonbit_panic();
        }
        _tmp$546 = (int32_t)src$10[_tmp$547];
        if (_tmp$545 < 0 || _tmp$545 >= Moonbit_array_length(dst$9)) {
          moonbit_panic();
        }
        dst$9[_tmp$545] = _tmp$546;
        _tmp$548 = i$13 + 1;
        i$13 = _tmp$548;
        continue;
      } else {
        moonbit_decref(src$10);
        moonbit_decref(dst$9);
      }
      break;
    }
  } else {
    int32_t _tmp$553 = len$14 - 1;
    int32_t i$16 = _tmp$553;
    while (1) {
      if (i$16 >= 0) {
        int32_t _tmp$549 = dst_offset$11 + i$16;
        int32_t _tmp$551 = src_offset$12 + i$16;
        int32_t _tmp$550;
        int32_t _tmp$552;
        if (_tmp$551 < 0 || _tmp$551 >= Moonbit_array_length(src$10)) {
          moonbit_panic();
        }
        _tmp$550 = (int32_t)src$10[_tmp$551];
        if (_tmp$549 < 0 || _tmp$549 >= Moonbit_array_length(dst$9)) {
          moonbit_panic();
        }
        dst$9[_tmp$549] = _tmp$550;
        _tmp$552 = i$16 - 1;
        i$16 = _tmp$552;
        continue;
      } else {
        moonbit_decref(src$10);
        moonbit_decref(dst$9);
      }
      break;
    }
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$abort$1(
  moonbit_string_t string$7,
  moonbit_string_t loc$8
) {
  moonbit_string_t _tmp$543 =
    moonbit_add_string(
      string$7, (moonbit_string_t)moonbit_string_literal_9.data
    );
  moonbit_string_t _tmp$544 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(loc$8);
  moonbit_string_t _tmp$542 = moonbit_add_string(_tmp$543, _tmp$544);
  moonbit_string_t _tmp$541 =
    moonbit_add_string(
      _tmp$542, (moonbit_string_t)moonbit_string_literal_10.data
    );
  $moonbitlang$core$abort$abort$1(_tmp$541);
  return 0;
}

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$5,
  moonbit_string_t loc$6
) {
  moonbit_string_t _tmp$539 =
    moonbit_add_string(
      string$5, (moonbit_string_t)moonbit_string_literal_9.data
    );
  moonbit_string_t _tmp$540 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(loc$6);
  moonbit_string_t _tmp$538 = moonbit_add_string(_tmp$539, _tmp$540);
  moonbit_string_t _tmp$537 =
    moonbit_add_string(
      _tmp$538, (moonbit_string_t)moonbit_string_literal_10.data
    );
  return $moonbitlang$core$abort$abort$0(_tmp$537);
}

int32_t $$moonbitlang$core$builtin$Logger$$write_object$0(
  struct $$moonbitlang$core$builtin$Logger self$4,
  int32_t obj$3
) {
  $$moonbitlang$core$builtin$Show$$Int$$output(obj$3, self$4);
  return 0;
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
  void* _obj_ptr$521,
  int32_t _param$520
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$519 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$521;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
    _self$519, _param$520
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$518,
  struct $StringView _param$517
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$516 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$518;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    _self$516, _param$517
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$515,
  moonbit_string_t _param$512,
  int32_t _param$513,
  int32_t _param$514
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$511 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$515;
  $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
    _self$511, _param$512, _param$513, _param$514
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$510,
  moonbit_string_t _param$509
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$508 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$510;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
    _self$508, _param$509
  );
  return 0;
}

void moonbit_init() {

}

int main(int argc, char** argv) {
  int32_t* _tmp$536;
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* arr$344;
  moonbit_string_t _tmp$523;
  moonbit_string_t _tmp$522;
  int32_t sum$345;
  int32_t _len$346;
  int32_t _i$347;
  int32_t _tmp$529;
  moonbit_string_t _tmp$528;
  moonbit_string_t _tmp$527;
  int32_t* _tmp$535;
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* doubled$350;
  int32_t _len$351;
  int32_t _i$352;
  moonbit_string_t _tmp$534;
  moonbit_string_t _tmp$533;
  moonbit_runtime_init(argc, argv);
  moonbit_init();
  _tmp$536 = (int32_t*)moonbit_make_int32_array_raw(5);
  _tmp$536[0] = 1;
  _tmp$536[1] = 2;
  _tmp$536[2] = 3;
  _tmp$536[3] = 4;
  _tmp$536[4] = 5;
  arr$344
  = (struct $$moonbitlang$core$builtin$Array$3c$Int$3e$*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$builtin$Array$3c$Int$3e$)
    );
  Moonbit_object_header(arr$344)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $$moonbitlang$core$builtin$Array$3c$Int$3e$, $0) >> 2,
      1,
      0
  );
  arr$344->$0 = _tmp$536;
  arr$344->$1 = 5;
  moonbit_incref(arr$344);
  _tmp$523
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
    arr$344
  );
  _tmp$522
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_11.data, _tmp$523
  );
  $moonbitlang$core$builtin$println$0(_tmp$522);
  sum$345 = 0;
  _len$346 = arr$344->$1;
  _i$347 = 0;
  while (1) {
    if (_i$347 < _len$346) {
      int32_t* _field$956 = arr$344->$0;
      int32_t* buf$525 = _field$956;
      int32_t _tmp$955 = (int32_t)buf$525[_i$347];
      int32_t x$348 = _tmp$955;
      int32_t _tmp$524 = sum$345;
      int32_t _tmp$526;
      sum$345 = _tmp$524 + x$348;
      _tmp$526 = _i$347 + 1;
      _i$347 = _tmp$526;
      continue;
    }
    break;
  }
  _tmp$529 = sum$345;
  _tmp$528
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
    _tmp$529
  );
  _tmp$527
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_12.data, _tmp$528
  );
  $moonbitlang$core$builtin$println$0(_tmp$527);
  _tmp$535 = (int32_t*)moonbit_empty_int32_array;
  doubled$350
  = (struct $$moonbitlang$core$builtin$Array$3c$Int$3e$*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$builtin$Array$3c$Int$3e$)
    );
  Moonbit_object_header(doubled$350)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $$moonbitlang$core$builtin$Array$3c$Int$3e$, $0) >> 2,
      1,
      0
  );
  doubled$350->$0 = _tmp$535;
  doubled$350->$1 = 0;
  _len$351 = arr$344->$1;
  _i$352 = 0;
  while (1) {
    if (_i$352 < _len$351) {
      int32_t* _field$954 = arr$344->$0;
      int32_t* buf$531 = _field$954;
      int32_t _tmp$953 = (int32_t)buf$531[_i$352];
      int32_t x$353 = _tmp$953;
      int32_t _tmp$530 = x$353 * 2;
      int32_t _tmp$532;
      moonbit_incref(doubled$350);
      $$moonbitlang$core$builtin$Array$$push$0(doubled$350, _tmp$530);
      _tmp$532 = _i$352 + 1;
      _i$352 = _tmp$532;
      continue;
    } else {
      moonbit_decref(arr$344);
    }
    break;
  }
  _tmp$534
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
    doubled$350
  );
  _tmp$533
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_13.data, _tmp$534
  );
  $moonbitlang$core$builtin$println$0(_tmp$533);
  return 0;
}