
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
static SHLegacyValue _1_checkGrade(SHRuntime *shr);
// control_flow.js:2:1
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
  SHLegacyValue np3 = _sh_ljs_undefined();

L0:
  ;
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[1] /*checkGrade*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[2] /*count*/);
  locals.t2 = _sh_ljs_get_global_object(shr);
  locals.t0 = _sh_ljs_create_closure(shr, NULL, _1_checkGrade, &s_function_info_table[1], shUnit);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t2, get_symbols(shUnit)[1] /*checkGrade*/, &locals.t0, get_write_prop_cache(shUnit) + 0);
  locals.t1 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t2, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 0);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[1] /*checkGrade*/, get_read_prop_cache(shUnit) + 1);
  frame[1] = _sh_ljs_double(95);
  np2 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t3 = _sh_ljs_call(shr, frame, 1);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[4] /*Score 95: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[3] = locals.t1;
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t2, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 2);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[1] /*checkGrade*/, get_read_prop_cache(shUnit) + 3);
  frame[1] = _sh_ljs_double(82);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t3 = _sh_ljs_call(shr, frame, 1);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[5] /*Score 82: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[3] = locals.t1;
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t2, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 4);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[1] /*checkGrade*/, get_read_prop_cache(shUnit) + 5);
  frame[1] = _sh_ljs_double(50);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t3 = _sh_ljs_call(shr, frame, 1);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[6] /*Score 50: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[3] = locals.t1;
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  np1 = _sh_ljs_double(0);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t2, get_symbols(shUnit)[2] /*count*/, &np1, get_write_prop_cache(shUnit) + 1);
  locals.t0 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[2] /*count*/, get_read_prop_cache(shUnit) + 6);
  np3 = _sh_ljs_double(3);
  np0 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t0, &np3));
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[7] /*Do-while count: */);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[8] /*While count: */);
  if(_sh_ljs_get_bool(np0)) goto L1;
  goto L2;

L1:
  ;
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t2, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 7);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[2] /*count*/, get_read_prop_cache(shUnit) + 8);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t3);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t3 = _sh_ljs_call(shr, frame, 1);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[2] /*count*/, get_read_prop_cache(shUnit) + 9);
  locals.t3 = _sh_ljs_inc_rjs_inline(shr, &locals.t3);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t2, get_symbols(shUnit)[2] /*count*/, &locals.t3, get_write_prop_cache(shUnit) + 2);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[2] /*count*/, get_read_prop_cache(shUnit) + 10);
  np0 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t3, &np3));
  if(_sh_ljs_get_bool(np0)) goto L1;
  goto L2;

L2:
  ;
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t2, get_symbols(shUnit)[3] /*print*/, get_read_prop_cache(shUnit) + 11);
  locals.t0 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[2] /*count*/, get_read_prop_cache(shUnit) + 12);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t0);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  locals.t0 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[2] /*count*/, get_read_prop_cache(shUnit) + 13);
  locals.t0 = _sh_ljs_to_numeric_rjs(shr, &locals.t0);
  locals.t3 = _sh_ljs_dec_rjs_inline(shr, &locals.t0);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t2, get_symbols(shUnit)[2] /*count*/, &locals.t3, get_write_prop_cache(shUnit) + 3);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[2] /*count*/, get_read_prop_cache(shUnit) + 14);
  np0 = _sh_ljs_bool(_sh_ljs_greater_rjs_inline(shr, &locals.t3, &np1));
  if(_sh_ljs_get_bool(np0)) goto L2;
  goto L3;

L3:
  ;
  _sh_leave(shr, &locals.head, frame);
  return locals.t0;
}
// control_flow.js:2:1
static SHLegacyValue _1_checkGrade(SHRuntime *shr) {
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
  SHLegacyValue np0 = _sh_ljs_undefined();

L0:
  ;
  locals.t1 = _sh_ljs_param(frame, 1);
  np0 = _sh_ljs_double(90);
  np0 = _sh_ljs_bool(_sh_ljs_greater_equal_rjs_inline(shr, &locals.t1, &np0));
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[9] /*A*/);
  if(_sh_ljs_get_bool(np0)) goto L5;
  goto L1;

