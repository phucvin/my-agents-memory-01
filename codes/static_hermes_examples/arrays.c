
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
// arrays.js:2:1
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
  } locals;
  _sh_check_native_stack_overflow(shr);
  SHLegacyValue *frame = _sh_enter(shr, &locals.head, 10);
  locals.head.count =6;
  SHUnit *shUnit = shr->units[unit_index];
  locals.t0 = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_undefined();
  locals.t2 = _sh_ljs_undefined();
  locals.t3 = _sh_ljs_undefined();
  locals.t4 = _sh_ljs_undefined();
  locals.t5 = _sh_ljs_undefined();
  SHLegacyValue np0 = _sh_ljs_undefined();
  SHLegacyValue np1 = _sh_ljs_undefined();
  SHLegacyValue np2 = _sh_ljs_undefined();
  SHLegacyValue np3 = _sh_ljs_undefined();

L0:
  ;
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[1] /*numbers*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[2] /*evens*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[3] /*i*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[4] /*squares*/);
  locals.t0 = _sh_ljs_get_global_object(shr);
  locals.t1 = _sh_ljs_new_array_with_buffer(shr, shUnit, 10, 10, 0);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[1] /*numbers*/, &locals.t1, get_write_prop_cache(shUnit) + 0);
  locals.t1 = _sh_ljs_new_array(shr, 0);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[2] /*evens*/, &locals.t1, get_write_prop_cache(shUnit) + 1);
  np1 = _sh_ljs_double(0);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[3] /*i*/, &np1, get_write_prop_cache(shUnit) + 2);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*i*/, get_read_prop_cache(shUnit) + 0);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*numbers*/, get_read_prop_cache(shUnit) + 1);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[5] /*length*/, get_read_prop_cache(shUnit) + 2);
  np2 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t2, &locals.t1));
  np0 = _sh_ljs_undefined();
  np3 = _sh_ljs_double(2);
  if(_sh_ljs_get_bool(np2)) goto L1;
  goto L4;

L1:
  ;
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*numbers*/, get_read_prop_cache(shUnit) + 3);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*i*/, get_read_prop_cache(shUnit) + 4);
  locals.t1 = _sh_ljs_get_by_val_rjs(shr,&locals.t2, &locals.t1);
  np2 = _sh_ljs_mod_rjs_inline(shr, &locals.t1, &np3);
  np2 = _sh_ljs_bool(_sh_ljs_get_double(np2) == _sh_ljs_get_double(np1));
  if(_sh_ljs_get_bool(np2)) goto L2;
  goto L3;

L2:
  ;
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*evens*/, get_read_prop_cache(shUnit) + 5);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[6] /*push*/, get_read_prop_cache(shUnit) + 6);
  locals.t4 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*numbers*/, get_read_prop_cache(shUnit) + 7);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*i*/, get_read_prop_cache(shUnit) + 8);
  frame[1] = _sh_ljs_get_by_val_rjs(shr,&locals.t4, &locals.t1);
  frame[4] = _sh_ljs_undefined();
  frame[2] = locals.t3;
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  goto L3;
L3:
  ;
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*i*/, get_read_prop_cache(shUnit) + 9);
  locals.t1 = _sh_ljs_inc_rjs_inline(shr, &locals.t1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[3] /*i*/, &locals.t1, get_write_prop_cache(shUnit) + 3);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*i*/, get_read_prop_cache(shUnit) + 10);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*numbers*/, get_read_prop_cache(shUnit) + 11);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[5] /*length*/, get_read_prop_cache(shUnit) + 12);
  np2 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t2, &locals.t1));
  if(_sh_ljs_get_bool(np2)) goto L1;
  goto L4;

L4:
  ;
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[7] /*print*/, get_read_prop_cache(shUnit) + 13);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*evens*/, get_read_prop_cache(shUnit) + 14);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[8] /*Evens: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_new_array(shr, 0);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[4] /*squares*/, &locals.t1, get_write_prop_cache(shUnit) + 4);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[3] /*i*/, &np1, get_write_prop_cache(shUnit) + 5);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*i*/, get_read_prop_cache(shUnit) + 15);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*evens*/, get_read_prop_cache(shUnit) + 16);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[5] /*length*/, get_read_prop_cache(shUnit) + 17);
  np1 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t2, &locals.t1));
  if(_sh_ljs_get_bool(np1)) goto L5;
  goto L6;

