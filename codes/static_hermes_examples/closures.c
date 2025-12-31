
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
static SHLegacyValue _1_makeCounter(SHRuntime *shr);
static SHLegacyValue _2_(SHRuntime *shr);
// closures.js:3:1
static SHLegacyValue _0_global(SHRuntime *shr) {
  _SH_MODEL();
  struct {
    SHLocals head;
    SHLegacyValue t0;
    SHLegacyValue t1;
    SHLegacyValue t2;
    SHLegacyValue t3;
    SHLegacyValue t4;
  } locals;
  _sh_check_native_stack_overflow(shr);
  SHLegacyValue *frame = _sh_enter(shr, &locals.head, 10);
  locals.head.count =5;
  SHUnit *shUnit = shr->units[unit_index];
  locals.t0 = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_undefined();
  locals.t2 = _sh_ljs_undefined();
  locals.t3 = _sh_ljs_undefined();
  locals.t4 = _sh_ljs_undefined();
  SHLegacyValue np0 = _sh_ljs_undefined();
  SHLegacyValue np1 = _sh_ljs_undefined();

L0:
  ;
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[1] /*makeCounter*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[2] /*counter1*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[3] /*counter2*/);
  locals.t0 = _sh_ljs_get_global_object(shr);
  locals.t1 = _sh_ljs_create_closure(shr, NULL, _1_makeCounter, &s_function_info_table[1], shUnit);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[1] /*makeCounter*/, &locals.t1, get_write_prop_cache(shUnit) + 0);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*makeCounter*/, get_read_prop_cache(shUnit) + 0);
  frame[1] = _sh_ljs_double(10);
  np0 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[2] /*counter1*/, &locals.t1, get_write_prop_cache(shUnit) + 1);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*makeCounter*/, get_read_prop_cache(shUnit) + 1);
  frame[1] = _sh_ljs_double(100);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[3] /*counter2*/, &locals.t1, get_write_prop_cache(shUnit) + 2);
  locals.t3 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 2);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*counter1*/, get_read_prop_cache(shUnit) + 3);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 0);
  locals.t2 = _sh_ljs_get_string(shr, get_symbols(shUnit)[5] /*Counter 1: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t2, &locals.t1);
  frame[4] = _sh_ljs_undefined();
  frame[3] = locals.t3;
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t3 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 4);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*counter1*/, get_read_prop_cache(shUnit) + 5);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 0);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t2, &locals.t1);
  frame[4] = _sh_ljs_undefined();
  frame[3] = locals.t3;
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t3 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 6);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*counter2*/, get_read_prop_cache(shUnit) + 7);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t4 = _sh_ljs_call(shr, frame, 0);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[6] /*Counter 2: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t4);
  frame[4] = _sh_ljs_undefined();
  frame[3] = locals.t3;
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 8);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*counter1*/, get_read_prop_cache(shUnit) + 9);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 0);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t2, &locals.t0);
  frame[4] = _sh_ljs_undefined();
  frame[3] = locals.t1;
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  _sh_leave(shr, &locals.head, frame);
  return locals.t0;
}
// closures.js:3:1
static SHLegacyValue _1_makeCounter(SHRuntime *shr) {
  struct {
    SHLocals head;
    SHLegacyValue t0;
    SHLegacyValue t1;
  } locals;
  _sh_check_native_stack_overflow(shr);
  SHLegacyValue *frame = _sh_enter(shr, &locals.head, 1);
  locals.head.count =2;
  SHUnit *shUnit = shr->units[unit_index];
  locals.t0 = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_undefined();

L0:
  ;
  locals.t0 = _sh_ljs_create_environment(shr, NULL, 1);
  locals.t1 = _sh_ljs_param(frame, 1);
  _sh_ljs_store_to_env(shr, locals.t0,locals.t1, 0);
  locals.t0 = _sh_ljs_create_closure(shr, &locals.t0, _2_, &s_function_info_table[2], shUnit);
  _sh_leave(shr, &locals.head, frame);
  return locals.t0;
}
// closures.js:5:10
static SHLegacyValue _2_(SHRuntime *shr) {
  struct {
    SHLocals head;
    SHLegacyValue t0;
    SHLegacyValue t1;
    SHLegacyValue t2;
  } locals;
  _sh_check_native_stack_overflow(shr);
  SHLegacyValue *frame = _sh_enter(shr, &locals.head, 1);
  locals.head.count =3;
  SHUnit *shUnit = shr->units[unit_index];
  locals.t0 = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_undefined();
  locals.t2 = _sh_ljs_undefined();

L0:
  ;
  locals.t2 = _sh_ljs_get_env_from_closure(shr, frame[-7]);  locals.t0 = _sh_ljs_load_from_env(locals.t2, 0);
  locals.t0 = _sh_ljs_to_numeric_rjs(shr, &locals.t0);
  locals.t1 = _sh_ljs_inc_rjs_inline(shr, &locals.t0);
  _sh_ljs_store_to_env(shr, locals.t2,locals.t1, 0);
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
  { .name_index = 7, .arg_count = 0, .prohibit_invoke = 2, .kind = 0 },
  { .name_index = 1, .arg_count = 1, .prohibit_invoke = 2, .kind = 0 },
  { .name_index = 0, .arg_count = 0, .prohibit_invoke = 2, .kind = 0 },
};
static const char s_ascii_pool[] = {
  '\0',
  'm', 'a', 'k', 'e', 'C', 'o', 'u', 'n', 't', 'e', 'r', '\0',
  'c', 'o', 'u', 'n', 't', 'e', 'r', '1', '\0',
  'c', 'o', 'u', 'n', 't', 'e', 'r', '2', '\0',
  'p', 'r', 'i', 'n', 't', '\0',
  'C', 'o', 'u', 'n', 't', 'e', 'r', ' ', '1', ':', ' ', '\0',
  'C', 'o', 'u', 'n', 't', 'e', 'r', ' ', '2', ':', ' ', '\0',
  'g', 'l', 'o', 'b', 'a', 'l', '\0',
};
static const char16_t s_u16_pool[] = {
};
static const uint32_t s_strings[] = {0,0,0,1,11,3587535301,13,8,2635948645,22,8,2635949684,31,5,2794059355,37,11,3440934386,49,11,2390585848,61,6,615793799,};
#define CREATE_THIS_UNIT sh_export_closures
struct UnitData {
  SHUnit unit;
  SHSymbolID symbol_data[8];
  SHWritePropertyCacheEntry write_prop_cache_data[3];
  SHReadPropertyCacheEntry read_prop_cache_data[10];
  SHPrivateNameCacheEntry private_name_cache_data[0];
  SHCompressedPointer object_literal_class_cache[0];
};
SHUnit *CREATE_THIS_UNIT(void) {
  struct UnitData *unit_data = calloc(sizeof(struct UnitData), 1);
  *unit_data = (struct UnitData){.unit = {.index = &unit_index,.num_symbols =8, .num_write_prop_cache_entries = 3, .num_read_prop_cache_entries = 10, .ascii_pool = s_ascii_pool, .u16_pool = s_u16_pool,.strings = s_strings, .symbols = unit_data->symbol_data,.write_prop_cache = unit_data->write_prop_cache_data,.read_prop_cache = unit_data->read_prop_cache_data, .private_name_cache = unit_data->private_name_cache_data, .obj_key_buffer = s_obj_key_buffer, .obj_key_buffer_size = 0, .literal_val_buffer = s_literal_val_buffer, .literal_val_buffer_size = 0, .obj_shape_table = s_obj_shape_table, .obj_shape_table_count = 0, .object_literal_class_cache = unit_data->object_literal_class_cache, .source_locations = s_source_locations, .source_locations_size = 1, .unit_main = _0_global, .unit_main_info = &s_function_info_table[0], .unit_name = "sh_compiled" }};
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
