
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
// bitwise.js:2:1
static SHLegacyValue _0_global(SHRuntime *shr) {
  _SH_MODEL();
  struct {
    SHLocals head;
    SHLegacyValue t0;
    SHLegacyValue t1;
    SHLegacyValue t2;
    SHLegacyValue t3;
  } locals;
  _sh_check_native_stack_overflow(shr);
  SHLegacyValue *frame = _sh_enter(shr, &locals.head, 10);
  locals.head.count =4;
  SHUnit *shUnit = shr->units[unit_index];
  locals.t0 = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_undefined();
  locals.t2 = _sh_ljs_undefined();
  locals.t3 = _sh_ljs_undefined();
  SHLegacyValue np0 = _sh_ljs_undefined();
  SHLegacyValue np1 = _sh_ljs_undefined();
  SHLegacyValue np2 = _sh_ljs_undefined();

L0:
  ;
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[1] /*a*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[2] /*b*/);
  locals.t0 = _sh_ljs_get_global_object(shr);
  np0 = _sh_ljs_double(5);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[1] /*a*/, &np0, get_write_prop_cache(shUnit) + 0);
  np0 = _sh_ljs_double(3);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[2] /*b*/, &np0, get_write_prop_cache(shUnit) + 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 0);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*a*/, get_read_prop_cache(shUnit) + 1);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[4] /*a: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  np0 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 2);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*b*/, get_read_prop_cache(shUnit) + 3);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[5] /*b: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 4);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*a*/, get_read_prop_cache(shUnit) + 5);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*b*/, get_read_prop_cache(shUnit) + 6);
  locals.t3 = _sh_ljs_bit_and_rjs_inline(shr, &locals.t3, &locals.t1);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[6] /*a & b: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 7);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*a*/, get_read_prop_cache(shUnit) + 8);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*b*/, get_read_prop_cache(shUnit) + 9);
  locals.t3 = _sh_ljs_bit_or_rjs_inline(shr, &locals.t3, &locals.t1);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[7] /*a | b: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 10);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*a*/, get_read_prop_cache(shUnit) + 11);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*b*/, get_read_prop_cache(shUnit) + 12);
  locals.t3 = _sh_ljs_bit_xor_rjs_inline(shr, &locals.t3, &locals.t1);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[8] /*a ^ b: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 13);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*a*/, get_read_prop_cache(shUnit) + 14);
  locals.t3 = _sh_ljs_bit_not_rjs_inline(shr, &locals.t1);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[9] /*~a: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 15);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*a*/, get_read_prop_cache(shUnit) + 16);
  np1 = _sh_ljs_double(1);
  np2 = _sh_ljs_left_shift_rjs_inline(shr, &locals.t1, &np1);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[10] /*a << 1: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &np2);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 17);
  locals.t0 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*a*/, get_read_prop_cache(shUnit) + 18);
  np1 = _sh_ljs_right_shift_rjs_inline(shr, &locals.t0, &np1);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[11] /*a >> 1: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &np1);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
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
  { .name_index = 12, .arg_count = 0, .prohibit_invoke = 2, .kind = 0 },
};
static const char s_ascii_pool[] = {
  '\0',
  'a', '\0',
  'b', '\0',
  'p', 'r', 'i', 'n', 't', '\0',
  'a', ':', ' ', '\0',
  'b', ':', ' ', '\0',
  'a', ' ', '&', ' ', 'b', ':', ' ', '\0',
  'a', ' ', '|', ' ', 'b', ':', ' ', '\0',
  'a', ' ', '^', ' ', 'b', ':', ' ', '\0',
  '~', 'a', ':', ' ', '\0',
  'a', ' ', '<', '<', ' ', '1', ':', ' ', '\0',
  'a', ' ', '>', '>', ' ', '1', ':', ' ', '\0',
  'g', 'l', 'o', 'b', 'a', 'l', '\0',
};
static const char16_t s_u16_pool[] = {
};
static const uint32_t s_strings[] = {0,0,0,1,1,98928,3,1,101955,5,5,2794059355,11,3,1462069320,15,3,2442848870,19,7,648792130,27,7,1797067680,35,7,457332425,43,4,2742269322,48,8,2182860050,57,8,2625297324,66,6,615793799,};
#define CREATE_THIS_UNIT sh_export_bitwise
struct UnitData {
  SHUnit unit;
  SHSymbolID symbol_data[13];
  SHWritePropertyCacheEntry write_prop_cache_data[2];
  SHReadPropertyCacheEntry read_prop_cache_data[19];
  SHPrivateNameCacheEntry private_name_cache_data[0];
  SHCompressedPointer object_literal_class_cache[0];
};
SHUnit *CREATE_THIS_UNIT(void) {
  struct UnitData *unit_data = calloc(sizeof(struct UnitData), 1);
  *unit_data = (struct UnitData){.unit = {.index = &unit_index,.num_symbols =13, .num_write_prop_cache_entries = 2, .num_read_prop_cache_entries = 19, .ascii_pool = s_ascii_pool, .u16_pool = s_u16_pool,.strings = s_strings, .symbols = unit_data->symbol_data,.write_prop_cache = unit_data->write_prop_cache_data,.read_prop_cache = unit_data->read_prop_cache_data, .private_name_cache = unit_data->private_name_cache_data, .obj_key_buffer = s_obj_key_buffer, .obj_key_buffer_size = 0, .literal_val_buffer = s_literal_val_buffer, .literal_val_buffer_size = 0, .obj_shape_table = s_obj_shape_table, .obj_shape_table_count = 0, .object_literal_class_cache = unit_data->object_literal_class_cache, .source_locations = s_source_locations, .source_locations_size = 1, .unit_main = _0_global, .unit_main_info = &s_function_info_table[0], .unit_name = "sh_compiled" }};
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
