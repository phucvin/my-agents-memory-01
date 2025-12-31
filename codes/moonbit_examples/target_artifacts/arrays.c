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

struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int;

struct $$3c$Int$3e$$3d$$3e$Int;

struct $ArrayView$$iterator$7c$Int$7c$$$2a$p$fn$4$2d$cap;

struct $Logger$$write_iter$inner$7c$Int$7c$$fn$2$2d$cap;

struct $$moonbitlang$core$builtin$Array$3c$Int$3e$;

struct $Ref$3c$Int$3e$;

struct $Result$3c$StringView$2a$$moonbitlang$core$builtin$CreatingViewError$3e$$Ok;

struct $StringView;

struct $Iterator$$iter$7c$Int$7c$$fn$3$2d$cap;

struct $$moonbitlang$core$builtin$Logger;

struct $$moonbitlang$core$builtin$SourceLocRepr;

struct $Ref$3c$Bool$3e$;

struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$;

struct $Logger$$write_iter$inner$7c$Int$7c$$fn$1$2d$cap;

struct $$3c$StringView$2a$StringView$3e$;

struct $Option$3c$StringView$3e$$Some;

struct $Result$3c$StringView$2a$$moonbitlang$core$builtin$CreatingViewError$3e$$Err;

struct $$moonbitlang$core$builtin$Logger$static_method_table;

struct $$moonbitlang$core$builtin$StringBuilder;

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$;

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

struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int {
  int32_t(* code)(
    struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int*,
    struct $$3c$Int$3e$$3d$$3e$Int*
  );

};

struct $$3c$Int$3e$$3d$$3e$Int {
  int32_t(* code)(struct $$3c$Int$3e$$3d$$3e$Int*, int32_t);

};

struct $ArrayView$$iterator$7c$Int$7c$$$2a$p$fn$4$2d$cap {
  int64_t(* code)(struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$*);
  int32_t $0_1;
  int32_t $0_2;
  int32_t* $0_0;
  struct $Ref$3c$Int$3e$* $1;

};

struct $Logger$$write_iter$inner$7c$Int$7c$$fn$2$2d$cap {
  int32_t(* code)(struct $$3c$Int$3e$$3d$$3e$Int*, int32_t);
  struct $Ref$3c$Bool$3e$* $0;
  moonbit_string_t $1;
  struct $$moonbitlang$core$builtin$Logger$static_method_table* $2_0;
  void* $2_1;

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

struct $Iterator$$iter$7c$Int$7c$$fn$3$2d$cap {
  int32_t(* code)(
    struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int*,
    struct $$3c$Int$3e$$3d$$3e$Int*
  );
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $0;

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

struct $Ref$3c$Bool$3e$ {
  int32_t $0;

};

struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ {
  int32_t $1;
  int32_t $2;
  int32_t* $0;

};

struct $Logger$$write_iter$inner$7c$Int$7c$$fn$1$2d$cap {
  int32_t(* code)(struct $$3c$Int$3e$$3d$$3e$Int*, int32_t);
  moonbit_string_t $0;
  struct $$moonbitlang$core$builtin$Logger$static_method_table* $1_0;
  void* $1_1;

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

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$ {
  int64_t(* code)(struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$*);

};

struct moonbit_result_0 {
  int tag;
  union { struct $StringView ok; void* err;  } data;

};

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$371,
  struct $$moonbitlang$core$builtin$Logger logger$372
);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$357,
  struct $$moonbitlang$core$builtin$Logger logger$370
);

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$355);

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$Array$$output$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$354,
  struct $$moonbitlang$core$builtin$Logger logger$353
);

struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int* $$moonbitlang$core$builtin$Array$$iter$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$352
);

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$Array$$iterator$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$351
);

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$ArrayView$$iterator$0(
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ self$349
);

int64_t $ArrayView$$iterator$7c$Int$7c$$$2a$p$fn$4(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* _env$1009
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$String$$to_string(
  moonbit_string_t self$347
);

int32_t $$moonbitlang$core$builtin$Show$$Int$$output(
  int32_t self$346,
  struct $$moonbitlang$core$builtin$Logger logger$345
);

int32_t $$moonbitlang$core$builtin$Array$$push$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$342,
  int32_t value$344
);

int32_t $$moonbitlang$core$builtin$Array$$realloc$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$340
);

int32_t $$moonbitlang$core$builtin$Array$$resize_buffer$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$336,
  int32_t new_capacity$334
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$331,
  struct $StringView str$332
);

int64_t $String$$offset_of_nth_char$inner(
  moonbit_string_t self$328,
  int32_t i$329,
  int32_t start_offset$330,
  int64_t end_offset$326
);

int64_t $String$$offset_of_nth_char_forward(
  moonbit_string_t self$323,
  int32_t n$321,
  int32_t start_offset$317,
  int32_t end_offset$318
);

int64_t $String$$offset_of_nth_char_backward(
  moonbit_string_t self$315,
  int32_t n$313,
  int32_t start_offset$312,
  int32_t end_offset$311
);

int32_t $String$$char_length_ge$inner(
  moonbit_string_t self$301,
  int32_t len$304,
  int32_t start_offset$308,
  int64_t end_offset$299
);

int32_t $$moonbitlang$core$builtin$ArrayView$$length$0(
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ self$297
);

struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int* $$moonbitlang$core$builtin$Iterator$$iter$0(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* self$292
);

int32_t $Iterator$$iter$7c$Int$7c$$fn$3(
  struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int* _env$953,
  struct $$3c$Int$3e$$3d$$3e$Int* yield_$290
);

int64_t $$moonbitlang$core$builtin$Iterator$$next$0(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* self$289
);

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$Iterator$$new$0(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* f$287
);

moonbit_string_t $Int$$to_string$inner(int32_t self$271, int32_t radix$270);

int32_t $moonbitlang$core$builtin$radix_count32(
  uint32_t value$264,
  int32_t radix$267
);

int32_t $moonbitlang$core$builtin$hex_count32(uint32_t value$262);

int32_t $moonbitlang$core$builtin$dec_count32(uint32_t value$261);

int32_t $moonbitlang$core$builtin$int_to_string_dec(
  uint16_t* buffer$251,
  uint32_t num$239,
  int32_t digit_start$242,
  int32_t total_len$241
);

int32_t $moonbitlang$core$builtin$int_to_string_generic(
  uint16_t* buffer$233,
  uint32_t num$227,
  int32_t digit_start$225,
  int32_t total_len$224,
  int32_t radix$229
);

int32_t $moonbitlang$core$builtin$int_to_string_hex(
  uint16_t* buffer$220,
  uint32_t num$216,
  int32_t digit_start$214,
  int32_t total_len$213
);

int32_t $$moonbitlang$core$builtin$Logger$$write_iter$inner$0(
  struct $$moonbitlang$core$builtin$Logger self$203,
  struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int* iter$206,
  moonbit_string_t prefix$204,
  moonbit_string_t suffix$211,
  moonbit_string_t sep$208,
  int32_t trailing$205
);

int32_t $Logger$$write_iter$inner$7c$Int$7c$$fn$2(
  struct $$3c$Int$3e$$3d$$3e$Int* _env$845,
  int32_t x$210
);

int32_t $Logger$$write_iter$inner$7c$Int$7c$$fn$1(
  struct $$3c$Int$3e$$3d$$3e$Int* _env$841,
  int32_t x$207
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(
  moonbit_string_t self$202
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  int32_t self$200
);

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$198
);

int32_t $StringView$$start_offset(struct $StringView self$196);

moonbit_string_t $StringView$$data(struct $StringView self$195);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$189,
  moonbit_string_t value$192,
  int32_t start$193,
  int32_t len$194
);

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$182,
  int32_t start$188,
  int64_t end$184
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$179,
  moonbit_string_t str$180
);

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$171,
  int32_t bytes_offset$166,
  moonbit_string_t str$173,
  int32_t str_offset$169,
  int32_t length$167
);

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$133
);

struct $$3c$StringView$2a$StringView$3e$* $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
  struct $StringView view$129
);

struct $StringView $StringView$$view$inner(
  struct $StringView self$126,
  int32_t start_offset$127,
  int64_t end_offset$124
);

int64_t $StringView$$rev_find(
  struct $StringView self$122,
  struct $StringView str$121
);

int64_t $moonbitlang$core$builtin$brute_force_rev_find(
  struct $StringView haystack$112,
  struct $StringView needle$114
);

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_rev_find(
  struct $StringView haystack$101,
  struct $StringView needle$103
);

int64_t $StringView$$find(
  struct $StringView self$99,
  struct $StringView str$98
);

int64_t $moonbitlang$core$builtin$brute_force_find(
  struct $StringView haystack$88,
  struct $StringView needle$90
);

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_find(
  struct $StringView haystack$74,
  struct $StringView needle$76
);

int32_t $StringView$$unsafe_charcode_at(
  struct $StringView self$70,
  int32_t index$71
);

int32_t $StringView$$length(struct $StringView self$69);

int32_t* $$moonbitlang$core$builtin$Array$$buffer$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$68
);

int32_t $Int$$is_trailing_surrogate(int32_t self$67);

int32_t $Int$$is_leading_surrogate(int32_t self$66);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$63,
  int32_t ch$65
);

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$58,
  int32_t required$59
);

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default();

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$52,
  int32_t offset$53,
  int32_t value$51
);

int32_t $UInt$$to_byte(uint32_t self$49);

uint32_t $Char$$to_uint(int32_t self$48);

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$47
);

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$42,
  int32_t offset$46,
  int64_t length$44
);

#define $moonbitlang$core$builtin$unsafe_sub_string moonbit_unsafe_bytes_sub_string

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$39
);

int32_t $$moonbitlang$core$builtin$UninitializedArray$$unsafe_blit$0(
  int32_t* dst$33,
  int32_t dst_offset$34,
  int32_t* src$35,
  int32_t src_offset$36,
  int32_t len$37
);

int32_t $FixedArray$$unsafe_blit$1(
  int32_t* dst$24,
  int32_t dst_offset$26,
  int32_t* src$25,
  int32_t src_offset$27,
  int32_t len$29
);

int32_t $FixedArray$$unsafe_blit$0(
  moonbit_bytes_t dst$15,
  int32_t dst_offset$17,
  moonbit_bytes_t src$16,
  int32_t src_offset$18,
  int32_t len$20
);

int64_t $moonbitlang$core$builtin$abort$3(
  moonbit_string_t string$13,
  moonbit_string_t loc$14
);

struct $StringView $moonbitlang$core$builtin$abort$2(
  moonbit_string_t string$11,
  moonbit_string_t loc$12
);

int32_t $moonbitlang$core$builtin$abort$1(
  moonbit_string_t string$9,
  moonbit_string_t loc$10
);

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$7,
  moonbit_string_t loc$8
);

int32_t $$moonbitlang$core$builtin$Logger$$write_object$0(
  struct $$moonbitlang$core$builtin$Logger self$6,
  int32_t obj$5
);

int64_t $moonbitlang$core$abort$abort$3(moonbit_string_t msg$4);

struct $StringView $moonbitlang$core$abort$abort$2(moonbit_string_t msg$3);

int32_t $moonbitlang$core$abort$abort$1(moonbit_string_t msg$2);

int32_t $moonbitlang$core$abort$abort$0(moonbit_string_t msg$1);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$541,
  int32_t _param$540
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$538,
  struct $StringView _param$537
);

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$535,
  moonbit_string_t _param$532,
  int32_t _param$533,
  int32_t _param$534
);

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$530,
  moonbit_string_t _param$529
);

struct { int32_t rc; uint32_t meta; uint16_t const data[3];
} const moonbit_string_literal_5 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 2),
    44, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[50];
} const moonbit_string_literal_9 =
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
} const moonbit_string_literal_8 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 22),
    105, 110, 118, 97, 108, 105, 100, 32, 115, 117, 114, 114, 111, 103,
    97, 116, 101, 32, 112, 97, 105, 114, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[7];
} const moonbit_string_literal_18 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 6),
    10, 32, 32, 97, 116, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[49];
} const moonbit_string_literal_17 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 48),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 98, 121,
    116, 101, 115, 46, 109, 98, 116, 58, 50, 57, 48, 58, 53, 45, 50,
    57, 48, 58, 51, 49, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[23];
} const moonbit_string_literal_14 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 22),
    73, 110, 118, 97, 108, 105, 100, 32, 105, 110, 100, 101, 120, 32,
    102, 111, 114, 32, 86, 105, 101, 119, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[31];
} const moonbit_string_literal_10 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 30),
    114, 97, 100, 105, 120, 32, 109, 117, 115, 116, 32, 98, 101, 32,
    98, 101, 116, 119, 101, 101, 110, 32, 50, 32, 97, 110, 100, 32, 51,
    54, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[17];
} const moonbit_string_literal_20 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 16),
    79, 114, 105, 103, 105, 110, 97, 108, 32, 97, 114, 114, 97, 121,
    58, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[16];
} const moonbit_string_literal_22 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 15),
    68, 111, 117, 98, 108, 101, 100, 32, 97, 114, 114, 97, 121, 58, 32,
    0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_12 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 48, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[18];
} const moonbit_string_literal_16 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 17),
    67, 104, 97, 114, 32, 111, 117, 116, 32, 111, 102, 32, 114, 97, 110,
    103, 101, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[24];
} const moonbit_string_literal_21 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 23),
    83, 117, 109, 32, 111, 102, 32, 97, 114, 114, 97, 121, 32, 101, 108,
    101, 109, 101, 110, 116, 115, 58, 32, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_4 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 93, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[54];
} const moonbit_string_literal_15 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 53),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 115, 116,
    114, 105, 110, 103, 118, 105, 101, 119, 46, 109, 98, 116, 58, 49,
    49, 49, 58, 53, 45, 49, 49, 49, 58, 51, 54, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[53];
} const moonbit_string_literal_11 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 52),
    64, 109, 111, 111, 110, 98, 105, 116, 108, 97, 110, 103, 47, 99,
    111, 114, 101, 47, 98, 117, 105, 108, 116, 105, 110, 58, 116, 111,
    95, 115, 116, 114, 105, 110, 103, 46, 109, 98, 116, 58, 50, 51, 57,
    58, 53, 45, 50, 51, 57, 58, 52, 52, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_3 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 91, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[37];
} const moonbit_string_literal_13 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 36),
    48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 100, 101, 102,
    103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115,
    116, 117, 118, 119, 120, 121, 122, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[20];
} const moonbit_string_literal_6 =
  {
    -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 19),
    73, 110, 118, 97, 108, 105, 100, 32, 115, 116, 97, 114, 116, 32,
    105, 110, 100, 101, 120, 0
  };

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_19 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 10, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[2];
} const moonbit_string_literal_0 =
  { -1, Moonbit_make_array_header(moonbit_BLOCK_KIND_VAL_ARRAY, 1, 1), 58, 0};

struct { int32_t rc; uint32_t meta; uint16_t const data[50];
} const moonbit_string_literal_7 =
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

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_find$constr$72;

