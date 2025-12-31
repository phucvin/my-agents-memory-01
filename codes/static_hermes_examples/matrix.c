
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
// matrix.js:2:1
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
  SHLegacyValue np2 = _sh_ljs_undefined();

L0:
  ;
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[1] /*A*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[2] /*B*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[3] /*C*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[4] /*i*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[5] /*j*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[6] /*sum*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[7] /*k*/);
  locals.t1 = _sh_ljs_new_array(shr, 2);
  locals.t0 = _sh_ljs_new_array_with_buffer(shr, shUnit, 2, 2, 0);
  _sh_ljs_define_own_in_dense_array(shr, &locals.t1, &locals.t0, 0);
  locals.t0 = _sh_ljs_new_array_with_buffer(shr, shUnit, 2, 2, 9);
  _sh_ljs_define_own_in_dense_array(shr, &locals.t1, &locals.t0, 1);
  locals.t0 = _sh_ljs_get_global_object(shr);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[1] /*A*/, &locals.t1, get_write_prop_cache(shUnit) + 0);
  locals.t1 = _sh_ljs_new_array(shr, 2);
  locals.t2 = _sh_ljs_new_array_with_buffer(shr, shUnit, 2, 2, 18);
  _sh_ljs_define_own_in_dense_array(shr, &locals.t1, &locals.t2, 0);
  locals.t2 = _sh_ljs_new_array_with_buffer(shr, shUnit, 2, 2, 27);
  _sh_ljs_define_own_in_dense_array(shr, &locals.t1, &locals.t2, 1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[2] /*B*/, &locals.t1, get_write_prop_cache(shUnit) + 1);
  locals.t1 = _sh_ljs_new_array(shr, 2);
  locals.t2 = _sh_ljs_new_array_with_buffer(shr, shUnit, 2, 2, 36);
  _sh_ljs_define_own_in_dense_array(shr, &locals.t1, &locals.t2, 0);
  locals.t2 = _sh_ljs_new_array_with_buffer(shr, shUnit, 2, 2, 36);
  _sh_ljs_define_own_in_dense_array(shr, &locals.t1, &locals.t2, 1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[3] /*C*/, &locals.t1, get_write_prop_cache(shUnit) + 2);
  np2 = _sh_ljs_double(0);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[4] /*i*/, &np2, get_write_prop_cache(shUnit) + 3);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[4] /*i*/, get_read_prop_cache(shUnit) + 0);
  np1 = _sh_ljs_double(2);
  np0 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t1, &np1));
  if(_sh_ljs_get_bool(np0)) goto L1;
  goto L6;

L1:
  ;
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[5] /*j*/, &np2, get_write_prop_cache(shUnit) + 4);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[5] /*j*/, get_read_prop_cache(shUnit) + 1);
  np0 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t1, &np1));
  if(_sh_ljs_get_bool(np0)) goto L2;
  goto L5;

L2:
  ;
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[6] /*sum*/, &np2, get_write_prop_cache(shUnit) + 5);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[7] /*k*/, &np2, get_write_prop_cache(shUnit) + 6);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[7] /*k*/, get_read_prop_cache(shUnit) + 2);
  np0 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t1, &np1));
  if(_sh_ljs_get_bool(np0)) goto L3;
  goto L4;

L3:
  ;
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[6] /*sum*/, get_read_prop_cache(shUnit) + 3);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*A*/, get_read_prop_cache(shUnit) + 4);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[4] /*i*/, get_read_prop_cache(shUnit) + 5);
  locals.t3 = _sh_ljs_get_by_val_rjs(shr,&locals.t3, &locals.t1);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[7] /*k*/, get_read_prop_cache(shUnit) + 6);
  locals.t3 = _sh_ljs_get_by_val_rjs(shr,&locals.t3, &locals.t1);
  locals.t4 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*B*/, get_read_prop_cache(shUnit) + 7);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[7] /*k*/, get_read_prop_cache(shUnit) + 8);
  locals.t4 = _sh_ljs_get_by_val_rjs(shr,&locals.t4, &locals.t1);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[5] /*j*/, get_read_prop_cache(shUnit) + 9);
  locals.t1 = _sh_ljs_get_by_val_rjs(shr,&locals.t4, &locals.t1);
  locals.t1 = _sh_ljs_mul_rjs_inline(shr, &locals.t3, &locals.t1);
  locals.t1 = _sh_ljs_add_rjs_inline(shr, &locals.t2, &locals.t1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[6] /*sum*/, &locals.t1, get_write_prop_cache(shUnit) + 7);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[7] /*k*/, get_read_prop_cache(shUnit) + 10);
  locals.t1 = _sh_ljs_inc_rjs_inline(shr, &locals.t1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[7] /*k*/, &locals.t1, get_write_prop_cache(shUnit) + 8);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[7] /*k*/, get_read_prop_cache(shUnit) + 11);
  np0 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t1, &np1));
  if(_sh_ljs_get_bool(np0)) goto L3;
  goto L4;

L4:
  ;
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*C*/, get_read_prop_cache(shUnit) + 12);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[4] /*i*/, get_read_prop_cache(shUnit) + 13);
  locals.t3 = _sh_ljs_get_by_val_rjs(shr,&locals.t2, &locals.t1);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[5] /*j*/, get_read_prop_cache(shUnit) + 14);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[6] /*sum*/, get_read_prop_cache(shUnit) + 15);
  _sh_ljs_put_by_val_loose_rjs(shr,&locals.t3, &locals.t2, &locals.t1);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[5] /*j*/, get_read_prop_cache(shUnit) + 16);
  locals.t1 = _sh_ljs_inc_rjs_inline(shr, &locals.t1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[5] /*j*/, &locals.t1, get_write_prop_cache(shUnit) + 9);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[5] /*j*/, get_read_prop_cache(shUnit) + 17);
  np0 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t1, &np1));
  if(_sh_ljs_get_bool(np0)) goto L2;
  goto L5;

