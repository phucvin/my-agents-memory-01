
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
// objects.js:2:1
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
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[12] /*person*/);
  locals.t1 = _sh_ljs_new_object_with_buffer(shr, shUnit, 0, 0);
  locals.t0 = _sh_ljs_new_object_with_buffer(shr, shUnit, 1, 12);
  _sh_prstore_object(shr, &locals.t1, 4, &locals.t0);
  locals.t0 = _sh_ljs_get_global_object(shr);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[12] /*person*/, &locals.t1, get_write_prop_cache(shUnit) + 0);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[13] /*print*/, get_read_prop_cache(shUnit) + 0);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[12] /*person*/, get_read_prop_cache(shUnit) + 1);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[0] /*firstName*/, get_read_prop_cache(shUnit) + 2);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[14] /*Name: */);
  locals.t4 = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[12] /*person*/, get_read_prop_cache(shUnit) + 3);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[1] /*lastName*/, get_read_prop_cache(shUnit) + 4);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[15] /* */);
  locals.t1 = _sh_string_concat(shr, 2, &locals.t4, &locals.t1);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  np0 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[13] /*print*/, get_read_prop_cache(shUnit) + 5);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[12] /*person*/, get_read_prop_cache(shUnit) + 6);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[2] /*age*/, get_read_prop_cache(shUnit) + 7);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[16] /*Age: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[13] /*print*/, get_read_prop_cache(shUnit) + 8);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[12] /*person*/, get_read_prop_cache(shUnit) + 9);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[4] /*address*/, get_read_prop_cache(shUnit) + 10);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[7] /*city*/, get_read_prop_cache(shUnit) + 11);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[17] /*City: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[12] /*person*/, get_read_prop_cache(shUnit) + 12);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[2] /*age*/, get_read_prop_cache(shUnit) + 13);
  np1 = _sh_ljs_double(1);
  locals.t1 = _sh_ljs_add_rjs_inline(shr, &locals.t1, &np1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t2, get_symbols(shUnit)[2] /*age*/, &locals.t1, get_write_prop_cache(shUnit) + 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[13] /*print*/, get_read_prop_cache(shUnit) + 14);
  locals.t0 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[12] /*person*/, get_read_prop_cache(shUnit) + 15);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*age*/, get_read_prop_cache(shUnit) + 16);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[18] /*Next year age: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t2);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  _sh_leave(shr, &locals.head, frame);
  return locals.t0;
}
static unsigned char s_literal_val_buffer[17] = {82,5,0,6,0,113,30,0,0,0,17,1,82,9,0,10,0,};
static unsigned char s_obj_key_buffer[16] = {85,0,0,1,0,2,0,3,0,4,0,82,7,0,8,0,};
static const SHShapeTableEntry s_obj_shape_table[] = {
  { .key_buffer_offset = 0, .num_props = 5 },
  { .key_buffer_offset = 11, .num_props = 2 },
};

static const SHSrcLoc s_source_locations[] = {
  { .filename_idx = 11, .line = 0, .column = 0 },
};

static SHNativeFuncInfo s_function_info_table[] = {
  { .name_index = 19, .arg_count = 0, .prohibit_invoke = 2, .kind = 0 },
};
static const char s_ascii_pool[] = {
  'f', 'i', 'r', 's', 't', 'N', 'a', 'm', 'e', '\0',
  'l', 'a', 's', 't', 'N', 'a', 'm', 'e', '\0',
  'a', 'g', 'e', '\0',
  'i', 's', 'E', 'm', 'p', 'l', 'o', 'y', 'e', 'd', '\0',
  'a', 'd', 'd', 'r', 'e', 's', 's', '\0',
  'J', 'o', 'h', 'n', '\0',
  'D', 'o', 'e', '\0',
  'c', 'i', 't', 'y', '\0',
  'z', 'i', 'p', '\0',
  'N', 'e', 'w', ' ', 'Y', 'o', 'r', 'k', '\0',
  '1', '0', '0', '0', '1', '\0',
  '\0',
  'p', 'e', 'r', 's', 'o', 'n', '\0',
  'p', 'r', 'i', 'n', 't', '\0',
  'N', 'a', 'm', 'e', ':', ' ', '\0',
  ' ', '\0',
  'A', 'g', 'e', ':', ' ', '\0',
  'C', 'i', 't', 'y', ':', ' ', '\0',
  'N', 'e', 'x', 't', ' ', 'y', 'e', 'a', 'r', ' ', 'a', 'g', 'e', ':', ' ', '\0',
  'g', 'l', 'o', 'b', 'a', 'l', '\0',
};
static const char16_t s_u16_pool[] = {
};
static const uint32_t s_strings[] = {0,9,2362613024,10,8,4113637843,19,3,1487537881,23,10,204432599,34,7,1957156082,42,4,1879039833,47,3,323537707,51,4,2636091475,56,3,2045696823,60,8,2904442887,69,5,3491732068,75,0,0,76,6,4222851168,83,5,2794059355,89,6,4096806524,96,1,33312,98,5,279077008,104,6,1580780938,111,15,3645056473,127,6,615793799,};
#define CREATE_THIS_UNIT sh_export_objects
struct UnitData {
  SHUnit unit;
  SHSymbolID symbol_data[20];
  SHWritePropertyCacheEntry write_prop_cache_data[2];
  SHReadPropertyCacheEntry read_prop_cache_data[17];
  SHPrivateNameCacheEntry private_name_cache_data[0];
  SHCompressedPointer object_literal_class_cache[2];
};
SHUnit *CREATE_THIS_UNIT(void) {
  struct UnitData *unit_data = calloc(sizeof(struct UnitData), 1);
  *unit_data = (struct UnitData){.unit = {.index = &unit_index,.num_symbols =20, .num_write_prop_cache_entries = 2, .num_read_prop_cache_entries = 17, .ascii_pool = s_ascii_pool, .u16_pool = s_u16_pool,.strings = s_strings, .symbols = unit_data->symbol_data,.write_prop_cache = unit_data->write_prop_cache_data,.read_prop_cache = unit_data->read_prop_cache_data, .private_name_cache = unit_data->private_name_cache_data, .obj_key_buffer = s_obj_key_buffer, .obj_key_buffer_size = 16, .literal_val_buffer = s_literal_val_buffer, .literal_val_buffer_size = 17, .obj_shape_table = s_obj_shape_table, .obj_shape_table_count = 2, .object_literal_class_cache = unit_data->object_literal_class_cache, .source_locations = s_source_locations, .source_locations_size = 1, .unit_main = _0_global, .unit_main_info = &s_function_info_table[0], .unit_name = "sh_compiled" }};
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