int64_t $moonbitlang$core$builtin$brute_force_find$constr$86;

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
  moonbit_string_t self$371,
  struct $$moonbitlang$core$builtin$Logger logger$372
) {
  moonbit_string_t _tmp$1048 = self$371;
  struct $$moonbitlang$core$builtin$SourceLocRepr* _tmp$1047 =
    $$moonbitlang$core$builtin$SourceLocRepr$$parse(_tmp$1048);
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
    _tmp$1047, logger$372
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output(
  struct $$moonbitlang$core$builtin$SourceLocRepr* self$357,
  struct $$moonbitlang$core$builtin$Logger logger$370
) {
  struct $StringView _field$1057 =
    (struct $StringView){self$357->$0_1, self$357->$0_2, self$357->$0_0};
  struct $StringView pkg$356 = _field$1057;
  int32_t _tmp$1046 =
    Moonbit_array_length($moonbitlang$core$builtin$output$$2a$bind$7c$8193);
  struct $StringView _tmp$1045;
  int64_t _bind$358;
  struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$* _bind$359;
  struct $StringView _field$1056;
  struct $StringView _module_name$366;
  void* _field$1055;
  int32_t _cnt$1138;
  void* _package_name$367;
  struct $StringView _field$1053;
  struct $StringView filename$1028;
  struct $StringView _field$1052;
  struct $StringView start_line$1029;
  struct $StringView _field$1051;
  struct $StringView start_column$1030;
  struct $StringView _field$1050;
  struct $StringView end_line$1031;
  struct $StringView _field$1049;
  int32_t _cnt$1142;
  struct $StringView end_column$1032;
  struct $$moonbitlang$core$builtin$Logger _bind$1027;
  moonbit_incref($moonbitlang$core$builtin$output$$2a$bind$7c$8193);
  _tmp$1045
  = (struct $StringView){
    0, _tmp$1046, $moonbitlang$core$builtin$output$$2a$bind$7c$8193
  };
  moonbit_incref(pkg$356.$0);
  moonbit_incref(pkg$356.$0);
  _bind$358 = $StringView$$find(pkg$356, _tmp$1045);
  if (_bind$358 == 4294967296ll) {
    void* None$1033 =
      (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
    _bind$359
    = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
        sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
      );
    Moonbit_object_header(_bind$359)->meta
    = Moonbit_make_regular_object_header(
      offsetof(
        struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
      )
      >> 2,
        2,
        0
    );
    _bind$359->$0_0 = pkg$356.$0;
    _bind$359->$0_1 = pkg$356.$1;
    _bind$359->$0_2 = pkg$356.$2;
    _bind$359->$1 = None$1033;
  } else {
    int64_t _Some$360 = _bind$358;
    int32_t _first_slash$361 = (int32_t)_Some$360;
    int32_t _tmp$1044 = _first_slash$361 + 1;
    struct $StringView _tmp$1041;
    int32_t _tmp$1043;
    struct $StringView _tmp$1042;
    int64_t _bind$362;
    moonbit_incref(pkg$356.$0);
    _tmp$1041 = $StringView$$view$inner(pkg$356, _tmp$1044, 4294967296ll);
    _tmp$1043
    = Moonbit_array_length(
      $moonbitlang$core$builtin$output$$2a$bind$7c$8187
    );
    moonbit_incref($moonbitlang$core$builtin$output$$2a$bind$7c$8187);
    _tmp$1042
    = (struct $StringView){
      0, _tmp$1043, $moonbitlang$core$builtin$output$$2a$bind$7c$8187
    };
    _bind$362 = $StringView$$find(_tmp$1041, _tmp$1042);
    if (_bind$362 == 4294967296ll) {
      void* None$1034 =
        (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _bind$359
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$359)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$359->$0_0 = pkg$356.$0;
      _bind$359->$0_1 = pkg$356.$1;
      _bind$359->$0_2 = pkg$356.$2;
      _bind$359->$1 = None$1034;
    } else {
      int64_t _Some$363 = _bind$362;
      int32_t _second_slash$364 = (int32_t)_Some$363;
      int32_t _tmp$1040 = _first_slash$361 + 1;
      int32_t module_name_end$365 = _tmp$1040 + _second_slash$364;
      int64_t _tmp$1039 = (int64_t)module_name_end$365;
      struct $StringView _tmp$1035;
      int32_t _tmp$1038;
      struct $StringView _tmp$1037;
      void* Some$1036;
      moonbit_incref(pkg$356.$0);
      _tmp$1035 = $StringView$$view$inner(pkg$356, 0, _tmp$1039);
      _tmp$1038 = module_name_end$365 + 1;
      _tmp$1037 = $StringView$$view$inner(pkg$356, _tmp$1038, 4294967296ll);
      Some$1036
      = (void*)moonbit_malloc(sizeof(struct $Option$3c$StringView$3e$$Some));
      Moonbit_object_header(Some$1036)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $Option$3c$StringView$3e$$Some, $0_0) >> 2, 1, 1
      );
      ((struct $Option$3c$StringView$3e$$Some*)Some$1036)->$0_0
      = _tmp$1037.$0;
      ((struct $Option$3c$StringView$3e$$Some*)Some$1036)->$0_1
      = _tmp$1037.$1;
      ((struct $Option$3c$StringView$3e$$Some*)Some$1036)->$0_2
      = _tmp$1037.$2;
      _bind$359
      = (struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$)
        );
      Moonbit_object_header(_bind$359)->meta
      = Moonbit_make_regular_object_header(
        offsetof(
          struct $$3c$StringView$2a$Option$3c$StringView$3e$$3e$, $0_0
        )
        >> 2,
          2,
          0
      );
      _bind$359->$0_0 = _tmp$1035.$0;
      _bind$359->$0_1 = _tmp$1035.$1;
      _bind$359->$0_2 = _tmp$1035.$2;
      _bind$359->$1 = Some$1036;
    }
  }
  _field$1056
  = (struct $StringView){
    _bind$359->$0_1, _bind$359->$0_2, _bind$359->$0_0
  };
  _module_name$366 = _field$1056;
  _field$1055 = _bind$359->$1;
  _cnt$1138 = Moonbit_object_header(_bind$359)->rc;
  if (_cnt$1138 > 1) {
    int32_t _new_cnt$1139;
    moonbit_incref(_field$1055);
    moonbit_incref(_module_name$366.$0);
    _new_cnt$1139 = _cnt$1138 - 1;
    Moonbit_object_header(_bind$359)->rc = _new_cnt$1139;
  } else if (_cnt$1138 == 1) {
    moonbit_free(_bind$359);
  }
  _package_name$367 = _field$1055;
  switch (Moonbit_object_tag(_package_name$367)) {
    case 1: {
      struct $Option$3c$StringView$3e$$Some* _Some$368 =
        (struct $Option$3c$StringView$3e$$Some*)_package_name$367;
      struct $StringView _field$1054 =
        (struct $StringView){
          _Some$368->$0_1, _Some$368->$0_2, _Some$368->$0_0
        };
      int32_t _cnt$1140 = Moonbit_object_header(_Some$368)->rc;
      struct $StringView _pkg_name$369;
      struct $$moonbitlang$core$builtin$Logger _bind$1026;
      if (_cnt$1140 > 1) {
        int32_t _new_cnt$1141;
        moonbit_incref(_field$1054.$0);
        _new_cnt$1141 = _cnt$1140 - 1;
        Moonbit_object_header(_Some$368)->rc = _new_cnt$1141;
      } else if (_cnt$1140 == 1) {
        moonbit_free(_Some$368);
      }
      _pkg_name$369 = _field$1054;
      if (logger$370.$1) {
        moonbit_incref(logger$370.$1);
      }
      logger$370.$0->$method_2(logger$370.$1, _pkg_name$369);
      _bind$1026 = logger$370;
      if (_bind$1026.$1) {
        moonbit_incref(_bind$1026.$1);
      }
      _bind$1026.$0->$method_3(_bind$1026.$1, 47);
      break;
    }
    default: {
      moonbit_decref(_package_name$367);
      break;
    }
  }
  _field$1053
  = (struct $StringView){
    self$357->$1_1, self$357->$1_2, self$357->$1_0
  };
  filename$1028 = _field$1053;
  moonbit_incref(filename$1028.$0);
  if (logger$370.$1) {
    moonbit_incref(logger$370.$1);
  }
  logger$370.$0->$method_2(logger$370.$1, filename$1028);
  if (logger$370.$1) {
    moonbit_incref(logger$370.$1);
  }
  logger$370.$0->$method_3(logger$370.$1, 58);
  _field$1052
  = (struct $StringView){
    self$357->$2_1, self$357->$2_2, self$357->$2_0
  };
  start_line$1029 = _field$1052;
  moonbit_incref(start_line$1029.$0);
  if (logger$370.$1) {
    moonbit_incref(logger$370.$1);
  }
  logger$370.$0->$method_2(logger$370.$1, start_line$1029);
  if (logger$370.$1) {
    moonbit_incref(logger$370.$1);
  }
  logger$370.$0->$method_3(logger$370.$1, 58);
  _field$1051
  = (struct $StringView){
    self$357->$3_1, self$357->$3_2, self$357->$3_0
  };
  start_column$1030 = _field$1051;
  moonbit_incref(start_column$1030.$0);
  if (logger$370.$1) {
    moonbit_incref(logger$370.$1);
  }
  logger$370.$0->$method_2(logger$370.$1, start_column$1030);
  if (logger$370.$1) {
    moonbit_incref(logger$370.$1);
  }
  logger$370.$0->$method_3(logger$370.$1, 45);
  _field$1050
  = (struct $StringView){
    self$357->$4_1, self$357->$4_2, self$357->$4_0
  };
  end_line$1031 = _field$1050;
  moonbit_incref(end_line$1031.$0);
  if (logger$370.$1) {
    moonbit_incref(logger$370.$1);
  }
  logger$370.$0->$method_2(logger$370.$1, end_line$1031);
  if (logger$370.$1) {
    moonbit_incref(logger$370.$1);
  }
  logger$370.$0->$method_3(logger$370.$1, 58);
  _field$1049
  = (struct $StringView){
    self$357->$5_1, self$357->$5_2, self$357->$5_0
  };
  _cnt$1142 = Moonbit_object_header(self$357)->rc;
  if (_cnt$1142 > 1) {
    int32_t _new_cnt$1148;
    moonbit_incref(_field$1049.$0);
    _new_cnt$1148 = _cnt$1142 - 1;
    Moonbit_object_header(self$357)->rc = _new_cnt$1148;
  } else if (_cnt$1142 == 1) {
    struct $StringView _field$1147 =
      (struct $StringView){self$357->$4_1, self$357->$4_2, self$357->$4_0};
    struct $StringView _field$1146;
    struct $StringView _field$1145;
    struct $StringView _field$1144;
    struct $StringView _field$1143;
    moonbit_decref(_field$1147.$0);
    _field$1146
    = (struct $StringView){
      self$357->$3_1, self$357->$3_2, self$357->$3_0
    };
    moonbit_decref(_field$1146.$0);
    _field$1145
    = (struct $StringView){
      self$357->$2_1, self$357->$2_2, self$357->$2_0
    };
    moonbit_decref(_field$1145.$0);
    _field$1144
    = (struct $StringView){
      self$357->$1_1, self$357->$1_2, self$357->$1_0
    };
    moonbit_decref(_field$1144.$0);
    _field$1143
    = (struct $StringView){
      self$357->$0_1, self$357->$0_2, self$357->$0_0
    };
    moonbit_decref(_field$1143.$0);
    moonbit_free(self$357);
  }
  end_column$1032 = _field$1049;
  if (logger$370.$1) {
    moonbit_incref(logger$370.$1);
  }
  logger$370.$0->$method_2(logger$370.$1, end_column$1032);
  if (logger$370.$1) {
    moonbit_incref(logger$370.$1);
  }
  logger$370.$0->$method_3(logger$370.$1, 64);
  _bind$1027 = logger$370;
  _bind$1027.$0->$method_2(_bind$1027.$1, _module_name$366);
  return 0;
}

int32_t $moonbitlang$core$builtin$println$0(moonbit_string_t input$355) {
  moonbit_println(input$355);
  moonbit_decref(input$355);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$Array$$output$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$354,
  struct $$moonbitlang$core$builtin$Logger logger$353
) {
  struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int* _tmp$1025 =
    $$moonbitlang$core$builtin$Array$$iter$0(self$354);
  $$moonbitlang$core$builtin$Logger$$write_iter$inner$0(
    logger$353,
      _tmp$1025,
      (moonbit_string_t)moonbit_string_literal_3.data,
      (moonbit_string_t)moonbit_string_literal_4.data,
      (moonbit_string_t)moonbit_string_literal_5.data,
      0
  );
  return 0;
}

struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int* $$moonbitlang$core$builtin$Array$$iter$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$352
) {
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* _tmp$1024 =
    $$moonbitlang$core$builtin$Array$$iterator$0(self$352);
  return $$moonbitlang$core$builtin$Iterator$$iter$0(_tmp$1024);
}

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$Array$$iterator$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$351
) {
  int32_t* _field$1059 = self$351->$0;
  int32_t* buf$1022 = _field$1059;
  int32_t _field$1058 = self$351->$1;
  int32_t _cnt$1149 = Moonbit_object_header(self$351)->rc;
  int32_t len$1023;
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ _tmp$1021;
  if (_cnt$1149 > 1) {
    int32_t _new_cnt$1150;
    moonbit_incref(buf$1022);
    _new_cnt$1150 = _cnt$1149 - 1;
    Moonbit_object_header(self$351)->rc = _new_cnt$1150;
  } else if (_cnt$1149 == 1) {
    moonbit_free(self$351);
  }
  len$1023 = _field$1058;
  _tmp$1021
  = (struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$){
    0, len$1023, buf$1022
  };
  return $$moonbitlang$core$builtin$ArrayView$$iterator$0(_tmp$1021);
}

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$ArrayView$$iterator$0(
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ self$349
) {
  struct $Ref$3c$Int$3e$* i$348 =
    (struct $Ref$3c$Int$3e$*)moonbit_malloc(sizeof(struct $Ref$3c$Int$3e$));
  struct $ArrayView$$iterator$7c$Int$7c$$$2a$p$fn$4$2d$cap* _closure$1165;
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* _p$520;
  Moonbit_object_header(i$348)->meta
  = Moonbit_make_regular_object_header(
    sizeof(struct $Ref$3c$Int$3e$) >> 2, 0, 0
  );
  i$348->$0 = 0;
  _closure$1165
  = (struct $ArrayView$$iterator$7c$Int$7c$$$2a$p$fn$4$2d$cap*)moonbit_malloc(
      sizeof(struct $ArrayView$$iterator$7c$Int$7c$$$2a$p$fn$4$2d$cap)
    );
  Moonbit_object_header(_closure$1165)->meta
  = Moonbit_make_regular_object_header(
    offsetof(
      struct $ArrayView$$iterator$7c$Int$7c$$$2a$p$fn$4$2d$cap, $0_0
    )
    >> 2,
      2,
      0
  );
  _closure$1165->code = &$ArrayView$$iterator$7c$Int$7c$$$2a$p$fn$4;
  _closure$1165->$0_0 = self$349.$0;
  _closure$1165->$0_1 = self$349.$1;
  _closure$1165->$0_2 = self$349.$2;
  _closure$1165->$1 = i$348;
  _p$520 = (struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$*)_closure$1165;
  return _p$520;
}

int64_t $ArrayView$$iterator$7c$Int$7c$$$2a$p$fn$4(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* _env$1009
) {
  struct $ArrayView$$iterator$7c$Int$7c$$$2a$p$fn$4$2d$cap* _casted_env$1010 =
    (struct $ArrayView$$iterator$7c$Int$7c$$$2a$p$fn$4$2d$cap*)_env$1009;
  struct $Ref$3c$Int$3e$* _field$1064 = _casted_env$1010->$1;
  struct $Ref$3c$Int$3e$* i$348 = _field$1064;
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ _field$1063 =
    (struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$){
      _casted_env$1010->$0_1, _casted_env$1010->$0_2, _casted_env$1010->$0_0
    };
  int32_t _cnt$1151 = Moonbit_object_header(_casted_env$1010)->rc;
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ self$349;
  int32_t val$1011;
  int32_t end$1013;
  int32_t start$1014;
  int32_t _tmp$1012;
  if (_cnt$1151 > 1) {
    int32_t _new_cnt$1152;
    moonbit_incref(i$348);
    moonbit_incref(_field$1063.$0);
    _new_cnt$1152 = _cnt$1151 - 1;
    Moonbit_object_header(_casted_env$1010)->rc = _new_cnt$1152;
  } else if (_cnt$1151 == 1) {
    moonbit_free(_casted_env$1010);
  }
  self$349 = _field$1063;
  val$1011 = i$348->$0;
  end$1013 = self$349.$2;
  start$1014 = self$349.$1;
  _tmp$1012 = end$1013 - start$1014;
  if (val$1011 < _tmp$1012) {
    int32_t* _field$1062 = self$349.$0;
    int32_t* buf$1017 = _field$1062;
    int32_t _field$1061 = self$349.$1;
    int32_t start$1019 = _field$1061;
    int32_t val$1020 = i$348->$0;
    int32_t _tmp$1018 = start$1019 + val$1020;
    int32_t _tmp$1060 = (int32_t)buf$1017[_tmp$1018];
    int32_t elem$350;
    int32_t val$1016;
    int32_t _tmp$1015;
    moonbit_decref(buf$1017);
    elem$350 = _tmp$1060;
    val$1016 = i$348->$0;
    _tmp$1015 = val$1016 + 1;
    i$348->$0 = _tmp$1015;
    moonbit_decref(i$348);
    return (int64_t)elem$350;
  } else {
    moonbit_decref(self$349.$0);
    moonbit_decref(i$348);
    return 4294967296ll;
  }
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$String$$to_string(
  moonbit_string_t self$347
) {
  return self$347;
}

int32_t $$moonbitlang$core$builtin$Show$$Int$$output(
  int32_t self$346,
  struct $$moonbitlang$core$builtin$Logger logger$345
) {
  moonbit_string_t _tmp$1008 = $Int$$to_string$inner(self$346, 10);
  logger$345.$0->$method_0(logger$345.$1, _tmp$1008);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Array$$push$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$342,
  int32_t value$344
) {
  int32_t len$1003 = self$342->$1;
  int32_t* _field$1067 = self$342->$0;
  int32_t* buf$1005 = _field$1067;
  int32_t _tmp$1066 = Moonbit_array_length(buf$1005);
  int32_t _tmp$1004 = _tmp$1066;
  int32_t length$343;
  int32_t* _field$1065;
  int32_t* buf$1006;
  int32_t _tmp$1007;
  if (len$1003 == _tmp$1004) {
    moonbit_incref(self$342);
    $$moonbitlang$core$builtin$Array$$realloc$0(self$342);
  }
  length$343 = self$342->$1;
  _field$1065 = self$342->$0;
  buf$1006 = _field$1065;
  buf$1006[length$343] = value$344;
  _tmp$1007 = length$343 + 1;
  self$342->$1 = _tmp$1007;
  moonbit_decref(self$342);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Array$$realloc$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$340
) {
  int32_t old_cap$339 = self$340->$1;
  int32_t new_cap$341;
  if (old_cap$339 == 0) {
    new_cap$341 = 8;
  } else {
    new_cap$341 = old_cap$339 * 2;
  }
  $$moonbitlang$core$builtin$Array$$resize_buffer$0(self$340, new_cap$341);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Array$$resize_buffer$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$336,
  int32_t new_capacity$334
) {
  int32_t* new_buf$333 =
    (int32_t*)moonbit_make_int32_array_raw(new_capacity$334);
  int32_t* _field$1069 = self$336->$0;
  int32_t* old_buf$335 = _field$1069;
  int32_t old_cap$337 = Moonbit_array_length(old_buf$335);
  int32_t copy_len$338;
  int32_t* _old$1068;
  if (old_cap$337 < new_capacity$334) {
    copy_len$338 = old_cap$337;
  } else {
    copy_len$338 = new_capacity$334;
  }
  moonbit_incref(old_buf$335);
  moonbit_incref(new_buf$333);
  $$moonbitlang$core$builtin$UninitializedArray$$unsafe_blit$0(
    new_buf$333, 0, old_buf$335, 0, copy_len$338
  );
  _old$1068 = self$336->$0;
  moonbit_decref(_old$1068);
  self$336->$0 = new_buf$333;
  moonbit_decref(self$336);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
  struct $$moonbitlang$core$builtin$StringBuilder* self$331,
  struct $StringView str$332
) {
  int32_t len$985 = self$331->$1;
  int32_t end$988 = str$332.$2;
  int32_t start$989 = str$332.$1;
  int32_t _tmp$987 = end$988 - start$989;
  int32_t _tmp$986 = _tmp$987 * 2;
  int32_t _tmp$984 = len$985 + _tmp$986;
  moonbit_bytes_t _field$1072;
  moonbit_bytes_t data$990;
  int32_t len$991;
  moonbit_string_t _field$1071;
  moonbit_string_t str$992;
  int32_t start$993;
  int32_t end$995;
  int32_t start$996;
  int32_t _tmp$994;
  int32_t len$998;
  int32_t end$1001;
  int32_t _field$1070;
  int32_t start$1002;
  int32_t _tmp$1000;
  int32_t _tmp$999;
  int32_t _tmp$997;
  moonbit_incref(self$331);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$331, _tmp$984
  );
  _field$1072 = self$331->$0;
  data$990 = _field$1072;
  len$991 = self$331->$1;
  _field$1071 = str$332.$0;
  str$992 = _field$1071;
  start$993 = str$332.$1;
  end$995 = str$332.$2;
  start$996 = str$332.$1;
  _tmp$994 = end$995 - start$996;
  moonbit_incref(str$992);
  moonbit_incref(data$990);
  $FixedArray$$blit_from_string(
    data$990, len$991, str$992, start$993, _tmp$994
  );
  len$998 = self$331->$1;
  end$1001 = str$332.$2;
  _field$1070 = str$332.$1;
  moonbit_decref(str$332.$0);
  start$1002 = _field$1070;
  _tmp$1000 = end$1001 - start$1002;
  _tmp$999 = _tmp$1000 * 2;
  _tmp$997 = len$998 + _tmp$999;
  self$331->$1 = _tmp$997;
  moonbit_decref(self$331);
  return 0;
}

