
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
static SHLegacyValue _1_riskyOperation(SHRuntime *shr);
// try_catch.js:2:1
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

  SHJmpBuf jmpBuf;
  volatile uint32_t tryState = 0;
  if (__builtin_expect(_sh_try(shr, &jmpBuf), 0) != 0) goto L_catch;

L0:
  ;
  _sh_ljs_declare_global_var(shr, get_symbols(shUnit)[1] /*riskyOperation*/);
  locals.t1 = _sh_ljs_get_global_object(shr);
  locals.t0 = _sh_ljs_create_closure(shr, NULL, _1_riskyOperation, &s_function_info_table[1], shUnit);
  _sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t1, get_symbols(shUnit)[1] /*riskyOperation*/, &locals.t0, get_write_prop_cache(shUnit) + 0);
  tryState = 1;
  goto L1;

L1:
  ;
  tryState = 2;
  goto L2;

L2:
  ;
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t1, get_symbols(shUnit)[2] /*print*/, get_read_prop_cache(shUnit) + 0);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[1] /*riskyOperation*/, get_read_prop_cache(shUnit) + 1);
  frame[1] = _sh_ljs_double(16);
  locals.t3 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t4 = _sh_ljs_call(shr, frame, 1);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[3] /*Sqrt(16): */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t4);
  frame[4] = _sh_ljs_undefined();
  frame[3] = locals.t2;
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t1, get_symbols(shUnit)[2] /*print*/, get_read_prop_cache(shUnit) + 2);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[1] /*riskyOperation*/, get_read_prop_cache(shUnit) + 3);
  frame[1] = _sh_ljs_double(-1);
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t4 = _sh_ljs_call(shr, frame, 1);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[4] /*Sqrt(-1): */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t4);
  frame[4] = _sh_ljs_undefined();
  frame[3] = locals.t2;
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  tryState = 1;
  goto L4;

L3:
  ;
  tryState = 1;
  locals.t0 = _sh_get_clear_thrown_value(shr);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t1, get_symbols(shUnit)[2] /*print*/, get_read_prop_cache(shUnit) + 4);
  locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[5] /*message*/, get_read_prop_cache(shUnit) + 5);
  locals.t0 = _sh_ljs_get_string(shr, get_symbols(shUnit)[6] /*Caught exception: */);
  frame[1] = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t2);
  locals.t0 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  goto L4;
L4:
  ;
  tryState = 0;
  goto L5;

L5:
  ;
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t1, get_symbols(shUnit)[2] /*print*/, get_read_prop_cache(shUnit) + 6);
  frame[1] = _sh_ljs_get_string(shr, get_symbols(shUnit)[7] /*Cleanup done*/);
  locals.t0 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  _sh_end_try(shr, &jmpBuf);
  _sh_leave(shr, &locals.head, frame);
  return locals.t0;

L6:
  ;
  tryState = 0;
  locals.t0 = _sh_get_clear_thrown_value(shr);
  frame[3] = _sh_ljs_try_get_by_id_rjs(shr,&locals.t1, get_symbols(shUnit)[2] /*print*/, get_read_prop_cache(shUnit) + 7);
  frame[1] = _sh_ljs_get_string(shr, get_symbols(shUnit)[7] /*Cleanup done*/);
  locals.t1 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = _sh_ljs_undefined();
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  _sh_throw(shr, locals.t0);

L_catch:
  if (tryState == 0) {
    _sh_end_try(shr, &jmpBuf);
    _sh_throw_current(shr);
  }
  _sh_catch_no_pop(shr, (SHLocals*)&locals, frame, 10);

  switch (tryState) {
    default:
      abort();
    case 1:
      goto L6;
    case 2:
      goto L3;
  }
}
// try_catch.js:2:1
static SHLegacyValue _1_riskyOperation(SHRuntime *shr) {
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

L0:
  ;
  locals.t3 = _sh_ljs_param(frame, 1);
  np0 = _sh_ljs_double(0);
  np0 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t3, &np0));
  locals.t0 = _sh_ljs_get_global_object(shr);
  if(_sh_ljs_get_bool(np0)) goto L2;
  goto L1;

L1:
  ;
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[8] /*Math*/, get_read_prop_cache(shUnit) + 8);
  frame[3] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[9] /*sqrt*/, get_read_prop_cache(shUnit) + 9);
  np0 = _sh_ljs_undefined();
  frame[4] = _sh_ljs_undefined();
  frame[2] = locals.t2;
  frame[1] = locals.t3;
  locals.t1 = _sh_ljs_call(shr, frame, 1);
  _sh_leave(shr, &locals.head, frame);
  return locals.t1;

