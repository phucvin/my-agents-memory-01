
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
// math_ops.js:2:1
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
  SHLegacyValue *frame = _sh_enter(shr, &locals.head, 12);
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
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[1] /*PI*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[2] /*radius*/);
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[3] /*area*/);
  locals.t0 = _sh_ljs_get_global_object(shr);
  np0 = _sh_ljs_double(((struct HermesValueBase){.raw = 4614256650576692846u}).f64);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[1] /*PI*/, &np0, get_write_prop_cache(shUnit) + 0);
  np3 = _sh_ljs_double(5);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[2] /*radius*/, &np3, get_write_prop_cache(shUnit) + 1);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*PI*/, get_read_prop_cache(shUnit) + 0);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*radius*/, get_read_prop_cache(shUnit) + 1);
  locals.t2 = _sh_ljs_mul_rjs_inline(shr, &locals.t2, &locals.t1);
  locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*radius*/, get_read_prop_cache(shUnit) + 2);
  locals.t1 = _sh_ljs_mul_rjs_inline(shr, &locals.t2, &locals.t1);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[3] /*area*/, &locals.t1, get_write_prop_cache(shUnit) + 2);
  frame[5] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 3);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*radius*/, get_read_prop_cache(shUnit) + 4);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[5] /*Area of circle with ...*/);
  locals.t4 = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*area*/, get_read_prop_cache(shUnit) + 5);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[6] /*: */);
  locals.t1 = _sh_string_concat(shr, 2, &locals.t4, &locals.t1);
  frame[3] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  np0 = _sh_ljs_undefined();
  frame[6] = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 6);
  locals.t3 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[7] /*Math*/, get_read_prop_cache(shUnit) + 7);
  frame[5] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[8] /*abs*/, get_read_prop_cache(shUnit) + 8);
  frame[3] = _sh_ljs_double(-10);
  frame[6] = _sh_ljs_undefined();
  frame[4] = locals.t3;
  locals.t3 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[9] /*Math.abs(-10): */);
  frame[3] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[6] = _sh_ljs_undefined();
  frame[5] = locals.t2;
  frame[4] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 9);
  locals.t3 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[7] /*Math*/, get_read_prop_cache(shUnit) + 10);
  frame[5] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[10] /*ceil*/, get_read_prop_cache(shUnit) + 11);
  frame[3] = _sh_ljs_double(((struct HermesValueBase){.raw = 4616414798036126925u}).f64);
  frame[6] = _sh_ljs_undefined();
  frame[4] = locals.t3;
  locals.t3 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[11] /*Math.ceil(4.2): */);
  frame[3] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[6] = _sh_ljs_undefined();
  frame[5] = locals.t2;
  frame[4] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 12);
  locals.t3 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[7] /*Math*/, get_read_prop_cache(shUnit) + 13);
  frame[5] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[12] /*floor*/, get_read_prop_cache(shUnit) + 14);
  frame[3] = _sh_ljs_double(((struct HermesValueBase){.raw = 4617090337980232499u}).f64);
  frame[6] = _sh_ljs_undefined();
  frame[4] = locals.t3;
  locals.t3 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[13] /*Math.floor(4.8): */);
  frame[3] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[6] = _sh_ljs_undefined();
  frame[5] = locals.t2;
  frame[4] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 15);
  locals.t3 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[7] /*Math*/, get_read_prop_cache(shUnit) + 16);
  frame[5] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[14] /*max*/, get_read_prop_cache(shUnit) + 17);
  frame[2] = _sh_ljs_double(20);
  frame[6] = _sh_ljs_undefined();
  frame[4] = locals.t3;
  frame[3] = _sh_ljs_double(10);
  frame[1] = _sh_ljs_double(5);
  locals.t3 = _sh_ljs_call(shr, frame, 3);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[15] /*Math.max(10, 20, 5):...*/);
  frame[3] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[6] = _sh_ljs_undefined();
  frame[5] = locals.t2;
  frame[4] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 18);
  locals.t3 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[7] /*Math*/, get_read_prop_cache(shUnit) + 19);
  frame[5] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[16] /*pow*/, get_read_prop_cache(shUnit) + 20);
  frame[3] = _sh_ljs_double(2);
  frame[6] = _sh_ljs_undefined();
  frame[4] = locals.t3;
  frame[2] = _sh_ljs_double(10);
  locals.t3 = _sh_ljs_call(shr, frame, 2);
  locals.t1 = _sh_ljs_get_string(shr, get_symbols(shUnit)[17] /*Math.pow(2, 10): */);
  frame[3] = _sh_ljs_add_rjs_inline(shr, &locals.t1, &locals.t3);
  frame[6] = _sh_ljs_undefined();
  frame[5] = locals.t2;
  frame[4] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  locals.t1 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[4] /*print*/, get_read_prop_cache(shUnit) + 21);
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[7] /*Math*/, get_read_prop_cache(shUnit) + 22);
  frame[5] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[18] /*sqrt*/, get_read_prop_cache(shUnit) + 23);
  frame[3] = _sh_ljs_double(25);
  frame[6] = _sh_ljs_undefined();
  frame[4] = locals.t2;
  locals.t2 = _sh_ljs_call(shr, frame, 1);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[19] /*Math.sqrt(25): */);
  frame[3] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t2);
  frame[6] = _sh_ljs_undefined();
  frame[5] = locals.t1;
  frame[4] = _sh_ljs_undefined();
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
  'P', 'I', '\0',
  'r', 'a', 'd', 'i', 'u', 's', '\0',
  'a', 'r', 'e', 'a', '\0',
  'p', 'r', 'i', 'n', 't', '\0',
  'A', 'r', 'e', 'a', ' ', 'o', 'f', ' ', 'c', 'i', 'r', 'c', 'l', 'e', ' ', 'w', 'i', 't', 'h', ' ', 'r', 'a', 'd', 'i', 'u', 's', ' ', '\0',
  ':', ' ', '\0',
  'M', 'a', 't', 'h', '\0',
  'a', 'b', 's', '\0',
  'M', 'a', 't', 'h', '.', 'a', 'b', 's', '(', '-', '1', '0', ')', ':', ' ', '\0',
  'c', 'e', 'i', 'l', '\0',
  'M', 'a', 't', 'h', '.', 'c', 'e', 'i', 'l', '(', '4', '.', '2', ')', ':', ' ', '\0',
  'f', 'l', 'o', 'o', 'r', '\0',
  'M', 'a', 't', 'h', '.', 'f', 'l', 'o', 'o', 'r', '(', '4', '.', '8', ')', ':', ' ', '\0',
  'm', 'a', 'x', '\0',
  'M', 'a', 't', 'h', '.', 'm', 'a', 'x', '(', '1', '0', ',', ' ', '2', '0', ',', ' ', '5', ')', ':', ' ', '\0',
  'p', 'o', 'w', '\0',
  'M', 'a', 't', 'h', '.', 'p', 'o', 'w', '(', '2', ',', ' ', '1', '0', ')', ':', ' ', '\0',
  's', 'q', 'r', 't', '\0',
  'M', 'a', 't', 'h', '.', 's', 'q', 'r', 't', '(', '2', '5', ')', ':', ' ', '\0',
  'g', 'l', 'o', 'b', 'a', 'l', '\0',
};
static const char16_t s_u16_pool[] = {
};
static const uint32_t s_strings[] = {0,0,0,1,2,84144940,4,6,3939457869,11,4,1342699174,16,5,2794059355,22,27,3682052486,50,2,60910836,53,4,471344224,58,3,1486442693,62,15,3858917604,78,4,2990652762,83,16,2270332848,100,5,1110891740,106,17,3816690739,124,3,1513641974,128,21,1964504686,150,3,4256347419,154,17,3591618309,172,4,1477974588,177,15,1005055487,193,6,615793799,};
#define CREATE_THIS_UNIT sh_export_math_ops
struct UnitData {
  SHUnit unit;
  SHSymbolID symbol_data[21];
  SHWritePropertyCacheEntry write_prop_cache_data[3];
  SHReadPropertyCacheEntry read_prop_cache_data[24];
  SHPrivateNameCacheEntry private_name_cache_data[0];
  SHCompressedPointer object_literal_class_cache[0];
};
SHUnit *CREATE_THIS_UNIT(void) {
  struct UnitData *unit_data = calloc(sizeof(struct UnitData), 1);
  *unit_data = (struct UnitData){.unit = {.index = &unit_index,.num_symbols =21, .num_write_prop_cache_entries = 3, .num_read_prop_cache_entries = 24, .ascii_pool = s_ascii_pool, .u16_pool = s_u16_pool,.strings = s_strings, .symbols = unit_data->symbol_data,.write_prop_cache = unit_data->write_prop_cache_data,.read_prop_cache = unit_data->read_prop_cache_data, .private_name_cache = unit_data->private_name_cache_data, .obj_key_buffer = s_obj_key_buffer, .obj_key_buffer_size = 0, .literal_val_buffer = s_literal_val_buffer, .literal_val_buffer_size = 0, .obj_shape_table = s_obj_shape_table, .obj_shape_table_count = 0, .object_literal_class_cache = unit_data->object_literal_class_cache, .source_locations = s_source_locations, .source_locations_size = 1, .unit_main = _0_global, .unit_main_info = &s_function_info_table[0], .unit_name = "sh_compiled" }};
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