int64_t $String$$offset_of_nth_char$inner(
  moonbit_string_t self$328,
  int32_t i$329,
  int32_t start_offset$330,
  int64_t end_offset$326
) {
  int32_t end_offset$325;
  if (end_offset$326 == 4294967296ll) {
    end_offset$325 = Moonbit_array_length(self$328);
  } else {
    int64_t _Some$327 = end_offset$326;
    end_offset$325 = (int32_t)_Some$327;
  }
  if (i$329 >= 0) {
    return $String$$offset_of_nth_char_forward(
             self$328, i$329, start_offset$330, end_offset$325
           );
  } else {
    int32_t _tmp$983 = -i$329;
    return $String$$offset_of_nth_char_backward(
             self$328, _tmp$983, start_offset$330, end_offset$325
           );
  }
}

int64_t $String$$offset_of_nth_char_forward(
  moonbit_string_t self$323,
  int32_t n$321,
  int32_t start_offset$317,
  int32_t end_offset$318
) {
  if (start_offset$317 >= 0 && start_offset$317 <= end_offset$318) {
    int32_t utf16_offset$319 = start_offset$317;
    int32_t char_count$320 = 0;
    int32_t _tmp$981;
    int32_t _if_result$1168;
    while (1) {
      int32_t _tmp$975 = utf16_offset$319;
      int32_t _if_result$1167;
      if (_tmp$975 < end_offset$318) {
        int32_t _tmp$974 = char_count$320;
        _if_result$1167 = _tmp$974 < n$321;
      } else {
        _if_result$1167 = 0;
      }
      if (_if_result$1167) {
        int32_t _tmp$979 = utf16_offset$319;
        int32_t c$322 = self$323[_tmp$979];
        int32_t _tmp$978;
        if (55296 <= c$322 && c$322 <= 56319) {
          int32_t _tmp$976 = utf16_offset$319;
          utf16_offset$319 = _tmp$976 + 2;
        } else {
          int32_t _tmp$977 = utf16_offset$319;
          utf16_offset$319 = _tmp$977 + 1;
        }
        _tmp$978 = char_count$320;
        char_count$320 = _tmp$978 + 1;
        continue;
      } else {
        moonbit_decref(self$323);
      }
      break;
    }
    _tmp$981 = char_count$320;
    if (_tmp$981 < n$321) {
      _if_result$1168 = 1;
    } else {
      int32_t _tmp$980 = utf16_offset$319;
      _if_result$1168 = _tmp$980 >= end_offset$318;
    }
    if (_if_result$1168) {
      return 4294967296ll;
    } else {
      int32_t _tmp$982 = utf16_offset$319;
      return (int64_t)_tmp$982;
    }
  } else {
    moonbit_decref(self$323);
    return $moonbitlang$core$builtin$abort$3(
             (moonbit_string_t)moonbit_string_literal_6.data,
               (moonbit_string_t)moonbit_string_literal_7.data
           );
  }
}

int64_t $String$$offset_of_nth_char_backward(
  moonbit_string_t self$315,
  int32_t n$313,
  int32_t start_offset$312,
  int32_t end_offset$311
) {
  int32_t char_count$309 = 0;
  int32_t utf16_offset$310 = end_offset$311;
  int32_t _tmp$972;
  int32_t _if_result$1171;
  while (1) {
    int32_t _tmp$965 = utf16_offset$310;
    int32_t _tmp$964 = _tmp$965 - 1;
    int32_t _if_result$1170;
    if (_tmp$964 >= start_offset$312) {
      int32_t _tmp$963 = char_count$309;
      _if_result$1170 = _tmp$963 < n$313;
    } else {
      _if_result$1170 = 0;
    }
    if (_if_result$1170) {
      int32_t _tmp$970 = utf16_offset$310;
      int32_t _tmp$969 = _tmp$970 - 1;
      int32_t c$314 = self$315[_tmp$969];
      int32_t _tmp$968;
      if (56320 <= c$314 && c$314 <= 57343) {
        int32_t _tmp$966 = utf16_offset$310;
        utf16_offset$310 = _tmp$966 - 2;
      } else {
        int32_t _tmp$967 = utf16_offset$310;
        utf16_offset$310 = _tmp$967 - 1;
      }
      _tmp$968 = char_count$309;
      char_count$309 = _tmp$968 + 1;
      continue;
    } else {
      moonbit_decref(self$315);
    }
    break;
  }
  _tmp$972 = char_count$309;
  if (_tmp$972 < n$313) {
    _if_result$1171 = 1;
  } else {
    int32_t _tmp$971 = utf16_offset$310;
    _if_result$1171 = _tmp$971 < start_offset$312;
  }
  if (_if_result$1171) {
    return 4294967296ll;
  } else {
    int32_t _tmp$973 = utf16_offset$310;
    return (int64_t)_tmp$973;
  }
}

int32_t $String$$char_length_ge$inner(
  moonbit_string_t self$301,
  int32_t len$304,
  int32_t start_offset$308,
  int64_t end_offset$299
) {
  int32_t end_offset$298;
  int32_t index$302;
  int32_t count$303;
  if (end_offset$299 == 4294967296ll) {
    end_offset$298 = Moonbit_array_length(self$301);
  } else {
    int64_t _Some$300 = end_offset$299;
    end_offset$298 = (int32_t)_Some$300;
  }
  index$302 = start_offset$308;
  count$303 = 0;
  while (1) {
    if (index$302 < end_offset$298 && count$303 < len$304) {
      int32_t c1$305 = self$301[index$302];
      int32_t _if_result$1173;
      int32_t _tmp$961;
      int32_t _tmp$962;
      if (55296 <= c1$305 && c1$305 <= 56319) {
        int32_t _tmp$957 = index$302 + 1;
        _if_result$1173 = _tmp$957 < end_offset$298;
      } else {
        _if_result$1173 = 0;
      }
      if (_if_result$1173) {
        int32_t _tmp$960 = index$302 + 1;
        int32_t c2$306 = self$301[_tmp$960];
        if (56320 <= c2$306 && c2$306 <= 57343) {
          int32_t _tmp$958 = index$302 + 2;
          int32_t _tmp$959 = count$303 + 1;
          index$302 = _tmp$958;
          count$303 = _tmp$959;
          continue;
        } else {
          $moonbitlang$core$builtin$abort$1(
            (moonbit_string_t)moonbit_string_literal_8.data,
              (moonbit_string_t)moonbit_string_literal_9.data
          );
        }
      }
      _tmp$961 = index$302 + 1;
      _tmp$962 = count$303 + 1;
      index$302 = _tmp$961;
      count$303 = _tmp$962;
      continue;
    } else {
      moonbit_decref(self$301);
      return count$303 >= len$304;
    }
    break;
  }
}

int32_t $$moonbitlang$core$builtin$ArrayView$$length$0(
  struct $$moonbitlang$core$builtin$ArrayView$3c$Int$3e$ self$297
) {
  int32_t end$955 = self$297.$2;
  int32_t _field$1073 = self$297.$1;
  int32_t start$956;
  moonbit_decref(self$297.$0);
  start$956 = _field$1073;
  return end$955 - start$956;
}

struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int* $$moonbitlang$core$builtin$Iterator$$iter$0(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* self$292
) {
  struct $Iterator$$iter$7c$Int$7c$$fn$3$2d$cap* _closure$1174 =
    (struct $Iterator$$iter$7c$Int$7c$$fn$3$2d$cap*)moonbit_malloc(
      sizeof(struct $Iterator$$iter$7c$Int$7c$$fn$3$2d$cap)
    );
  Moonbit_object_header(_closure$1174)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $Iterator$$iter$7c$Int$7c$$fn$3$2d$cap, $0) >> 2, 1, 0
  );
  _closure$1174->code = &$Iterator$$iter$7c$Int$7c$$fn$3;
  _closure$1174->$0 = self$292;
  return (struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int*)_closure$1174;
}

int32_t $Iterator$$iter$7c$Int$7c$$fn$3(
  struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int* _env$953,
  struct $$3c$Int$3e$$3d$$3e$Int* yield_$290
) {
  struct $Iterator$$iter$7c$Int$7c$$fn$3$2d$cap* _casted_env$954 =
    (struct $Iterator$$iter$7c$Int$7c$$fn$3$2d$cap*)_env$953;
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* _field$1074 =
    _casted_env$954->$0;
  int32_t _cnt$1153 = Moonbit_object_header(_casted_env$954)->rc;
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* self$292;
  if (_cnt$1153 > 1) {
    int32_t _new_cnt$1154;
    moonbit_incref(_field$1074);
    _new_cnt$1154 = _cnt$1153 - 1;
    Moonbit_object_header(_casted_env$954)->rc = _new_cnt$1154;
  } else if (_cnt$1153 == 1) {
    moonbit_free(_casted_env$954);
  }
  self$292 = _field$1074;
  while (1) {
    int64_t _bind$291;
    moonbit_incref(self$292);
    _bind$291 = $$moonbitlang$core$builtin$Iterator$$next$0(self$292);
    if (_bind$291 == 4294967296ll) {
      moonbit_decref(self$292);
      moonbit_decref(yield_$290);
      return 1;
    } else {
      int64_t _Some$293 = _bind$291;
      int32_t _x$294 = (int32_t)_Some$293;
      int32_t _bind$295;
      moonbit_incref(yield_$290);
      _bind$295 = yield_$290->code(yield_$290, _x$294);
      switch (_bind$295) {
        case 1:
          break;
        default: {
          moonbit_decref(self$292);
          moonbit_decref(yield_$290);
          return 0;
          break;
        }
      }
      continue;
    }
    break;
  }
}

int64_t $$moonbitlang$core$builtin$Iterator$$next$0(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* self$289
) {
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* _func$288 = self$289;
  return _func$288->code(_func$288);
}

struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* $$moonbitlang$core$builtin$Iterator$$new$0(
  struct $$3c$$3e$$3d$$3e$Option$3c$Int$3e$* f$287
) {
  return f$287;
}

moonbit_string_t $Int$$to_string$inner(int32_t self$271, int32_t radix$270) {
  int32_t is_negative$272;
  uint32_t num$273;
  uint16_t* buffer$274;
  if (radix$270 < 2 || radix$270 > 36) {
    $moonbitlang$core$builtin$abort$1(
      (moonbit_string_t)moonbit_string_literal_10.data,
        (moonbit_string_t)moonbit_string_literal_11.data
    );
  }
  if (self$271 == 0) {
    return (moonbit_string_t)moonbit_string_literal_12.data;
  }
  is_negative$272 = self$271 < 0;
  if (is_negative$272) {
    int32_t _tmp$952 = -self$271;
    num$273 = *(uint32_t*)&_tmp$952;
  } else {
    num$273 = *(uint32_t*)&self$271;
  }
  switch (radix$270) {
    case 10: {
      int32_t digit_len$275 = $moonbitlang$core$builtin$dec_count32(num$273);
      int32_t _tmp$949;
      int32_t total_len$276;
      uint16_t* buffer$277;
      int32_t digit_start$278;
      if (is_negative$272) {
        _tmp$949 = 1;
      } else {
        _tmp$949 = 0;
      }
      total_len$276 = digit_len$275 + _tmp$949;
      buffer$277 = (uint16_t*)moonbit_make_string(total_len$276, 0);
      if (is_negative$272) {
        digit_start$278 = 1;
      } else {
        digit_start$278 = 0;
      }
      moonbit_incref(buffer$277);
      $moonbitlang$core$builtin$int_to_string_dec(
        buffer$277, num$273, digit_start$278, total_len$276
      );
      buffer$274 = buffer$277;
      break;
    }

    case 16: {
      int32_t digit_len$279 = $moonbitlang$core$builtin$hex_count32(num$273);
      int32_t _tmp$950;
      int32_t total_len$280;
      uint16_t* buffer$281;
      int32_t digit_start$282;
      if (is_negative$272) {
        _tmp$950 = 1;
      } else {
        _tmp$950 = 0;
      }
      total_len$280 = digit_len$279 + _tmp$950;
      buffer$281 = (uint16_t*)moonbit_make_string(total_len$280, 0);
      if (is_negative$272) {
        digit_start$282 = 1;
      } else {
        digit_start$282 = 0;
      }
      moonbit_incref(buffer$281);
      $moonbitlang$core$builtin$int_to_string_hex(
        buffer$281, num$273, digit_start$282, total_len$280
      );
      buffer$274 = buffer$281;
      break;
    }
    default: {
      int32_t digit_len$283 =
        $moonbitlang$core$builtin$radix_count32(num$273, radix$270);
      int32_t _tmp$951;
      int32_t total_len$284;
      uint16_t* buffer$285;
      int32_t digit_start$286;
      if (is_negative$272) {
        _tmp$951 = 1;
      } else {
        _tmp$951 = 0;
      }
      total_len$284 = digit_len$283 + _tmp$951;
      buffer$285 = (uint16_t*)moonbit_make_string(total_len$284, 0);
      if (is_negative$272) {
        digit_start$286 = 1;
      } else {
        digit_start$286 = 0;
      }
      moonbit_incref(buffer$285);
      $moonbitlang$core$builtin$int_to_string_generic(
        buffer$285, num$273, digit_start$286, total_len$284, radix$270
      );
      buffer$274 = buffer$285;
      break;
    }
  }
  if (is_negative$272) {
    buffer$274[0] = 45;
  }
  return buffer$274;
}

int32_t $moonbitlang$core$builtin$radix_count32(
  uint32_t value$264,
  int32_t radix$267
) {
  uint32_t num$265;
  uint32_t base$266;
  int32_t count$268;
  if (value$264 == 0u) {
    return 1;
  }
  num$265 = value$264;
  base$266 = *(uint32_t*)&radix$267;
  count$268 = 0;
  while (1) {
    uint32_t _tmp$946 = num$265;
    if (_tmp$946 > 0u) {
      int32_t _tmp$947 = count$268;
      uint32_t _tmp$948;
      count$268 = _tmp$947 + 1;
      _tmp$948 = num$265;
      num$265 = _tmp$948 / base$266;
      continue;
    }
    break;
  }
  return count$268;
}

int32_t $moonbitlang$core$builtin$hex_count32(uint32_t value$262) {
  if (value$262 == 0u) {
    return 1;
  } else {
    int32_t leading_zeros$263 = moonbit_clz32(value$262);
    int32_t _tmp$945 = 31 - leading_zeros$263;
    int32_t _tmp$944 = _tmp$945 / 4;
    return _tmp$944 + 1;
  }
}

int32_t $moonbitlang$core$builtin$dec_count32(uint32_t value$261) {
  if (value$261 >= 100000u) {
    if (value$261 >= 10000000u) {
      if (value$261 >= 1000000000u) {
        return 10;
      } else if (value$261 >= 100000000u) {
        return 9;
      } else {
        return 8;
      }
    } else if (value$261 >= 1000000u) {
      return 7;
    } else {
      return 6;
    }
  } else if (value$261 >= 1000u) {
    if (value$261 >= 10000u) {
      return 5;
    } else {
      return 4;
    }
  } else if (value$261 >= 100u) {
    return 3;
  } else if (value$261 >= 10u) {
    return 2;
  } else {
    return 1;
  }
}

