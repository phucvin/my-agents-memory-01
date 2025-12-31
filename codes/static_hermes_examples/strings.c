
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
// strings.js:2:1
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
  SHLegacyValue *frame = _sh_enter(shr, &locals.head, 11);
  locals.head.count =5;
  SHUnit *shUnit = shr->units[unit_index];
  locals.t0 = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_undefined();
  locals.t2 = _sh_ljs_undefined();
  locals.t3 = _sh_ljs_undefined();
  locals.t4 = _sh_ljs_undefined();
  SHLegacyValue np0 = _sh_ljs_undefined();
  SHLegacyValue np1 = _sh_ljs_undefined();
  SHLegacyValue np2 = _sh_ljs_undefined();

L0:
  ;
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[1] /*text*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[2] /*parts*/);
  locals.t0 = _sh_ljs_get_global_object(shr);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[3] /*The quick brown fox ...*/);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[1] /*text*/, &locals.t1, get_write_prop_cache(shUnit) + 0);
  frame[4] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 0);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*text*/, get_read_prop_cache(shUnit) + 1);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[5] /*Original: */);
  frame[2] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  np0 = _sh_ljs_undefined();
  frame[5] = _sh_ljs_undefined();
  frame[3] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[4] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 2);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*text*/, get_read_prop_cache(shUnit) + 3);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[6] /*length*/, get_read_prop_cache(shUnit) + 4);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[7] /*Length: */);
  frame[2] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[5] = _sh_ljs_undefined();
  frame[3] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 5);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*text*/, get_read_prop_cache(shUnit) + 6);
  frame[4] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[8] /*toUpperCase*/, get_read_prop_cache(shUnit) + 7);
  frame[5] = _sh_ljs_undefined();
  frame[3] = locals.t3;
  locals.t3 = _sh_ljs_call(shr, frame, 0);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[9] /*UpperCase: */);
  frame[2] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[5] = _sh_ljs_undefined();
  frame[4] = locals.t2;
  frame[3] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 8);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*text*/, get_read_prop_cache(shUnit) + 9);
  frame[4] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[10] /*substring*/, get_read_prop_cache(shUnit) + 10);
  frame[1] = _sh_ljs_double(9);
  frame[2] = _sh_ljs_double(4);
  frame[5] = _sh_ljs_undefined();
  frame[3] = locals.t3;
  locals.t3 = _sh_ljs_call(shr, frame, 2);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[11] /*Substring (4, 9): */);
  frame[2] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[5] = _sh_ljs_undefined();
  frame[4] = locals.t2;
  frame[3] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 11);
  locals.t4 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*text*/, get_read_prop_cache(shUnit) + 12);
  frame[4] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t4,get_symbols(shUnit)[12] /*indexOf*/, get_read_prop_cache(shUnit) + 13);
  frame[2] = _sh_ljs_get_string(shr, get_symbols(shUnit)[13] /*fox*/);
  frame[5] = _sh_ljs_undefined();
  frame[3] = locals.t4;
  locals.t3 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[14] /*Index of 'fox': */);
  frame[2] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[5] = _sh_ljs_undefined();
  frame[4] = locals.t2;
  frame[3] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*text*/, get_read_prop_cache(shUnit) + 14);
  frame[4] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[15] /*split*/, get_read_prop_cache(shUnit) + 15);
  frame[2] = _sh_ljs_get_string(shr, get_symbols(shUnit)[16] /* */);
  frame[5] = _sh_ljs_undefined();
  frame[3] = locals.t3;
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[2] /*parts*/, &locals.t1, get_write_prop_cache(shUnit) + 1);
  frame[4] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 16);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*parts*/, get_read_prop_cache(shUnit) + 17);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[6] /*length*/, get_read_prop_cache(shUnit) + 18);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[17] /*Split by space: */);
  locals.t3 = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[18] /* words*/);
  frame[2] = _sh_string_concat(shr, 2, &locals.t3, &locals.t1);
  frame[5] = _sh_ljs_undefined();
  frame[3] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[4] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 19);
  locals.t0 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*parts*/, get_read_prop_cache(shUnit) + 20);
  locals.t2 = _sh_ljs_get_by_index_rjs(shr,&locals.t0, 0);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[19] /*First word: */);
  frame[2] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t2);
  frame[5] = _sh_ljs_undefined();
  frame[3] = _sh_ljs_undefined();
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
  { .name_index = 20, .arg_count = 0, .prohibit_invoke = 2, .kind = 0 },
};
static const char s_ascii_pool[] = {
  '\0',
  't', 'e', 'x', 't', '\0',
  'p', 'a', 'r', 't', 's', '\0',
  'T', 'h', 'e', ' ', 'q', 'u', 'i', 'c', 'k', ' ', 'b', 'r', 'o', 'w', 'n', ' ', 'f', 'o', 'x', ' ', 'j', 'u', 'm', 'p', 's', ' ', 'o', 'v', 'e', 'r', ' ', 't', 'h', 'e', ' ', 'l', 'a', 'z', 'y', ' ', 'd', 'o', 'g', '\0',
  'p', 'r', 'i', 'n', 't', '\0',
  'O', 'r', 'i', 'g', 'i', 'n', 'a', 'l', ':', ' ', '\0',
  'l', 'e', 'n', 'g', 't', 'h', '\0',
  'L', 'e', 'n', 'g', 't', 'h', ':', ' ', '\0',
  't', 'o', 'U', 'p', 'p', 'e', 'r', 'C', 'a', 's', 'e', '\0',
  'U', 'p', 'p', 'e', 'r', 'C', 'a', 's', 'e', ':', ' ', '\0',
  's', 'u', 'b', 's', 't', 'r', 'i', 'n', 'g', '\0',
  'S', 'u', 'b', 's', 't', 'r', 'i', 'n', 'g', ' ', '(', '4', ',', ' ', '9', ')', ':', ' ', '\0',
  'i', 'n', 'd', 'e', 'x', 'O', 'f', '\0',
  'f', 'o', 'x', '\0',
  'I', 'n', 'd', 'e', 'x', ' ', 'o', 'f', ' ', '\x0027', 'f', 'o', 'x', '\x0027', ':', ' ', '\0',
  's', 'p', 'l', 'i', 't', '\0',
  ' ', '\0',
  'S', 'p', 'l', 'i', 't', ' ', 'b', 'y', ' ', 's', 'p', 'a', 'c', 'e', ':', ' ', '\0',
  ' ', 'w', 'o', 'r', 'd', 's', '\0',
  'F', 'i', 'r', 's', 't', ' ', 'w', 'o', 'r', 'd', ':', ' ', '\0',
  'g', 'l', 'o', 'b', 'a', 'l', '\0',
};
static const char16_t s_u16_pool[] = {
};
static const uint32_t s_strings[] = {0,0,0,1,4,280487688,6,5,2512261921,12,43,2521570541,56,5,2794059355,62,10,781815525,73,6,363462486,80,8,1740910222,89,11,1899654094,101,11,4153566047,113,9,3950372574,123,18,2846997619,142,7,2471355310,150,3,2458940615,154,16,1432278831,171,5,247753208,177,1,33312,179,16,987973621,196,6,1463702510,203,12,2337705802,216,6,615793799,};
#define CREATE_THIS_UNIT sh_export_strings
struct UnitData {
  SHUnit unit;
  SHSymbolID symbol_data[21];
  SHWritePropertyCacheEntry write_prop_cache_data[2];
  SHReadPropertyCacheEntry read_prop_cache_data[21];
  SHPrivateNameCacheEntry private_name_cache_data[0];
  SHCompressedPointer object_literal_class_cache[0];
};
SHUnit *CREATE_THIS_UNIT(void) {
  struct UnitData *unit_data = calloc(sizeof(struct UnitData), 1);
  *unit_data = (struct UnitData){.unit = {.index = &unit_index,.num_symbols =21, .num_write_prop_cache_entries = 2, .num_read_prop_cache_entries = 21, .ascii_pool = s_ascii_pool, .u16_pool = s_u16_pool,.strings = s_strings, .symbols = unit_data->symbol_data,.write_prop_cache = unit_data->write_prop_cache_data,.read_prop_cache = unit_data->read_prop_cache_data, .private_name_cache = unit_data->private_name_cache_data, .obj_key_buffer = s_obj_key_buffer, .obj_key_buffer_size = 0, .literal_val_buffer = s_literal_val_buffer, .literal_val_buffer_size = 0, .obj_shape_table = s_obj_shape_table, .obj_shape_table_count = 0, .object_literal_class_cache = unit_data->object_literal_class_cache, .source_locations = s_source_locations, .source_locations_size = 1, .unit_main = _0_global, .unit_main_info = &s_function_info_table[0], .unit_name = "sh_compiled" }};
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
