
#include "hermes/VM/static_h.h"

#include <stdlib.h>


static uint32_t unit_index;
static inline SHSymbolID* get_symbols(SHUnit *);
static inline SHWritePropertyCacheEntry* get_write_prop_cache(SHUnit *);
static inline SHReadPropertyCacheEntry* get_read_prop_cache(SHUnit *);
static inline SHPrivateNameCacheEntry* get_private_name_cache(SHUnit *);
static const SHSrcLoc s_source_locations[];
static SHNativeFuncInfo s_function_info_table[];
static SHLegacyValue _0_global(SHRuntime *shr);
static SHLegacyValue _1_fib(SHRuntime *shr);
// recursion.js:2:1
static SHLegacyValue _0_global(SHRuntime *shr) {
  _SH_MODEL();
  struct {
    SHLocals head;
    SHLegacyValue t0;
    SHLegacyValue t1;
    SHLegacyValue t2;
    SHLegacyValue t3;
    SHLegacyValue t4;
    SHLegacyValue t5;
    SHLegacyValue t6;
    SHLegacyValue t7;
  } locals;
  _sh_check_native_stack_overflow(shr);
  SHLegacyValue *frame = _sh_enter(shr, &locals.head, 10);
  locals.head.count =8;
  SHUnit *shUnit = shr->units[unit_index];
  locals.t0 = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_undefined();
  locals.t2 = _sh_ljs_undefined();
  locals.t3 = _sh_ljs_undefined();
  locals.t4 = _sh_ljs_undefined();
  locals.t5 = _sh_ljs_undefined();
  locals.t6 = _sh_ljs_undefined();
  locals.t7 = _sh_ljs_undefined();
  SHLegacyValue np0 = _sh_ljs_undefined();
  SHLegacyValue np1 = _sh_ljs_undefined();
  SHLegacyValue np2 = _sh_ljs_undefined();

L0:
  ;
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[1] /*fib*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[2] /*i*/);
  locals.t3 = _sh_ljs_get_global_object(shr);
  locals.t0 = _sh_ljs_create_closure(shr, NULL, _1_fib, &s_function_info_table[1], shUnit);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t3, get_symbols(shUnit)[1] /*fib*/, &locals.t0, get_write_prop_cache(shUnit) + 0);
  np0 = _sh_ljs_double(0);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t3, get_symbols(shUnit)[2] /*i*/, &np0, get_write_prop_cache(shUnit) + 1);
  locals.t0 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[2] /*i*/, get_read_prop_cache(shUnit) + 0);
  np2 = _sh_ljs_double(10);
  np0 = _sh_ljs_bool(_sh_ljs_less_equal_rjs_inline(shr, &locals.t0, &np2));
  np1 = _sh_ljs_undefined();
  locals.t2 = _sh_ljs_get_string(shr, get_symbols(shUnit)[3] /*Fib(*/);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[4] /*) = */);
  locals.t0 = _sh_ljs_undefined();
  if(_sh_ljs_get_bool(np0)) goto L1;
  goto L2;

L1:
  ;
  locals.t5 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t3, get_symbols(shUnit)[5] /*print*/, get_read_prop_cache(shUnit) + 1);
  locals.t4 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[2] /*i*/, get_read_prop_cache(shUnit) + 2);
  locals.t4 = _sh_ljs_add_rjs_inline(shr, &locals.t2, &locals.t4);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[1] /*fib*/, get_read_prop_cache(shUnit) + 3);
  frame[1] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[2] /*i*/, get_read_prop_cache(shUnit) + 4);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t6 = _sh_ljs_call(shr, frame, 1);
  locals.t4 = _sh_string_concat(shr, 2, &locals.t4, &locals.t1);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t4, &locals.t6);
  frame[4] = _sh_ljs_undefined();
  frame[3] = locals.t5;
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  locals.t5 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[2] /*i*/, get_read_prop_cache(shUnit) + 5);
  locals.t5 = _sh_ljs_inc_rjs_inline(shr, &locals.t5);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t3, get_symbols(shUnit)[2] /*i*/, &locals.t5, get_write_prop_cache(shUnit) + 2);
  locals.t5 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[2] /*i*/, get_read_prop_cache(shUnit) + 6);
  np0 = _sh_ljs_bool(_sh_ljs_less_equal_rjs_inline(shr, &locals.t5, &np2));
  if(_sh_ljs_get_bool(np0)) goto L1;
  goto L2;