int32_t $moonbitlang$core$builtin$int_to_string_dec(
  uint16_t* buffer$251,
  uint32_t num$239,
  int32_t digit_start$242,
  int32_t total_len$241
) {
  uint32_t num$238 = num$239;
  int32_t offset$240 = total_len$241 - digit_start$242;
  uint32_t _tmp$943;
  int32_t remaining$253;
  int32_t _tmp$924;
  while (1) {
    uint32_t _tmp$887 = num$238;
    if (_tmp$887 >= 10000u) {
      uint32_t _tmp$910 = num$238;
      uint32_t t$243 = _tmp$910 / 10000u;
      uint32_t _tmp$909 = num$238;
      uint32_t _tmp$908 = _tmp$909 % 10000u;
      int32_t r$244 = *(int32_t*)&_tmp$908;
      int32_t d1$245;
      int32_t d2$246;
      int32_t _tmp$888;
      int32_t _tmp$907;
      int32_t _tmp$906;
      int32_t d1_hi$247;
      int32_t _tmp$905;
      int32_t _tmp$904;
      int32_t d1_lo$248;
      int32_t _tmp$903;
      int32_t _tmp$902;
      int32_t d2_hi$249;
      int32_t _tmp$901;
      int32_t _tmp$900;
      int32_t d2_lo$250;
      int32_t _tmp$890;
      int32_t _tmp$889;
      int32_t _tmp$893;
      int32_t _tmp$892;
      int32_t _tmp$891;
      int32_t _tmp$896;
      int32_t _tmp$895;
      int32_t _tmp$894;
      int32_t _tmp$899;
      int32_t _tmp$898;
      int32_t _tmp$897;
      num$238 = t$243;
      d1$245 = r$244 / 100;
      d2$246 = r$244 % 100;
      _tmp$888 = offset$240;
      offset$240 = _tmp$888 - 4;
      _tmp$907 = d1$245 / 10;
      _tmp$906 = 48 + _tmp$907;
      d1_hi$247 = (uint16_t)_tmp$906;
      _tmp$905 = d1$245 % 10;
      _tmp$904 = 48 + _tmp$905;
      d1_lo$248 = (uint16_t)_tmp$904;
      _tmp$903 = d2$246 / 10;
      _tmp$902 = 48 + _tmp$903;
      d2_hi$249 = (uint16_t)_tmp$902;
      _tmp$901 = d2$246 % 10;
      _tmp$900 = 48 + _tmp$901;
      d2_lo$250 = (uint16_t)_tmp$900;
      _tmp$890 = offset$240;
      _tmp$889 = digit_start$242 + _tmp$890;
      buffer$251[_tmp$889] = d1_hi$247;
      _tmp$893 = offset$240;
      _tmp$892 = digit_start$242 + _tmp$893;
      _tmp$891 = _tmp$892 + 1;
      buffer$251[_tmp$891] = d1_lo$248;
      _tmp$896 = offset$240;
      _tmp$895 = digit_start$242 + _tmp$896;
      _tmp$894 = _tmp$895 + 2;
      buffer$251[_tmp$894] = d2_hi$249;
      _tmp$899 = offset$240;
      _tmp$898 = digit_start$242 + _tmp$899;
      _tmp$897 = _tmp$898 + 3;
      buffer$251[_tmp$897] = d2_lo$250;
      continue;
    }
    break;
  }
  _tmp$943 = num$238;
  remaining$253 = *(int32_t*)&_tmp$943;
  while (1) {
    int32_t _tmp$911 = remaining$253;
    if (_tmp$911 >= 100) {
      int32_t _tmp$923 = remaining$253;
      int32_t t$254 = _tmp$923 / 100;
      int32_t _tmp$922 = remaining$253;
      int32_t d$255 = _tmp$922 % 100;
      int32_t _tmp$912;
      int32_t _tmp$921;
      int32_t _tmp$920;
      int32_t d_hi$256;
      int32_t _tmp$919;
      int32_t _tmp$918;
      int32_t d_lo$257;
      int32_t _tmp$914;
      int32_t _tmp$913;
      int32_t _tmp$917;
      int32_t _tmp$916;
      int32_t _tmp$915;
      remaining$253 = t$254;
      _tmp$912 = offset$240;
      offset$240 = _tmp$912 - 2;
      _tmp$921 = d$255 / 10;
      _tmp$920 = 48 + _tmp$921;
      d_hi$256 = (uint16_t)_tmp$920;
      _tmp$919 = d$255 % 10;
      _tmp$918 = 48 + _tmp$919;
      d_lo$257 = (uint16_t)_tmp$918;
      _tmp$914 = offset$240;
      _tmp$913 = digit_start$242 + _tmp$914;
      buffer$251[_tmp$913] = d_hi$256;
      _tmp$917 = offset$240;
      _tmp$916 = digit_start$242 + _tmp$917;
      _tmp$915 = _tmp$916 + 1;
      buffer$251[_tmp$915] = d_lo$257;
      continue;
    }
    break;
  }
  _tmp$924 = remaining$253;
  if (_tmp$924 >= 10) {
    int32_t _tmp$925 = offset$240;
    int32_t _tmp$936;
    int32_t _tmp$935;
    int32_t _tmp$934;
    int32_t d_hi$259;
    int32_t _tmp$933;
    int32_t _tmp$932;
    int32_t _tmp$931;
    int32_t d_lo$260;
    int32_t _tmp$927;
    int32_t _tmp$926;
    int32_t _tmp$930;
    int32_t _tmp$929;
    int32_t _tmp$928;
    offset$240 = _tmp$925 - 2;
    _tmp$936 = remaining$253;
    _tmp$935 = _tmp$936 / 10;
    _tmp$934 = 48 + _tmp$935;
    d_hi$259 = (uint16_t)_tmp$934;
    _tmp$933 = remaining$253;
    _tmp$932 = _tmp$933 % 10;
    _tmp$931 = 48 + _tmp$932;
    d_lo$260 = (uint16_t)_tmp$931;
    _tmp$927 = offset$240;
    _tmp$926 = digit_start$242 + _tmp$927;
    buffer$251[_tmp$926] = d_hi$259;
    _tmp$930 = offset$240;
    _tmp$929 = digit_start$242 + _tmp$930;
    _tmp$928 = _tmp$929 + 1;
    buffer$251[_tmp$928] = d_lo$260;
    moonbit_decref(buffer$251);
  } else {
    int32_t _tmp$937 = offset$240;
    int32_t _tmp$942;
    int32_t _tmp$938;
    int32_t _tmp$941;
    int32_t _tmp$940;
    int32_t _tmp$939;
    offset$240 = _tmp$937 - 1;
    _tmp$942 = offset$240;
    _tmp$938 = digit_start$242 + _tmp$942;
    _tmp$941 = remaining$253;
    _tmp$940 = 48 + _tmp$941;
    _tmp$939 = (uint16_t)_tmp$940;
    buffer$251[_tmp$938] = _tmp$939;
    moonbit_decref(buffer$251);
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int_to_string_generic(
  uint16_t* buffer$233,
  uint32_t num$227,
  int32_t digit_start$225,
  int32_t total_len$224,
  int32_t radix$229
) {
  int32_t offset$223 = total_len$224 - digit_start$225;
  uint32_t n$226 = num$227;
  uint32_t base$228 = *(uint32_t*)&radix$229;
  int32_t _tmp$867 = radix$229 - 1;
  int32_t _tmp$866 = radix$229 & _tmp$867;
  if (_tmp$866 == 0) {
    int32_t shift$230 = moonbit_ctz32(radix$229);
    uint32_t mask$231 = base$228 - 1u;
    while (1) {
      uint32_t _tmp$868 = n$226;
      if (_tmp$868 > 0u) {
        int32_t _tmp$869 = offset$223;
        uint32_t _tmp$876;
        uint32_t _tmp$875;
        int32_t digit$232;
        int32_t _tmp$873;
        int32_t _tmp$870;
        int32_t _tmp$872;
        int32_t _tmp$871;
        uint32_t _tmp$874;
        offset$223 = _tmp$869 - 1;
        _tmp$876 = n$226;
        _tmp$875 = _tmp$876 & mask$231;
        digit$232 = *(int32_t*)&_tmp$875;
        _tmp$873 = offset$223;
        _tmp$870 = digit_start$225 + _tmp$873;
        _tmp$872
        = ((moonbit_string_t)moonbit_string_literal_13.data)[
          digit$232
        ];
        _tmp$871 = (uint16_t)_tmp$872;
        buffer$233[_tmp$870] = _tmp$871;
        _tmp$874 = n$226;
        n$226 = _tmp$874 >> (shift$230 & 31);
        continue;
      } else {
        moonbit_decref(buffer$233);
      }
      break;
    }
  } else {
    while (1) {
      uint32_t _tmp$877 = n$226;
      if (_tmp$877 > 0u) {
        int32_t _tmp$878 = offset$223;
        uint32_t _tmp$886;
        uint32_t q$235;
        uint32_t _tmp$884;
        uint32_t _tmp$885;
        uint32_t _tmp$883;
        int32_t digit$236;
        int32_t _tmp$882;
        int32_t _tmp$879;
        int32_t _tmp$881;
        int32_t _tmp$880;
        offset$223 = _tmp$878 - 1;
        _tmp$886 = n$226;
        q$235 = _tmp$886 / base$228;
        _tmp$884 = n$226;
        _tmp$885 = q$235 * base$228;
        _tmp$883 = _tmp$884 - _tmp$885;
        digit$236 = *(int32_t*)&_tmp$883;
        _tmp$882 = offset$223;
        _tmp$879 = digit_start$225 + _tmp$882;
        _tmp$881
        = ((moonbit_string_t)moonbit_string_literal_13.data)[
          digit$236
        ];
        _tmp$880 = (uint16_t)_tmp$881;
        buffer$233[_tmp$879] = _tmp$880;
        n$226 = q$235;
        continue;
      } else {
        moonbit_decref(buffer$233);
      }
      break;
    }
  }
  return 0;
}

int32_t $moonbitlang$core$builtin$int_to_string_hex(
  uint16_t* buffer$220,
  uint32_t num$216,
  int32_t digit_start$214,
  int32_t total_len$213
) {
  int32_t offset$212 = total_len$213 - digit_start$214;
  uint32_t n$215 = num$216;
  int32_t _tmp$861;
  while (1) {
    int32_t _tmp$847 = offset$212;
    if (_tmp$847 >= 2) {
      int32_t _tmp$848 = offset$212;
      uint32_t _tmp$860;
      uint32_t _tmp$859;
      int32_t byte_val$217;
      int32_t hi$218;
      int32_t lo$219;
      int32_t _tmp$852;
      int32_t _tmp$849;
      int32_t _tmp$851;
      int32_t _tmp$850;
      int32_t _tmp$857;
      int32_t _tmp$856;
      int32_t _tmp$853;
      int32_t _tmp$855;
      int32_t _tmp$854;
      uint32_t _tmp$858;
      offset$212 = _tmp$848 - 2;
      _tmp$860 = n$215;
      _tmp$859 = _tmp$860 & 255u;
      byte_val$217 = *(int32_t*)&_tmp$859;
      hi$218 = byte_val$217 / 16;
      lo$219 = byte_val$217 % 16;
      _tmp$852 = offset$212;
      _tmp$849 = digit_start$214 + _tmp$852;
      _tmp$851 = ((moonbit_string_t)moonbit_string_literal_13.data)[hi$218];
      _tmp$850 = (uint16_t)_tmp$851;
      buffer$220[_tmp$849] = _tmp$850;
      _tmp$857 = offset$212;
      _tmp$856 = digit_start$214 + _tmp$857;
      _tmp$853 = _tmp$856 + 1;
      _tmp$855 = ((moonbit_string_t)moonbit_string_literal_13.data)[lo$219];
      _tmp$854 = (uint16_t)_tmp$855;
      buffer$220[_tmp$853] = _tmp$854;
      _tmp$858 = n$215;
      n$215 = _tmp$858 >> 8;
      continue;
    }
    break;
  }
  _tmp$861 = offset$212;
  if (_tmp$861 == 1) {
    uint32_t _tmp$865 = n$215;
    uint32_t _tmp$864 = _tmp$865 & 15u;
    int32_t nibble$222 = *(int32_t*)&_tmp$864;
    int32_t _tmp$863 =
      ((moonbit_string_t)moonbit_string_literal_13.data)[nibble$222];
    int32_t _tmp$862 = (uint16_t)_tmp$863;
    buffer$220[digit_start$214] = _tmp$862;
    moonbit_decref(buffer$220);
  } else {
    moonbit_decref(buffer$220);
  }
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$write_iter$inner$0(
  struct $$moonbitlang$core$builtin$Logger self$203,
  struct $$3c$$3c$Int$3e$$3d$$3e$Int$3e$$3d$$3e$Int* iter$206,
  moonbit_string_t prefix$204,
  moonbit_string_t suffix$211,
  moonbit_string_t sep$208,
  int32_t trailing$205
) {
  if (self$203.$1) {
    moonbit_incref(self$203.$1);
  }
  self$203.$0->$method_0(self$203.$1, prefix$204);
  if (trailing$205) {
    struct $Logger$$write_iter$inner$7c$Int$7c$$fn$1$2d$cap* _closure$1182;
    struct $$3c$Int$3e$$3d$$3e$Int* _tmp$840;
    int32_t _tmp$839;
    if (self$203.$1) {
      moonbit_incref(self$203.$1);
    }
    _closure$1182
    = (struct $Logger$$write_iter$inner$7c$Int$7c$$fn$1$2d$cap*)moonbit_malloc(
        sizeof(struct $Logger$$write_iter$inner$7c$Int$7c$$fn$1$2d$cap)
      );
    Moonbit_object_header(_closure$1182)->meta
    = Moonbit_make_regular_object_header(
      offsetof(
        struct $Logger$$write_iter$inner$7c$Int$7c$$fn$1$2d$cap, $0
      )
      >> 2,
        3,
        0
    );
    _closure$1182->code = &$Logger$$write_iter$inner$7c$Int$7c$$fn$1;
    _closure$1182->$0 = sep$208;
    _closure$1182->$1_0 = self$203.$0;
    _closure$1182->$1_1 = self$203.$1;
    _tmp$840 = (struct $$3c$Int$3e$$3d$$3e$Int*)_closure$1182;
    _tmp$839 = iter$206->code(iter$206, _tmp$840);
  } else {
    struct $Ref$3c$Bool$3e$* first$209 =
      (struct $Ref$3c$Bool$3e$*)moonbit_malloc(
        sizeof(struct $Ref$3c$Bool$3e$)
      );
    struct $Logger$$write_iter$inner$7c$Int$7c$$fn$2$2d$cap* _closure$1183;
    struct $$3c$Int$3e$$3d$$3e$Int* _tmp$844;
    int32_t _tmp$843;
    Moonbit_object_header(first$209)->meta
    = Moonbit_make_regular_object_header(
      sizeof(struct $Ref$3c$Bool$3e$) >> 2, 0, 0
    );
    first$209->$0 = 1;
    if (self$203.$1) {
      moonbit_incref(self$203.$1);
    }
    _closure$1183
    = (struct $Logger$$write_iter$inner$7c$Int$7c$$fn$2$2d$cap*)moonbit_malloc(
        sizeof(struct $Logger$$write_iter$inner$7c$Int$7c$$fn$2$2d$cap)
      );
    Moonbit_object_header(_closure$1183)->meta
    = Moonbit_make_regular_object_header(
      offsetof(
        struct $Logger$$write_iter$inner$7c$Int$7c$$fn$2$2d$cap, $0
      )
      >> 2,
        4,
        0
    );
    _closure$1183->code = &$Logger$$write_iter$inner$7c$Int$7c$$fn$2;
    _closure$1183->$0 = first$209;
    _closure$1183->$1 = sep$208;
    _closure$1183->$2_0 = self$203.$0;
    _closure$1183->$2_1 = self$203.$1;
    _tmp$844 = (struct $$3c$Int$3e$$3d$$3e$Int*)_closure$1183;
    _tmp$843 = iter$206->code(iter$206, _tmp$844);
  }
  self$203.$0->$method_0(self$203.$1, suffix$211);
  return 0;
}

int32_t $Logger$$write_iter$inner$7c$Int$7c$$fn$2(
  struct $$3c$Int$3e$$3d$$3e$Int* _env$845,
  int32_t x$210
) {
  struct $Logger$$write_iter$inner$7c$Int$7c$$fn$2$2d$cap* _casted_env$846 =
    (struct $Logger$$write_iter$inner$7c$Int$7c$$fn$2$2d$cap*)_env$845;
  struct $$moonbitlang$core$builtin$Logger _field$1077 =
    (struct $$moonbitlang$core$builtin$Logger){
      _casted_env$846->$2_0, _casted_env$846->$2_1
    };
  struct $$moonbitlang$core$builtin$Logger self$203 = _field$1077;
  moonbit_string_t _field$1076 = _casted_env$846->$1;
  moonbit_string_t sep$208 = _field$1076;
  struct $Ref$3c$Bool$3e$* _field$1075 = _casted_env$846->$0;
  int32_t _cnt$1155 = Moonbit_object_header(_casted_env$846)->rc;
  struct $Ref$3c$Bool$3e$* first$209;
  if (_cnt$1155 > 1) {
    int32_t _new_cnt$1156;
    if (self$203.$1) {
      moonbit_incref(self$203.$1);
    }
    moonbit_incref(sep$208);
    moonbit_incref(_field$1075);
    _new_cnt$1156 = _cnt$1155 - 1;
    Moonbit_object_header(_casted_env$846)->rc = _new_cnt$1156;
  } else if (_cnt$1155 == 1) {
    moonbit_free(_casted_env$846);
  }
  first$209 = _field$1075;
  if (first$209->$0) {
    moonbit_decref(sep$208);
    first$209->$0 = 0;
    moonbit_decref(first$209);
  } else {
    moonbit_decref(first$209);
    if (self$203.$1) {
      moonbit_incref(self$203.$1);
    }
    self$203.$0->$method_0(self$203.$1, sep$208);
  }
  $$moonbitlang$core$builtin$Logger$$write_object$0(self$203, x$210);
  return 1;
}

int32_t $Logger$$write_iter$inner$7c$Int$7c$$fn$1(
  struct $$3c$Int$3e$$3d$$3e$Int* _env$841,
  int32_t x$207
) {
  struct $Logger$$write_iter$inner$7c$Int$7c$$fn$1$2d$cap* _casted_env$842 =
    (struct $Logger$$write_iter$inner$7c$Int$7c$$fn$1$2d$cap*)_env$841;
  struct $$moonbitlang$core$builtin$Logger _field$1079 =
    (struct $$moonbitlang$core$builtin$Logger){
      _casted_env$842->$1_0, _casted_env$842->$1_1
    };
  struct $$moonbitlang$core$builtin$Logger self$203 = _field$1079;
  moonbit_string_t _field$1078 = _casted_env$842->$0;
  int32_t _cnt$1157 = Moonbit_object_header(_casted_env$842)->rc;
  moonbit_string_t sep$208;
  if (_cnt$1157 > 1) {
    int32_t _new_cnt$1158;
    if (self$203.$1) {
      moonbit_incref(self$203.$1);
    }
    moonbit_incref(_field$1078);
    _new_cnt$1158 = _cnt$1157 - 1;
    Moonbit_object_header(_casted_env$842)->rc = _new_cnt$1158;
  } else if (_cnt$1157 == 1) {
    moonbit_free(_casted_env$842);
  }
  sep$208 = _field$1078;
  if (self$203.$1) {
    moonbit_incref(self$203.$1);
  }
  $$moonbitlang$core$builtin$Logger$$write_object$0(self$203, x$207);
  self$203.$0->$method_0(self$203.$1, sep$208);
  return 1;
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(
  moonbit_string_t self$202
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$201 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$838;
  moonbit_incref(logger$201);
  _tmp$838
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$201
  };
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output(
    self$202, _tmp$838
  );
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$201);
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
  int32_t self$200
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$199 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$837;
  moonbit_incref(logger$199);
  _tmp$837
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$199
  };
  $$moonbitlang$core$builtin$Show$$Int$$output(self$200, _tmp$837);
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$199);
}