L2:
  ;
  locals.t2 = _sh_ljs_try_get_by_id_rjs(shr,&locals.t0, get_symbols(shUnit)[10] /*Error*/, get_read_prop_cache(shUnit) + 10);
  locals.t1 = _sh_ljs_create_this(shr, &locals.t2, &locals.t2, get_read_prop_cache(shUnit) + 11);
  frame[1] = _sh_ljs_get_string(shr, get_symbols(shUnit)[11] /*Value cannot be nega...*/);
  frame[4] = locals.t2;
  frame[3] = locals.t2;
  frame[2] = locals.t1;
  locals.t0 = _sh_ljs_call(shr, frame, 1);
  locals.t0 = _sh_ljs_is_object(locals.t0) ? locals.t0 : locals.t1;
  _sh_throw(shr, locals.t0);
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
  { .name_index = 1, .arg_count = 1, .prohibit_invoke = 2, .kind = 0 },
};
static const char s_ascii_pool[] = {
  '\0',
  'r', 'i', 's', 'k', 'y', 'O', 'p', 'e', 'r', 'a', 't', 'i', 'o', 'n', '\0',
  'p', 'r', 'i', 'n', 't', '\0',
  'S', 'q', 'r', 't', '(', '1', '6', ')', ':', ' ', '\0',
  'S', 'q', 'r', 't', '(', '-', '1', ')', ':', ' ', '\0',
  'm', 'e', 's', 's', 'a', 'g', 'e', '\0',
  'C', 'a', 'u', 'g', 'h', 't', ' ', 'e', 'x', 'c', 'e', 'p', 't', 'i', 'o', 'n', ':', ' ', '\0',
  'C', 'l', 'e', 'a', 'n', 'u', 'p', ' ', 'd', 'o', 'n', 'e', '\0',
  'M', 'a', 't', 'h', '\0',
  's', 'q', 'r', 't', '\0',
  'E', 'r', 'r', 'o', 'r', '\0',
  'V', 'a', 'l', 'u', 'e', ' ', 'c', 'a', 'n', 'n', 'o', 't', ' ', 'b', 'e', ' ', 'n', 'e', 'g', 'a', 't', 'i', 'v', 'e', '\0',
  'g', 'l', 'o', 'b', 'a', 'l', '\0',
};
static const char16_t s_u16_pool[] = {
};
static const uint32_t s_strings[] = {0,0,0,1,14,3381854116,16,5,2794059355,22,10,2391780137,33,10,3349327013,44,7,1675131932,52,18,2730299549,71,12,3362695407,84,4,471344224,89,4,1477974588,94,5,2432869328,100,24,2704126907,125,6,615793799,};
#define CREATE_THIS_UNIT sh_export_try_catch
struct UnitData {
  SHUnit unit;
  SHSymbolID symbol_data[13];
  SHWritePropertyCacheEntry write_prop_cache_data[1];
  SHReadPropertyCacheEntry read_prop_cache_data[12];
  SHPrivateNameCacheEntry private_name_cache_data[0];
  SHCompressedPointer object_literal_class_cache[0];
};
SHUnit *CREATE_THIS_UNIT(void) {
  struct UnitData *unit_data = calloc(sizeof(struct UnitData), 1);
  *unit_data = (struct UnitData){.unit = {.index = &unit_index,.num_symbols =13, .num_write_prop_cache_entries = 1, .num_read_prop_cache_entries = 12, .ascii_pool = s_ascii_pool, .u16_pool = s_u16_pool,.strings = s_strings, .symbols = unit_data->symbol_data,.write_prop_cache = unit_data->write_prop_cache_data,.read_prop_cache = unit_data->read_prop_cache_data, .private_name_cache = unit_data->private_name_cache_data, .obj_key_buffer = s_obj_key_buffer, .obj_key_buffer_size = 0, .literal_val_buffer = s_literal_val_buffer, .literal_val_buffer_size = 0, .obj_shape_table = s_obj_shape_table, .obj_shape_table_count = 0, .object_literal_class_cache = unit_data->object_literal_class_cache, .source_locations = s_source_locations, .source_locations_size = 1, .unit_main = _0_global, .unit_main_info = &s_function_info_table[0], .unit_name = "sh_compiled" }};
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