L2:
  ;
  // PhiInst
  _sh_leave(shr, &locals.head, frame);
  return locals.t0;
}
// recursion.js:2:1
static SHLegacyValue _1_fib(SHRuntime *shr) {
  struct {
    SHLocals head;
    SHLegacyValue t0;
    SHLegacyValue t1;
    SHLegacyValue t2;
  } locals;
  _sh_check_native_stack_overflow(shr);
  SHLegacyValue *frame = _sh_enter(shr, &locals.head, 10);
  locals.head.count =3;
  SHUnit *shUnit = shr->units[unit_index];
  locals.t0 = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_undefined();
  locals.t2 = _sh_ljs_undefined();
  SHLegacyValue np0 = _sh_ljs_undefined();
  SHLegacyValue np1 = _sh_ljs_undefined();

L0:
  ;
  locals.t0 = _sh_ljs_param(frame, 1);
  np0 = _sh_ljs_double(1);
  np1 = _sh_ljs_bool(_sh_ljs_less_equal_rjs_inline(shr, &locals.t0, &np0));
  if(_sh_ljs_get_bool(np1)) goto L2;
  goto L1;

L1:
  ;
  locals.t1 = _sh_ljs_get_global_object(shr);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[1] /*fib*/, get_read_prop_cache(shUnit) + 7);
  frame[1] = _sh_ljs_sub_rjs_inline(shr, &locals.t0, &np0);
  np1 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t2 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[1] /*fib*/, get_read_prop_cache(shUnit) + 8);
  np0 = _sh_ljs_double(2);
  frame[1] = _sh_ljs_sub_rjs_inline(shr, &locals.t0, &np0);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_add_rjs_inline(shr, &locals.t2, &locals.t1);
  _sh_leave(shr, &locals.head, frame);
  return locals.t1;

L2:
  ;
  _sh_leave(shr, &locals.head, frame);
  return locals.t0;
}
static unsigned char s_literal_val_buffer[0] = {};
static unsigned char s_obj_key_buffer[0] = {};
static const SHShapeTableEntry s_obj_shape_table[] = {
};

static const SHSrcLoc s_source_locations[] = {
  { .filename_idx = 0, .line = 0, .column = 0 },
};

static SHNativeFuncInfo s_function_info_table[] = {
  { .name_index = 6, .arg_count = 0, .prohibit_invoke = 2, .kind = 0 },
  { .name_index = 1, .arg_count = 1, .prohibit_invoke = 2, .kind = 0 },
};
static const char s_ascii_pool[] = {
  '\0',
  'f', 'i', 'b', '\0',
  'i', '\0',
  'F', 'i', 'b', '(', '\0',
  ')', ' ', '=', ' ', '\0',
  'p', 'r', 'i', 'n', 't', '\0',
  'g', 'l', 'o', 'b', 'a', 'l', '\0',
};
static const char16_t s_u16_pool[] = {
};
static const uint32_t s_strings[] = {0,0,0,1,3,2473893398,5,1,107256,7,4,3548902262,12,4,577375795,17,5,2794059355,23,6,615793799,};
#define CREATE_THIS_UNIT sh_export_recursion
struct UnitData {
  SHUnit unit;
  SHSymbolID symbol_data[7];
  SHWritePropertyCacheEntry write_prop_cache_data[3];
  SHReadPropertyCacheEntry read_prop_cache_data[9];
  SHPrivateNameCacheEntry private_name_cache_data[0];
  SHCompressedPointer object_literal_class_cache[0];
};
SHUnit *CREATE_THIS_UNIT(void) {
  struct UnitData *unit_data = calloc(sizeof(struct UnitData), 1);
  *unit_data = (struct UnitData){.unit = {.index = &unit_index,.num_symbols =7, .num_write_prop_cache_entries = 3, .num_read_prop_cache_entries = 9, .ascii_pool = s_ascii_pool, .u16_pool = s_u16_pool,.strings = s_strings, .symbols = unit_data->symbol_data,.write_prop_cache = unit_data->write_prop_cache_data,.read_prop_cache = unit_data->read_prop_cache_data, .private_name_cache = unit_data->private_name_cache_data, .obj_key_buffer = s_obj_key_buffer, .obj_key_buffer_size = 0, .literal_val_buffer = s_literal_val_buffer, .literal_val_buffer_size = 0, .obj_shape_table = s_obj_shape_table, .obj_shape_table_count = 0, .object_literal_class_cache = unit_data->object_literal_class_cache, .source_locations = s_source_locations, .source_locations_size = 1, .unit_main = _0_global, .unit_main_info = &s_function_info_table[0], .unit_name = "sh_compiled" }};
  return (SHUnit *)unit_data;
}

SHSymbolID *get_symbols(SHUnit *unit) {
  return ((struct UnitData *)unit)->symbol_data;
}

SHWritePropertyCacheEntry *get_write_prop_cache(SHUnit *unit) {
  return ((struct UnitData *)unit)->write_prop_cache_data;
}
SHReadPropertyCacheEntry *get_read_prop_cache(SHUnit *unit) {
  return ((struct UnitData *)unit)->read_prop_cache_data;
}
SHPrivateNameCacheEntry *get_private_name_cache(SHUnit *unit) {
  return ((struct UnitData *)unit)->private_name_cache_data;
}