moonbit_string_t $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$198
) {
  struct $$moonbitlang$core$builtin$StringBuilder* logger$197 =
    $$moonbitlang$core$builtin$StringBuilder$$new$inner(0);
  struct $$moonbitlang$core$builtin$Logger _tmp$836;
  moonbit_incref(logger$197);
  _tmp$836
  = (struct $$moonbitlang$core$builtin$Logger){
    $$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id,
      logger$197
  };
  $$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$Array$$output$0(
    self$198, _tmp$836
  );
  return $$moonbitlang$core$builtin$StringBuilder$$to_string(logger$197);
}

int32_t $StringView$$start_offset(struct $StringView self$196) {
  int32_t _field$1080 = self$196.$1;
  moonbit_decref(self$196.$0);
  return _field$1080;
}

moonbit_string_t $StringView$$data(struct $StringView self$195) {
  moonbit_string_t _field$1081 = self$195.$0;
  return _field$1081;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
  struct $$moonbitlang$core$builtin$StringBuilder* self$189,
  moonbit_string_t value$192,
  int32_t start$193,
  int32_t len$194
) {
  void* _try_err$191;
  struct $StringView _tmp$831;
  int32_t _tmp$833 = start$193 + len$194;
  int64_t _tmp$832 = (int64_t)_tmp$833;
  struct moonbit_result_0 _tmp$1185 =
    $String$$sub$inner(value$192, start$193, _tmp$832);
  if (_tmp$1185.tag) {
    struct $StringView const _ok$834 = _tmp$1185.data.ok;
    _tmp$831 = _ok$834;
  } else {
    void* const _err$835 = _tmp$1185.data.err;
    _try_err$191 = _err$835;
    goto $join$190;
  }
  goto $joinlet$1184;
  $join$190:;
  moonbit_decref(_try_err$191);
  moonbit_panic();
  $joinlet$1184:;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    self$189, _tmp$831
  );
  return 0;
}

struct moonbit_result_0 $String$$sub$inner(
  moonbit_string_t self$182,
  int32_t start$188,
  int64_t end$184
) {
  int32_t len$181 = Moonbit_array_length(self$182);
  int32_t end$183;
  int32_t start$187;
  if (end$184 == 4294967296ll) {
    end$183 = len$181;
  } else {
    int64_t _Some$185 = end$184;
    int32_t _end$186 = (int32_t)_Some$185;
    if (_end$186 < 0) {
      end$183 = len$181 + _end$186;
    } else {
      end$183 = _end$186;
    }
  }
  if (start$188 < 0) {
    start$187 = len$181 + start$188;
  } else {
    start$187 = start$188;
  }
  if (start$187 >= 0 && start$187 <= end$183 && end$183 <= len$181) {
    int32_t _if_result$1186;
    int32_t _if_result$1188;
    struct $StringView _tmp$829;
    struct moonbit_result_0 _result$1190;
    if (start$187 < len$181) {
      int32_t _p$492 = self$182[start$187];
      _if_result$1186 = 56320 <= _p$492 && _p$492 <= 57343;
    } else {
      _if_result$1186 = 0;
    }
    if (_if_result$1186) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$827;
      struct moonbit_result_0 _result$1187;
      moonbit_decref(self$182);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$827
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$1187.tag = 0;
      _result$1187.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$827;
      return _result$1187;
    }
    if (end$183 < len$181) {
      int32_t _p$495 = self$182[end$183];
      _if_result$1188 = 56320 <= _p$495 && _p$495 <= 57343;
    } else {
      _if_result$1188 = 0;
    }
    if (_if_result$1188) {
      void* moonbitlang$core$builtin$CreatingViewError$InvalidIndex$828;
      struct moonbit_result_0 _result$1189;
      moonbit_decref(self$182);
      moonbitlang$core$builtin$CreatingViewError$InvalidIndex$828
      = (struct moonbit_object*)&moonbit_constant_constructor_0 + 1;
      _result$1189.tag = 0;
      _result$1189.data.err
      = moonbitlang$core$builtin$CreatingViewError$InvalidIndex$828;
      return _result$1189;
    }
    _tmp$829 = (struct $StringView){start$187, end$183, self$182};
    _result$1190.tag = 1;
    _result$1190.data.ok = _tmp$829;
    return _result$1190;
  } else {
    void* moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$830;
    struct moonbit_result_0 _result$1191;
    moonbit_decref(self$182);
    moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$830
    = (struct moonbit_object*)&moonbit_constant_constructor_1 + 1;
    _result$1191.tag = 0;
    _result$1191.data.err
    = moonbitlang$core$builtin$CreatingViewError$IndexOutOfBounds$830;
    return _result$1191;
  }
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$179,
  moonbit_string_t str$180
) {
  int32_t len$817 = self$179->$1;
  int32_t _tmp$819 = Moonbit_array_length(str$180);
  int32_t _tmp$818 = _tmp$819 * 2;
  int32_t _tmp$816 = len$817 + _tmp$818;
  moonbit_bytes_t _field$1083;
  moonbit_bytes_t data$820;
  int32_t len$821;
  int32_t _tmp$822;
  int32_t len$824;
  int32_t _tmp$1082;
  int32_t _tmp$826;
  int32_t _tmp$825;
  int32_t _tmp$823;
  moonbit_incref(self$179);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$179, _tmp$816
  );
  _field$1083 = self$179->$0;
  data$820 = _field$1083;
  len$821 = self$179->$1;
  _tmp$822 = Moonbit_array_length(str$180);
  moonbit_incref(data$820);
  moonbit_incref(str$180);
  $FixedArray$$blit_from_string(data$820, len$821, str$180, 0, _tmp$822);
  len$824 = self$179->$1;
  _tmp$1082 = Moonbit_array_length(str$180);
  moonbit_decref(str$180);
  _tmp$826 = _tmp$1082;
  _tmp$825 = _tmp$826 * 2;
  _tmp$823 = len$824 + _tmp$825;
  self$179->$1 = _tmp$823;
  moonbit_decref(self$179);
  return 0;
}

int32_t $FixedArray$$blit_from_string(
  moonbit_bytes_t self$171,
  int32_t bytes_offset$166,
  moonbit_string_t str$173,
  int32_t str_offset$169,
  int32_t length$167
) {
  int32_t _tmp$815 = length$167 * 2;
  int32_t _tmp$814 = bytes_offset$166 + _tmp$815;
  int32_t e1$165 = _tmp$814 - 1;
  int32_t _tmp$813 = str_offset$169 + length$167;
  int32_t e2$168 = _tmp$813 - 1;
  int32_t len1$170 = Moonbit_array_length(self$171);
  int32_t len2$172 = Moonbit_array_length(str$173);
  if (
    length$167 >= 0
    && bytes_offset$166 >= 0
    && e1$165 < len1$170
    && str_offset$169 >= 0
    && e2$168 < len2$172
  ) {
    int32_t end_str_offset$174 = str_offset$169 + length$167;
    int32_t i$175 = str_offset$169;
    int32_t j$176 = bytes_offset$166;
    while (1) {
      if (i$175 < end_str_offset$174) {
        int32_t _tmp$810 = str$173[i$175];
        uint32_t c$177 = *(uint32_t*)&_tmp$810;
        uint32_t _p$486 = c$177 & 255u;
        int32_t _tmp$806 = *(int32_t*)&_p$486;
        int32_t _tmp$805 = _tmp$806 & 0xff;
        int32_t _tmp$807;
        uint32_t _p$489;
        int32_t _tmp$809;
        int32_t _tmp$808;
        int32_t _tmp$811;
        int32_t _tmp$812;
        if (j$176 < 0 || j$176 >= Moonbit_array_length(self$171)) {
          moonbit_panic();
        }
        self$171[j$176] = _tmp$805;
        _tmp$807 = j$176 + 1;
        _p$489 = c$177 >> 8;
        _tmp$809 = *(int32_t*)&_p$489;
        _tmp$808 = _tmp$809 & 0xff;
        if (_tmp$807 < 0 || _tmp$807 >= Moonbit_array_length(self$171)) {
          moonbit_panic();
        }
        self$171[_tmp$807] = _tmp$808;
        _tmp$811 = i$175 + 1;
        _tmp$812 = j$176 + 2;
        i$175 = _tmp$811;
        j$176 = _tmp$812;
        continue;
      } else {
        moonbit_decref(str$173);
        moonbit_decref(self$171);
      }
      break;
    }
  } else {
    moonbit_decref(str$173);
    moonbit_decref(self$171);
    moonbit_panic();
  }
  return 0;
}