L5:
  ;
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[4] /*i*/, get_read_prop_cache(shUnit) + 18);
  locals.t1 = _sh_ljs_inc_rjs_inline(shr, &locals.t1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[4] /*i*/, &locals.t1, get_write_prop_cache(shUnit) + 10);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[4] /*i*/, get_read_prop_cache(shUnit) + 19);
  np0 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t1, &np1));
  if(_sh_ljs_get_bool(np0)) goto L1;
  goto L6;

L6:
  ;
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[8] /*print*/, get_read_prop_cache(shUnit) + 20);
  frame[1] = _sh_ljs_get_string(shr, get_symbols(shUnit)[9] /*Result Matrix C:*/);
  np0 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[8] /*print*/, get_read_prop_cache(shUnit) + 21);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*C*/, get_read_prop_cache(shUnit) + 22);
  locals.t1 = _sh_ljs_get_by_index_rjs(shr,&locals.t1, 0);
  locals.t1 = _sh_ljs_get_by_index_rjs(shr,&locals.t1, 0);
  locals.t3 = _sh_ljs_get_string(shr, get_symbols(shUnit)[10] /* */);
  locals.t4 = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*C*/, get_read_prop_cache(shUnit) + 23);
  locals.t1 = _sh_ljs_get_by_index_rjs(shr,&locals.t1, 0);
  locals.t1 = _sh_ljs_get_by_index_rjs(shr,&locals.t1, 1);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t4, &locals.t1);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[8] /*print*/, get_read_prop_cache(shUnit) + 24);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*C*/, get_read_prop_cache(shUnit) + 25);
  locals.t2 = _sh_ljs_get_by_index_rjs(shr,&locals.t2, 1);
  locals.t2 = _sh_ljs_get_by_index_rjs(shr,&locals.t2, 0);
  locals.t2 = _sh_ljs_add_rjs_inline(shr, &locals.t2, &locals.t3);
  locals.t0 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*C*/, get_read_prop_cache(shUnit) + 26);
  locals.t0 = _sh_ljs_get_by_index_rjs(shr,&locals.t0, 1);
  locals.t0 = _sh_ljs_get_by_index_rjs(shr,&locals.t0, 1);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t2, &locals.t0);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  _sh_leave(shr, &locals.head, frame);
  return locals.t0;
}
static unsigned char s_literal_val_buffer[45] = {114,1,0,0,0,2,0,0,0,114,3,0,0,0,4,0,0,0,114,5,0,0,0,6,0,0,0,114,7,0,0,0,8,0,0,0,114,0,0,0,0,0,0,0,0,};
static unsigned char s_obj_key_buffer[0] = {};
static const SHShapeTableEntry s_obj_shape_table[] = {
};

static const SHSrcLoc s_source_locations[] = {
  { .filename_idx = 0, .line = 0, .column = 0 },
};

static SHNativeFuncInfo s_function_info_table[] = {
  { .name_index = 11, .arg_count = 0, .prohibit_invoke = 2, .kind = 0 },
};
static const char s_ascii_pool[] = {
  '\0',
  'A', '\0',
  'B', '\0',
  'C', '\0',
  'i', '\0',
  'j', '\0',
  's', 'u', 'm', '\0',
  'k', '\0',
  'p', 'r', 'i', 'n', 't', '\0',
  'R', 'e', 's', 'u', 'l', 't', ' ', 'M', 'a', 't', 'r', 'i', 'x', ' ', 'C', ':', '\0',
  ' ', '\0',
  'g', 'l', 'o', 'b', 'a', 'l', '\0',
};
static const char16_t s_u16_pool[] = {
};
static const uint32_t s_strings[] = {0,0,0,1,1,65616,3,1,68707,5,1,67698,7,1,107256,9,1,110283,11,3,3122771808,15,1,109274,17,5,2794059355,23,16,180397563,40,1,33312,42,6,615793799,};
#define CREATE_THIS_UNIT sh_export_matrix
struct UnitData {
  SHUnit unit;
  SHSymbolID symbol_data[12];
  SHWritePropertyCacheEntry write_prop_cache_data[11];
  SHReadPropertyCacheEntry read_prop_cache_data[27];
  SHPrivateNameCacheEntry private_name_cache_data[0];
  SHCompressedPointer object_literal_class_cache[0];
};
SHUnit *CREATE_THIS_UNIT(void) {
  struct UnitData *unit_data = calloc(sizeof(struct UnitData), 1);
  *unit_data = (struct UnitData){.unit = {.index = &unit_index,.num_symbols =12, .num_write_prop_cache_entries = 11, .num_read_prop_cache_entries = 27, .ascii_pool = s_ascii_pool, .u16_pool = s_u16_pool,.strings = s_strings, .symbols = unit_data->symbol_data,.write_prop_cache = unit_data->write_prop_cache_data,.read_prop_cache = unit_data->read_prop_cache_data, .private_name_cache = unit_data->private_name_cache_data, .obj_key_buffer = s_obj_key_buffer, .obj_key_buffer_size = 0, .literal_val_buffer = s_literal_val_buffer, .literal_val_buffer_size = 45, .obj_shape_table = s_obj_shape_table, .obj_shape_table_count = 0, .object_literal_class_cache = unit_data->object_literal_class_cache, .source_locations = s_source_locations, .source_locations_size = 1, .unit_main = _0_global, .unit_main_info = &s_function_info_table[0], .unit_name = "sh_compiled" }};
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
