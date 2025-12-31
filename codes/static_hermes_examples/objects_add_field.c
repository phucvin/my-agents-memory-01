
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
// codes/static_hermes_examples/objects_add_field.js:1:1
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
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[3] /*point*/);
  locals.t0 = _sh_ljs_get_global_object(shr);
  locals.t1 = _sh_ljs_new_object_with_buffer(shr, shUnit, 0, 0);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[3] /*point*/, &locals.t1, get_write_prop_cache(shUnit) + 0);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 0);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*point*/, get_read_prop_cache(shUnit) + 1);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[0] /*x*/, get_read_prop_cache(shUnit) + 2);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[5] /*Point: */);
  locals.t1 = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*point*/, get_read_prop_cache(shUnit) + 3);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[1] /*y*/, get_read_prop_cache(shUnit) + 4);
  locals.t4 = _sh_ljs_get_string(shr, get_symbols(shUnit)[6] /*, */);
  locals.t1 = _sh_string_concat(shr, 2, &locals.t1, &locals.t4);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  np0 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*point*/, get_read_prop_cache(shUnit) + 5);
  np1 = _sh_ljs_double(30);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t1, get_symbols(shUnit)[7] /*z*/, &np1, get_write_prop_cache(shUnit) + 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 6);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*point*/, get_read_prop_cache(shUnit) + 7);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[0] /*x*/, get_read_prop_cache(shUnit) + 8);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[8] /*Point with z: */);
  locals.t1 = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*point*/, get_read_prop_cache(shUnit) + 9);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[1] /*y*/, get_read_prop_cache(shUnit) + 10);
  locals.t1 = _sh_string_concat(shr, 2, &locals.t1, &locals.t4);
  locals.t1 = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*point*/, get_read_prop_cache(shUnit) + 11);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[7] /*z*/, get_read_prop_cache(shUnit) + 12);
  locals.t1 = _sh_string_concat(shr, 2, &locals.t1, &locals.t4);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*point*/, get_read_prop_cache(shUnit) + 13);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[7] /*z*/, get_read_prop_cache(shUnit) + 14);
  np1 = _sh_ljs_double(5);
  locals.t1 = _sh_ljs_add_rjs_inline(shr, &locals.t1, &np1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t2, get_symbols(shUnit)[7] /*z*/, &locals.t1, get_write_prop_cache(shUnit) + 2);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 15);
  locals.t0 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*point*/, get_read_prop_cache(shUnit) + 16);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[7] /*z*/, get_read_prop_cache(shUnit) + 17);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[9] /*Updated z: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t2);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  _sh_leave(shr, &locals.head, frame);
  return locals.t0;
}
static unsigned char s_literal_val_buffer[9] = {114,10,0,0,0,20,0,0,0,};
static unsigned char s_obj_key_buffer[5] = {82,0,0,1,0,};
static const SHShapeTableEntry s_obj_shape_table[] = {
  { .key_buffer_offset = 0, .num_props = 2 },
};

static const SHSrcLoc s_source_locations[] = {
  { .filename_idx = 2, .line = 0, .column = 0 },
};

static SHNativeFuncInfo s_function_info_table[] = {
  { .name_index = 10, .arg_count = 0, .prohibit_invoke = 2, .kind = 0 },
};
static const char s_ascii_pool[] = {
  'x', '\0',
  'y', '\0',
  '\0',
  'p', 'o', 'i', 'n', 't', '\0',
  'p', 'r', 'i', 'n', 't', '\0',
  'P', 'o', 'i', 'n', 't', ':', ' ', '\0',
  ',', ' ', '\0',
  'z', '\0',
  'P', 'o', 'i', 'n', 't', ' ', 'w', 'i', 't', 'h', ' ', 'z', ':', ' ', '\0',
  'U', 'p', 'd', 'a', 't', 'e', 'd', ' ', 'z', ':', ' ', '\0',
  'g', 'l', 'o', 'b', 'a', 'l', '\0',
};
static const char16_t s_u16_pool[] = {
};
static const uint32_t s_strings[] = {0,1,124921,2,1,123880,4,0,0,5,5,2496710148,11,5,2794059355,17,7,4277449299,25,2,46649472,28,1,126939,30,14,257792864,45,11,2515067024,57,6,615793799,};
#define CREATE_THIS_UNIT sh_export_objects_add_field
struct UnitData {
  SHUnit unit;
  SHSymbolID symbol_data[11];
  SHWritePropertyCacheEntry write_prop_cache_data[3];
  SHReadPropertyCacheEntry read_prop_cache_data[18];
  SHPrivateNameCacheEntry private_name_cache_data[0];
  SHCompressedPointer object_literal_class_cache[1];
};
SHUnit *CREATE_THIS_UNIT(void) {
  struct UnitData *unit_data = calloc(sizeof(struct UnitData), 1);
  *unit_data = (struct UnitData){.unit = {.index = &unit_index,.num_symbols =11, .num_write_prop_cache_entries = 3, .num_read_prop_cache_entries = 18, .ascii_pool = s_ascii_pool, .u16_pool = s_u16_pool,.strings = s_strings, .symbols = unit_data->symbol_data,.write_prop_cache = unit_data->write_prop_cache_data,.read_prop_cache = unit_data->read_prop_cache_data, .private_name_cache = unit_data->private_name_cache_data, .obj_key_buffer = s_obj_key_buffer, .obj_key_buffer_size = 5, .literal_val_buffer = s_literal_val_buffer, .literal_val_buffer_size = 9, .obj_shape_table = s_obj_shape_table, .obj_shape_table_count = 1, .object_literal_class_cache = unit_data->object_literal_class_cache, .source_locations = s_source_locations, .source_locations_size = 1, .unit_main = _0_global, .unit_main_info = &s_function_info_table[0], .unit_name = "sh_compiled" }};
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