struct $$moonbitlang$core$builtin$SourceLocRepr* $$moonbitlang$core$builtin$SourceLocRepr$$parse(
  moonbit_string_t repr$133
) {
  int32_t _tmp$774 = Moonbit_array_length(repr$133);
  int64_t _tmp$773 = (int64_t)_tmp$774;
  moonbit_incref(repr$133);
  if ($String$$char_length_ge$inner(repr$133, 1, 0, _tmp$773)) {
    int32_t _tmp$804 = repr$133[0];
    int32_t _x$134 = _tmp$804;
    if (_x$134 == 64) {
      int32_t _tmp$803 = Moonbit_array_length(repr$133);
      int64_t _tmp$802 = (int64_t)_tmp$803;
      int64_t _bind$384;
      int32_t _tmp$800;
      int32_t _tmp$801;
      struct $StringView _x$135;
      int32_t _tmp$799;
      struct $StringView _tmp$798;
      int64_t _bind$137;
      moonbit_incref(repr$133);
      _bind$384 = $String$$offset_of_nth_char$inner(repr$133, 1, 0, _tmp$802);
      if (_bind$384 == 4294967296ll) {
        _tmp$800 = Moonbit_array_length(repr$133);
      } else {
        int64_t _Some$136 = _bind$384;
        _tmp$800 = (int32_t)_Some$136;
      }
      _tmp$801 = Moonbit_array_length(repr$133);
      _x$135 = (struct $StringView){_tmp$800, _tmp$801, repr$133};
      _tmp$799
      = Moonbit_array_length(
        $moonbitlang$core$builtin$parse$$2a$bind$7c$5443
      );
      moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5443);
      _tmp$798
      = (struct $StringView){
        0, _tmp$799, $moonbitlang$core$builtin$parse$$2a$bind$7c$5443
      };
      moonbit_incref(_x$135.$0);
      _bind$137 = $StringView$$find(_x$135, _tmp$798);
      if (_bind$137 == 4294967296ll) {
        moonbit_decref(_x$135.$0);
        moonbit_panic();
      } else {
        int64_t _Some$138 = _bind$137;
        int32_t _pkg_end$139 = (int32_t)_Some$138;
        int64_t _tmp$797 = (int64_t)_pkg_end$139;
        struct $StringView pkg$140;
        int32_t _tmp$796;
        struct $StringView _tmp$795;
        int64_t _bind$141;
        moonbit_incref(_x$135.$0);
        pkg$140 = $StringView$$view$inner(_x$135, 0, _tmp$797);
        _tmp$796
        = Moonbit_array_length(
          $moonbitlang$core$builtin$parse$$2a$bind$7c$5437
        );
        moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5437);
        _tmp$795
        = (struct $StringView){
          0, _tmp$796, $moonbitlang$core$builtin$parse$$2a$bind$7c$5437
        };
        moonbit_incref(_x$135.$0);
        _bind$141 = $StringView$$rev_find(_x$135, _tmp$795);
        if (_bind$141 == 4294967296ll) {
          moonbit_decref(pkg$140.$0);
          moonbit_decref(_x$135.$0);
          moonbit_panic();
        } else {
          int64_t _Some$142 = _bind$141;
          int32_t _start_loc_end$143 = (int32_t)_Some$142;
          int32_t _tmp$775 = _start_loc_end$143 + 1;
          int32_t end$777 = _x$135.$2;
          int32_t start$778 = _x$135.$1;
          int32_t _tmp$776 = end$777 - start$778;
          if (_tmp$775 < _tmp$776) {
            int32_t _tmp$794 = _start_loc_end$143 + 1;
            struct $StringView end_loc$144;
            struct $$3c$StringView$2a$StringView$3e$* _bind$145;
            moonbit_incref(_x$135.$0);
            end_loc$144
            = $StringView$$view$inner(
              _x$135, _tmp$794, 4294967296ll
            );
            _bind$145
            = $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
              end_loc$144
            );
            if (_bind$145 == 0) {
              if (_bind$145) {
                moonbit_decref(_bind$145);
              }
              moonbit_decref(pkg$140.$0);
              moonbit_decref(_x$135.$0);
              moonbit_panic();
            } else {
              struct $$3c$StringView$2a$StringView$3e$* _Some$146 = _bind$145;
              struct $$3c$StringView$2a$StringView$3e$* _x$147 = _Some$146;
              struct $StringView _field$1087 =
                (struct $StringView){
                  _x$147->$0_1, _x$147->$0_2, _x$147->$0_0
                };
              struct $StringView _end_line$148 = _field$1087;
              struct $StringView _field$1086 =
                (struct $StringView){
                  _x$147->$1_1, _x$147->$1_2, _x$147->$1_0
                };
              int32_t _cnt$1159 = Moonbit_object_header(_x$147)->rc;
              struct $StringView _end_column$149;
              int64_t _tmp$793;
              struct $StringView rest$150;
              int32_t _tmp$792;
              struct $StringView _tmp$791;
              int64_t _bind$152;
              if (_cnt$1159 > 1) {
                int32_t _new_cnt$1160;
                moonbit_incref(_field$1086.$0);
                moonbit_incref(_end_line$148.$0);
                _new_cnt$1160 = _cnt$1159 - 1;
                Moonbit_object_header(_x$147)->rc = _new_cnt$1160;
              } else if (_cnt$1159 == 1) {
                moonbit_free(_x$147);
              }
              _end_column$149 = _field$1086;
              _tmp$793 = (int64_t)_start_loc_end$143;
              rest$150 = $StringView$$view$inner(_x$135, 0, _tmp$793);
              _tmp$792
              = Moonbit_array_length(
                $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              );
              moonbit_incref(
                $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              );
              _tmp$791
              = (struct $StringView){
                0, _tmp$792, $moonbitlang$core$builtin$parse$$2a$bind$7c$5424
              };
              moonbit_incref(rest$150.$0);
              _bind$152 = $StringView$$rev_find(rest$150, _tmp$791);
              if (_bind$152 == 4294967296ll) {
                moonbit_decref(rest$150.$0);
                moonbit_decref(_end_column$149.$0);
                moonbit_decref(_end_line$148.$0);
                moonbit_decref(pkg$140.$0);
                goto $join$151;
              } else {
                int64_t _Some$153 = _bind$152;
                int32_t _start_line_end$154 = (int32_t)_Some$153;
                int64_t _tmp$790 = (int64_t)_start_line_end$154;
                struct $StringView _tmp$787;
                int32_t _tmp$789;
                struct $StringView _tmp$788;
                int64_t _bind$155;
                moonbit_incref(rest$150.$0);
                _tmp$787 = $StringView$$view$inner(rest$150, 0, _tmp$790);
                _tmp$789
                = Moonbit_array_length(
                  $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                );
                moonbit_incref(
                  $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                );
                _tmp$788
                = (struct $StringView){
                  0,
                    _tmp$789,
                    $moonbitlang$core$builtin$parse$$2a$bind$7c$5418
                };
                _bind$155 = $StringView$$rev_find(_tmp$787, _tmp$788);
                if (_bind$155 == 4294967296ll) {
                  moonbit_decref(rest$150.$0);
                  moonbit_decref(_end_column$149.$0);
                  moonbit_decref(_end_line$148.$0);
                  moonbit_decref(pkg$140.$0);
                  goto $join$151;
                } else {
                  int64_t _Some$156 = _bind$155;
                  int32_t _filename_end$157 = (int32_t)_Some$156;
                  int32_t _tmp$779 = _filename_end$157 + 1;
                  int32_t end$781 = rest$150.$2;
                  int32_t start$782 = rest$150.$1;
                  int32_t _tmp$780 = end$781 - start$782;
                  if (_tmp$779 < _tmp$780) {
                    int32_t _tmp$786 = _filename_end$157 + 1;
                    struct $StringView start_loc$158;
                    struct $$3c$StringView$2a$StringView$3e$* _bind$159;
                    moonbit_incref(rest$150.$0);
                    start_loc$158
                    = $StringView$$view$inner(
                      rest$150, _tmp$786, 4294967296ll
                    );
                    _bind$159
                    = $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
                      start_loc$158
                    );
                    if (_bind$159 == 0) {
                      if (_bind$159) {
                        moonbit_decref(_bind$159);
                      }
                      moonbit_decref(rest$150.$0);
                      moonbit_decref(_end_column$149.$0);
                      moonbit_decref(_end_line$148.$0);
                      moonbit_decref(pkg$140.$0);
                      moonbit_panic();
                    } else {
                      struct $$3c$StringView$2a$StringView$3e$* _Some$160 =
                        _bind$159;
                      struct $$3c$StringView$2a$StringView$3e$* _x$161 =
                        _Some$160;
                      struct $StringView _field$1085 =
                        (struct $StringView){
                          _x$161->$0_1, _x$161->$0_2, _x$161->$0_0
                        };
                      struct $StringView _start_line$162 = _field$1085;
                      struct $StringView _field$1084 =
                        (struct $StringView){
                          _x$161->$1_1, _x$161->$1_2, _x$161->$1_0
                        };
                      int32_t _cnt$1161 = Moonbit_object_header(_x$161)->rc;
                      struct $StringView _start_column$163;
                      int32_t _tmp$783;
                      if (_cnt$1161 > 1) {
                        int32_t _new_cnt$1162;
                        moonbit_incref(_field$1084.$0);
                        moonbit_incref(_start_line$162.$0);
                        _new_cnt$1162 = _cnt$1161 - 1;
                        Moonbit_object_header(_x$161)->rc = _new_cnt$1162;
                      } else if (_cnt$1161 == 1) {
                        moonbit_free(_x$161);
                      }
                      _start_column$163 = _field$1084;
                      _tmp$783 = _pkg_end$139 + 1;
                      if (_filename_end$157 > _tmp$783) {
                        int32_t _tmp$784 = _pkg_end$139 + 1;
                        int64_t _tmp$785 = (int64_t)_filename_end$157;
                        struct $StringView filename$164 =
                          $StringView$$view$inner(
                            rest$150, _tmp$784, _tmp$785
                          );
                        struct $$moonbitlang$core$builtin$SourceLocRepr* _block$1195 =
                          (struct $$moonbitlang$core$builtin$SourceLocRepr*)moonbit_malloc(
                            sizeof(
                              struct $$moonbitlang$core$builtin$SourceLocRepr
                            )
                          );
                        Moonbit_object_header(_block$1195)->meta
                        = Moonbit_make_regular_object_header(
                          offsetof(
                            struct $$moonbitlang$core$builtin$SourceLocRepr,
                              $0_0
                          )
                          >> 2,
                            6,
                            0
                        );
                        _block$1195->$0_0 = pkg$140.$0;
                        _block$1195->$0_1 = pkg$140.$1;
                        _block$1195->$0_2 = pkg$140.$2;
                        _block$1195->$1_0 = filename$164.$0;
                        _block$1195->$1_1 = filename$164.$1;
                        _block$1195->$1_2 = filename$164.$2;
                        _block$1195->$2_0 = _start_line$162.$0;
                        _block$1195->$2_1 = _start_line$162.$1;
                        _block$1195->$2_2 = _start_line$162.$2;
                        _block$1195->$3_0 = _start_column$163.$0;
                        _block$1195->$3_1 = _start_column$163.$1;
                        _block$1195->$3_2 = _start_column$163.$2;
                        _block$1195->$4_0 = _end_line$148.$0;
                        _block$1195->$4_1 = _end_line$148.$1;
                        _block$1195->$4_2 = _end_line$148.$2;
                        _block$1195->$5_0 = _end_column$149.$0;
                        _block$1195->$5_1 = _end_column$149.$1;
                        _block$1195->$5_2 = _end_column$149.$2;
                        return _block$1195;
                      } else {
                        moonbit_decref(_start_column$163.$0);
                        moonbit_decref(_start_line$162.$0);
                        moonbit_decref(rest$150.$0);
                        moonbit_decref(_end_column$149.$0);
                        moonbit_decref(_end_line$148.$0);
                        moonbit_decref(pkg$140.$0);
                        moonbit_panic();
                      }
                    }
                  } else {
                    moonbit_decref(rest$150.$0);
                    moonbit_decref(_end_column$149.$0);
                    moonbit_decref(_end_line$148.$0);
                    moonbit_decref(pkg$140.$0);
                    moonbit_panic();
                  }
                }
              }
              $join$151:;
              moonbit_panic();
            }
          } else {
            moonbit_decref(pkg$140.$0);
            moonbit_decref(_x$135.$0);
            moonbit_panic();
          }
        }
      }
    } else {
      moonbit_decref(repr$133);
      goto $join$132;
    }
  } else {
    moonbit_decref(repr$133);
    goto $join$132;
  }
  $join$132:;
  moonbit_panic();
}

struct $$3c$StringView$2a$StringView$3e$* $moonbitlang$core$builtin$parse$parse_loc$7c$1101(
  struct $StringView view$129
) {
  int32_t _tmp$772 =
    Moonbit_array_length($moonbitlang$core$builtin$parse$$2a$bind$7c$5404);
  struct $StringView _tmp$771;
  int64_t _bind$128;
  moonbit_incref($moonbitlang$core$builtin$parse$$2a$bind$7c$5404);
  _tmp$771
  = (struct $StringView){
    0, _tmp$772, $moonbitlang$core$builtin$parse$$2a$bind$7c$5404
  };
  moonbit_incref(view$129.$0);
  _bind$128 = $StringView$$find(view$129, _tmp$771);
  if (_bind$128 == 4294967296ll) {
    moonbit_decref(view$129.$0);
    return 0;
  } else {
    int64_t _Some$130 = _bind$128;
    int32_t _i$131 = (int32_t)_Some$130;
    int32_t _if_result$1196;
    if (_i$131 > 0) {
      int32_t _tmp$762 = _i$131 + 1;
      int32_t end$764 = view$129.$2;
      int32_t start$765 = view$129.$1;
      int32_t _tmp$763 = end$764 - start$765;
      _if_result$1196 = _tmp$762 < _tmp$763;
    } else {
      _if_result$1196 = 0;
    }
    if (_if_result$1196) {
      int64_t _tmp$770 = (int64_t)_i$131;
      struct $StringView _tmp$767;
      int32_t _tmp$769;
      struct $StringView _tmp$768;
      struct $$3c$StringView$2a$StringView$3e$* _tuple$766;
      moonbit_incref(view$129.$0);
      _tmp$767 = $StringView$$view$inner(view$129, 0, _tmp$770);
      _tmp$769 = _i$131 + 1;
      _tmp$768 = $StringView$$view$inner(view$129, _tmp$769, 4294967296ll);
      _tuple$766
      = (struct $$3c$StringView$2a$StringView$3e$*)moonbit_malloc(
          sizeof(struct $$3c$StringView$2a$StringView$3e$)
        );
      Moonbit_object_header(_tuple$766)->meta
      = Moonbit_make_regular_object_header(
        offsetof(struct $$3c$StringView$2a$StringView$3e$, $0_0) >> 2, 2, 0
      );
      _tuple$766->$0_0 = _tmp$767.$0;
      _tuple$766->$0_1 = _tmp$767.$1;
      _tuple$766->$0_2 = _tmp$767.$2;
      _tuple$766->$1_0 = _tmp$768.$0;
      _tuple$766->$1_1 = _tmp$768.$1;
      _tuple$766->$1_2 = _tmp$768.$2;
      return _tuple$766;
    } else {
      moonbit_decref(view$129.$0);
      return 0;
    }
  }
}

struct $StringView $StringView$$view$inner(
  struct $StringView self$126,
  int32_t start_offset$127,
  int64_t end_offset$124
) {
  int32_t end_offset$123;
  int32_t _if_result$1197;
  if (end_offset$124 == 4294967296ll) {
    int32_t end$760 = self$126.$2;
    int32_t start$761 = self$126.$1;
    end_offset$123 = end$760 - start$761;
  } else {
    int64_t _Some$125 = end_offset$124;
    end_offset$123 = (int32_t)_Some$125;
  }
  if (start_offset$127 >= 0) {
    if (start_offset$127 <= end_offset$123) {
      int32_t end$753 = self$126.$2;
      int32_t start$754 = self$126.$1;
      int32_t _tmp$752 = end$753 - start$754;
      _if_result$1197 = end_offset$123 <= _tmp$752;
    } else {
      _if_result$1197 = 0;
    }
  } else {
    _if_result$1197 = 0;
  }
  if (_if_result$1197) {
    moonbit_string_t _field$1089 = self$126.$0;
    moonbit_string_t str$755 = _field$1089;
    int32_t start$759 = self$126.$1;
    int32_t _tmp$756 = start$759 + start_offset$127;
    int32_t _field$1088 = self$126.$1;
    int32_t start$758 = _field$1088;
    int32_t _tmp$757 = start$758 + end_offset$123;
    return (struct $StringView){_tmp$756, _tmp$757, str$755};
  } else {
    moonbit_decref(self$126.$0);
    return $moonbitlang$core$builtin$abort$2(
             (moonbit_string_t)moonbit_string_literal_14.data,
               (moonbit_string_t)moonbit_string_literal_15.data
           );
  }
}

int64_t $StringView$$rev_find(
  struct $StringView self$122,
  struct $StringView str$121
) {
  int32_t end$750 = str$121.$2;
  int32_t start$751 = str$121.$1;
  int32_t _tmp$749 = end$750 - start$751;
  if (_tmp$749 <= 4) {
    return $moonbitlang$core$builtin$brute_force_rev_find(self$122, str$121);
  } else {
    return $moonbitlang$core$builtin$boyer_moore_horspool_rev_find(
             self$122, str$121
           );
  }
}