L1:
  ;
  np0 = _sh_ljs_double(80);
  np0 = _sh_ljs_bool(_sh_ljs_greater_equal_rjs_inline(shr, &locals.t1, &np0));
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[10] /*B*/);
  if(_sh_ljs_get_bool(np0)) goto L5;
  goto L2;

L2:
  ;
  np0 = _sh_ljs_double(70);
  np0 = _sh_ljs_bool(_sh_ljs_greater_equal_rjs_inline(shr, &locals.t1, &np0));
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[11] /*C*/);
  if(_sh_ljs_get_bool(np0)) goto L5;
  goto L3;

L3:
  ;
  np0 = _sh_ljs_double(60);
  np0 = _sh_ljs_bool(_sh_ljs_greater_equal_rjs_inline(shr, &locals.t1, &np0));
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[12] /*D*/);
  if(_sh_ljs_get_bool(np0)) goto L5;
  goto L4;

L4:
  ;
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[13] /*F*/);
  goto L5;
L5:
  ;
  // PhiInst
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
  { .name_index = 14, .arg_count = 0, .prohibit_invoke = 2, .kind = 0 },
  { .name_index = 1, .arg_count = 1, .prohibit_invoke = 2, .kind = 0 },
};
static const char s_ascii_pool[] = {
  '\0',
  'c', 'h', 'e', 'c', 'k', 'G', 'r', 'a', 'd', 'e', '\0',
  'c', 'o', 'u', 'n', 't', '\0',
  'p', 'r', 'i', 'n', 't', '\0',
  'S', 'c', 'o', 'r', 'e', ' ', '9', '5', ':', ' ', '\0',
  'S', 'c', 'o', 'r', 'e', ' ', '8', '2', ':', ' ', '\0',
  'S', 'c', 'o', 'r', 'e', ' ', '5', '0', ':', ' ', '\0',
  'D', 'o', '-', 'w', 'h', 'i', 'l', 'e', ' ', 'c', 'o', 'u', 'n', 't', ':', ' ', '\0',
  'W', 'h', 'i', 'l', 'e', ' ', 'c', 'o', 'u', 'n', 't', ':', ' ', '\0',
  'A', '\0',
  'B', '\0',
  'C', '\0',
  'D', '\0',
  'F', '\0',
  'g', 'l', 'o', 'b', 'a', 'l', '\0',
};
static const char16_t s_u16_pool[] = {
};
static const uint32_t s_strings[] = {0,0,0,1,10,382972965,12,5,123589934,18,5,2794059355,24,10,1863127771,35,10,2018597637,46,10,291658859,57,16,1560568430,74,13,3866296536,88,1,65616,90,1,68707,92,1,67698,94,1,70661,96,1,72743,98,6,615793799,};
#define CREATE_THIS_UNIT sh_export_control_flow
struct UnitData {
  SHUnit unit;
  SHSymbolID symbol_data[15];
  SHWritePropertyCacheEntry write_prop_cache_data[4];
  SHReadPropertyCacheEntry read_prop_cache_data[15];
  SHPrivateNameCacheEntry private_name_cache_data[0];
  SHCompressedPointer object_literal_class_cache[0];
};
SHUnit *CREATE_THIS_UNIT(void) {
  struct UnitData *unit_data = calloc(sizeof(struct UnitData), 1);
  *unit_data = (struct UnitData){.unit = {.index = &unit_index,.num_symbols =15, .num_write_prop_cache_entries = 4, .num_read_prop_cache_entries = 15, .ascii_pool = s_ascii_pool, .u16_pool = s_u16_pool,.strings = s_strings, .symbols = unit_data->symbol_data,.write_prop_cache = unit_data->write_prop_cache_data,.read_prop_cache = unit_data->read_prop_cache_data, .private_name_cache = unit_data->private_name_cache_data, .obj_key_buffer = s_obj_key_buffer, .obj_key_buffer_size = 0, .literal_val_buffer = s_literal_val_buffer, .literal_val_buffer_size = 0, .obj_shape_table = s_obj_shape_table, .obj_shape_table_count = 0, .object_literal_class_cache = unit_data->object_literal_class_cache, .source_locations = s_source_locations, .source_locations_size = 1, .unit_main = _0_global, .unit_main_info = &s_function_info_table[0], .unit_name = "sh_compiled" }};
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