L5:
  ;
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[4] /*squares*/, get_read_prop_cache(shUnit) + 18);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[6] /*push*/, get_read_prop_cache(shUnit) + 19);
  locals.t4 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*evens*/, get_read_prop_cache(shUnit) + 20);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*i*/, get_read_prop_cache(shUnit) + 21);
  locals.t4 = _sh_ljs_get_by_val_rjs(shr,&locals.t4, &locals.t1);
  locals.t5 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*evens*/, get_read_prop_cache(shUnit) + 22);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*i*/, get_read_prop_cache(shUnit) + 23);
  locals.t1 = _sh_ljs_get_by_val_rjs(shr,&locals.t5, &locals.t1);
  frame[1] = _sh_ljs_mul_rjs_inline(shr, &locals.t4, &locals.t1);
  frame[4] = _sh_ljs_undefined();
  frame[2] = locals.t3;
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*i*/, get_read_prop_cache(shUnit) + 24);
  locals.t1 = _sh_ljs_inc_rjs_inline(shr, &locals.t1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[3] /*i*/, &locals.t1, get_write_prop_cache(shUnit) + 6);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*i*/, get_read_prop_cache(shUnit) + 25);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*evens*/, get_read_prop_cache(shUnit) + 26);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[5] /*length*/, get_read_prop_cache(shUnit) + 27);
  np1 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t2, &locals.t1));
  if(_sh_ljs_get_bool(np1)) goto L5;
  goto L6;

L6:
  ;
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[7] /*print*/, get_read_prop_cache(shUnit) + 28);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[4] /*squares*/, get_read_prop_cache(shUnit) + 29);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[9] /*Squares of evens: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t2);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  _sh_leave(shr, &locals.head, frame);
  return locals.t0;
}
static unsigned char s_literal_val_buffer[41] = {122,1,0,0,0,2,0,0,0,3,0,0,0,4,0,0,0,5,0,0,0,6,0,0,0,7,0,0,0,8,0,0,0,9,0,0,0,10,0,0,0,};
static unsigned char s_obj_key_buffer[0] = {};
static const SHShapeTableEntry s_obj_shape_table[] = {
};

static const SHSrcLoc s_source_locations[] = {
  { .filename_idx = 0, .line = 0, .column = 0 },
};

static SHNativeFuncInfo s_function_info_table[] = {
  { .name_index = 10, .arg_count = 0, .prohibit_invoke = 2, .kind = 0 },
};
static const char s_ascii_pool[] = {
  '\0',
  'n', 'u', 'm', 'b', 'e', 'r', 's', '\0',
  'e', 'v', 'e', 'n', 's', '\0',
  'i', '\0',
  's', 'q', 'u', 'a', 'r', 'e', 's', '\0',
  'l', 'e', 'n', 'g', 't', 'h', '\0',
  'p', 'u', 's', 'h', '\0',
  'p', 'r', 'i', 'n', 't', '\0',
  'E', 'v', 'e', 'n', 's', ':', ' ', '\0',
  'S', 'q', 'u', 'a', 'r', 'e', 's', ' ', 'o', 'f', ' ', 'e', 'v', 'e', 'n', 's', ':', ' ', '\0',
  'g', 'l', 'o', 'b', 'a', 'l', '\0',
};
static const char16_t s_u16_pool[] = {
};
static const uint32_t s_strings[] = {0,0,0,1,7,1440102898,9,5,3712010005,15,1,107256,17,7,171525542,25,6,363462486,32,4,1059174534,37,5,2794059355,43,7,2413446590,51,18,74058821,70,6,615793799,};
#define CREATE_THIS_UNIT sh_export_arrays
struct UnitData {
  SHUnit unit;
  SHSymbolID symbol_data[11];
  SHWritePropertyCacheEntry write_prop_cache_data[7];
  SHReadPropertyCacheEntry read_prop_cache_data[30];
  SHPrivateNameCacheEntry private_name_cache_data[0];
  SHCompressedPointer object_literal_class_cache[0];
};
SHUnit *CREATE_THIS_UNIT(void) {
  struct UnitData *unit_data = calloc(sizeof(struct UnitData), 1);
  *unit_data = (struct UnitData){.unit = {.index = &unit_index,.num_symbols =11, .num_write_prop_cache_entries = 7, .num_read_prop_cache_entries = 30, .ascii_pool = s_ascii_pool, .u16_pool = s_u16_pool,.strings = s_strings, .symbols = unit_data->symbol_data,.write_prop_cache = unit_data->write_prop_cache_data,.read_prop_cache = unit_data->read_prop_cache_data, .private_name_cache = unit_data->private_name_cache_data, .obj_key_buffer = s_obj_key_buffer, .obj_key_buffer_size = 0, .literal_val_buffer = s_literal_val_buffer, .literal_val_buffer_size = 41, .obj_shape_table = s_obj_shape_table, .obj_shape_table_count = 0, .object_literal_class_cache = unit_data->object_literal_class_cache, .source_locations = s_source_locations, .source_locations_size = 1, .unit_main = _0_global, .unit_main_info = &s_function_info_table[0], .unit_name = "sh_compiled" }};
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