int64_t $moonbitlang$core$builtin$brute_force_rev_find(
  struct $StringView haystack$112,
  struct $StringView needle$114
) {
  int32_t end$747 = haystack$112.$2;
  int32_t start$748 = haystack$112.$1;
  int32_t haystack_len$111 = end$747 - start$748;
  int32_t end$745 = needle$114.$2;
  int32_t start$746 = needle$114.$1;
  int32_t needle_len$113 = end$745 - start$746;
  if (needle_len$113 > 0) {
    if (haystack_len$111 >= needle_len$113) {
      int32_t _p$463 = 0;
      moonbit_string_t _field$1097 = needle$114.$0;
      moonbit_string_t str$742 = _field$1097;
      int32_t start$744 = needle$114.$1;
      int32_t _tmp$743 = start$744 + _p$463;
      int32_t _tmp$1096 = str$742[_tmp$743];
      int32_t needle_first$115 = _tmp$1096;
      int32_t i$116 = haystack_len$111 - needle_len$113;
      while (1) {
        int32_t _tmp$722 = i$116;
        if (_tmp$722 >= 0) {
          int32_t _tmp$729;
          while (1) {
            int32_t _tmp$727 = i$116;
            int32_t _if_result$1200;
            if (_tmp$727 >= 0) {
              int32_t _p$466 = i$116;
              moonbit_string_t _field$1095 = haystack$112.$0;
              moonbit_string_t str$724 = _field$1095;
              int32_t start$726 = haystack$112.$1;
              int32_t _tmp$725 = start$726 + _p$466;
              int32_t _tmp$1094 = str$724[_tmp$725];
              int32_t _tmp$723 = _tmp$1094;
              _if_result$1200 = _tmp$723 != needle_first$115;
            } else {
              _if_result$1200 = 0;
            }
            if (_if_result$1200) {
              int32_t _tmp$728 = i$116;
              i$116 = _tmp$728 - 1;
              continue;
            }
            break;
          }
          _tmp$729 = i$116;
          if (_tmp$729 >= 0) {
            int32_t j$118 = 1;
            int32_t _tmp$741;
            while (1) {
              if (j$118 < needle_len$113) {
                int32_t _tmp$738 = i$116;
                int32_t _p$469 = _tmp$738 + j$118;
                moonbit_string_t _field$1093 = haystack$112.$0;
                moonbit_string_t str$735 = _field$1093;
                int32_t start$737 = haystack$112.$1;
                int32_t _tmp$736 = start$737 + _p$469;
                int32_t _tmp$1092 = str$735[_tmp$736];
                int32_t _tmp$730 = _tmp$1092;
                moonbit_string_t _field$1091 = needle$114.$0;
                moonbit_string_t str$732 = _field$1091;
                int32_t start$734 = needle$114.$1;
                int32_t _tmp$733 = start$734 + j$118;
                int32_t _tmp$1090 = str$732[_tmp$733];
                int32_t _tmp$731 = _tmp$1090;
                int32_t _tmp$739;
                if (_tmp$730 != _tmp$731) {
                  break;
                }
                _tmp$739 = j$118 + 1;
                j$118 = _tmp$739;
                continue;
              } else {
                int32_t _tmp$740;
                moonbit_decref(needle$114.$0);
                moonbit_decref(haystack$112.$0);
                _tmp$740 = i$116;
                return (int64_t)_tmp$740;
              }
              break;
            }
            _tmp$741 = i$116;
            i$116 = _tmp$741 - 1;
          }
          continue;
        } else {
          moonbit_decref(needle$114.$0);
          moonbit_decref(haystack$112.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$114.$0);
      moonbit_decref(haystack$112.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$114.$0);
    moonbit_decref(haystack$112.$0);
    return (int64_t)haystack_len$111;
  }
}

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_rev_find(
  struct $StringView haystack$101,
  struct $StringView needle$103
) {
  int32_t end$720 = haystack$101.$2;
  int32_t start$721 = haystack$101.$1;
  int32_t haystack_len$100 = end$720 - start$721;
  int32_t end$718 = needle$103.$2;
  int32_t start$719 = needle$103.$1;
  int32_t needle_len$102 = end$718 - start$719;
  if (needle_len$102 > 0) {
    if (haystack_len$100 >= needle_len$102) {
      int32_t* skip_table$104 =
        (int32_t*)moonbit_make_int32_array(256, needle_len$102);
      int32_t _tmp$700 = needle_len$102 - 1;
      int32_t i$105 = _tmp$700;
      int32_t _tmp$717;
      int32_t i$107;
      while (1) {
        if (i$105 > 0) {
          moonbit_string_t _field$1105 = needle$103.$0;
          moonbit_string_t str$696 = _field$1105;
          int32_t start$698 = needle$103.$1;
          int32_t _tmp$697 = start$698 + i$105;
          int32_t _tmp$1104 = str$696[_tmp$697];
          int32_t _tmp$695 = _tmp$1104;
          int32_t _tmp$694 = _tmp$695 & 255;
          int32_t _tmp$699;
          if (
            _tmp$694 < 0 || _tmp$694 >= Moonbit_array_length(skip_table$104)
          ) {
            moonbit_panic();
          }
          skip_table$104[_tmp$694] = i$105;
          _tmp$699 = i$105 - 1;
          i$105 = _tmp$699;
          continue;
        }
        break;
      }
      _tmp$717 = haystack_len$100 - needle_len$102;
      i$107 = _tmp$717;
      while (1) {
        if (i$107 >= 0) {
          int32_t j$108 = 0;
          moonbit_string_t _field$1099;
          moonbit_string_t str$714;
          int32_t start$716;
          int32_t _tmp$715;
          int32_t _tmp$1098;
          int32_t _tmp$713;
          int32_t _tmp$712;
          int32_t _tmp$711;
          int32_t _tmp$710;
          while (1) {
            if (j$108 < needle_len$102) {
              int32_t _p$452 = i$107 + j$108;
              moonbit_string_t _field$1103 = haystack$101.$0;
              moonbit_string_t str$706 = _field$1103;
              int32_t start$708 = haystack$101.$1;
              int32_t _tmp$707 = start$708 + _p$452;
              int32_t _tmp$1102 = str$706[_tmp$707];
              int32_t _tmp$701 = _tmp$1102;
              moonbit_string_t _field$1101 = needle$103.$0;
              moonbit_string_t str$703 = _field$1101;
              int32_t start$705 = needle$103.$1;
              int32_t _tmp$704 = start$705 + j$108;
              int32_t _tmp$1100 = str$703[_tmp$704];
              int32_t _tmp$702 = _tmp$1100;
              int32_t _tmp$709;
              if (_tmp$701 != _tmp$702) {
                break;
              }
              _tmp$709 = j$108 + 1;
              j$108 = _tmp$709;
              continue;
            } else {
              moonbit_decref(skip_table$104);
              moonbit_decref(needle$103.$0);
              moonbit_decref(haystack$101.$0);
              return (int64_t)i$107;
            }
            break;
          }
          _field$1099 = haystack$101.$0;
          str$714 = _field$1099;
          start$716 = haystack$101.$1;
          _tmp$715 = start$716 + i$107;
          _tmp$1098 = str$714[_tmp$715];
          _tmp$713 = _tmp$1098;
          _tmp$712 = _tmp$713 & 255;
          if (
            _tmp$712 < 0 || _tmp$712 >= Moonbit_array_length(skip_table$104)
          ) {
            moonbit_panic();
          }
          _tmp$711 = (int32_t)skip_table$104[_tmp$712];
          _tmp$710 = i$107 - _tmp$711;
          i$107 = _tmp$710;
          continue;
        } else {
          moonbit_decref(skip_table$104);
          moonbit_decref(needle$103.$0);
          moonbit_decref(haystack$101.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$103.$0);
      moonbit_decref(haystack$101.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$103.$0);
    moonbit_decref(haystack$101.$0);
    return (int64_t)haystack_len$100;
  }
}

int64_t $StringView$$find(
  struct $StringView self$99,
  struct $StringView str$98
) {
  int32_t end$692 = str$98.$2;
  int32_t start$693 = str$98.$1;
  int32_t _tmp$691 = end$692 - start$693;
  if (_tmp$691 <= 4) {
    return $moonbitlang$core$builtin$brute_force_find(self$99, str$98);
  } else {
    return $moonbitlang$core$builtin$boyer_moore_horspool_find(
             self$99, str$98
           );
  }
}

int64_t $moonbitlang$core$builtin$brute_force_find(
  struct $StringView haystack$88,
  struct $StringView needle$90
) {
  int32_t end$689 = haystack$88.$2;
  int32_t start$690 = haystack$88.$1;
  int32_t haystack_len$87 = end$689 - start$690;
  int32_t end$687 = needle$90.$2;
  int32_t start$688 = needle$90.$1;
  int32_t needle_len$89 = end$687 - start$688;
  if (needle_len$89 > 0) {
    if (haystack_len$87 >= needle_len$89) {
      int32_t _p$433 = 0;
      moonbit_string_t _field$1113 = needle$90.$0;
      moonbit_string_t str$684 = _field$1113;
      int32_t start$686 = needle$90.$1;
      int32_t _tmp$685 = start$686 + _p$433;
      int32_t _tmp$1112 = str$684[_tmp$685];
      int32_t needle_first$91 = _tmp$1112;
      int32_t forward_len$92 = haystack_len$87 - needle_len$89;
      int32_t i$93 = 0;
      while (1) {
        int32_t _tmp$664 = i$93;
        if (_tmp$664 <= forward_len$92) {
          int32_t _tmp$671;
          while (1) {
            int32_t _tmp$669 = i$93;
            int32_t _if_result$1207;
            if (_tmp$669 <= forward_len$92) {
              int32_t _p$436 = i$93;
              moonbit_string_t _field$1111 = haystack$88.$0;
              moonbit_string_t str$666 = _field$1111;
              int32_t start$668 = haystack$88.$1;
              int32_t _tmp$667 = start$668 + _p$436;
              int32_t _tmp$1110 = str$666[_tmp$667];
              int32_t _tmp$665 = _tmp$1110;
              _if_result$1207 = _tmp$665 != needle_first$91;
            } else {
              _if_result$1207 = 0;
            }
            if (_if_result$1207) {
              int32_t _tmp$670 = i$93;
              i$93 = _tmp$670 + 1;
              continue;
            }
            break;
          }
          _tmp$671 = i$93;
          if (_tmp$671 <= forward_len$92) {
            int32_t j$95 = 1;
            int32_t _tmp$683;
            while (1) {
              if (j$95 < needle_len$89) {
                int32_t _tmp$680 = i$93;
                int32_t _p$439 = _tmp$680 + j$95;
                moonbit_string_t _field$1109 = haystack$88.$0;
                moonbit_string_t str$677 = _field$1109;
                int32_t start$679 = haystack$88.$1;
                int32_t _tmp$678 = start$679 + _p$439;
                int32_t _tmp$1108 = str$677[_tmp$678];
                int32_t _tmp$672 = _tmp$1108;
                moonbit_string_t _field$1107 = needle$90.$0;
                moonbit_string_t str$674 = _field$1107;
                int32_t start$676 = needle$90.$1;
                int32_t _tmp$675 = start$676 + j$95;
                int32_t _tmp$1106 = str$674[_tmp$675];
                int32_t _tmp$673 = _tmp$1106;
                int32_t _tmp$681;
                if (_tmp$672 != _tmp$673) {
                  break;
                }
                _tmp$681 = j$95 + 1;
                j$95 = _tmp$681;
                continue;
              } else {
                int32_t _tmp$682;
                moonbit_decref(needle$90.$0);
                moonbit_decref(haystack$88.$0);
                _tmp$682 = i$93;
                return (int64_t)_tmp$682;
              }
              break;
            }
            _tmp$683 = i$93;
            i$93 = _tmp$683 + 1;
          }
          continue;
        } else {
          moonbit_decref(needle$90.$0);
          moonbit_decref(haystack$88.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$90.$0);
      moonbit_decref(haystack$88.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$90.$0);
    moonbit_decref(haystack$88.$0);
    return $moonbitlang$core$builtin$brute_force_find$constr$86;
  }
}

int64_t $moonbitlang$core$builtin$boyer_moore_horspool_find(
  struct $StringView haystack$74,
  struct $StringView needle$76
) {
  int32_t end$662 = haystack$74.$2;
  int32_t start$663 = haystack$74.$1;
  int32_t haystack_len$73 = end$662 - start$663;
  int32_t end$660 = needle$76.$2;
  int32_t start$661 = needle$76.$1;
  int32_t needle_len$75 = end$660 - start$661;
  if (needle_len$75 > 0) {
    if (haystack_len$73 >= needle_len$75) {
      int32_t* skip_table$77 =
        (int32_t*)moonbit_make_int32_array(256, needle_len$75);
      int32_t _end4301$78 = needle_len$75 - 1;
      int32_t i$79 = 0;
      int32_t i$81;
      while (1) {
        if (i$79 < _end4301$78) {
          moonbit_string_t _field$1121 = needle$76.$0;
          moonbit_string_t str$638 = _field$1121;
          int32_t start$640 = needle$76.$1;
          int32_t _tmp$639 = start$640 + i$79;
          int32_t _tmp$1120 = str$638[_tmp$639];
          int32_t _tmp$637 = _tmp$1120;
          int32_t _tmp$634 = _tmp$637 & 255;
          int32_t _tmp$636 = needle_len$75 - 1;
          int32_t _tmp$635 = _tmp$636 - i$79;
          int32_t _tmp$641;
          if (
            _tmp$634 < 0 || _tmp$634 >= Moonbit_array_length(skip_table$77)
          ) {
            moonbit_panic();
          }
          skip_table$77[_tmp$634] = _tmp$635;
          _tmp$641 = i$79 + 1;
          i$79 = _tmp$641;
          continue;
        }
        break;
      }
      i$81 = 0;
      while (1) {
        int32_t _tmp$642 = haystack_len$73 - needle_len$75;
        if (i$81 <= _tmp$642) {
          int32_t _end4307$82 = needle_len$75 - 1;
          int32_t j$83 = 0;
          int32_t _tmp$659;
          int32_t _p$426;
          moonbit_string_t _field$1115;
          moonbit_string_t str$656;
          int32_t start$658;
          int32_t _tmp$657;
          int32_t _tmp$1114;
          int32_t _tmp$655;
          int32_t _tmp$654;
          int32_t _tmp$653;
          int32_t _tmp$652;
          while (1) {
            if (j$83 <= _end4307$82) {
              int32_t _p$421 = i$81 + j$83;
              moonbit_string_t _field$1119 = haystack$74.$0;
              moonbit_string_t str$648 = _field$1119;
              int32_t start$650 = haystack$74.$1;
              int32_t _tmp$649 = start$650 + _p$421;
              int32_t _tmp$1118 = str$648[_tmp$649];
              int32_t _tmp$643 = _tmp$1118;
              moonbit_string_t _field$1117 = needle$76.$0;
              moonbit_string_t str$645 = _field$1117;
              int32_t start$647 = needle$76.$1;
              int32_t _tmp$646 = start$647 + j$83;
              int32_t _tmp$1116 = str$645[_tmp$646];
              int32_t _tmp$644 = _tmp$1116;
              int32_t _tmp$651;
              if (_tmp$643 != _tmp$644) {
                break;
              }
              _tmp$651 = j$83 + 1;
              j$83 = _tmp$651;
              continue;
            } else {
              moonbit_decref(skip_table$77);
              moonbit_decref(needle$76.$0);
              moonbit_decref(haystack$74.$0);
              return (int64_t)i$81;
            }
            break;
          }
          _tmp$659 = i$81 + needle_len$75;
          _p$426 = _tmp$659 - 1;
          _field$1115 = haystack$74.$0;
          str$656 = _field$1115;
          start$658 = haystack$74.$1;
          _tmp$657 = start$658 + _p$426;
          _tmp$1114 = str$656[_tmp$657];
          _tmp$655 = _tmp$1114;
          _tmp$654 = _tmp$655 & 255;
          if (
            _tmp$654 < 0 || _tmp$654 >= Moonbit_array_length(skip_table$77)
          ) {
            moonbit_panic();
          }
          _tmp$653 = (int32_t)skip_table$77[_tmp$654];
          _tmp$652 = i$81 + _tmp$653;
          i$81 = _tmp$652;
          continue;
        } else {
          moonbit_decref(skip_table$77);
          moonbit_decref(needle$76.$0);
          moonbit_decref(haystack$74.$0);
        }
        break;
      }
      return 4294967296ll;
    } else {
      moonbit_decref(needle$76.$0);
      moonbit_decref(haystack$74.$0);
      return 4294967296ll;
    }
  } else {
    moonbit_decref(needle$76.$0);
    moonbit_decref(haystack$74.$0);
    return $moonbitlang$core$builtin$boyer_moore_horspool_find$constr$72;
  }
}

int32_t $StringView$$unsafe_charcode_at(
  struct $StringView self$70,
  int32_t index$71
) {
  moonbit_string_t _field$1124 = self$70.$0;
  moonbit_string_t str$631 = _field$1124;
  int32_t _field$1123 = self$70.$1;
  int32_t start$633 = _field$1123;
  int32_t _tmp$632 = start$633 + index$71;
  int32_t _tmp$1122 = str$631[_tmp$632];
  moonbit_decref(str$631);
  return _tmp$1122;
}

int32_t $StringView$$length(struct $StringView self$69) {
  int32_t end$629 = self$69.$2;
  int32_t _field$1125 = self$69.$1;
  int32_t start$630;
  moonbit_decref(self$69.$0);
  start$630 = _field$1125;
  return end$629 - start$630;
}

int32_t* $$moonbitlang$core$builtin$Array$$buffer$0(
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* self$68
) {
  int32_t* _field$1126 = self$68->$0;
  int32_t _cnt$1163 = Moonbit_object_header(self$68)->rc;
  if (_cnt$1163 > 1) {
    int32_t _new_cnt$1164;
    moonbit_incref(_field$1126);
    _new_cnt$1164 = _cnt$1163 - 1;
    Moonbit_object_header(self$68)->rc = _new_cnt$1164;
  } else if (_cnt$1163 == 1) {
    moonbit_free(self$68);
  }
  return _field$1126;
}

int32_t $Int$$is_trailing_surrogate(int32_t self$67) {
  return 56320 <= self$67 && self$67 <= 57343;
}

int32_t $Int$$is_leading_surrogate(int32_t self$66) {
  return 55296 <= self$66 && self$66 <= 56319;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
  struct $$moonbitlang$core$builtin$StringBuilder* self$63,
  int32_t ch$65
) {
  int32_t len$624 = self$63->$1;
  int32_t _tmp$623 = len$624 + 4;
  moonbit_bytes_t _field$1127;
  moonbit_bytes_t data$627;
  int32_t len$628;
  int32_t inc$64;
  int32_t len$626;
  int32_t _tmp$625;
  moonbit_incref(self$63);
  $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
    self$63, _tmp$623
  );
  _field$1127 = self$63->$0;
  data$627 = _field$1127;
  len$628 = self$63->$1;
  moonbit_incref(data$627);
  inc$64 = $FixedArray$$set_utf16le_char(data$627, len$628, ch$65);
  len$626 = self$63->$1;
  _tmp$625 = len$626 + inc$64;
  self$63->$1 = _tmp$625;
  moonbit_decref(self$63);
  return 0;
}

int32_t $$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary(
  struct $$moonbitlang$core$builtin$StringBuilder* self$58,
  int32_t required$59
) {
  moonbit_bytes_t _field$1131 = self$58->$0;
  moonbit_bytes_t data$622 = _field$1131;
  int32_t _tmp$1130 = Moonbit_array_length(data$622);
  int32_t current_len$57 = _tmp$1130;
  int32_t enough_space$60;
  int32_t _tmp$621;
  moonbit_bytes_t new_data$62;
  moonbit_bytes_t _field$1129;
  moonbit_bytes_t data$619;
  int32_t len$620;
  moonbit_bytes_t _old$1128;
  if (required$59 <= current_len$57) {
    moonbit_decref(self$58);
    return 0;
  }
  enough_space$60 = current_len$57;
  while (1) {
    int32_t _tmp$617 = enough_space$60;
    if (_tmp$617 < required$59) {
      int32_t _tmp$618 = enough_space$60;
      enough_space$60 = _tmp$618 * 2;
      continue;
    }
    break;
  }
  _tmp$621 = enough_space$60;
  new_data$62 = (moonbit_bytes_t)moonbit_make_bytes(_tmp$621, 0);
  _field$1129 = self$58->$0;
  data$619 = _field$1129;
  len$620 = self$58->$1;
  moonbit_incref(data$619);
  moonbit_incref(new_data$62);
  $FixedArray$$unsafe_blit$0(new_data$62, 0, data$619, 0, len$620);
  _old$1128 = self$58->$0;
  moonbit_decref(_old$1128);
  self$58->$0 = new_data$62;
  moonbit_decref(self$58);
  return 0;
}

int32_t $$moonbitlang$core$builtin$Default$$Byte$$default() {
  return 0;
}

int32_t $FixedArray$$set_utf16le_char(
  moonbit_bytes_t self$52,
  int32_t offset$53,
  int32_t value$51
) {
  int32_t _tmp$616 = value$51;
  uint32_t code$50 = *(uint32_t*)&_tmp$616;
  if (code$50 < 65536u) {
    uint32_t _p$395 = code$50 & 255u;
    int32_t _tmp$599 = *(int32_t*)&_p$395;
    int32_t _tmp$598 = _tmp$599 & 0xff;
    int32_t _tmp$600;
    uint32_t _p$398;
    int32_t _tmp$602;
    int32_t _tmp$601;
    if (offset$53 < 0 || offset$53 >= Moonbit_array_length(self$52)) {
      moonbit_panic();
    }
    self$52[offset$53] = _tmp$598;
    _tmp$600 = offset$53 + 1;
    _p$398 = code$50 >> 8;
    _tmp$602 = *(int32_t*)&_p$398;
    _tmp$601 = _tmp$602 & 0xff;
    if (_tmp$600 < 0 || _tmp$600 >= Moonbit_array_length(self$52)) {
      moonbit_panic();
    }
    self$52[_tmp$600] = _tmp$601;
    moonbit_decref(self$52);
    return 2;
  } else if (code$50 < 1114112u) {
    uint32_t hi$54 = code$50 - 65536u;
    uint32_t _tmp$615 = hi$54 >> 10;
    uint32_t lo$55 = _tmp$615 | 55296u;
    uint32_t _tmp$614 = hi$54 & 1023u;
    uint32_t hi$56 = _tmp$614 | 56320u;
    uint32_t _p$401 = lo$55 & 255u;
    int32_t _tmp$604 = *(int32_t*)&_p$401;
    int32_t _tmp$603 = _tmp$604 & 0xff;
    int32_t _tmp$605;
    uint32_t _p$404;
    int32_t _tmp$607;
    int32_t _tmp$606;
    int32_t _tmp$608;
    uint32_t _p$407;
    int32_t _tmp$610;
    int32_t _tmp$609;
    int32_t _tmp$611;
    uint32_t _p$410;
    int32_t _tmp$613;
    int32_t _tmp$612;
    if (offset$53 < 0 || offset$53 >= Moonbit_array_length(self$52)) {
      moonbit_panic();
    }
    self$52[offset$53] = _tmp$603;
    _tmp$605 = offset$53 + 1;
    _p$404 = lo$55 >> 8;
    _tmp$607 = *(int32_t*)&_p$404;
    _tmp$606 = _tmp$607 & 0xff;
    if (_tmp$605 < 0 || _tmp$605 >= Moonbit_array_length(self$52)) {
      moonbit_panic();
    }
    self$52[_tmp$605] = _tmp$606;
    _tmp$608 = offset$53 + 2;
    _p$407 = hi$56 & 255u;
    _tmp$610 = *(int32_t*)&_p$407;
    _tmp$609 = _tmp$610 & 0xff;
    if (_tmp$608 < 0 || _tmp$608 >= Moonbit_array_length(self$52)) {
      moonbit_panic();
    }
    self$52[_tmp$608] = _tmp$609;
    _tmp$611 = offset$53 + 3;
    _p$410 = hi$56 >> 8;
    _tmp$613 = *(int32_t*)&_p$410;
    _tmp$612 = _tmp$613 & 0xff;
    if (_tmp$611 < 0 || _tmp$611 >= Moonbit_array_length(self$52)) {
      moonbit_panic();
    }
    self$52[_tmp$611] = _tmp$612;
    moonbit_decref(self$52);
    return 4;
  } else {
    moonbit_decref(self$52);
    return $moonbitlang$core$builtin$abort$0(
             (moonbit_string_t)moonbit_string_literal_16.data,
               (moonbit_string_t)moonbit_string_literal_17.data
           );
  }
}

int32_t $UInt$$to_byte(uint32_t self$49) {
  int32_t _tmp$597 = *(int32_t*)&self$49;
  return _tmp$597 & 0xff;
}

uint32_t $Char$$to_uint(int32_t self$48) {
  int32_t _tmp$596 = self$48;
  return *(uint32_t*)&_tmp$596;
}

moonbit_string_t $$moonbitlang$core$builtin$StringBuilder$$to_string(
  struct $$moonbitlang$core$builtin$StringBuilder* self$47
) {
  moonbit_bytes_t _field$1133 = self$47->$0;
  moonbit_bytes_t data$595 = _field$1133;
  moonbit_bytes_t _tmp$592;
  int32_t _field$1132;
  int32_t len$594;
  int64_t _tmp$593;
  moonbit_incref(data$595);
  _tmp$592 = data$595;
  _field$1132 = self$47->$1;
  moonbit_decref(self$47);
  len$594 = _field$1132;
  _tmp$593 = (int64_t)len$594;
  return $Bytes$$to_unchecked_string$inner(_tmp$592, 0, _tmp$593);
}

moonbit_string_t $Bytes$$to_unchecked_string$inner(
  moonbit_bytes_t self$42,
  int32_t offset$46,
  int64_t length$44
) {
  int32_t len$41 = Moonbit_array_length(self$42);
  int32_t length$43;
  int32_t _if_result$1213;
  if (length$44 == 4294967296ll) {
    length$43 = len$41 - offset$46;
  } else {
    int64_t _Some$45 = length$44;
    length$43 = (int32_t)_Some$45;
  }
  if (offset$46 >= 0) {
    if (length$43 >= 0) {
      int32_t _tmp$591 = offset$46 + length$43;
      _if_result$1213 = _tmp$591 <= len$41;
    } else {
      _if_result$1213 = 0;
    }
  } else {
    _if_result$1213 = 0;
  }
  if (_if_result$1213) {
    return $moonbitlang$core$builtin$unsafe_sub_string(
             self$42, offset$46, length$43
           );
  } else {
    moonbit_decref(self$42);
    moonbit_panic();
  }
}

struct $$moonbitlang$core$builtin$StringBuilder* $$moonbitlang$core$builtin$StringBuilder$$new$inner(
  int32_t size_hint$39
) {
  int32_t initial$38;
  moonbit_bytes_t data$40;
  struct $$moonbitlang$core$builtin$StringBuilder* _block$1214;
  if (size_hint$39 < 1) {
    initial$38 = 1;
  } else {
    initial$38 = size_hint$39;
  }
  data$40 = (moonbit_bytes_t)moonbit_make_bytes(initial$38, 0);
  _block$1214
  = (struct $$moonbitlang$core$builtin$StringBuilder*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$builtin$StringBuilder)
    );
  Moonbit_object_header(_block$1214)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $$moonbitlang$core$builtin$StringBuilder, $0) >> 2, 1, 0
  );
  _block$1214->$0 = data$40;
  _block$1214->$1 = 0;
  return _block$1214;
}

int32_t $$moonbitlang$core$builtin$UninitializedArray$$unsafe_blit$0(
  int32_t* dst$33,
  int32_t dst_offset$34,
  int32_t* src$35,
  int32_t src_offset$36,
  int32_t len$37
) {
  $FixedArray$$unsafe_blit$1(
    dst$33, dst_offset$34, src$35, src_offset$36, len$37
  );
  return 0;
}

int32_t $FixedArray$$unsafe_blit$1(
  int32_t* dst$24,
  int32_t dst_offset$26,
  int32_t* src$25,
  int32_t src_offset$27,
  int32_t len$29
) {
  if (dst$24 == src$25 && dst_offset$26 < src_offset$27) {
    int32_t i$28 = 0;
    while (1) {
      if (i$28 < len$29) {
        int32_t _tmp$582 = dst_offset$26 + i$28;
        int32_t _tmp$584 = src_offset$27 + i$28;
        int32_t _tmp$583;
        int32_t _tmp$585;
        if (_tmp$584 < 0 || _tmp$584 >= Moonbit_array_length(src$25)) {
          moonbit_panic();
        }
        _tmp$583 = (int32_t)src$25[_tmp$584];
        if (_tmp$582 < 0 || _tmp$582 >= Moonbit_array_length(dst$24)) {
          moonbit_panic();
        }
        dst$24[_tmp$582] = _tmp$583;
        _tmp$585 = i$28 + 1;
        i$28 = _tmp$585;
        continue;
      } else {
        moonbit_decref(src$25);
        moonbit_decref(dst$24);
      }
      break;
    }
  } else {
    int32_t _tmp$590 = len$29 - 1;
    int32_t i$31 = _tmp$590;
    while (1) {
      if (i$31 >= 0) {
        int32_t _tmp$586 = dst_offset$26 + i$31;
        int32_t _tmp$588 = src_offset$27 + i$31;
        int32_t _tmp$587;
        int32_t _tmp$589;
        if (_tmp$588 < 0 || _tmp$588 >= Moonbit_array_length(src$25)) {
          moonbit_panic();
        }
        _tmp$587 = (int32_t)src$25[_tmp$588];
        if (_tmp$586 < 0 || _tmp$586 >= Moonbit_array_length(dst$24)) {
          moonbit_panic();
        }
        dst$24[_tmp$586] = _tmp$587;
        _tmp$589 = i$31 - 1;
        i$31 = _tmp$589;
        continue;
      } else {
        moonbit_decref(src$25);
        moonbit_decref(dst$24);
      }
      break;
    }
  }
  return 0;
}

int32_t $FixedArray$$unsafe_blit$0(
  moonbit_bytes_t dst$15,
  int32_t dst_offset$17,
  moonbit_bytes_t src$16,
  int32_t src_offset$18,
  int32_t len$20
) {
  if (dst$15 == src$16 && dst_offset$17 < src_offset$18) {
    int32_t i$19 = 0;
    while (1) {
      if (i$19 < len$20) {
        int32_t _tmp$573 = dst_offset$17 + i$19;
        int32_t _tmp$575 = src_offset$18 + i$19;
        int32_t _tmp$574;
        int32_t _tmp$576;
        if (_tmp$575 < 0 || _tmp$575 >= Moonbit_array_length(src$16)) {
          moonbit_panic();
        }
        _tmp$574 = (int32_t)src$16[_tmp$575];
        if (_tmp$573 < 0 || _tmp$573 >= Moonbit_array_length(dst$15)) {
          moonbit_panic();
        }
        dst$15[_tmp$573] = _tmp$574;
        _tmp$576 = i$19 + 1;
        i$19 = _tmp$576;
        continue;
      } else {
        moonbit_decref(src$16);
        moonbit_decref(dst$15);
      }
      break;
    }
  } else {
    int32_t _tmp$581 = len$20 - 1;
    int32_t i$22 = _tmp$581;
    while (1) {
      if (i$22 >= 0) {
        int32_t _tmp$577 = dst_offset$17 + i$22;
        int32_t _tmp$579 = src_offset$18 + i$22;
        int32_t _tmp$578;
        int32_t _tmp$580;
        if (_tmp$579 < 0 || _tmp$579 >= Moonbit_array_length(src$16)) {
          moonbit_panic();
        }
        _tmp$578 = (int32_t)src$16[_tmp$579];
        if (_tmp$577 < 0 || _tmp$577 >= Moonbit_array_length(dst$15)) {
          moonbit_panic();
        }
        dst$15[_tmp$577] = _tmp$578;
        _tmp$580 = i$22 - 1;
        i$22 = _tmp$580;
        continue;
      } else {
        moonbit_decref(src$16);
        moonbit_decref(dst$15);
      }
      break;
    }
  }
  return 0;
}

int64_t $moonbitlang$core$builtin$abort$3(
  moonbit_string_t string$13,
  moonbit_string_t loc$14
) {
  moonbit_string_t _tmp$571 =
    moonbit_add_string(
      string$13, (moonbit_string_t)moonbit_string_literal_18.data
    );
  moonbit_string_t _tmp$572 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(loc$14);
  moonbit_string_t _tmp$570 = moonbit_add_string(_tmp$571, _tmp$572);
  moonbit_string_t _tmp$569 =
    moonbit_add_string(
      _tmp$570, (moonbit_string_t)moonbit_string_literal_19.data
    );
  return $moonbitlang$core$abort$abort$3(_tmp$569);
}

struct $StringView $moonbitlang$core$builtin$abort$2(
  moonbit_string_t string$11,
  moonbit_string_t loc$12
) {
  moonbit_string_t _tmp$567 =
    moonbit_add_string(
      string$11, (moonbit_string_t)moonbit_string_literal_18.data
    );
  moonbit_string_t _tmp$568 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(loc$12);
  moonbit_string_t _tmp$566 = moonbit_add_string(_tmp$567, _tmp$568);
  moonbit_string_t _tmp$565 =
    moonbit_add_string(
      _tmp$566, (moonbit_string_t)moonbit_string_literal_19.data
    );
  return $moonbitlang$core$abort$abort$2(_tmp$565);
}

int32_t $moonbitlang$core$builtin$abort$1(
  moonbit_string_t string$9,
  moonbit_string_t loc$10
) {
  moonbit_string_t _tmp$563 =
    moonbit_add_string(
      string$9, (moonbit_string_t)moonbit_string_literal_18.data
    );
  moonbit_string_t _tmp$564 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(loc$10);
  moonbit_string_t _tmp$562 = moonbit_add_string(_tmp$563, _tmp$564);
  moonbit_string_t _tmp$561 =
    moonbit_add_string(
      _tmp$562, (moonbit_string_t)moonbit_string_literal_19.data
    );
  $moonbitlang$core$abort$abort$1(_tmp$561);
  return 0;
}

int32_t $moonbitlang$core$builtin$abort$0(
  moonbit_string_t string$7,
  moonbit_string_t loc$8
) {
  moonbit_string_t _tmp$559 =
    moonbit_add_string(
      string$7, (moonbit_string_t)moonbit_string_literal_18.data
    );
  moonbit_string_t _tmp$560 =
    $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$2(loc$8);
  moonbit_string_t _tmp$558 = moonbit_add_string(_tmp$559, _tmp$560);
  moonbit_string_t _tmp$557 =
    moonbit_add_string(
      _tmp$558, (moonbit_string_t)moonbit_string_literal_19.data
    );
  return $moonbitlang$core$abort$abort$0(_tmp$557);
}

int32_t $$moonbitlang$core$builtin$Logger$$write_object$0(
  struct $$moonbitlang$core$builtin$Logger self$6,
  int32_t obj$5
) {
  $$moonbitlang$core$builtin$Show$$Int$$output(obj$5, self$6);
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
  return 0;
}

int32_t $moonbitlang$core$abort$abort$0(moonbit_string_t msg$1) {
  moonbit_println(msg$1);
  moonbit_decref(msg$1);
  moonbit_panic();
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$541,
  int32_t _param$540
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$539 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$541;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char(
    _self$539, _param$540
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$538,
  struct $StringView _param$537
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$536 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$538;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view(
    _self$536, _param$537
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0(
  void* _obj_ptr$535,
  moonbit_string_t _param$532,
  int32_t _param$533,
  int32_t _param$534
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$531 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$535;
  $$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0(
    _self$531, _param$532, _param$533, _param$534
  );
  return 0;
}

int32_t $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger(
  void* _obj_ptr$530,
  moonbit_string_t _param$529
) {
  struct $$moonbitlang$core$builtin$StringBuilder* _self$528 =
    (struct $$moonbitlang$core$builtin$StringBuilder*)_obj_ptr$530;
  $$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string(
    _self$528, _param$529
  );
  return 0;
}

void moonbit_init() {
  $moonbitlang$core$builtin$boyer_moore_horspool_find$constr$72 = (int64_t)0;
  $moonbitlang$core$builtin$brute_force_find$constr$86 = (int64_t)0;
}

int main(int argc, char** argv) {
  int32_t* _tmp$556;
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* arr$373;
  moonbit_string_t _tmp$543;
  moonbit_string_t _tmp$542;
  int32_t sum$374;
  int32_t _len$375;
  int32_t _i$376;
  int32_t _tmp$549;
  moonbit_string_t _tmp$548;
  moonbit_string_t _tmp$547;
  int32_t* _tmp$555;
  struct $$moonbitlang$core$builtin$Array$3c$Int$3e$* doubled$379;
  int32_t _len$380;
  int32_t _i$381;
  moonbit_string_t _tmp$554;
  moonbit_string_t _tmp$553;
  moonbit_runtime_init(argc, argv);
  moonbit_init();
  _tmp$556 = (int32_t*)moonbit_make_int32_array_raw(5);
  _tmp$556[0] = 1;
  _tmp$556[1] = 2;
  _tmp$556[2] = 3;
  _tmp$556[3] = 4;
  _tmp$556[4] = 5;
  arr$373
  = (struct $$moonbitlang$core$builtin$Array$3c$Int$3e$*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$builtin$Array$3c$Int$3e$)
    );
  Moonbit_object_header(arr$373)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $$moonbitlang$core$builtin$Array$3c$Int$3e$, $0) >> 2,
      1,
      0
  );
  arr$373->$0 = _tmp$556;
  arr$373->$1 = 5;
  moonbit_incref(arr$373);
  _tmp$543
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
    arr$373
  );
  _tmp$542
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_20.data, _tmp$543
  );
  $moonbitlang$core$builtin$println$0(_tmp$542);
  sum$374 = 0;
  _len$375 = arr$373->$1;
  _i$376 = 0;
  while (1) {
    if (_i$376 < _len$375) {
      int32_t* _field$1137 = arr$373->$0;
      int32_t* buf$545 = _field$1137;
      int32_t _tmp$1136 = (int32_t)buf$545[_i$376];
      int32_t x$377 = _tmp$1136;
      int32_t _tmp$544 = sum$374;
      int32_t _tmp$546;
      sum$374 = _tmp$544 + x$377;
      _tmp$546 = _i$376 + 1;
      _i$376 = _tmp$546;
      continue;
    }
    break;
  }
  _tmp$549 = sum$374;
  _tmp$548
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1(
    _tmp$549
  );
  _tmp$547
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_21.data, _tmp$548
  );
  $moonbitlang$core$builtin$println$0(_tmp$547);
  _tmp$555 = (int32_t*)moonbit_empty_int32_array;
  doubled$379
  = (struct $$moonbitlang$core$builtin$Array$3c$Int$3e$*)moonbit_malloc(
      sizeof(struct $$moonbitlang$core$builtin$Array$3c$Int$3e$)
    );
  Moonbit_object_header(doubled$379)->meta
  = Moonbit_make_regular_object_header(
    offsetof(struct $$moonbitlang$core$builtin$Array$3c$Int$3e$, $0) >> 2,
      1,
      0
  );
  doubled$379->$0 = _tmp$555;
  doubled$379->$1 = 0;
  _len$380 = arr$373->$1;
  _i$381 = 0;
  while (1) {
    if (_i$381 < _len$380) {
      int32_t* _field$1135 = arr$373->$0;
      int32_t* buf$551 = _field$1135;
      int32_t _tmp$1134 = (int32_t)buf$551[_i$381];
      int32_t x$382 = _tmp$1134;
      int32_t _tmp$550 = x$382 * 2;
      int32_t _tmp$552;
      moonbit_incref(doubled$379);
      $$moonbitlang$core$builtin$Array$$push$0(doubled$379, _tmp$550);
      _tmp$552 = _i$381 + 1;
      _i$381 = _tmp$552;
      continue;
    } else {
      moonbit_decref(arr$373);
    }
    break;
  }
  _tmp$554
  = $$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0(
    doubled$379
  );
  _tmp$553
  = moonbit_add_string(
    (moonbit_string_t)moonbit_string_literal_22.data, _tmp$554
  );
  $moonbitlang$core$builtin$println$0(_tmp$553);
  return 0;
}