; ModuleID = '/app/codes/moonbit_examples/target_artifacts/hof.c'
source_filename = "/app/codes/moonbit_examples/target_artifacts/hof.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.anon = type { i32, i32, [50 x i16] }
%struct.anon.0 = type { i32, i32, [2 x i16] }
%struct.anon.1 = type { i32, i32, [23 x i16] }
%struct.anon.2 = type { i32, i32, [7 x i16] }
%struct.anon.3 = type { i32, i32, [49 x i16] }
%struct.anon.4 = type { i32, i32, [23 x i16] }
%struct.anon.5 = type { i32, i32, [31 x i16] }
%struct.anon.6 = type { i32, i32, [2 x i16] }
%struct.anon.7 = type { i32, i32, [18 x i16] }
%struct.anon.8 = type { i32, i32, [20 x i16] }
%struct.anon.9 = type { i32, i32, [54 x i16] }
%struct.anon.10 = type { i32, i32, [53 x i16] }
%struct.anon.11 = type { i32, i32, [37 x i16] }
%struct.anon.12 = type { i32, i32, [20 x i16] }
%struct.anon.13 = type { i32, i32, [2 x i16] }
%struct.anon.14 = type { i32, i32, [2 x i16] }
%struct.anon.15 = type { i32, i32, [20 x i16] }
%struct.anon.16 = type { i32, i32, [50 x i16] }
%struct.anon.17 = type { i32, i32, [2 x i16] }
%struct.moonbit_object = type { i32, i32 }
%struct.anon.18 = type { i32, i32, %"struct.$$3c$Int$3e$$3d$$3e$Int" }
%"struct.$$3c$Int$3e$$3d$$3e$Int" = type { ptr }
%struct.anon.19 = type { i32, i32, %"struct.$$3c$Int$3e$$3d$$3e$Int" }
%struct.anon.20 = type { i32, i32, %"struct.$$moonbitlang$core$builtin$Logger$static_method_table" }
%"struct.$$moonbitlang$core$builtin$Logger$static_method_table" = type { ptr, ptr, ptr, ptr }
%"struct.$StringView" = type { i32, i32, ptr }
%"struct.$$moonbitlang$core$builtin$Logger" = type { ptr, ptr }
%"struct.$$3c$StringView$2a$StringView$3e$" = type { i32, i32, i32, i32, ptr, ptr }
%"struct.$$moonbitlang$core$builtin$SourceLocRepr" = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, ptr, ptr, ptr, ptr, ptr, ptr }
%"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$" = type { i32, i32, ptr, ptr }
%"struct.$Option$3c$StringView$3e$$Some" = type { i32, i32, ptr }
%"struct.$$moonbitlang$core$builtin$StringBuilder" = type { i32, ptr }
%struct.moonbit_result_0 = type { i32, %union.anon }
%union.anon = type { %"struct.$StringView" }

@moonbit_string_literal_6 = dso_local constant %struct.anon { i32 -1, i32 -1879048143, [50 x i16] [i16 64, i16 109, i16 111, i16 111, i16 110, i16 98, i16 105, i16 116, i16 108, i16 97, i16 110, i16 103, i16 47, i16 99, i16 111, i16 114, i16 101, i16 47, i16 98, i16 117, i16 105, i16 108, i16 116, i16 105, i16 110, i16 58, i16 115, i16 116, i16 114, i16 105, i16 110, i16 103, i16 46, i16 109, i16 98, i16 116, i16 58, i16 52, i16 57, i16 49, i16 58, i16 57, i16 45, i16 52, i16 57, i16 49, i16 58, i16 52, i16 48, i16 0] }, align 4
@moonbit_string_literal_1 = dso_local constant %struct.anon.0 { i32 -1, i32 -1879048191, [2 x i16] [i16 45, i16 0] }, align 4
@moonbit_string_literal_5 = dso_local constant %struct.anon.1 { i32 -1, i32 -1879048170, [23 x i16] [i16 105, i16 110, i16 118, i16 97, i16 108, i16 105, i16 100, i16 32, i16 115, i16 117, i16 114, i16 114, i16 111, i16 103, i16 97, i16 116, i16 101, i16 32, i16 112, i16 97, i16 105, i16 114, i16 0] }, align 4
@moonbit_string_literal_15 = dso_local constant %struct.anon.2 { i32 -1, i32 -1879048186, [7 x i16] [i16 10, i16 32, i16 32, i16 97, i16 116, i16 32, i16 0] }, align 4
@moonbit_string_literal_14 = dso_local constant %struct.anon.3 { i32 -1, i32 -1879048144, [49 x i16] [i16 64, i16 109, i16 111, i16 111, i16 110, i16 98, i16 105, i16 116, i16 108, i16 97, i16 110, i16 103, i16 47, i16 99, i16 111, i16 114, i16 101, i16 47, i16 98, i16 117, i16 105, i16 108, i16 116, i16 105, i16 110, i16 58, i16 98, i16 121, i16 116, i16 101, i16 115, i16 46, i16 109, i16 98, i16 116, i16 58, i16 50, i16 57, i16 48, i16 58, i16 53, i16 45, i16 50, i16 57, i16 48, i16 58, i16 51, i16 49, i16 0] }, align 4
@moonbit_string_literal_11 = dso_local constant %struct.anon.4 { i32 -1, i32 -1879048170, [23 x i16] [i16 73, i16 110, i16 118, i16 97, i16 108, i16 105, i16 100, i16 32, i16 105, i16 110, i16 100, i16 101, i16 120, i16 32, i16 102, i16 111, i16 114, i16 32, i16 86, i16 105, i16 101, i16 119, i16 0] }, align 4
@moonbit_string_literal_7 = dso_local constant %struct.anon.5 { i32 -1, i32 -1879048162, [31 x i16] [i16 114, i16 97, i16 100, i16 105, i16 120, i16 32, i16 109, i16 117, i16 115, i16 116, i16 32, i16 98, i16 101, i16 32, i16 98, i16 101, i16 116, i16 119, i16 101, i16 101, i16 110, i16 32, i16 50, i16 32, i16 97, i16 110, i16 100, i16 32, i16 51, i16 54, i16 0] }, align 4
@moonbit_string_literal_9 = dso_local constant %struct.anon.6 { i32 -1, i32 -1879048191, [2 x i16] [i16 48, i16 0] }, align 4
@moonbit_string_literal_13 = dso_local constant %struct.anon.7 { i32 -1, i32 -1879048175, [18 x i16] [i16 67, i16 104, i16 97, i16 114, i16 32, i16 111, i16 117, i16 116, i16 32, i16 111, i16 102, i16 32, i16 114, i16 97, i16 110, i16 103, i16 101, i16 0] }, align 4
@moonbit_string_literal_18 = dso_local constant %struct.anon.8 { i32 -1, i32 -1879048173, [20 x i16] [i16 65, i16 112, i16 112, i16 108, i16 121, i16 32, i16 115, i16 113, i16 117, i16 97, i16 114, i16 101, i16 32, i16 116, i16 111, i16 32, i16 53, i16 58, i16 32, i16 0] }, align 4
@moonbit_string_literal_12 = dso_local constant %struct.anon.9 { i32 -1, i32 -1879048139, [54 x i16] [i16 64, i16 109, i16 111, i16 111, i16 110, i16 98, i16 105, i16 116, i16 108, i16 97, i16 110, i16 103, i16 47, i16 99, i16 111, i16 114, i16 101, i16 47, i16 98, i16 117, i16 105, i16 108, i16 116, i16 105, i16 110, i16 58, i16 115, i16 116, i16 114, i16 105, i16 110, i16 103, i16 118, i16 105, i16 101, i16 119, i16 46, i16 109, i16 98, i16 116, i16 58, i16 49, i16 49, i16 49, i16 58, i16 53, i16 45, i16 49, i16 49, i16 49, i16 58, i16 51, i16 54, i16 0] }, align 4
@moonbit_string_literal_8 = dso_local constant %struct.anon.10 { i32 -1, i32 -1879048140, [53 x i16] [i16 64, i16 109, i16 111, i16 111, i16 110, i16 98, i16 105, i16 116, i16 108, i16 97, i16 110, i16 103, i16 47, i16 99, i16 111, i16 114, i16 101, i16 47, i16 98, i16 117, i16 105, i16 108, i16 116, i16 105, i16 110, i16 58, i16 116, i16 111, i16 95, i16 115, i16 116, i16 114, i16 105, i16 110, i16 103, i16 46, i16 109, i16 98, i16 116, i16 58, i16 50, i16 51, i16 57, i16 58, i16 53, i16 45, i16 50, i16 51, i16 57, i16 58, i16 52, i16 52, i16 0] }, align 4
@moonbit_string_literal_10 = dso_local constant %struct.anon.11 { i32 -1, i32 -1879048156, [37 x i16] [i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 97, i16 98, i16 99, i16 100, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 112, i16 113, i16 114, i16 115, i16 116, i16 117, i16 118, i16 119, i16 120, i16 121, i16 122, i16 0] }, align 4
@moonbit_string_literal_3 = dso_local constant %struct.anon.12 { i32 -1, i32 -1879048173, [20 x i16] [i16 73, i16 110, i16 118, i16 97, i16 108, i16 105, i16 100, i16 32, i16 115, i16 116, i16 97, i16 114, i16 116, i16 32, i16 105, i16 110, i16 100, i16 101, i16 120, i16 0] }, align 4
@moonbit_string_literal_16 = dso_local constant %struct.anon.13 { i32 -1, i32 -1879048191, [2 x i16] [i16 10, i16 0] }, align 4
@moonbit_string_literal_0 = dso_local constant %struct.anon.14 { i32 -1, i32 -1879048191, [2 x i16] [i16 58, i16 0] }, align 4
@moonbit_string_literal_17 = dso_local constant %struct.anon.15 { i32 -1, i32 -1879048173, [20 x i16] [i16 65, i16 112, i16 112, i16 108, i16 121, i16 32, i16 100, i16 111, i16 117, i16 98, i16 108, i16 101, i16 32, i16 116, i16 111, i16 32, i16 53, i16 58, i16 32, i16 0] }, align 4
@moonbit_string_literal_4 = dso_local constant %struct.anon.16 { i32 -1, i32 -1879048143, [50 x i16] [i16 64, i16 109, i16 111, i16 111, i16 110, i16 98, i16 105, i16 116, i16 108, i16 97, i16 110, i16 103, i16 47, i16 99, i16 111, i16 114, i16 101, i16 47, i16 98, i16 117, i16 105, i16 108, i16 116, i16 105, i16 110, i16 58, i16 115, i16 116, i16 114, i16 105, i16 110, i16 103, i16 46, i16 109, i16 98, i16 116, i16 58, i16 51, i16 54, i16 54, i16 58, i16 53, i16 45, i16 51, i16 54, i16 54, i16 58, i16 51, i16 51, i16 0] }, align 4
@moonbit_string_literal_2 = dso_local constant %struct.anon.17 { i32 -1, i32 -1879048191, [2 x i16] [i16 47, i16 0] }, align 4
@moonbit_constant_constructor_0 = dso_local constant %struct.moonbit_object { i32 -1, i32 1048576 }, align 4
@moonbit_constant_constructor_1 = dso_local constant %struct.moonbit_object { i32 -1, i32 1048577 }, align 4
@"$username$moonbit_examples$cmd$hof$_init$2a$$double$7c$2$dyncall$closure" = dso_local constant %struct.anon.18 { i32 -1, i32 1048576, %"struct.$$3c$Int$3e$$3d$$3e$Int" { ptr @"$username$moonbit_examples$cmd$hof$_init$2a$$double$7c$2$dyncall" } }, align 8
@"$username$moonbit_examples$cmd$hof$_init$2a$$square$7c$4$dyncall$closure" = dso_local constant %struct.anon.19 { i32 -1, i32 1048576, %"struct.$$3c$Int$3e$$3d$$3e$Int" { ptr @"$username$moonbit_examples$cmd$hof$_init$2a$$square$7c$4$dyncall" } }, align 8
@"$$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id$object" = dso_local global %struct.anon.20 { i32 -1, i32 4194304, %"struct.$$moonbitlang$core$builtin$Logger$static_method_table" { ptr @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger", ptr @"$$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0", ptr @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger", ptr @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger" } }, align 8
@"$$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id" = dso_local global ptr getelementptr (i8, ptr @"$$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id$object", i64 8), align 8
@"$moonbitlang$core$builtin$parse$$2a$bind$7c$5404" = dso_local global ptr getelementptr (i8, ptr @moonbit_string_literal_0, i64 8), align 8
@"$moonbitlang$core$builtin$parse$$2a$bind$7c$5443" = dso_local global ptr getelementptr (i8, ptr @moonbit_string_literal_0, i64 8), align 8
@"$moonbitlang$core$builtin$parse$$2a$bind$7c$5437" = dso_local global ptr getelementptr (i8, ptr @moonbit_string_literal_1, i64 8), align 8
@"$moonbitlang$core$builtin$parse$$2a$bind$7c$5424" = dso_local global ptr getelementptr (i8, ptr @moonbit_string_literal_0, i64 8), align 8
@"$moonbitlang$core$builtin$parse$$2a$bind$7c$5418" = dso_local global ptr getelementptr (i8, ptr @moonbit_string_literal_0, i64 8), align 8
@"$moonbitlang$core$builtin$output$$2a$bind$7c$8193" = dso_local global ptr getelementptr (i8, ptr @moonbit_string_literal_2, i64 8), align 8
@"$moonbitlang$core$builtin$output$$2a$bind$7c$8187" = dso_local global ptr getelementptr (i8, ptr @moonbit_string_literal_2, i64 8), align 8
@"$moonbitlang$core$builtin$brute_force_find$constr$69" = dso_local global i64 0, align 8
@"$moonbitlang$core$builtin$boyer_moore_horspool_find$constr$55" = dso_local global i64 0, align 8
@"$username$moonbit_examples$cmd$hof$_init$2a$$double$7c$2$clo" = dso_local global ptr null, align 8
@"$username$moonbit_examples$cmd$hof$_init$2a$$square$7c$4$clo" = dso_local global ptr null, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$username$moonbit_examples$cmd$hof$_init$2a$$double$7c$2$dyncall"(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4
  %6 = call i32 @"$username$moonbit_examples$cmd$hof$_init$2a$$double$7c$2"(i32 noundef %5)
  ret i32 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$username$moonbit_examples$cmd$hof$_init$2a$$square$7c$4$dyncall"(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4
  %6 = call i32 @"$username$moonbit_examples$cmd$hof$_init$2a$$square$7c$4"(i32 noundef %5)
  ret i32 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string$dyncall_as_$moonbitlang$core$builtin$Logger"(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %6 = load ptr, ptr %3, align 8
  store ptr %6, ptr %5, align 8
  %7 = load ptr, ptr %5, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = call i32 @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string"(ptr noundef %7, ptr noundef %8)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$dyncall_as_$moonbitlang$core$builtin$Logger$0"(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %10 = load ptr, ptr %5, align 8
  store ptr %10, ptr %9, align 8
  %11 = load ptr, ptr %9, align 8
  %12 = load ptr, ptr %6, align 8
  %13 = load i32, ptr %7, align 4
  %14 = load i32, ptr %8, align 4
  %15 = call i32 @"$$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0"(ptr noundef %11, ptr noundef %12, i32 noundef %13, i32 noundef %14)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view$dyncall_as_$moonbitlang$core$builtin$Logger"(ptr noundef %0, i64 %1, ptr %2) #0 {
  %4 = alloca %"struct.$StringView", align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 0
  store i64 %1, ptr %7, align 8
  %8 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 1
  store ptr %2, ptr %8, align 8
  store ptr %0, ptr %5, align 8
  %9 = load ptr, ptr %5, align 8
  store ptr %9, ptr %6, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 0
  %12 = load i64, ptr %11, align 8
  %13 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 1
  %14 = load ptr, ptr %13, align 8
  %15 = call i32 @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view"(ptr noundef %10, i64 %12, ptr %14)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char$dyncall_as_$moonbitlang$core$builtin$Logger"(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %6 = load ptr, ptr %3, align 8
  store ptr %6, ptr %5, align 8
  %7 = load ptr, ptr %5, align 8
  %8 = load i32, ptr %4, align 4
  %9 = call i32 @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char"(ptr noundef %7, i32 noundef %8)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$username$moonbit_examples$cmd$hof$_init$2a$$square$7c$4"(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = load i32, ptr %2, align 4
  %5 = mul nsw i32 %3, %4
  ret i32 %5
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$username$moonbit_examples$cmd$hof$_init$2a$$double$7c$2"(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = mul nsw i32 %3, 2
  ret i32 %4
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$username$moonbit_examples$cmd$hof$apply"(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %"struct.$$3c$Int$3e$$3d$$3e$Int", ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %6, align 8
  %8 = load ptr, ptr %3, align 8
  %9 = load i32, ptr %4, align 4
  %10 = call i32 %7(ptr noundef %8, i32 noundef %9)
  ret i32 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output"(ptr noundef %0, ptr %1, ptr %2) #0 {
  %4 = alloca %"struct.$$moonbitlang$core$builtin$Logger", align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 0
  store ptr %1, ptr %8, align 8
  %9 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 1
  store ptr %2, ptr %9, align 8
  store ptr %0, ptr %5, align 8
  %10 = load ptr, ptr %5, align 8
  store ptr %10, ptr %6, align 8
  %11 = load ptr, ptr %6, align 8
  %12 = call ptr @"$$moonbitlang$core$builtin$SourceLocRepr$$parse"(ptr noundef %11)
  store ptr %12, ptr %7, align 8
  %13 = load ptr, ptr %7, align 8
  %14 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 0
  %15 = load ptr, ptr %14, align 8
  %16 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 1
  %17 = load ptr, ptr %16, align 8
  %18 = call i32 @"$$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output"(ptr noundef %13, ptr %15, ptr %17)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$$moonbitlang$core$builtin$SourceLocRepr$$parse"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca %"struct.$StringView", align 8
  %13 = alloca i32, align 4
  %14 = alloca %"struct.$StringView", align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca %"struct.$StringView", align 8
  %18 = alloca %"struct.$StringView", align 8
  %19 = alloca i64, align 8
  %20 = alloca i32, align 4
  %21 = alloca i64, align 8
  %22 = alloca %"struct.$StringView", align 8
  %23 = alloca i32, align 4
  %24 = alloca %"struct.$StringView", align 8
  %25 = alloca i64, align 8
  %26 = alloca %"struct.$StringView", align 8
  %27 = alloca %"struct.$StringView", align 8
  %28 = alloca i64, align 8
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca %"struct.$StringView", align 8
  %36 = alloca ptr, align 8
  %37 = alloca %"struct.$StringView", align 8
  %38 = alloca ptr, align 8
  %39 = alloca ptr, align 8
  %40 = alloca %"struct.$StringView", align 8
  %41 = alloca %"struct.$StringView", align 8
  %42 = alloca %"struct.$StringView", align 8
  %43 = alloca i32, align 4
  %44 = alloca %"struct.$StringView", align 8
  %45 = alloca i64, align 8
  %46 = alloca %"struct.$StringView", align 8
  %47 = alloca i32, align 4
  %48 = alloca %"struct.$StringView", align 8
  %49 = alloca i64, align 8
  %50 = alloca i32, align 4
  %51 = alloca %"struct.$StringView", align 8
  %52 = alloca %"struct.$StringView", align 8
  %53 = alloca i64, align 8
  %54 = alloca i32, align 4
  %55 = alloca i64, align 8
  %56 = alloca %"struct.$StringView", align 8
  %57 = alloca i32, align 4
  %58 = alloca %"struct.$StringView", align 8
  %59 = alloca i64, align 8
  %60 = alloca %"struct.$StringView", align 8
  %61 = alloca %"struct.$StringView", align 8
  %62 = alloca i64, align 8
  %63 = alloca i32, align 4
  %64 = alloca i32, align 4
  %65 = alloca i32, align 4
  %66 = alloca i32, align 4
  %67 = alloca i32, align 4
  %68 = alloca i32, align 4
  %69 = alloca %"struct.$StringView", align 8
  %70 = alloca ptr, align 8
  %71 = alloca %"struct.$StringView", align 8
  %72 = alloca ptr, align 8
  %73 = alloca ptr, align 8
  %74 = alloca %"struct.$StringView", align 8
  %75 = alloca %"struct.$StringView", align 8
  %76 = alloca %"struct.$StringView", align 8
  %77 = alloca i32, align 4
  %78 = alloca %"struct.$StringView", align 8
  %79 = alloca i32, align 4
  %80 = alloca i32, align 4
  %81 = alloca i32, align 4
  %82 = alloca i64, align 8
  %83 = alloca %"struct.$StringView", align 8
  %84 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %85 = load ptr, ptr %2, align 8
  %86 = getelementptr inbounds %struct.moonbit_object, ptr %85, i64 -1
  %87 = getelementptr inbounds %struct.moonbit_object, ptr %86, i32 0, i32 1
  %88 = load i32, ptr %87, align 4
  %89 = and i32 %88, 268435455
  store i32 %89, ptr %3, align 4
  %90 = load i32, ptr %3, align 4
  %91 = sext i32 %90 to i64
  store i64 %91, ptr %4, align 8
  %92 = load ptr, ptr %2, align 8
  call void @moonbit_incref_inlined(ptr noundef %92)
  %93 = load ptr, ptr %2, align 8
  %94 = load i64, ptr %4, align 8
  %95 = call i32 @"$String$$char_length_ge$inner"(ptr noundef %93, i32 noundef 1, i32 noundef 0, i64 noundef %94)
  %96 = icmp ne i32 %95, 0
  br i1 %96, label %97, label %641

97:                                               ; preds = %1
  %98 = load ptr, ptr %2, align 8
  %99 = getelementptr inbounds i16, ptr %98, i64 0
  %100 = load i16, ptr %99, align 2
  %101 = zext i16 %100 to i32
  store i32 %101, ptr %5, align 4
  %102 = load i32, ptr %5, align 4
  store i32 %102, ptr %6, align 4
  %103 = load i32, ptr %6, align 4
  %104 = icmp eq i32 %103, 64
  br i1 %104, label %105, label %639

105:                                              ; preds = %97
  %106 = load ptr, ptr %2, align 8
  %107 = getelementptr inbounds %struct.moonbit_object, ptr %106, i64 -1
  %108 = getelementptr inbounds %struct.moonbit_object, ptr %107, i32 0, i32 1
  %109 = load i32, ptr %108, align 4
  %110 = and i32 %109, 268435455
  store i32 %110, ptr %7, align 4
  %111 = load i32, ptr %7, align 4
  %112 = sext i32 %111 to i64
  store i64 %112, ptr %8, align 8
  %113 = load ptr, ptr %2, align 8
  call void @moonbit_incref_inlined(ptr noundef %113)
  %114 = load ptr, ptr %2, align 8
  %115 = load i64, ptr %8, align 8
  %116 = call i64 @"$String$$offset_of_nth_char$inner"(ptr noundef %114, i32 noundef 1, i32 noundef 0, i64 noundef %115)
  store i64 %116, ptr %9, align 8
  %117 = load i64, ptr %9, align 8
  %118 = icmp eq i64 %117, 4294967296
  br i1 %118, label %119, label %125

119:                                              ; preds = %105
  %120 = load ptr, ptr %2, align 8
  %121 = getelementptr inbounds %struct.moonbit_object, ptr %120, i64 -1
  %122 = getelementptr inbounds %struct.moonbit_object, ptr %121, i32 0, i32 1
  %123 = load i32, ptr %122, align 4
  %124 = and i32 %123, 268435455
  store i32 %124, ptr %10, align 4
  br label %129

125:                                              ; preds = %105
  %126 = load i64, ptr %9, align 8
  store i64 %126, ptr %16, align 8
  %127 = load i64, ptr %16, align 8
  %128 = trunc i64 %127 to i32
  store i32 %128, ptr %10, align 4
  br label %129

129:                                              ; preds = %125, %119
  %130 = load ptr, ptr %2, align 8
  %131 = getelementptr inbounds %struct.moonbit_object, ptr %130, i64 -1
  %132 = getelementptr inbounds %struct.moonbit_object, ptr %131, i32 0, i32 1
  %133 = load i32, ptr %132, align 4
  %134 = and i32 %133, 268435455
  store i32 %134, ptr %11, align 4
  %135 = getelementptr inbounds %"struct.$StringView", ptr %17, i32 0, i32 0
  %136 = load i32, ptr %10, align 4
  store i32 %136, ptr %135, align 8
  %137 = getelementptr inbounds %"struct.$StringView", ptr %17, i32 0, i32 1
  %138 = load i32, ptr %11, align 4
  store i32 %138, ptr %137, align 4
  %139 = getelementptr inbounds %"struct.$StringView", ptr %17, i32 0, i32 2
  %140 = load ptr, ptr %2, align 8
  store ptr %140, ptr %139, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %12, ptr align 8 %17, i64 16, i1 false)
  %141 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5443", align 8
  %142 = getelementptr inbounds %struct.moonbit_object, ptr %141, i64 -1
  %143 = getelementptr inbounds %struct.moonbit_object, ptr %142, i32 0, i32 1
  %144 = load i32, ptr %143, align 4
  %145 = and i32 %144, 268435455
  store i32 %145, ptr %13, align 4
  %146 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5443", align 8
  call void @moonbit_incref_inlined(ptr noundef %146)
  %147 = getelementptr inbounds %"struct.$StringView", ptr %18, i32 0, i32 0
  store i32 0, ptr %147, align 8
  %148 = getelementptr inbounds %"struct.$StringView", ptr %18, i32 0, i32 1
  %149 = load i32, ptr %13, align 4
  store i32 %149, ptr %148, align 4
  %150 = getelementptr inbounds %"struct.$StringView", ptr %18, i32 0, i32 2
  %151 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5443", align 8
  store ptr %151, ptr %150, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %14, ptr align 8 %18, i64 16, i1 false)
  %152 = getelementptr inbounds %"struct.$StringView", ptr %12, i32 0, i32 2
  %153 = load ptr, ptr %152, align 8
  call void @moonbit_incref_inlined(ptr noundef %153)
  %154 = getelementptr inbounds { i64, ptr }, ptr %12, i32 0, i32 0
  %155 = load i64, ptr %154, align 8
  %156 = getelementptr inbounds { i64, ptr }, ptr %12, i32 0, i32 1
  %157 = load ptr, ptr %156, align 8
  %158 = getelementptr inbounds { i64, ptr }, ptr %14, i32 0, i32 0
  %159 = load i64, ptr %158, align 8
  %160 = getelementptr inbounds { i64, ptr }, ptr %14, i32 0, i32 1
  %161 = load ptr, ptr %160, align 8
  %162 = call i64 @"$StringView$$find"(i64 %155, ptr %157, i64 %159, ptr %161)
  store i64 %162, ptr %15, align 8
  %163 = load i64, ptr %15, align 8
  %164 = icmp eq i64 %163, 4294967296
  br i1 %164, label %165, label %168

165:                                              ; preds = %129
  %166 = getelementptr inbounds %"struct.$StringView", ptr %12, i32 0, i32 2
  %167 = load ptr, ptr %166, align 8
  call void @moonbit_decref_inlined(ptr noundef %167)
  call void @moonbit_panic() #6
  unreachable

168:                                              ; preds = %129
  %169 = load i64, ptr %15, align 8
  store i64 %169, ptr %19, align 8
  %170 = load i64, ptr %19, align 8
  %171 = trunc i64 %170 to i32
  store i32 %171, ptr %20, align 4
  %172 = load i32, ptr %20, align 4
  %173 = sext i32 %172 to i64
  store i64 %173, ptr %21, align 8
  %174 = getelementptr inbounds %"struct.$StringView", ptr %12, i32 0, i32 2
  %175 = load ptr, ptr %174, align 8
  call void @moonbit_incref_inlined(ptr noundef %175)
  %176 = load i64, ptr %21, align 8
  %177 = getelementptr inbounds { i64, ptr }, ptr %12, i32 0, i32 0
  %178 = load i64, ptr %177, align 8
  %179 = getelementptr inbounds { i64, ptr }, ptr %12, i32 0, i32 1
  %180 = load ptr, ptr %179, align 8
  %181 = call { i64, ptr } @"$StringView$$view$inner"(i64 %178, ptr %180, i32 noundef 0, i64 noundef %176)
  %182 = getelementptr inbounds { i64, ptr }, ptr %26, i32 0, i32 0
  %183 = extractvalue { i64, ptr } %181, 0
  store i64 %183, ptr %182, align 8
  %184 = getelementptr inbounds { i64, ptr }, ptr %26, i32 0, i32 1
  %185 = extractvalue { i64, ptr } %181, 1
  store ptr %185, ptr %184, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %22, ptr align 8 %26, i64 16, i1 false)
  %186 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5437", align 8
  %187 = getelementptr inbounds %struct.moonbit_object, ptr %186, i64 -1
  %188 = getelementptr inbounds %struct.moonbit_object, ptr %187, i32 0, i32 1
  %189 = load i32, ptr %188, align 4
  %190 = and i32 %189, 268435455
  store i32 %190, ptr %23, align 4
  %191 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5437", align 8
  call void @moonbit_incref_inlined(ptr noundef %191)
  %192 = getelementptr inbounds %"struct.$StringView", ptr %27, i32 0, i32 0
  store i32 0, ptr %192, align 8
  %193 = getelementptr inbounds %"struct.$StringView", ptr %27, i32 0, i32 1
  %194 = load i32, ptr %23, align 4
  store i32 %194, ptr %193, align 4
  %195 = getelementptr inbounds %"struct.$StringView", ptr %27, i32 0, i32 2
  %196 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5437", align 8
  store ptr %196, ptr %195, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %24, ptr align 8 %27, i64 16, i1 false)
  %197 = getelementptr inbounds %"struct.$StringView", ptr %12, i32 0, i32 2
  %198 = load ptr, ptr %197, align 8
  call void @moonbit_incref_inlined(ptr noundef %198)
  %199 = getelementptr inbounds { i64, ptr }, ptr %12, i32 0, i32 0
  %200 = load i64, ptr %199, align 8
  %201 = getelementptr inbounds { i64, ptr }, ptr %12, i32 0, i32 1
  %202 = load ptr, ptr %201, align 8
  %203 = getelementptr inbounds { i64, ptr }, ptr %24, i32 0, i32 0
  %204 = load i64, ptr %203, align 8
  %205 = getelementptr inbounds { i64, ptr }, ptr %24, i32 0, i32 1
  %206 = load ptr, ptr %205, align 8
  %207 = call i64 @"$StringView$$rev_find"(i64 %200, ptr %202, i64 %204, ptr %206)
  store i64 %207, ptr %25, align 8
  %208 = load i64, ptr %25, align 8
  %209 = icmp eq i64 %208, 4294967296
  br i1 %209, label %210, label %215

210:                                              ; preds = %168
  %211 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 2
  %212 = load ptr, ptr %211, align 8
  call void @moonbit_decref_inlined(ptr noundef %212)
  %213 = getelementptr inbounds %"struct.$StringView", ptr %12, i32 0, i32 2
  %214 = load ptr, ptr %213, align 8
  call void @moonbit_decref_inlined(ptr noundef %214)
  call void @moonbit_panic() #6
  unreachable

215:                                              ; preds = %168
  %216 = load i64, ptr %25, align 8
  store i64 %216, ptr %28, align 8
  %217 = load i64, ptr %28, align 8
  %218 = trunc i64 %217 to i32
  store i32 %218, ptr %29, align 4
  %219 = load i32, ptr %29, align 4
  %220 = add nsw i32 %219, 1
  store i32 %220, ptr %30, align 4
  %221 = getelementptr inbounds %"struct.$StringView", ptr %12, i32 0, i32 1
  %222 = load i32, ptr %221, align 4
  store i32 %222, ptr %31, align 4
  %223 = getelementptr inbounds %"struct.$StringView", ptr %12, i32 0, i32 0
  %224 = load i32, ptr %223, align 8
  store i32 %224, ptr %32, align 4
  %225 = load i32, ptr %31, align 4
  %226 = load i32, ptr %32, align 4
  %227 = sub nsw i32 %225, %226
  store i32 %227, ptr %33, align 4
  %228 = load i32, ptr %30, align 4
  %229 = load i32, ptr %33, align 4
  %230 = icmp slt i32 %228, %229
  br i1 %230, label %231, label %634

231:                                              ; preds = %215
  %232 = load i32, ptr %29, align 4
  %233 = add nsw i32 %232, 1
  store i32 %233, ptr %34, align 4
  %234 = getelementptr inbounds %"struct.$StringView", ptr %12, i32 0, i32 2
  %235 = load ptr, ptr %234, align 8
  call void @moonbit_incref_inlined(ptr noundef %235)
  %236 = load i32, ptr %34, align 4
  %237 = getelementptr inbounds { i64, ptr }, ptr %12, i32 0, i32 0
  %238 = load i64, ptr %237, align 8
  %239 = getelementptr inbounds { i64, ptr }, ptr %12, i32 0, i32 1
  %240 = load ptr, ptr %239, align 8
  %241 = call { i64, ptr } @"$StringView$$view$inner"(i64 %238, ptr %240, i32 noundef %236, i64 noundef 4294967296)
  %242 = getelementptr inbounds { i64, ptr }, ptr %37, i32 0, i32 0
  %243 = extractvalue { i64, ptr } %241, 0
  store i64 %243, ptr %242, align 8
  %244 = getelementptr inbounds { i64, ptr }, ptr %37, i32 0, i32 1
  %245 = extractvalue { i64, ptr } %241, 1
  store ptr %245, ptr %244, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %35, ptr align 8 %37, i64 16, i1 false)
  %246 = getelementptr inbounds { i64, ptr }, ptr %35, i32 0, i32 0
  %247 = load i64, ptr %246, align 8
  %248 = getelementptr inbounds { i64, ptr }, ptr %35, i32 0, i32 1
  %249 = load ptr, ptr %248, align 8
  %250 = call ptr @"$moonbitlang$core$builtin$parse$parse_loc$7c$1101"(i64 %247, ptr %249)
  store ptr %250, ptr %36, align 8
  %251 = load ptr, ptr %36, align 8
  %252 = icmp eq ptr %251, null
  br i1 %252, label %253, label %263

253:                                              ; preds = %231
  %254 = load ptr, ptr %36, align 8
  %255 = icmp ne ptr %254, null
  br i1 %255, label %256, label %258

256:                                              ; preds = %253
  %257 = load ptr, ptr %36, align 8
  call void @moonbit_decref_inlined(ptr noundef %257)
  br label %258

258:                                              ; preds = %256, %253
  %259 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 2
  %260 = load ptr, ptr %259, align 8
  call void @moonbit_decref_inlined(ptr noundef %260)
  %261 = getelementptr inbounds %"struct.$StringView", ptr %12, i32 0, i32 2
  %262 = load ptr, ptr %261, align 8
  call void @moonbit_decref_inlined(ptr noundef %262)
  call void @moonbit_panic() #6
  unreachable

263:                                              ; preds = %231
  %264 = load ptr, ptr %36, align 8
  store ptr %264, ptr %38, align 8
  %265 = load ptr, ptr %38, align 8
  store ptr %265, ptr %39, align 8
  %266 = getelementptr inbounds %"struct.$StringView", ptr %40, i32 0, i32 0
  %267 = load ptr, ptr %39, align 8
  %268 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %267, i32 0, i32 0
  %269 = load i32, ptr %268, align 8
  store i32 %269, ptr %266, align 8
  %270 = getelementptr inbounds %"struct.$StringView", ptr %40, i32 0, i32 1
  %271 = load ptr, ptr %39, align 8
  %272 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %271, i32 0, i32 1
  %273 = load i32, ptr %272, align 4
  store i32 %273, ptr %270, align 4
  %274 = getelementptr inbounds %"struct.$StringView", ptr %40, i32 0, i32 2
  %275 = load ptr, ptr %39, align 8
  %276 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %275, i32 0, i32 4
  %277 = load ptr, ptr %276, align 8
  store ptr %277, ptr %274, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %41, ptr align 8 %40, i64 16, i1 false)
  %278 = getelementptr inbounds %"struct.$StringView", ptr %42, i32 0, i32 0
  %279 = load ptr, ptr %39, align 8
  %280 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %279, i32 0, i32 2
  %281 = load i32, ptr %280, align 8
  store i32 %281, ptr %278, align 8
  %282 = getelementptr inbounds %"struct.$StringView", ptr %42, i32 0, i32 1
  %283 = load ptr, ptr %39, align 8
  %284 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %283, i32 0, i32 3
  %285 = load i32, ptr %284, align 4
  store i32 %285, ptr %282, align 4
  %286 = getelementptr inbounds %"struct.$StringView", ptr %42, i32 0, i32 2
  %287 = load ptr, ptr %39, align 8
  %288 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %287, i32 0, i32 5
  %289 = load ptr, ptr %288, align 8
  store ptr %289, ptr %286, align 8
  %290 = load ptr, ptr %39, align 8
  %291 = getelementptr inbounds %struct.moonbit_object, ptr %290, i64 -1
  %292 = getelementptr inbounds %struct.moonbit_object, ptr %291, i32 0, i32 0
  %293 = load i32, ptr %292, align 4
  store i32 %293, ptr %43, align 4
  %294 = load i32, ptr %43, align 4
  %295 = icmp sgt i32 %294, 1
  br i1 %295, label %296, label %307

296:                                              ; preds = %263
  %297 = getelementptr inbounds %"struct.$StringView", ptr %42, i32 0, i32 2
  %298 = load ptr, ptr %297, align 8
  call void @moonbit_incref_inlined(ptr noundef %298)
  %299 = getelementptr inbounds %"struct.$StringView", ptr %41, i32 0, i32 2
  %300 = load ptr, ptr %299, align 8
  call void @moonbit_incref_inlined(ptr noundef %300)
  %301 = load i32, ptr %43, align 4
  %302 = sub nsw i32 %301, 1
  store i32 %302, ptr %50, align 4
  %303 = load i32, ptr %50, align 4
  %304 = load ptr, ptr %39, align 8
  %305 = getelementptr inbounds %struct.moonbit_object, ptr %304, i64 -1
  %306 = getelementptr inbounds %struct.moonbit_object, ptr %305, i32 0, i32 0
  store i32 %303, ptr %306, align 4
  br label %314

307:                                              ; preds = %263
  %308 = load i32, ptr %43, align 4
  %309 = icmp eq i32 %308, 1
  br i1 %309, label %310, label %313

310:                                              ; preds = %307
  %311 = load ptr, ptr %39, align 8
  %312 = getelementptr inbounds %struct.moonbit_object, ptr %311, i64 -1
  call void @free(ptr noundef %312)
  br label %313

313:                                              ; preds = %310, %307
  br label %314

314:                                              ; preds = %313, %296
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %44, ptr align 8 %42, i64 16, i1 false)
  %315 = load i32, ptr %29, align 4
  %316 = sext i32 %315 to i64
  store i64 %316, ptr %45, align 8
  %317 = load i64, ptr %45, align 8
  %318 = getelementptr inbounds { i64, ptr }, ptr %12, i32 0, i32 0
  %319 = load i64, ptr %318, align 8
  %320 = getelementptr inbounds { i64, ptr }, ptr %12, i32 0, i32 1
  %321 = load ptr, ptr %320, align 8
  %322 = call { i64, ptr } @"$StringView$$view$inner"(i64 %319, ptr %321, i32 noundef 0, i64 noundef %317)
  %323 = getelementptr inbounds { i64, ptr }, ptr %51, i32 0, i32 0
  %324 = extractvalue { i64, ptr } %322, 0
  store i64 %324, ptr %323, align 8
  %325 = getelementptr inbounds { i64, ptr }, ptr %51, i32 0, i32 1
  %326 = extractvalue { i64, ptr } %322, 1
  store ptr %326, ptr %325, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %46, ptr align 8 %51, i64 16, i1 false)
  %327 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5424", align 8
  %328 = getelementptr inbounds %struct.moonbit_object, ptr %327, i64 -1
  %329 = getelementptr inbounds %struct.moonbit_object, ptr %328, i32 0, i32 1
  %330 = load i32, ptr %329, align 4
  %331 = and i32 %330, 268435455
  store i32 %331, ptr %47, align 4
  %332 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5424", align 8
  call void @moonbit_incref_inlined(ptr noundef %332)
  %333 = getelementptr inbounds %"struct.$StringView", ptr %52, i32 0, i32 0
  store i32 0, ptr %333, align 8
  %334 = getelementptr inbounds %"struct.$StringView", ptr %52, i32 0, i32 1
  %335 = load i32, ptr %47, align 4
  store i32 %335, ptr %334, align 4
  %336 = getelementptr inbounds %"struct.$StringView", ptr %52, i32 0, i32 2
  %337 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5424", align 8
  store ptr %337, ptr %336, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %48, ptr align 8 %52, i64 16, i1 false)
  %338 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 2
  %339 = load ptr, ptr %338, align 8
  call void @moonbit_incref_inlined(ptr noundef %339)
  %340 = getelementptr inbounds { i64, ptr }, ptr %46, i32 0, i32 0
  %341 = load i64, ptr %340, align 8
  %342 = getelementptr inbounds { i64, ptr }, ptr %46, i32 0, i32 1
  %343 = load ptr, ptr %342, align 8
  %344 = getelementptr inbounds { i64, ptr }, ptr %48, i32 0, i32 0
  %345 = load i64, ptr %344, align 8
  %346 = getelementptr inbounds { i64, ptr }, ptr %48, i32 0, i32 1
  %347 = load ptr, ptr %346, align 8
  %348 = call i64 @"$StringView$$rev_find"(i64 %341, ptr %343, i64 %345, ptr %347)
  store i64 %348, ptr %49, align 8
  %349 = load i64, ptr %49, align 8
  %350 = icmp eq i64 %349, 4294967296
  br i1 %350, label %351, label %360

351:                                              ; preds = %314
  %352 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 2
  %353 = load ptr, ptr %352, align 8
  call void @moonbit_decref_inlined(ptr noundef %353)
  %354 = getelementptr inbounds %"struct.$StringView", ptr %44, i32 0, i32 2
  %355 = load ptr, ptr %354, align 8
  call void @moonbit_decref_inlined(ptr noundef %355)
  %356 = getelementptr inbounds %"struct.$StringView", ptr %41, i32 0, i32 2
  %357 = load ptr, ptr %356, align 8
  call void @moonbit_decref_inlined(ptr noundef %357)
  %358 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 2
  %359 = load ptr, ptr %358, align 8
  call void @moonbit_decref_inlined(ptr noundef %359)
  br label %633

360:                                              ; preds = %314
  %361 = load i64, ptr %49, align 8
  store i64 %361, ptr %53, align 8
  %362 = load i64, ptr %53, align 8
  %363 = trunc i64 %362 to i32
  store i32 %363, ptr %54, align 4
  %364 = load i32, ptr %54, align 4
  %365 = sext i32 %364 to i64
  store i64 %365, ptr %55, align 8
  %366 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 2
  %367 = load ptr, ptr %366, align 8
  call void @moonbit_incref_inlined(ptr noundef %367)
  %368 = load i64, ptr %55, align 8
  %369 = getelementptr inbounds { i64, ptr }, ptr %46, i32 0, i32 0
  %370 = load i64, ptr %369, align 8
  %371 = getelementptr inbounds { i64, ptr }, ptr %46, i32 0, i32 1
  %372 = load ptr, ptr %371, align 8
  %373 = call { i64, ptr } @"$StringView$$view$inner"(i64 %370, ptr %372, i32 noundef 0, i64 noundef %368)
  %374 = getelementptr inbounds { i64, ptr }, ptr %60, i32 0, i32 0
  %375 = extractvalue { i64, ptr } %373, 0
  store i64 %375, ptr %374, align 8
  %376 = getelementptr inbounds { i64, ptr }, ptr %60, i32 0, i32 1
  %377 = extractvalue { i64, ptr } %373, 1
  store ptr %377, ptr %376, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %56, ptr align 8 %60, i64 16, i1 false)
  %378 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5418", align 8
  %379 = getelementptr inbounds %struct.moonbit_object, ptr %378, i64 -1
  %380 = getelementptr inbounds %struct.moonbit_object, ptr %379, i32 0, i32 1
  %381 = load i32, ptr %380, align 4
  %382 = and i32 %381, 268435455
  store i32 %382, ptr %57, align 4
  %383 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5418", align 8
  call void @moonbit_incref_inlined(ptr noundef %383)
  %384 = getelementptr inbounds %"struct.$StringView", ptr %61, i32 0, i32 0
  store i32 0, ptr %384, align 8
  %385 = getelementptr inbounds %"struct.$StringView", ptr %61, i32 0, i32 1
  %386 = load i32, ptr %57, align 4
  store i32 %386, ptr %385, align 4
  %387 = getelementptr inbounds %"struct.$StringView", ptr %61, i32 0, i32 2
  %388 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5418", align 8
  store ptr %388, ptr %387, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %58, ptr align 8 %61, i64 16, i1 false)
  %389 = getelementptr inbounds { i64, ptr }, ptr %56, i32 0, i32 0
  %390 = load i64, ptr %389, align 8
  %391 = getelementptr inbounds { i64, ptr }, ptr %56, i32 0, i32 1
  %392 = load ptr, ptr %391, align 8
  %393 = getelementptr inbounds { i64, ptr }, ptr %58, i32 0, i32 0
  %394 = load i64, ptr %393, align 8
  %395 = getelementptr inbounds { i64, ptr }, ptr %58, i32 0, i32 1
  %396 = load ptr, ptr %395, align 8
  %397 = call i64 @"$StringView$$rev_find"(i64 %390, ptr %392, i64 %394, ptr %396)
  store i64 %397, ptr %59, align 8
  %398 = load i64, ptr %59, align 8
  %399 = icmp eq i64 %398, 4294967296
  br i1 %399, label %400, label %409

400:                                              ; preds = %360
  %401 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 2
  %402 = load ptr, ptr %401, align 8
  call void @moonbit_decref_inlined(ptr noundef %402)
  %403 = getelementptr inbounds %"struct.$StringView", ptr %44, i32 0, i32 2
  %404 = load ptr, ptr %403, align 8
  call void @moonbit_decref_inlined(ptr noundef %404)
  %405 = getelementptr inbounds %"struct.$StringView", ptr %41, i32 0, i32 2
  %406 = load ptr, ptr %405, align 8
  call void @moonbit_decref_inlined(ptr noundef %406)
  %407 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 2
  %408 = load ptr, ptr %407, align 8
  call void @moonbit_decref_inlined(ptr noundef %408)
  br label %633

409:                                              ; preds = %360
  %410 = load i64, ptr %59, align 8
  store i64 %410, ptr %62, align 8
  %411 = load i64, ptr %62, align 8
  %412 = trunc i64 %411 to i32
  store i32 %412, ptr %63, align 4
  %413 = load i32, ptr %63, align 4
  %414 = add nsw i32 %413, 1
  store i32 %414, ptr %64, align 4
  %415 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 1
  %416 = load i32, ptr %415, align 4
  store i32 %416, ptr %65, align 4
  %417 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 0
  %418 = load i32, ptr %417, align 8
  store i32 %418, ptr %66, align 4
  %419 = load i32, ptr %65, align 4
  %420 = load i32, ptr %66, align 4
  %421 = sub nsw i32 %419, %420
  store i32 %421, ptr %67, align 4
  %422 = load i32, ptr %64, align 4
  %423 = load i32, ptr %67, align 4
  %424 = icmp slt i32 %422, %423
  br i1 %424, label %425, label %624

425:                                              ; preds = %409
  %426 = load i32, ptr %63, align 4
  %427 = add nsw i32 %426, 1
  store i32 %427, ptr %68, align 4
  %428 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 2
  %429 = load ptr, ptr %428, align 8
  call void @moonbit_incref_inlined(ptr noundef %429)
  %430 = load i32, ptr %68, align 4
  %431 = getelementptr inbounds { i64, ptr }, ptr %46, i32 0, i32 0
  %432 = load i64, ptr %431, align 8
  %433 = getelementptr inbounds { i64, ptr }, ptr %46, i32 0, i32 1
  %434 = load ptr, ptr %433, align 8
  %435 = call { i64, ptr } @"$StringView$$view$inner"(i64 %432, ptr %434, i32 noundef %430, i64 noundef 4294967296)
  %436 = getelementptr inbounds { i64, ptr }, ptr %71, i32 0, i32 0
  %437 = extractvalue { i64, ptr } %435, 0
  store i64 %437, ptr %436, align 8
  %438 = getelementptr inbounds { i64, ptr }, ptr %71, i32 0, i32 1
  %439 = extractvalue { i64, ptr } %435, 1
  store ptr %439, ptr %438, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %69, ptr align 8 %71, i64 16, i1 false)
  %440 = getelementptr inbounds { i64, ptr }, ptr %69, i32 0, i32 0
  %441 = load i64, ptr %440, align 8
  %442 = getelementptr inbounds { i64, ptr }, ptr %69, i32 0, i32 1
  %443 = load ptr, ptr %442, align 8
  %444 = call ptr @"$moonbitlang$core$builtin$parse$parse_loc$7c$1101"(i64 %441, ptr %443)
  store ptr %444, ptr %70, align 8
  %445 = load ptr, ptr %70, align 8
  %446 = icmp eq ptr %445, null
  br i1 %446, label %447, label %461

447:                                              ; preds = %425
  %448 = load ptr, ptr %70, align 8
  %449 = icmp ne ptr %448, null
  br i1 %449, label %450, label %452

450:                                              ; preds = %447
  %451 = load ptr, ptr %70, align 8
  call void @moonbit_decref_inlined(ptr noundef %451)
  br label %452

452:                                              ; preds = %450, %447
  %453 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 2
  %454 = load ptr, ptr %453, align 8
  call void @moonbit_decref_inlined(ptr noundef %454)
  %455 = getelementptr inbounds %"struct.$StringView", ptr %44, i32 0, i32 2
  %456 = load ptr, ptr %455, align 8
  call void @moonbit_decref_inlined(ptr noundef %456)
  %457 = getelementptr inbounds %"struct.$StringView", ptr %41, i32 0, i32 2
  %458 = load ptr, ptr %457, align 8
  call void @moonbit_decref_inlined(ptr noundef %458)
  %459 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 2
  %460 = load ptr, ptr %459, align 8
  call void @moonbit_decref_inlined(ptr noundef %460)
  call void @moonbit_panic() #6
  unreachable

461:                                              ; preds = %425
  %462 = load ptr, ptr %70, align 8
  store ptr %462, ptr %72, align 8
  %463 = load ptr, ptr %72, align 8
  store ptr %463, ptr %73, align 8
  %464 = getelementptr inbounds %"struct.$StringView", ptr %74, i32 0, i32 0
  %465 = load ptr, ptr %73, align 8
  %466 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %465, i32 0, i32 0
  %467 = load i32, ptr %466, align 8
  store i32 %467, ptr %464, align 8
  %468 = getelementptr inbounds %"struct.$StringView", ptr %74, i32 0, i32 1
  %469 = load ptr, ptr %73, align 8
  %470 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %469, i32 0, i32 1
  %471 = load i32, ptr %470, align 4
  store i32 %471, ptr %468, align 4
  %472 = getelementptr inbounds %"struct.$StringView", ptr %74, i32 0, i32 2
  %473 = load ptr, ptr %73, align 8
  %474 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %473, i32 0, i32 4
  %475 = load ptr, ptr %474, align 8
  store ptr %475, ptr %472, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %75, ptr align 8 %74, i64 16, i1 false)
  %476 = getelementptr inbounds %"struct.$StringView", ptr %76, i32 0, i32 0
  %477 = load ptr, ptr %73, align 8
  %478 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %477, i32 0, i32 2
  %479 = load i32, ptr %478, align 8
  store i32 %479, ptr %476, align 8
  %480 = getelementptr inbounds %"struct.$StringView", ptr %76, i32 0, i32 1
  %481 = load ptr, ptr %73, align 8
  %482 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %481, i32 0, i32 3
  %483 = load i32, ptr %482, align 4
  store i32 %483, ptr %480, align 4
  %484 = getelementptr inbounds %"struct.$StringView", ptr %76, i32 0, i32 2
  %485 = load ptr, ptr %73, align 8
  %486 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %485, i32 0, i32 5
  %487 = load ptr, ptr %486, align 8
  store ptr %487, ptr %484, align 8
  %488 = load ptr, ptr %73, align 8
  %489 = getelementptr inbounds %struct.moonbit_object, ptr %488, i64 -1
  %490 = getelementptr inbounds %struct.moonbit_object, ptr %489, i32 0, i32 0
  %491 = load i32, ptr %490, align 4
  store i32 %491, ptr %77, align 4
  %492 = load i32, ptr %77, align 4
  %493 = icmp sgt i32 %492, 1
  br i1 %493, label %494, label %505

494:                                              ; preds = %461
  %495 = getelementptr inbounds %"struct.$StringView", ptr %76, i32 0, i32 2
  %496 = load ptr, ptr %495, align 8
  call void @moonbit_incref_inlined(ptr noundef %496)
  %497 = getelementptr inbounds %"struct.$StringView", ptr %75, i32 0, i32 2
  %498 = load ptr, ptr %497, align 8
  call void @moonbit_incref_inlined(ptr noundef %498)
  %499 = load i32, ptr %77, align 4
  %500 = sub nsw i32 %499, 1
  store i32 %500, ptr %80, align 4
  %501 = load i32, ptr %80, align 4
  %502 = load ptr, ptr %73, align 8
  %503 = getelementptr inbounds %struct.moonbit_object, ptr %502, i64 -1
  %504 = getelementptr inbounds %struct.moonbit_object, ptr %503, i32 0, i32 0
  store i32 %501, ptr %504, align 4
  br label %512

505:                                              ; preds = %461
  %506 = load i32, ptr %77, align 4
  %507 = icmp eq i32 %506, 1
  br i1 %507, label %508, label %511

508:                                              ; preds = %505
  %509 = load ptr, ptr %73, align 8
  %510 = getelementptr inbounds %struct.moonbit_object, ptr %509, i64 -1
  call void @free(ptr noundef %510)
  br label %511

511:                                              ; preds = %508, %505
  br label %512

512:                                              ; preds = %511, %494
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %78, ptr align 8 %76, i64 16, i1 false)
  %513 = load i32, ptr %20, align 4
  %514 = add nsw i32 %513, 1
  store i32 %514, ptr %79, align 4
  %515 = load i32, ptr %63, align 4
  %516 = load i32, ptr %79, align 4
  %517 = icmp sgt i32 %515, %516
  br i1 %517, label %518, label %611

518:                                              ; preds = %512
  %519 = load i32, ptr %20, align 4
  %520 = add nsw i32 %519, 1
  store i32 %520, ptr %81, align 4
  %521 = load i32, ptr %63, align 4
  %522 = sext i32 %521 to i64
  store i64 %522, ptr %82, align 8
  %523 = load i32, ptr %81, align 4
  %524 = load i64, ptr %82, align 8
  %525 = getelementptr inbounds { i64, ptr }, ptr %46, i32 0, i32 0
  %526 = load i64, ptr %525, align 8
  %527 = getelementptr inbounds { i64, ptr }, ptr %46, i32 0, i32 1
  %528 = load ptr, ptr %527, align 8
  %529 = call { i64, ptr } @"$StringView$$view$inner"(i64 %526, ptr %528, i32 noundef %523, i64 noundef %524)
  %530 = getelementptr inbounds { i64, ptr }, ptr %83, i32 0, i32 0
  %531 = extractvalue { i64, ptr } %529, 0
  store i64 %531, ptr %530, align 8
  %532 = getelementptr inbounds { i64, ptr }, ptr %83, i32 0, i32 1
  %533 = extractvalue { i64, ptr } %529, 1
  store ptr %533, ptr %532, align 8
  %534 = call ptr @moonbit_malloc_inlined(i64 noundef 96)
  store ptr %534, ptr %84, align 8
  %535 = load ptr, ptr %84, align 8
  %536 = getelementptr inbounds %struct.moonbit_object, ptr %535, i64 -1
  %537 = getelementptr inbounds %struct.moonbit_object, ptr %536, i32 0, i32 1
  store i32 6292992, ptr %537, align 4
  %538 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 2
  %539 = load ptr, ptr %538, align 8
  %540 = load ptr, ptr %84, align 8
  %541 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %540, i32 0, i32 12
  store ptr %539, ptr %541, align 8
  %542 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 0
  %543 = load i32, ptr %542, align 8
  %544 = load ptr, ptr %84, align 8
  %545 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %544, i32 0, i32 0
  store i32 %543, ptr %545, align 8
  %546 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 1
  %547 = load i32, ptr %546, align 4
  %548 = load ptr, ptr %84, align 8
  %549 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %548, i32 0, i32 1
  store i32 %547, ptr %549, align 4
  %550 = getelementptr inbounds %"struct.$StringView", ptr %83, i32 0, i32 2
  %551 = load ptr, ptr %550, align 8
  %552 = load ptr, ptr %84, align 8
  %553 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %552, i32 0, i32 13
  store ptr %551, ptr %553, align 8
  %554 = getelementptr inbounds %"struct.$StringView", ptr %83, i32 0, i32 0
  %555 = load i32, ptr %554, align 8
  %556 = load ptr, ptr %84, align 8
  %557 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %556, i32 0, i32 2
  store i32 %555, ptr %557, align 8
  %558 = getelementptr inbounds %"struct.$StringView", ptr %83, i32 0, i32 1
  %559 = load i32, ptr %558, align 4
  %560 = load ptr, ptr %84, align 8
  %561 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %560, i32 0, i32 3
  store i32 %559, ptr %561, align 4
  %562 = getelementptr inbounds %"struct.$StringView", ptr %75, i32 0, i32 2
  %563 = load ptr, ptr %562, align 8
  %564 = load ptr, ptr %84, align 8
  %565 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %564, i32 0, i32 14
  store ptr %563, ptr %565, align 8
  %566 = getelementptr inbounds %"struct.$StringView", ptr %75, i32 0, i32 0
  %567 = load i32, ptr %566, align 8
  %568 = load ptr, ptr %84, align 8
  %569 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %568, i32 0, i32 4
  store i32 %567, ptr %569, align 8
  %570 = getelementptr inbounds %"struct.$StringView", ptr %75, i32 0, i32 1
  %571 = load i32, ptr %570, align 4
  %572 = load ptr, ptr %84, align 8
  %573 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %572, i32 0, i32 5
  store i32 %571, ptr %573, align 4
  %574 = getelementptr inbounds %"struct.$StringView", ptr %78, i32 0, i32 2
  %575 = load ptr, ptr %574, align 8
  %576 = load ptr, ptr %84, align 8
  %577 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %576, i32 0, i32 15
  store ptr %575, ptr %577, align 8
  %578 = getelementptr inbounds %"struct.$StringView", ptr %78, i32 0, i32 0
  %579 = load i32, ptr %578, align 8
  %580 = load ptr, ptr %84, align 8
  %581 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %580, i32 0, i32 6
  store i32 %579, ptr %581, align 8
  %582 = getelementptr inbounds %"struct.$StringView", ptr %78, i32 0, i32 1
  %583 = load i32, ptr %582, align 4
  %584 = load ptr, ptr %84, align 8
  %585 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %584, i32 0, i32 7
  store i32 %583, ptr %585, align 4
  %586 = getelementptr inbounds %"struct.$StringView", ptr %41, i32 0, i32 2
  %587 = load ptr, ptr %586, align 8
  %588 = load ptr, ptr %84, align 8
  %589 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %588, i32 0, i32 16
  store ptr %587, ptr %589, align 8
  %590 = getelementptr inbounds %"struct.$StringView", ptr %41, i32 0, i32 0
  %591 = load i32, ptr %590, align 8
  %592 = load ptr, ptr %84, align 8
  %593 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %592, i32 0, i32 8
  store i32 %591, ptr %593, align 8
  %594 = getelementptr inbounds %"struct.$StringView", ptr %41, i32 0, i32 1
  %595 = load i32, ptr %594, align 4
  %596 = load ptr, ptr %84, align 8
  %597 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %596, i32 0, i32 9
  store i32 %595, ptr %597, align 4
  %598 = getelementptr inbounds %"struct.$StringView", ptr %44, i32 0, i32 2
  %599 = load ptr, ptr %598, align 8
  %600 = load ptr, ptr %84, align 8
  %601 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %600, i32 0, i32 17
  store ptr %599, ptr %601, align 8
  %602 = getelementptr inbounds %"struct.$StringView", ptr %44, i32 0, i32 0
  %603 = load i32, ptr %602, align 8
  %604 = load ptr, ptr %84, align 8
  %605 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %604, i32 0, i32 10
  store i32 %603, ptr %605, align 8
  %606 = getelementptr inbounds %"struct.$StringView", ptr %44, i32 0, i32 1
  %607 = load i32, ptr %606, align 4
  %608 = load ptr, ptr %84, align 8
  %609 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %608, i32 0, i32 11
  store i32 %607, ptr %609, align 4
  %610 = load ptr, ptr %84, align 8
  ret ptr %610

611:                                              ; preds = %512
  %612 = getelementptr inbounds %"struct.$StringView", ptr %78, i32 0, i32 2
  %613 = load ptr, ptr %612, align 8
  call void @moonbit_decref_inlined(ptr noundef %613)
  %614 = getelementptr inbounds %"struct.$StringView", ptr %75, i32 0, i32 2
  %615 = load ptr, ptr %614, align 8
  call void @moonbit_decref_inlined(ptr noundef %615)
  %616 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 2
  %617 = load ptr, ptr %616, align 8
  call void @moonbit_decref_inlined(ptr noundef %617)
  %618 = getelementptr inbounds %"struct.$StringView", ptr %44, i32 0, i32 2
  %619 = load ptr, ptr %618, align 8
  call void @moonbit_decref_inlined(ptr noundef %619)
  %620 = getelementptr inbounds %"struct.$StringView", ptr %41, i32 0, i32 2
  %621 = load ptr, ptr %620, align 8
  call void @moonbit_decref_inlined(ptr noundef %621)
  %622 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 2
  %623 = load ptr, ptr %622, align 8
  call void @moonbit_decref_inlined(ptr noundef %623)
  call void @moonbit_panic() #6
  unreachable

624:                                              ; preds = %409
  %625 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 2
  %626 = load ptr, ptr %625, align 8
  call void @moonbit_decref_inlined(ptr noundef %626)
  %627 = getelementptr inbounds %"struct.$StringView", ptr %44, i32 0, i32 2
  %628 = load ptr, ptr %627, align 8
  call void @moonbit_decref_inlined(ptr noundef %628)
  %629 = getelementptr inbounds %"struct.$StringView", ptr %41, i32 0, i32 2
  %630 = load ptr, ptr %629, align 8
  call void @moonbit_decref_inlined(ptr noundef %630)
  %631 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 2
  %632 = load ptr, ptr %631, align 8
  call void @moonbit_decref_inlined(ptr noundef %632)
  call void @moonbit_panic() #6
  unreachable

633:                                              ; preds = %400, %351
  call void @moonbit_panic() #6
  unreachable

634:                                              ; preds = %215
  %635 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 2
  %636 = load ptr, ptr %635, align 8
  call void @moonbit_decref_inlined(ptr noundef %636)
  %637 = getelementptr inbounds %"struct.$StringView", ptr %12, i32 0, i32 2
  %638 = load ptr, ptr %637, align 8
  call void @moonbit_decref_inlined(ptr noundef %638)
  call void @moonbit_panic() #6
  unreachable

639:                                              ; preds = %97
  %640 = load ptr, ptr %2, align 8
  call void @moonbit_decref_inlined(ptr noundef %640)
  br label %643

641:                                              ; preds = %1
  %642 = load ptr, ptr %2, align 8
  call void @moonbit_decref_inlined(ptr noundef %642)
  br label %643

643:                                              ; preds = %641, %639
  call void @moonbit_panic() #6
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLocRepr$$output"(ptr noundef %0, ptr %1, ptr %2) #0 {
  %4 = alloca %"struct.$$moonbitlang$core$builtin$Logger", align 8
  %5 = alloca ptr, align 8
  %6 = alloca %"struct.$StringView", align 8
  %7 = alloca %"struct.$StringView", align 8
  %8 = alloca i32, align 4
  %9 = alloca %"struct.$StringView", align 8
  %10 = alloca i64, align 8
  %11 = alloca ptr, align 8
  %12 = alloca %"struct.$StringView", align 8
  %13 = alloca %"struct.$StringView", align 8
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca ptr, align 8
  %17 = alloca %"struct.$StringView", align 8
  %18 = alloca %"struct.$StringView", align 8
  %19 = alloca %"struct.$StringView", align 8
  %20 = alloca %"struct.$StringView", align 8
  %21 = alloca %"struct.$StringView", align 8
  %22 = alloca %"struct.$StringView", align 8
  %23 = alloca %"struct.$StringView", align 8
  %24 = alloca %"struct.$StringView", align 8
  %25 = alloca %"struct.$StringView", align 8
  %26 = alloca i32, align 4
  %27 = alloca %"struct.$StringView", align 8
  %28 = alloca %"struct.$$moonbitlang$core$builtin$Logger", align 8
  %29 = alloca %"struct.$StringView", align 8
  %30 = alloca ptr, align 8
  %31 = alloca i64, align 8
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca %"struct.$StringView", align 8
  %35 = alloca i32, align 4
  %36 = alloca %"struct.$StringView", align 8
  %37 = alloca i64, align 8
  %38 = alloca %"struct.$StringView", align 8
  %39 = alloca %"struct.$StringView", align 8
  %40 = alloca ptr, align 8
  %41 = alloca i64, align 8
  %42 = alloca i32, align 4
  %43 = alloca i32, align 4
  %44 = alloca i32, align 4
  %45 = alloca i64, align 8
  %46 = alloca %"struct.$StringView", align 8
  %47 = alloca i32, align 4
  %48 = alloca %"struct.$StringView", align 8
  %49 = alloca ptr, align 8
  %50 = alloca %"struct.$StringView", align 8
  %51 = alloca %"struct.$StringView", align 8
  %52 = alloca %"struct.$StringView", align 8
  %53 = alloca i32, align 4
  %54 = alloca ptr, align 8
  %55 = alloca %"struct.$StringView", align 8
  %56 = alloca i32, align 4
  %57 = alloca %"struct.$StringView", align 8
  %58 = alloca %"struct.$$moonbitlang$core$builtin$Logger", align 8
  %59 = alloca i32, align 4
  %60 = alloca %"struct.$StringView", align 8
  %61 = alloca %"struct.$StringView", align 8
  %62 = alloca %"struct.$StringView", align 8
  %63 = alloca %"struct.$StringView", align 8
  %64 = alloca %"struct.$StringView", align 8
  %65 = alloca i32, align 4
  %66 = alloca %"struct.$StringView", align 8
  %67 = alloca %"struct.$StringView", align 8
  %68 = alloca %"struct.$StringView", align 8
  %69 = alloca %"struct.$StringView", align 8
  %70 = alloca %"struct.$StringView", align 8
  %71 = alloca %"struct.$StringView", align 8
  %72 = alloca %"struct.$StringView", align 8
  %73 = alloca %"struct.$StringView", align 8
  %74 = alloca %"struct.$StringView", align 8
  %75 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 0
  store ptr %1, ptr %75, align 8
  %76 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 1
  store ptr %2, ptr %76, align 8
  store ptr %0, ptr %5, align 8
  %77 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %78 = load ptr, ptr %5, align 8
  %79 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %78, i32 0, i32 0
  %80 = load i32, ptr %79, align 8
  store i32 %80, ptr %77, align 8
  %81 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 1
  %82 = load ptr, ptr %5, align 8
  %83 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %82, i32 0, i32 1
  %84 = load i32, ptr %83, align 4
  store i32 %84, ptr %81, align 4
  %85 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %86 = load ptr, ptr %5, align 8
  %87 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %86, i32 0, i32 12
  %88 = load ptr, ptr %87, align 8
  store ptr %88, ptr %85, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %7, ptr align 8 %6, i64 16, i1 false)
  %89 = load ptr, ptr @"$moonbitlang$core$builtin$output$$2a$bind$7c$8193", align 8
  %90 = getelementptr inbounds %struct.moonbit_object, ptr %89, i64 -1
  %91 = getelementptr inbounds %struct.moonbit_object, ptr %90, i32 0, i32 1
  %92 = load i32, ptr %91, align 4
  %93 = and i32 %92, 268435455
  store i32 %93, ptr %8, align 4
  %94 = load ptr, ptr @"$moonbitlang$core$builtin$output$$2a$bind$7c$8193", align 8
  call void @moonbit_incref_inlined(ptr noundef %94)
  %95 = getelementptr inbounds %"struct.$StringView", ptr %29, i32 0, i32 0
  store i32 0, ptr %95, align 8
  %96 = getelementptr inbounds %"struct.$StringView", ptr %29, i32 0, i32 1
  %97 = load i32, ptr %8, align 4
  store i32 %97, ptr %96, align 4
  %98 = getelementptr inbounds %"struct.$StringView", ptr %29, i32 0, i32 2
  %99 = load ptr, ptr @"$moonbitlang$core$builtin$output$$2a$bind$7c$8193", align 8
  store ptr %99, ptr %98, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %9, ptr align 8 %29, i64 16, i1 false)
  %100 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %101 = load ptr, ptr %100, align 8
  call void @moonbit_incref_inlined(ptr noundef %101)
  %102 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %103 = load ptr, ptr %102, align 8
  call void @moonbit_incref_inlined(ptr noundef %103)
  %104 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  %105 = load i64, ptr %104, align 8
  %106 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  %107 = load ptr, ptr %106, align 8
  %108 = getelementptr inbounds { i64, ptr }, ptr %9, i32 0, i32 0
  %109 = load i64, ptr %108, align 8
  %110 = getelementptr inbounds { i64, ptr }, ptr %9, i32 0, i32 1
  %111 = load ptr, ptr %110, align 8
  %112 = call i64 @"$StringView$$find"(i64 %105, ptr %107, i64 %109, ptr %111)
  store i64 %112, ptr %10, align 8
  %113 = load i64, ptr %10, align 8
  %114 = icmp eq i64 %113, 4294967296
  br i1 %114, label %115, label %135

115:                                              ; preds = %3
  store ptr getelementptr inbounds (%struct.moonbit_object, ptr @moonbit_constant_constructor_0, i64 1), ptr %30, align 8
  %116 = call ptr @moonbit_malloc_inlined(i64 noundef 24)
  store ptr %116, ptr %11, align 8
  %117 = load ptr, ptr %11, align 8
  %118 = getelementptr inbounds %struct.moonbit_object, ptr %117, i64 -1
  %119 = getelementptr inbounds %struct.moonbit_object, ptr %118, i32 0, i32 1
  store i32 1049088, ptr %119, align 4
  %120 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %121 = load ptr, ptr %120, align 8
  %122 = load ptr, ptr %11, align 8
  %123 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %122, i32 0, i32 2
  store ptr %121, ptr %123, align 8
  %124 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %125 = load i32, ptr %124, align 8
  %126 = load ptr, ptr %11, align 8
  %127 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %126, i32 0, i32 0
  store i32 %125, ptr %127, align 8
  %128 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 1
  %129 = load i32, ptr %128, align 4
  %130 = load ptr, ptr %11, align 8
  %131 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %130, i32 0, i32 1
  store i32 %129, ptr %131, align 4
  %132 = load ptr, ptr %30, align 8
  %133 = load ptr, ptr %11, align 8
  %134 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %133, i32 0, i32 3
  store ptr %132, ptr %134, align 8
  br label %266

135:                                              ; preds = %3
  %136 = load i64, ptr %10, align 8
  store i64 %136, ptr %31, align 8
  %137 = load i64, ptr %31, align 8
  %138 = trunc i64 %137 to i32
  store i32 %138, ptr %32, align 4
  %139 = load i32, ptr %32, align 4
  %140 = add nsw i32 %139, 1
  store i32 %140, ptr %33, align 4
  %141 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %142 = load ptr, ptr %141, align 8
  call void @moonbit_incref_inlined(ptr noundef %142)
  %143 = load i32, ptr %33, align 4
  %144 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  %145 = load i64, ptr %144, align 8
  %146 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  %147 = load ptr, ptr %146, align 8
  %148 = call { i64, ptr } @"$StringView$$view$inner"(i64 %145, ptr %147, i32 noundef %143, i64 noundef 4294967296)
  %149 = getelementptr inbounds { i64, ptr }, ptr %38, i32 0, i32 0
  %150 = extractvalue { i64, ptr } %148, 0
  store i64 %150, ptr %149, align 8
  %151 = getelementptr inbounds { i64, ptr }, ptr %38, i32 0, i32 1
  %152 = extractvalue { i64, ptr } %148, 1
  store ptr %152, ptr %151, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %34, ptr align 8 %38, i64 16, i1 false)
  %153 = load ptr, ptr @"$moonbitlang$core$builtin$output$$2a$bind$7c$8187", align 8
  %154 = getelementptr inbounds %struct.moonbit_object, ptr %153, i64 -1
  %155 = getelementptr inbounds %struct.moonbit_object, ptr %154, i32 0, i32 1
  %156 = load i32, ptr %155, align 4
  %157 = and i32 %156, 268435455
  store i32 %157, ptr %35, align 4
  %158 = load ptr, ptr @"$moonbitlang$core$builtin$output$$2a$bind$7c$8187", align 8
  call void @moonbit_incref_inlined(ptr noundef %158)
  %159 = getelementptr inbounds %"struct.$StringView", ptr %39, i32 0, i32 0
  store i32 0, ptr %159, align 8
  %160 = getelementptr inbounds %"struct.$StringView", ptr %39, i32 0, i32 1
  %161 = load i32, ptr %35, align 4
  store i32 %161, ptr %160, align 4
  %162 = getelementptr inbounds %"struct.$StringView", ptr %39, i32 0, i32 2
  %163 = load ptr, ptr @"$moonbitlang$core$builtin$output$$2a$bind$7c$8187", align 8
  store ptr %163, ptr %162, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %36, ptr align 8 %39, i64 16, i1 false)
  %164 = getelementptr inbounds { i64, ptr }, ptr %34, i32 0, i32 0
  %165 = load i64, ptr %164, align 8
  %166 = getelementptr inbounds { i64, ptr }, ptr %34, i32 0, i32 1
  %167 = load ptr, ptr %166, align 8
  %168 = getelementptr inbounds { i64, ptr }, ptr %36, i32 0, i32 0
  %169 = load i64, ptr %168, align 8
  %170 = getelementptr inbounds { i64, ptr }, ptr %36, i32 0, i32 1
  %171 = load ptr, ptr %170, align 8
  %172 = call i64 @"$StringView$$find"(i64 %165, ptr %167, i64 %169, ptr %171)
  store i64 %172, ptr %37, align 8
  %173 = load i64, ptr %37, align 8
  %174 = icmp eq i64 %173, 4294967296
  br i1 %174, label %175, label %195

175:                                              ; preds = %135
  store ptr getelementptr inbounds (%struct.moonbit_object, ptr @moonbit_constant_constructor_0, i64 1), ptr %40, align 8
  %176 = call ptr @moonbit_malloc_inlined(i64 noundef 24)
  store ptr %176, ptr %11, align 8
  %177 = load ptr, ptr %11, align 8
  %178 = getelementptr inbounds %struct.moonbit_object, ptr %177, i64 -1
  %179 = getelementptr inbounds %struct.moonbit_object, ptr %178, i32 0, i32 1
  store i32 1049088, ptr %179, align 4
  %180 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %181 = load ptr, ptr %180, align 8
  %182 = load ptr, ptr %11, align 8
  %183 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %182, i32 0, i32 2
  store ptr %181, ptr %183, align 8
  %184 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %185 = load i32, ptr %184, align 8
  %186 = load ptr, ptr %11, align 8
  %187 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %186, i32 0, i32 0
  store i32 %185, ptr %187, align 8
  %188 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 1
  %189 = load i32, ptr %188, align 4
  %190 = load ptr, ptr %11, align 8
  %191 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %190, i32 0, i32 1
  store i32 %189, ptr %191, align 4
  %192 = load ptr, ptr %40, align 8
  %193 = load ptr, ptr %11, align 8
  %194 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %193, i32 0, i32 3
  store ptr %192, ptr %194, align 8
  br label %265

195:                                              ; preds = %135
  %196 = load i64, ptr %37, align 8
  store i64 %196, ptr %41, align 8
  %197 = load i64, ptr %41, align 8
  %198 = trunc i64 %197 to i32
  store i32 %198, ptr %42, align 4
  %199 = load i32, ptr %32, align 4
  %200 = add nsw i32 %199, 1
  store i32 %200, ptr %43, align 4
  %201 = load i32, ptr %43, align 4
  %202 = load i32, ptr %42, align 4
  %203 = add nsw i32 %201, %202
  store i32 %203, ptr %44, align 4
  %204 = load i32, ptr %44, align 4
  %205 = sext i32 %204 to i64
  store i64 %205, ptr %45, align 8
  %206 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %207 = load ptr, ptr %206, align 8
  call void @moonbit_incref_inlined(ptr noundef %207)
  %208 = load i64, ptr %45, align 8
  %209 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  %210 = load i64, ptr %209, align 8
  %211 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  %212 = load ptr, ptr %211, align 8
  %213 = call { i64, ptr } @"$StringView$$view$inner"(i64 %210, ptr %212, i32 noundef 0, i64 noundef %208)
  %214 = getelementptr inbounds { i64, ptr }, ptr %50, i32 0, i32 0
  %215 = extractvalue { i64, ptr } %213, 0
  store i64 %215, ptr %214, align 8
  %216 = getelementptr inbounds { i64, ptr }, ptr %50, i32 0, i32 1
  %217 = extractvalue { i64, ptr } %213, 1
  store ptr %217, ptr %216, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %46, ptr align 8 %50, i64 16, i1 false)
  %218 = load i32, ptr %44, align 4
  %219 = add nsw i32 %218, 1
  store i32 %219, ptr %47, align 4
  %220 = load i32, ptr %47, align 4
  %221 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  %222 = load i64, ptr %221, align 8
  %223 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  %224 = load ptr, ptr %223, align 8
  %225 = call { i64, ptr } @"$StringView$$view$inner"(i64 %222, ptr %224, i32 noundef %220, i64 noundef 4294967296)
  %226 = getelementptr inbounds { i64, ptr }, ptr %51, i32 0, i32 0
  %227 = extractvalue { i64, ptr } %225, 0
  store i64 %227, ptr %226, align 8
  %228 = getelementptr inbounds { i64, ptr }, ptr %51, i32 0, i32 1
  %229 = extractvalue { i64, ptr } %225, 1
  store ptr %229, ptr %228, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %48, ptr align 8 %51, i64 16, i1 false)
  %230 = call ptr @moonbit_malloc_inlined(i64 noundef 16)
  store ptr %230, ptr %49, align 8
  %231 = load ptr, ptr %49, align 8
  %232 = getelementptr inbounds %struct.moonbit_object, ptr %231, i64 -1
  %233 = getelementptr inbounds %struct.moonbit_object, ptr %232, i32 0, i32 1
  store i32 1048833, ptr %233, align 4
  %234 = getelementptr inbounds %"struct.$StringView", ptr %48, i32 0, i32 2
  %235 = load ptr, ptr %234, align 8
  %236 = load ptr, ptr %49, align 8
  %237 = getelementptr inbounds %"struct.$Option$3c$StringView$3e$$Some", ptr %236, i32 0, i32 2
  store ptr %235, ptr %237, align 8
  %238 = getelementptr inbounds %"struct.$StringView", ptr %48, i32 0, i32 0
  %239 = load i32, ptr %238, align 8
  %240 = load ptr, ptr %49, align 8
  %241 = getelementptr inbounds %"struct.$Option$3c$StringView$3e$$Some", ptr %240, i32 0, i32 0
  store i32 %239, ptr %241, align 8
  %242 = getelementptr inbounds %"struct.$StringView", ptr %48, i32 0, i32 1
  %243 = load i32, ptr %242, align 4
  %244 = load ptr, ptr %49, align 8
  %245 = getelementptr inbounds %"struct.$Option$3c$StringView$3e$$Some", ptr %244, i32 0, i32 1
  store i32 %243, ptr %245, align 4
  %246 = call ptr @moonbit_malloc_inlined(i64 noundef 24)
  store ptr %246, ptr %11, align 8
  %247 = load ptr, ptr %11, align 8
  %248 = getelementptr inbounds %struct.moonbit_object, ptr %247, i64 -1
  %249 = getelementptr inbounds %struct.moonbit_object, ptr %248, i32 0, i32 1
  store i32 1049088, ptr %249, align 4
  %250 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 2
  %251 = load ptr, ptr %250, align 8
  %252 = load ptr, ptr %11, align 8
  %253 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %252, i32 0, i32 2
  store ptr %251, ptr %253, align 8
  %254 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 0
  %255 = load i32, ptr %254, align 8
  %256 = load ptr, ptr %11, align 8
  %257 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %256, i32 0, i32 0
  store i32 %255, ptr %257, align 8
  %258 = getelementptr inbounds %"struct.$StringView", ptr %46, i32 0, i32 1
  %259 = load i32, ptr %258, align 4
  %260 = load ptr, ptr %11, align 8
  %261 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %260, i32 0, i32 1
  store i32 %259, ptr %261, align 4
  %262 = load ptr, ptr %49, align 8
  %263 = load ptr, ptr %11, align 8
  %264 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %263, i32 0, i32 3
  store ptr %262, ptr %264, align 8
  br label %265

265:                                              ; preds = %195, %175
  br label %266

266:                                              ; preds = %265, %115
  %267 = getelementptr inbounds %"struct.$StringView", ptr %52, i32 0, i32 0
  %268 = load ptr, ptr %11, align 8
  %269 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %268, i32 0, i32 0
  %270 = load i32, ptr %269, align 8
  store i32 %270, ptr %267, align 8
  %271 = getelementptr inbounds %"struct.$StringView", ptr %52, i32 0, i32 1
  %272 = load ptr, ptr %11, align 8
  %273 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %272, i32 0, i32 1
  %274 = load i32, ptr %273, align 4
  store i32 %274, ptr %271, align 4
  %275 = getelementptr inbounds %"struct.$StringView", ptr %52, i32 0, i32 2
  %276 = load ptr, ptr %11, align 8
  %277 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %276, i32 0, i32 2
  %278 = load ptr, ptr %277, align 8
  store ptr %278, ptr %275, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %12, ptr align 8 %52, i64 16, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %13, ptr align 8 %12, i64 16, i1 false)
  %279 = load ptr, ptr %11, align 8
  %280 = getelementptr inbounds %"struct.$$3c$StringView$2a$Option$3c$StringView$3e$$3e$", ptr %279, i32 0, i32 3
  %281 = load ptr, ptr %280, align 8
  store ptr %281, ptr %14, align 8
  %282 = load ptr, ptr %11, align 8
  %283 = getelementptr inbounds %struct.moonbit_object, ptr %282, i64 -1
  %284 = getelementptr inbounds %struct.moonbit_object, ptr %283, i32 0, i32 0
  %285 = load i32, ptr %284, align 4
  store i32 %285, ptr %15, align 4
  %286 = load i32, ptr %15, align 4
  %287 = icmp sgt i32 %286, 1
  br i1 %287, label %288, label %298

288:                                              ; preds = %266
  %289 = load ptr, ptr %14, align 8
  call void @moonbit_incref_inlined(ptr noundef %289)
  %290 = getelementptr inbounds %"struct.$StringView", ptr %13, i32 0, i32 2
  %291 = load ptr, ptr %290, align 8
  call void @moonbit_incref_inlined(ptr noundef %291)
  %292 = load i32, ptr %15, align 4
  %293 = sub nsw i32 %292, 1
  store i32 %293, ptr %53, align 4
  %294 = load i32, ptr %53, align 4
  %295 = load ptr, ptr %11, align 8
  %296 = getelementptr inbounds %struct.moonbit_object, ptr %295, i64 -1
  %297 = getelementptr inbounds %struct.moonbit_object, ptr %296, i32 0, i32 0
  store i32 %294, ptr %297, align 4
  br label %305

298:                                              ; preds = %266
  %299 = load i32, ptr %15, align 4
  %300 = icmp eq i32 %299, 1
  br i1 %300, label %301, label %304

301:                                              ; preds = %298
  %302 = load ptr, ptr %11, align 8
  %303 = getelementptr inbounds %struct.moonbit_object, ptr %302, i64 -1
  call void @free(ptr noundef %303)
  br label %304

304:                                              ; preds = %301, %298
  br label %305

305:                                              ; preds = %304, %288
  %306 = load ptr, ptr %14, align 8
  store ptr %306, ptr %16, align 8
  %307 = load ptr, ptr %16, align 8
  %308 = getelementptr inbounds %struct.moonbit_object, ptr %307, i64 -1
  %309 = getelementptr inbounds %struct.moonbit_object, ptr %308, i32 0, i32 1
  %310 = load i32, ptr %309, align 4
  %311 = and i32 %310, 255
  switch i32 %311, label %381 [
    i32 1, label %312
  ]

312:                                              ; preds = %305
  %313 = load ptr, ptr %16, align 8
  store ptr %313, ptr %54, align 8
  %314 = getelementptr inbounds %"struct.$StringView", ptr %55, i32 0, i32 0
  %315 = load ptr, ptr %54, align 8
  %316 = getelementptr inbounds %"struct.$Option$3c$StringView$3e$$Some", ptr %315, i32 0, i32 0
  %317 = load i32, ptr %316, align 8
  store i32 %317, ptr %314, align 8
  %318 = getelementptr inbounds %"struct.$StringView", ptr %55, i32 0, i32 1
  %319 = load ptr, ptr %54, align 8
  %320 = getelementptr inbounds %"struct.$Option$3c$StringView$3e$$Some", ptr %319, i32 0, i32 1
  %321 = load i32, ptr %320, align 4
  store i32 %321, ptr %318, align 4
  %322 = getelementptr inbounds %"struct.$StringView", ptr %55, i32 0, i32 2
  %323 = load ptr, ptr %54, align 8
  %324 = getelementptr inbounds %"struct.$Option$3c$StringView$3e$$Some", ptr %323, i32 0, i32 2
  %325 = load ptr, ptr %324, align 8
  store ptr %325, ptr %322, align 8
  %326 = load ptr, ptr %54, align 8
  %327 = getelementptr inbounds %struct.moonbit_object, ptr %326, i64 -1
  %328 = getelementptr inbounds %struct.moonbit_object, ptr %327, i32 0, i32 0
  %329 = load i32, ptr %328, align 4
  store i32 %329, ptr %56, align 4
  %330 = load i32, ptr %56, align 4
  %331 = icmp sgt i32 %330, 1
  br i1 %331, label %332, label %341

332:                                              ; preds = %312
  %333 = getelementptr inbounds %"struct.$StringView", ptr %55, i32 0, i32 2
  %334 = load ptr, ptr %333, align 8
  call void @moonbit_incref_inlined(ptr noundef %334)
  %335 = load i32, ptr %56, align 4
  %336 = sub nsw i32 %335, 1
  store i32 %336, ptr %59, align 4
  %337 = load i32, ptr %59, align 4
  %338 = load ptr, ptr %54, align 8
  %339 = getelementptr inbounds %struct.moonbit_object, ptr %338, i64 -1
  %340 = getelementptr inbounds %struct.moonbit_object, ptr %339, i32 0, i32 0
  store i32 %337, ptr %340, align 4
  br label %348

341:                                              ; preds = %312
  %342 = load i32, ptr %56, align 4
  %343 = icmp eq i32 %342, 1
  br i1 %343, label %344, label %347

344:                                              ; preds = %341
  %345 = load ptr, ptr %54, align 8
  %346 = getelementptr inbounds %struct.moonbit_object, ptr %345, i64 -1
  call void @free(ptr noundef %346)
  br label %347

347:                                              ; preds = %344, %341
  br label %348

348:                                              ; preds = %347, %332
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %57, ptr align 8 %55, i64 16, i1 false)
  %349 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %350 = load ptr, ptr %349, align 8
  %351 = icmp ne ptr %350, null
  br i1 %351, label %352, label %355

352:                                              ; preds = %348
  %353 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %354 = load ptr, ptr %353, align 8
  call void @moonbit_incref_inlined(ptr noundef %354)
  br label %355

355:                                              ; preds = %352, %348
  %356 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %357 = load ptr, ptr %356, align 8
  %358 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %357, i32 0, i32 2
  %359 = load ptr, ptr %358, align 8
  %360 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %361 = load ptr, ptr %360, align 8
  %362 = getelementptr inbounds { i64, ptr }, ptr %57, i32 0, i32 0
  %363 = load i64, ptr %362, align 8
  %364 = getelementptr inbounds { i64, ptr }, ptr %57, i32 0, i32 1
  %365 = load ptr, ptr %364, align 8
  %366 = call i32 %359(ptr noundef %361, i64 %363, ptr %365)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %58, ptr align 8 %4, i64 16, i1 false)
  %367 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %58, i32 0, i32 1
  %368 = load ptr, ptr %367, align 8
  %369 = icmp ne ptr %368, null
  br i1 %369, label %370, label %373

370:                                              ; preds = %355
  %371 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %58, i32 0, i32 1
  %372 = load ptr, ptr %371, align 8
  call void @moonbit_incref_inlined(ptr noundef %372)
  br label %373

373:                                              ; preds = %370, %355
  %374 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %58, i32 0, i32 0
  %375 = load ptr, ptr %374, align 8
  %376 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %375, i32 0, i32 3
  %377 = load ptr, ptr %376, align 8
  %378 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %58, i32 0, i32 1
  %379 = load ptr, ptr %378, align 8
  %380 = call i32 %377(ptr noundef %379, i32 noundef 47)
  br label %383

381:                                              ; preds = %305
  %382 = load ptr, ptr %16, align 8
  call void @moonbit_decref_inlined(ptr noundef %382)
  br label %383

383:                                              ; preds = %381, %373
  %384 = getelementptr inbounds %"struct.$StringView", ptr %60, i32 0, i32 0
  %385 = load ptr, ptr %5, align 8
  %386 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %385, i32 0, i32 2
  %387 = load i32, ptr %386, align 8
  store i32 %387, ptr %384, align 8
  %388 = getelementptr inbounds %"struct.$StringView", ptr %60, i32 0, i32 1
  %389 = load ptr, ptr %5, align 8
  %390 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %389, i32 0, i32 3
  %391 = load i32, ptr %390, align 4
  store i32 %391, ptr %388, align 4
  %392 = getelementptr inbounds %"struct.$StringView", ptr %60, i32 0, i32 2
  %393 = load ptr, ptr %5, align 8
  %394 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %393, i32 0, i32 13
  %395 = load ptr, ptr %394, align 8
  store ptr %395, ptr %392, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %17, ptr align 8 %60, i64 16, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %18, ptr align 8 %17, i64 16, i1 false)
  %396 = getelementptr inbounds %"struct.$StringView", ptr %18, i32 0, i32 2
  %397 = load ptr, ptr %396, align 8
  call void @moonbit_incref_inlined(ptr noundef %397)
  %398 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %399 = load ptr, ptr %398, align 8
  %400 = icmp ne ptr %399, null
  br i1 %400, label %401, label %404

401:                                              ; preds = %383
  %402 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %403 = load ptr, ptr %402, align 8
  call void @moonbit_incref_inlined(ptr noundef %403)
  br label %404

404:                                              ; preds = %401, %383
  %405 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %406 = load ptr, ptr %405, align 8
  %407 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %406, i32 0, i32 2
  %408 = load ptr, ptr %407, align 8
  %409 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %410 = load ptr, ptr %409, align 8
  %411 = getelementptr inbounds { i64, ptr }, ptr %18, i32 0, i32 0
  %412 = load i64, ptr %411, align 8
  %413 = getelementptr inbounds { i64, ptr }, ptr %18, i32 0, i32 1
  %414 = load ptr, ptr %413, align 8
  %415 = call i32 %408(ptr noundef %410, i64 %412, ptr %414)
  %416 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %417 = load ptr, ptr %416, align 8
  %418 = icmp ne ptr %417, null
  br i1 %418, label %419, label %422

419:                                              ; preds = %404
  %420 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %421 = load ptr, ptr %420, align 8
  call void @moonbit_incref_inlined(ptr noundef %421)
  br label %422

422:                                              ; preds = %419, %404
  %423 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %424 = load ptr, ptr %423, align 8
  %425 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %424, i32 0, i32 3
  %426 = load ptr, ptr %425, align 8
  %427 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %428 = load ptr, ptr %427, align 8
  %429 = call i32 %426(ptr noundef %428, i32 noundef 58)
  %430 = getelementptr inbounds %"struct.$StringView", ptr %61, i32 0, i32 0
  %431 = load ptr, ptr %5, align 8
  %432 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %431, i32 0, i32 4
  %433 = load i32, ptr %432, align 8
  store i32 %433, ptr %430, align 8
  %434 = getelementptr inbounds %"struct.$StringView", ptr %61, i32 0, i32 1
  %435 = load ptr, ptr %5, align 8
  %436 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %435, i32 0, i32 5
  %437 = load i32, ptr %436, align 4
  store i32 %437, ptr %434, align 4
  %438 = getelementptr inbounds %"struct.$StringView", ptr %61, i32 0, i32 2
  %439 = load ptr, ptr %5, align 8
  %440 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %439, i32 0, i32 14
  %441 = load ptr, ptr %440, align 8
  store ptr %441, ptr %438, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %19, ptr align 8 %61, i64 16, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %20, ptr align 8 %19, i64 16, i1 false)
  %442 = getelementptr inbounds %"struct.$StringView", ptr %20, i32 0, i32 2
  %443 = load ptr, ptr %442, align 8
  call void @moonbit_incref_inlined(ptr noundef %443)
  %444 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %445 = load ptr, ptr %444, align 8
  %446 = icmp ne ptr %445, null
  br i1 %446, label %447, label %450

447:                                              ; preds = %422
  %448 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %449 = load ptr, ptr %448, align 8
  call void @moonbit_incref_inlined(ptr noundef %449)
  br label %450

450:                                              ; preds = %447, %422
  %451 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %452 = load ptr, ptr %451, align 8
  %453 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %452, i32 0, i32 2
  %454 = load ptr, ptr %453, align 8
  %455 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %456 = load ptr, ptr %455, align 8
  %457 = getelementptr inbounds { i64, ptr }, ptr %20, i32 0, i32 0
  %458 = load i64, ptr %457, align 8
  %459 = getelementptr inbounds { i64, ptr }, ptr %20, i32 0, i32 1
  %460 = load ptr, ptr %459, align 8
  %461 = call i32 %454(ptr noundef %456, i64 %458, ptr %460)
  %462 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %463 = load ptr, ptr %462, align 8
  %464 = icmp ne ptr %463, null
  br i1 %464, label %465, label %468

465:                                              ; preds = %450
  %466 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %467 = load ptr, ptr %466, align 8
  call void @moonbit_incref_inlined(ptr noundef %467)
  br label %468

468:                                              ; preds = %465, %450
  %469 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %470 = load ptr, ptr %469, align 8
  %471 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %470, i32 0, i32 3
  %472 = load ptr, ptr %471, align 8
  %473 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %474 = load ptr, ptr %473, align 8
  %475 = call i32 %472(ptr noundef %474, i32 noundef 58)
  %476 = getelementptr inbounds %"struct.$StringView", ptr %62, i32 0, i32 0
  %477 = load ptr, ptr %5, align 8
  %478 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %477, i32 0, i32 6
  %479 = load i32, ptr %478, align 8
  store i32 %479, ptr %476, align 8
  %480 = getelementptr inbounds %"struct.$StringView", ptr %62, i32 0, i32 1
  %481 = load ptr, ptr %5, align 8
  %482 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %481, i32 0, i32 7
  %483 = load i32, ptr %482, align 4
  store i32 %483, ptr %480, align 4
  %484 = getelementptr inbounds %"struct.$StringView", ptr %62, i32 0, i32 2
  %485 = load ptr, ptr %5, align 8
  %486 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %485, i32 0, i32 15
  %487 = load ptr, ptr %486, align 8
  store ptr %487, ptr %484, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %21, ptr align 8 %62, i64 16, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %22, ptr align 8 %21, i64 16, i1 false)
  %488 = getelementptr inbounds %"struct.$StringView", ptr %22, i32 0, i32 2
  %489 = load ptr, ptr %488, align 8
  call void @moonbit_incref_inlined(ptr noundef %489)
  %490 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %491 = load ptr, ptr %490, align 8
  %492 = icmp ne ptr %491, null
  br i1 %492, label %493, label %496

493:                                              ; preds = %468
  %494 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %495 = load ptr, ptr %494, align 8
  call void @moonbit_incref_inlined(ptr noundef %495)
  br label %496

496:                                              ; preds = %493, %468
  %497 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %498 = load ptr, ptr %497, align 8
  %499 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %498, i32 0, i32 2
  %500 = load ptr, ptr %499, align 8
  %501 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %502 = load ptr, ptr %501, align 8
  %503 = getelementptr inbounds { i64, ptr }, ptr %22, i32 0, i32 0
  %504 = load i64, ptr %503, align 8
  %505 = getelementptr inbounds { i64, ptr }, ptr %22, i32 0, i32 1
  %506 = load ptr, ptr %505, align 8
  %507 = call i32 %500(ptr noundef %502, i64 %504, ptr %506)
  %508 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %509 = load ptr, ptr %508, align 8
  %510 = icmp ne ptr %509, null
  br i1 %510, label %511, label %514

511:                                              ; preds = %496
  %512 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %513 = load ptr, ptr %512, align 8
  call void @moonbit_incref_inlined(ptr noundef %513)
  br label %514

514:                                              ; preds = %511, %496
  %515 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %516 = load ptr, ptr %515, align 8
  %517 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %516, i32 0, i32 3
  %518 = load ptr, ptr %517, align 8
  %519 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %520 = load ptr, ptr %519, align 8
  %521 = call i32 %518(ptr noundef %520, i32 noundef 45)
  %522 = getelementptr inbounds %"struct.$StringView", ptr %63, i32 0, i32 0
  %523 = load ptr, ptr %5, align 8
  %524 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %523, i32 0, i32 8
  %525 = load i32, ptr %524, align 8
  store i32 %525, ptr %522, align 8
  %526 = getelementptr inbounds %"struct.$StringView", ptr %63, i32 0, i32 1
  %527 = load ptr, ptr %5, align 8
  %528 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %527, i32 0, i32 9
  %529 = load i32, ptr %528, align 4
  store i32 %529, ptr %526, align 4
  %530 = getelementptr inbounds %"struct.$StringView", ptr %63, i32 0, i32 2
  %531 = load ptr, ptr %5, align 8
  %532 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %531, i32 0, i32 16
  %533 = load ptr, ptr %532, align 8
  store ptr %533, ptr %530, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %23, ptr align 8 %63, i64 16, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %24, ptr align 8 %23, i64 16, i1 false)
  %534 = getelementptr inbounds %"struct.$StringView", ptr %24, i32 0, i32 2
  %535 = load ptr, ptr %534, align 8
  call void @moonbit_incref_inlined(ptr noundef %535)
  %536 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %537 = load ptr, ptr %536, align 8
  %538 = icmp ne ptr %537, null
  br i1 %538, label %539, label %542

539:                                              ; preds = %514
  %540 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %541 = load ptr, ptr %540, align 8
  call void @moonbit_incref_inlined(ptr noundef %541)
  br label %542

542:                                              ; preds = %539, %514
  %543 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %544 = load ptr, ptr %543, align 8
  %545 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %544, i32 0, i32 2
  %546 = load ptr, ptr %545, align 8
  %547 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %548 = load ptr, ptr %547, align 8
  %549 = getelementptr inbounds { i64, ptr }, ptr %24, i32 0, i32 0
  %550 = load i64, ptr %549, align 8
  %551 = getelementptr inbounds { i64, ptr }, ptr %24, i32 0, i32 1
  %552 = load ptr, ptr %551, align 8
  %553 = call i32 %546(ptr noundef %548, i64 %550, ptr %552)
  %554 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %555 = load ptr, ptr %554, align 8
  %556 = icmp ne ptr %555, null
  br i1 %556, label %557, label %560

557:                                              ; preds = %542
  %558 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %559 = load ptr, ptr %558, align 8
  call void @moonbit_incref_inlined(ptr noundef %559)
  br label %560

560:                                              ; preds = %557, %542
  %561 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %562 = load ptr, ptr %561, align 8
  %563 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %562, i32 0, i32 3
  %564 = load ptr, ptr %563, align 8
  %565 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %566 = load ptr, ptr %565, align 8
  %567 = call i32 %564(ptr noundef %566, i32 noundef 58)
  %568 = getelementptr inbounds %"struct.$StringView", ptr %64, i32 0, i32 0
  %569 = load ptr, ptr %5, align 8
  %570 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %569, i32 0, i32 10
  %571 = load i32, ptr %570, align 8
  store i32 %571, ptr %568, align 8
  %572 = getelementptr inbounds %"struct.$StringView", ptr %64, i32 0, i32 1
  %573 = load ptr, ptr %5, align 8
  %574 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %573, i32 0, i32 11
  %575 = load i32, ptr %574, align 4
  store i32 %575, ptr %572, align 4
  %576 = getelementptr inbounds %"struct.$StringView", ptr %64, i32 0, i32 2
  %577 = load ptr, ptr %5, align 8
  %578 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %577, i32 0, i32 17
  %579 = load ptr, ptr %578, align 8
  store ptr %579, ptr %576, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %25, ptr align 8 %64, i64 16, i1 false)
  %580 = load ptr, ptr %5, align 8
  %581 = getelementptr inbounds %struct.moonbit_object, ptr %580, i64 -1
  %582 = getelementptr inbounds %struct.moonbit_object, ptr %581, i32 0, i32 0
  %583 = load i32, ptr %582, align 4
  store i32 %583, ptr %26, align 4
  %584 = load i32, ptr %26, align 4
  %585 = icmp sgt i32 %584, 1
  br i1 %585, label %586, label %595

586:                                              ; preds = %560
  %587 = getelementptr inbounds %"struct.$StringView", ptr %25, i32 0, i32 2
  %588 = load ptr, ptr %587, align 8
  call void @moonbit_incref_inlined(ptr noundef %588)
  %589 = load i32, ptr %26, align 4
  %590 = sub nsw i32 %589, 1
  store i32 %590, ptr %65, align 4
  %591 = load i32, ptr %65, align 4
  %592 = load ptr, ptr %5, align 8
  %593 = getelementptr inbounds %struct.moonbit_object, ptr %592, i64 -1
  %594 = getelementptr inbounds %struct.moonbit_object, ptr %593, i32 0, i32 0
  store i32 %591, ptr %594, align 4
  br label %672

595:                                              ; preds = %560
  %596 = load i32, ptr %26, align 4
  %597 = icmp eq i32 %596, 1
  br i1 %597, label %598, label %671

598:                                              ; preds = %595
  %599 = getelementptr inbounds %"struct.$StringView", ptr %66, i32 0, i32 0
  %600 = load ptr, ptr %5, align 8
  %601 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %600, i32 0, i32 8
  %602 = load i32, ptr %601, align 8
  store i32 %602, ptr %599, align 8
  %603 = getelementptr inbounds %"struct.$StringView", ptr %66, i32 0, i32 1
  %604 = load ptr, ptr %5, align 8
  %605 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %604, i32 0, i32 9
  %606 = load i32, ptr %605, align 4
  store i32 %606, ptr %603, align 4
  %607 = getelementptr inbounds %"struct.$StringView", ptr %66, i32 0, i32 2
  %608 = load ptr, ptr %5, align 8
  %609 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %608, i32 0, i32 16
  %610 = load ptr, ptr %609, align 8
  store ptr %610, ptr %607, align 8
  %611 = getelementptr inbounds %"struct.$StringView", ptr %66, i32 0, i32 2
  %612 = load ptr, ptr %611, align 8
  call void @moonbit_decref_inlined(ptr noundef %612)
  %613 = getelementptr inbounds %"struct.$StringView", ptr %71, i32 0, i32 0
  %614 = load ptr, ptr %5, align 8
  %615 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %614, i32 0, i32 6
  %616 = load i32, ptr %615, align 8
  store i32 %616, ptr %613, align 8
  %617 = getelementptr inbounds %"struct.$StringView", ptr %71, i32 0, i32 1
  %618 = load ptr, ptr %5, align 8
  %619 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %618, i32 0, i32 7
  %620 = load i32, ptr %619, align 4
  store i32 %620, ptr %617, align 4
  %621 = getelementptr inbounds %"struct.$StringView", ptr %71, i32 0, i32 2
  %622 = load ptr, ptr %5, align 8
  %623 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %622, i32 0, i32 15
  %624 = load ptr, ptr %623, align 8
  store ptr %624, ptr %621, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %67, ptr align 8 %71, i64 16, i1 false)
  %625 = getelementptr inbounds %"struct.$StringView", ptr %67, i32 0, i32 2
  %626 = load ptr, ptr %625, align 8
  call void @moonbit_decref_inlined(ptr noundef %626)
  %627 = getelementptr inbounds %"struct.$StringView", ptr %72, i32 0, i32 0
  %628 = load ptr, ptr %5, align 8
  %629 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %628, i32 0, i32 4
  %630 = load i32, ptr %629, align 8
  store i32 %630, ptr %627, align 8
  %631 = getelementptr inbounds %"struct.$StringView", ptr %72, i32 0, i32 1
  %632 = load ptr, ptr %5, align 8
  %633 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %632, i32 0, i32 5
  %634 = load i32, ptr %633, align 4
  store i32 %634, ptr %631, align 4
  %635 = getelementptr inbounds %"struct.$StringView", ptr %72, i32 0, i32 2
  %636 = load ptr, ptr %5, align 8
  %637 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %636, i32 0, i32 14
  %638 = load ptr, ptr %637, align 8
  store ptr %638, ptr %635, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %68, ptr align 8 %72, i64 16, i1 false)
  %639 = getelementptr inbounds %"struct.$StringView", ptr %68, i32 0, i32 2
  %640 = load ptr, ptr %639, align 8
  call void @moonbit_decref_inlined(ptr noundef %640)
  %641 = getelementptr inbounds %"struct.$StringView", ptr %73, i32 0, i32 0
  %642 = load ptr, ptr %5, align 8
  %643 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %642, i32 0, i32 2
  %644 = load i32, ptr %643, align 8
  store i32 %644, ptr %641, align 8
  %645 = getelementptr inbounds %"struct.$StringView", ptr %73, i32 0, i32 1
  %646 = load ptr, ptr %5, align 8
  %647 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %646, i32 0, i32 3
  %648 = load i32, ptr %647, align 4
  store i32 %648, ptr %645, align 4
  %649 = getelementptr inbounds %"struct.$StringView", ptr %73, i32 0, i32 2
  %650 = load ptr, ptr %5, align 8
  %651 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %650, i32 0, i32 13
  %652 = load ptr, ptr %651, align 8
  store ptr %652, ptr %649, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %69, ptr align 8 %73, i64 16, i1 false)
  %653 = getelementptr inbounds %"struct.$StringView", ptr %69, i32 0, i32 2
  %654 = load ptr, ptr %653, align 8
  call void @moonbit_decref_inlined(ptr noundef %654)
  %655 = getelementptr inbounds %"struct.$StringView", ptr %74, i32 0, i32 0
  %656 = load ptr, ptr %5, align 8
  %657 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %656, i32 0, i32 0
  %658 = load i32, ptr %657, align 8
  store i32 %658, ptr %655, align 8
  %659 = getelementptr inbounds %"struct.$StringView", ptr %74, i32 0, i32 1
  %660 = load ptr, ptr %5, align 8
  %661 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %660, i32 0, i32 1
  %662 = load i32, ptr %661, align 4
  store i32 %662, ptr %659, align 4
  %663 = getelementptr inbounds %"struct.$StringView", ptr %74, i32 0, i32 2
  %664 = load ptr, ptr %5, align 8
  %665 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$SourceLocRepr", ptr %664, i32 0, i32 12
  %666 = load ptr, ptr %665, align 8
  store ptr %666, ptr %663, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %70, ptr align 8 %74, i64 16, i1 false)
  %667 = getelementptr inbounds %"struct.$StringView", ptr %70, i32 0, i32 2
  %668 = load ptr, ptr %667, align 8
  call void @moonbit_decref_inlined(ptr noundef %668)
  %669 = load ptr, ptr %5, align 8
  %670 = getelementptr inbounds %struct.moonbit_object, ptr %669, i64 -1
  call void @free(ptr noundef %670)
  br label %671

671:                                              ; preds = %598, %595
  br label %672

672:                                              ; preds = %671, %586
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %27, ptr align 8 %25, i64 16, i1 false)
  %673 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %674 = load ptr, ptr %673, align 8
  %675 = icmp ne ptr %674, null
  br i1 %675, label %676, label %679

676:                                              ; preds = %672
  %677 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %678 = load ptr, ptr %677, align 8
  call void @moonbit_incref_inlined(ptr noundef %678)
  br label %679

679:                                              ; preds = %676, %672
  %680 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %681 = load ptr, ptr %680, align 8
  %682 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %681, i32 0, i32 2
  %683 = load ptr, ptr %682, align 8
  %684 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %685 = load ptr, ptr %684, align 8
  %686 = getelementptr inbounds { i64, ptr }, ptr %27, i32 0, i32 0
  %687 = load i64, ptr %686, align 8
  %688 = getelementptr inbounds { i64, ptr }, ptr %27, i32 0, i32 1
  %689 = load ptr, ptr %688, align 8
  %690 = call i32 %683(ptr noundef %685, i64 %687, ptr %689)
  %691 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %692 = load ptr, ptr %691, align 8
  %693 = icmp ne ptr %692, null
  br i1 %693, label %694, label %697

694:                                              ; preds = %679
  %695 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %696 = load ptr, ptr %695, align 8
  call void @moonbit_incref_inlined(ptr noundef %696)
  br label %697

697:                                              ; preds = %694, %679
  %698 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %699 = load ptr, ptr %698, align 8
  %700 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %699, i32 0, i32 3
  %701 = load ptr, ptr %700, align 8
  %702 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %703 = load ptr, ptr %702, align 8
  %704 = call i32 %701(ptr noundef %703, i32 noundef 64)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %28, ptr align 8 %4, i64 16, i1 false)
  %705 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %28, i32 0, i32 0
  %706 = load ptr, ptr %705, align 8
  %707 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %706, i32 0, i32 2
  %708 = load ptr, ptr %707, align 8
  %709 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %28, i32 0, i32 1
  %710 = load ptr, ptr %709, align 8
  %711 = getelementptr inbounds { i64, ptr }, ptr %13, i32 0, i32 0
  %712 = load i64, ptr %711, align 8
  %713 = getelementptr inbounds { i64, ptr }, ptr %13, i32 0, i32 1
  %714 = load ptr, ptr %713, align 8
  %715 = call i32 %708(ptr noundef %710, i64 %712, ptr %714)
  ret i32 0
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @moonbit_incref_inlined(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %struct.moonbit_object, ptr %5, i64 -1
  store ptr %6, ptr %3, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = getelementptr inbounds %struct.moonbit_object, ptr %7, i32 0, i32 0
  %9 = load i32, ptr %8, align 4
  store i32 %9, ptr %4, align 4
  %10 = load i32, ptr %4, align 4
  %11 = icmp sgt i32 %10, 0
  br i1 %11, label %12, label %17

12:                                               ; preds = %1
  %13 = load i32, ptr %4, align 4
  %14 = add nsw i32 %13, 1
  %15 = load ptr, ptr %3, align 8
  %16 = getelementptr inbounds %struct.moonbit_object, ptr %15, i32 0, i32 0
  store i32 %14, ptr %16, align 4
  br label %17

17:                                               ; preds = %12, %1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @"$StringView$$find"(i64 %0, ptr %1, i64 %2, ptr %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca %"struct.$StringView", align 8
  %7 = alloca %"struct.$StringView", align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  store i64 %0, ptr %11, align 8
  %12 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  store ptr %1, ptr %12, align 8
  %13 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  store i64 %2, ptr %13, align 8
  %14 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  store ptr %3, ptr %14, align 8
  %15 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 1
  %16 = load i32, ptr %15, align 4
  store i32 %16, ptr %8, align 4
  %17 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %18 = load i32, ptr %17, align 8
  store i32 %18, ptr %9, align 4
  %19 = load i32, ptr %8, align 4
  %20 = load i32, ptr %9, align 4
  %21 = sub nsw i32 %19, %20
  store i32 %21, ptr %10, align 4
  %22 = load i32, ptr %10, align 4
  %23 = icmp sle i32 %22, 4
  br i1 %23, label %24, label %34

24:                                               ; preds = %4
  %25 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  %26 = load i64, ptr %25, align 8
  %27 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  %28 = load ptr, ptr %27, align 8
  %29 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  %30 = load i64, ptr %29, align 8
  %31 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  %32 = load ptr, ptr %31, align 8
  %33 = call i64 @"$moonbitlang$core$builtin$brute_force_find"(i64 %26, ptr %28, i64 %30, ptr %32)
  store i64 %33, ptr %5, align 8
  br label %44

34:                                               ; preds = %4
  %35 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  %36 = load i64, ptr %35, align 8
  %37 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  %38 = load ptr, ptr %37, align 8
  %39 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  %40 = load i64, ptr %39, align 8
  %41 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  %42 = load ptr, ptr %41, align 8
  %43 = call i64 @"$moonbitlang$core$builtin$boyer_moore_horspool_find"(i64 %36, ptr %38, i64 %40, ptr %42)
  store i64 %43, ptr %5, align 8
  br label %44

44:                                               ; preds = %34, %24
  %45 = load i64, ptr %5, align 8
  ret i64 %45
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @moonbit_malloc_inlined(i64 noundef %0) #0 {
  %2 = alloca i64, align 8
  %3 = alloca ptr, align 8
  store i64 %0, ptr %2, align 8
  %4 = load i64, ptr %2, align 8
  %5 = add i64 8, %4
  %6 = call ptr @malloc(i64 noundef %5) #7
  store ptr %6, ptr %3, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = getelementptr inbounds %struct.moonbit_object, ptr %7, i32 0, i32 0
  store i32 1, ptr %8, align 4
  %9 = load ptr, ptr %3, align 8
  %10 = getelementptr inbounds %struct.moonbit_object, ptr %9, i64 1
  ret ptr %10
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local { i64, ptr } @"$StringView$$view$inner"(i64 %0, ptr %1, i32 noundef %2, i64 noundef %3) #0 {
  %5 = alloca %"struct.$StringView", align 8
  %6 = alloca %"struct.$StringView", align 8
  %7 = alloca i32, align 4
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i64, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca ptr, align 8
  %18 = alloca ptr, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  store i64 %0, ptr %24, align 8
  %25 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  store ptr %1, ptr %25, align 8
  store i32 %2, ptr %7, align 4
  store i64 %3, ptr %8, align 8
  %26 = load i64, ptr %8, align 8
  %27 = icmp eq i64 %26, 4294967296
  br i1 %27, label %28, label %36

28:                                               ; preds = %4
  %29 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 1
  %30 = load i32, ptr %29, align 4
  store i32 %30, ptr %11, align 4
  %31 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %32 = load i32, ptr %31, align 8
  store i32 %32, ptr %12, align 4
  %33 = load i32, ptr %11, align 4
  %34 = load i32, ptr %12, align 4
  %35 = sub nsw i32 %33, %34
  store i32 %35, ptr %9, align 4
  br label %40

36:                                               ; preds = %4
  %37 = load i64, ptr %8, align 8
  store i64 %37, ptr %13, align 8
  %38 = load i64, ptr %13, align 8
  %39 = trunc i64 %38 to i32
  store i32 %39, ptr %9, align 4
  br label %40

40:                                               ; preds = %36, %28
  %41 = load i32, ptr %7, align 4
  %42 = icmp sge i32 %41, 0
  br i1 %42, label %43, label %61

43:                                               ; preds = %40
  %44 = load i32, ptr %7, align 4
  %45 = load i32, ptr %9, align 4
  %46 = icmp sle i32 %44, %45
  br i1 %46, label %47, label %59

47:                                               ; preds = %43
  %48 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 1
  %49 = load i32, ptr %48, align 4
  store i32 %49, ptr %14, align 4
  %50 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %51 = load i32, ptr %50, align 8
  store i32 %51, ptr %15, align 4
  %52 = load i32, ptr %14, align 4
  %53 = load i32, ptr %15, align 4
  %54 = sub nsw i32 %52, %53
  store i32 %54, ptr %16, align 4
  %55 = load i32, ptr %9, align 4
  %56 = load i32, ptr %16, align 4
  %57 = icmp sle i32 %55, %56
  %58 = zext i1 %57 to i32
  store i32 %58, ptr %10, align 4
  br label %60

59:                                               ; preds = %43
  store i32 0, ptr %10, align 4
  br label %60

60:                                               ; preds = %59, %47
  br label %62

61:                                               ; preds = %40
  store i32 0, ptr %10, align 4
  br label %62

62:                                               ; preds = %61, %60
  %63 = load i32, ptr %10, align 4
  %64 = icmp ne i32 %63, 0
  br i1 %64, label %65, label %86

65:                                               ; preds = %62
  %66 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %67 = load ptr, ptr %66, align 8
  store ptr %67, ptr %17, align 8
  %68 = load ptr, ptr %17, align 8
  store ptr %68, ptr %18, align 8
  %69 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %70 = load i32, ptr %69, align 8
  store i32 %70, ptr %19, align 4
  %71 = load i32, ptr %19, align 4
  %72 = load i32, ptr %7, align 4
  %73 = add nsw i32 %71, %72
  store i32 %73, ptr %20, align 4
  %74 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %75 = load i32, ptr %74, align 8
  store i32 %75, ptr %21, align 4
  %76 = load i32, ptr %21, align 4
  store i32 %76, ptr %22, align 4
  %77 = load i32, ptr %22, align 4
  %78 = load i32, ptr %9, align 4
  %79 = add nsw i32 %77, %78
  store i32 %79, ptr %23, align 4
  %80 = getelementptr inbounds %"struct.$StringView", ptr %5, i32 0, i32 0
  %81 = load i32, ptr %20, align 4
  store i32 %81, ptr %80, align 8
  %82 = getelementptr inbounds %"struct.$StringView", ptr %5, i32 0, i32 1
  %83 = load i32, ptr %23, align 4
  store i32 %83, ptr %82, align 4
  %84 = getelementptr inbounds %"struct.$StringView", ptr %5, i32 0, i32 2
  %85 = load ptr, ptr %18, align 8
  store ptr %85, ptr %84, align 8
  br label %94

86:                                               ; preds = %62
  %87 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %88 = load ptr, ptr %87, align 8
  call void @moonbit_decref_inlined(ptr noundef %88)
  %89 = call { i64, ptr } @"$moonbitlang$core$builtin$abort$2"(ptr noundef getelementptr inbounds (%struct.anon.4, ptr @moonbit_string_literal_11, i32 0, i32 2), ptr noundef getelementptr inbounds (%struct.anon.9, ptr @moonbit_string_literal_12, i32 0, i32 2))
  %90 = getelementptr inbounds { i64, ptr }, ptr %5, i32 0, i32 0
  %91 = extractvalue { i64, ptr } %89, 0
  store i64 %91, ptr %90, align 8
  %92 = getelementptr inbounds { i64, ptr }, ptr %5, i32 0, i32 1
  %93 = extractvalue { i64, ptr } %89, 1
  store ptr %93, ptr %92, align 8
  br label %94

94:                                               ; preds = %86, %65
  %95 = load { i64, ptr }, ptr %5, align 8
  ret { i64, ptr } %95
}

declare void @free(ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @moonbit_decref_inlined(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %struct.moonbit_object, ptr %5, i64 -1
  store ptr %6, ptr %3, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = getelementptr inbounds %struct.moonbit_object, ptr %7, i32 0, i32 0
  %9 = load i32, ptr %8, align 4
  store i32 %9, ptr %4, align 4
  %10 = load i32, ptr %4, align 4
  %11 = icmp sgt i32 %10, 1
  br i1 %11, label %12, label %17

12:                                               ; preds = %1
  %13 = load i32, ptr %4, align 4
  %14 = sub nsw i32 %13, 1
  %15 = load ptr, ptr %3, align 8
  %16 = getelementptr inbounds %struct.moonbit_object, ptr %15, i32 0, i32 0
  store i32 %14, ptr %16, align 4
  br label %23

17:                                               ; preds = %1
  %18 = load i32, ptr %4, align 4
  %19 = icmp eq i32 %18, 1
  br i1 %19, label %20, label %22

20:                                               ; preds = %17
  %21 = load ptr, ptr %2, align 8
  call void @moonbit_drop_object(ptr noundef %21)
  br label %22

22:                                               ; preds = %20, %17
  br label %23

23:                                               ; preds = %22, %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$moonbitlang$core$builtin$println$0"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @moonbit_println(ptr noundef %3)
  %4 = load ptr, ptr %2, align 8
  call void @moonbit_decref_inlined(ptr noundef %4)
  ret i32 0
}

declare void @moonbit_println(ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$$moonbitlang$core$builtin$Show$$String$$to_string"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Show$$Int$$output"(i32 noundef %0, ptr %1, ptr %2) #0 {
  %4 = alloca %"struct.$$moonbitlang$core$builtin$Logger", align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 0
  store ptr %1, ptr %7, align 8
  %8 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 1
  store ptr %2, ptr %8, align 8
  store i32 %0, ptr %5, align 4
  %9 = load i32, ptr %5, align 4
  %10 = call ptr @"$Int$$to_string$inner"(i32 noundef %9, i32 noundef 10)
  store ptr %10, ptr %6, align 8
  %11 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 0
  %12 = load ptr, ptr %11, align 8
  %13 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger$static_method_table", ptr %12, i32 0, i32 0
  %14 = load ptr, ptr %13, align 8
  %15 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %4, i32 0, i32 1
  %16 = load ptr, ptr %15, align 8
  %17 = load ptr, ptr %6, align 8
  %18 = call i32 %14(ptr noundef %16, ptr noundef %17)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$Int$$to_string$inner"(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca ptr, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca ptr, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca ptr, align 8
  %24 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  %25 = load i32, ptr %5, align 4
  %26 = icmp slt i32 %25, 2
  br i1 %26, label %30, label %27

27:                                               ; preds = %2
  %28 = load i32, ptr %5, align 4
  %29 = icmp sgt i32 %28, 36
  br i1 %29, label %30, label %32

30:                                               ; preds = %27, %2
  %31 = call i32 @"$moonbitlang$core$builtin$abort$0"(ptr noundef getelementptr inbounds (%struct.anon.5, ptr @moonbit_string_literal_7, i32 0, i32 2), ptr noundef getelementptr inbounds (%struct.anon.10, ptr @moonbit_string_literal_8, i32 0, i32 2))
  br label %32

32:                                               ; preds = %30, %27
  %33 = load i32, ptr %4, align 4
  %34 = icmp eq i32 %33, 0
  br i1 %34, label %35, label %36

35:                                               ; preds = %32
  store ptr getelementptr inbounds (%struct.anon.6, ptr @moonbit_string_literal_9, i32 0, i32 2), ptr %3, align 8
  br label %135

36:                                               ; preds = %32
  %37 = load i32, ptr %4, align 4
  %38 = icmp slt i32 %37, 0
  %39 = zext i1 %38 to i32
  store i32 %39, ptr %6, align 4
  %40 = load i32, ptr %6, align 4
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %42, label %46

42:                                               ; preds = %36
  %43 = load i32, ptr %4, align 4
  %44 = sub nsw i32 0, %43
  store i32 %44, ptr %9, align 4
  %45 = load i32, ptr %9, align 4
  store i32 %45, ptr %7, align 4
  br label %48

46:                                               ; preds = %36
  %47 = load i32, ptr %4, align 4
  store i32 %47, ptr %7, align 4
  br label %48

48:                                               ; preds = %46, %42
  %49 = load i32, ptr %5, align 4
  switch i32 %49, label %100 [
    i32 10, label %50
    i32 16, label %75
  ]

50:                                               ; preds = %48
  %51 = load i32, ptr %7, align 4
  %52 = call i32 @"$moonbitlang$core$builtin$dec_count32"(i32 noundef %51)
  store i32 %52, ptr %10, align 4
  %53 = load i32, ptr %6, align 4
  %54 = icmp ne i32 %53, 0
  br i1 %54, label %55, label %56

55:                                               ; preds = %50
  store i32 1, ptr %11, align 4
  br label %57

56:                                               ; preds = %50
  store i32 0, ptr %11, align 4
  br label %57

57:                                               ; preds = %56, %55
  %58 = load i32, ptr %10, align 4
  %59 = load i32, ptr %11, align 4
  %60 = add nsw i32 %58, %59
  store i32 %60, ptr %12, align 4
  %61 = load i32, ptr %12, align 4
  %62 = call ptr @moonbit_make_string(i32 noundef %61, i16 noundef zeroext 0)
  store ptr %62, ptr %13, align 8
  %63 = load i32, ptr %6, align 4
  %64 = icmp ne i32 %63, 0
  br i1 %64, label %65, label %66

65:                                               ; preds = %57
  store i32 1, ptr %14, align 4
  br label %67

66:                                               ; preds = %57
  store i32 0, ptr %14, align 4
  br label %67

67:                                               ; preds = %66, %65
  %68 = load ptr, ptr %13, align 8
  call void @moonbit_incref_inlined(ptr noundef %68)
  %69 = load ptr, ptr %13, align 8
  %70 = load i32, ptr %7, align 4
  %71 = load i32, ptr %14, align 4
  %72 = load i32, ptr %12, align 4
  %73 = call i32 @"$moonbitlang$core$builtin$int_to_string_dec"(ptr noundef %69, i32 noundef %70, i32 noundef %71, i32 noundef %72)
  %74 = load ptr, ptr %13, align 8
  store ptr %74, ptr %8, align 8
  br label %127

75:                                               ; preds = %48
  %76 = load i32, ptr %7, align 4
  %77 = call i32 @"$moonbitlang$core$builtin$hex_count32"(i32 noundef %76)
  store i32 %77, ptr %15, align 4
  %78 = load i32, ptr %6, align 4
  %79 = icmp ne i32 %78, 0
  br i1 %79, label %80, label %81

80:                                               ; preds = %75
  store i32 1, ptr %16, align 4
  br label %82

81:                                               ; preds = %75
  store i32 0, ptr %16, align 4
  br label %82

82:                                               ; preds = %81, %80
  %83 = load i32, ptr %15, align 4
  %84 = load i32, ptr %16, align 4
  %85 = add nsw i32 %83, %84
  store i32 %85, ptr %17, align 4
  %86 = load i32, ptr %17, align 4
  %87 = call ptr @moonbit_make_string(i32 noundef %86, i16 noundef zeroext 0)
  store ptr %87, ptr %18, align 8
  %88 = load i32, ptr %6, align 4
  %89 = icmp ne i32 %88, 0
  br i1 %89, label %90, label %91

90:                                               ; preds = %82
  store i32 1, ptr %19, align 4
  br label %92

91:                                               ; preds = %82
  store i32 0, ptr %19, align 4
  br label %92

92:                                               ; preds = %91, %90
  %93 = load ptr, ptr %18, align 8
  call void @moonbit_incref_inlined(ptr noundef %93)
  %94 = load ptr, ptr %18, align 8
  %95 = load i32, ptr %7, align 4
  %96 = load i32, ptr %19, align 4
  %97 = load i32, ptr %17, align 4
  %98 = call i32 @"$moonbitlang$core$builtin$int_to_string_hex"(ptr noundef %94, i32 noundef %95, i32 noundef %96, i32 noundef %97)
  %99 = load ptr, ptr %18, align 8
  store ptr %99, ptr %8, align 8
  br label %127

100:                                              ; preds = %48
  %101 = load i32, ptr %7, align 4
  %102 = load i32, ptr %5, align 4
  %103 = call i32 @"$moonbitlang$core$builtin$radix_count32"(i32 noundef %101, i32 noundef %102)
  store i32 %103, ptr %20, align 4
  %104 = load i32, ptr %6, align 4
  %105 = icmp ne i32 %104, 0
  br i1 %105, label %106, label %107

106:                                              ; preds = %100
  store i32 1, ptr %21, align 4
  br label %108

107:                                              ; preds = %100
  store i32 0, ptr %21, align 4
  br label %108

108:                                              ; preds = %107, %106
  %109 = load i32, ptr %20, align 4
  %110 = load i32, ptr %21, align 4
  %111 = add nsw i32 %109, %110
  store i32 %111, ptr %22, align 4
  %112 = load i32, ptr %22, align 4
  %113 = call ptr @moonbit_make_string(i32 noundef %112, i16 noundef zeroext 0)
  store ptr %113, ptr %23, align 8
  %114 = load i32, ptr %6, align 4
  %115 = icmp ne i32 %114, 0
  br i1 %115, label %116, label %117

116:                                              ; preds = %108
  store i32 1, ptr %24, align 4
  br label %118

117:                                              ; preds = %108
  store i32 0, ptr %24, align 4
  br label %118

118:                                              ; preds = %117, %116
  %119 = load ptr, ptr %23, align 8
  call void @moonbit_incref_inlined(ptr noundef %119)
  %120 = load ptr, ptr %23, align 8
  %121 = load i32, ptr %7, align 4
  %122 = load i32, ptr %24, align 4
  %123 = load i32, ptr %22, align 4
  %124 = load i32, ptr %5, align 4
  %125 = call i32 @"$moonbitlang$core$builtin$int_to_string_generic"(ptr noundef %120, i32 noundef %121, i32 noundef %122, i32 noundef %123, i32 noundef %124)
  %126 = load ptr, ptr %23, align 8
  store ptr %126, ptr %8, align 8
  br label %127

127:                                              ; preds = %118, %92, %67
  %128 = load i32, ptr %6, align 4
  %129 = icmp ne i32 %128, 0
  br i1 %129, label %130, label %133

130:                                              ; preds = %127
  %131 = load ptr, ptr %8, align 8
  %132 = getelementptr inbounds i16, ptr %131, i64 0
  store i16 45, ptr %132, align 2
  br label %133

133:                                              ; preds = %130, %127
  %134 = load ptr, ptr %8, align 8
  store ptr %134, ptr %3, align 8
  br label %135

135:                                              ; preds = %133, %35
  %136 = load ptr, ptr %3, align 8
  ret ptr %136
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view"(ptr noundef %0, i64 %1, ptr %2) #0 {
  %4 = alloca %"struct.$StringView", align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 0
  store i64 %1, ptr %28, align 8
  %29 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 1
  store ptr %2, ptr %29, align 8
  store ptr %0, ptr %5, align 8
  %30 = load ptr, ptr %5, align 8
  %31 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %30, i32 0, i32 0
  %32 = load i32, ptr %31, align 8
  store i32 %32, ptr %6, align 4
  %33 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 1
  %34 = load i32, ptr %33, align 4
  store i32 %34, ptr %7, align 4
  %35 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 0
  %36 = load i32, ptr %35, align 8
  store i32 %36, ptr %8, align 4
  %37 = load i32, ptr %7, align 4
  %38 = load i32, ptr %8, align 4
  %39 = sub nsw i32 %37, %38
  store i32 %39, ptr %9, align 4
  %40 = load i32, ptr %9, align 4
  %41 = mul nsw i32 %40, 2
  store i32 %41, ptr %10, align 4
  %42 = load i32, ptr %6, align 4
  %43 = load i32, ptr %10, align 4
  %44 = add nsw i32 %42, %43
  store i32 %44, ptr %11, align 4
  %45 = load ptr, ptr %5, align 8
  call void @moonbit_incref_inlined(ptr noundef %45)
  %46 = load ptr, ptr %5, align 8
  %47 = load i32, ptr %11, align 4
  %48 = call i32 @"$$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary"(ptr noundef %46, i32 noundef %47)
  %49 = load ptr, ptr %5, align 8
  %50 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %49, i32 0, i32 1
  %51 = load ptr, ptr %50, align 8
  store ptr %51, ptr %12, align 8
  %52 = load ptr, ptr %12, align 8
  store ptr %52, ptr %13, align 8
  %53 = load ptr, ptr %5, align 8
  %54 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %53, i32 0, i32 0
  %55 = load i32, ptr %54, align 8
  store i32 %55, ptr %14, align 4
  %56 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 2
  %57 = load ptr, ptr %56, align 8
  store ptr %57, ptr %15, align 8
  %58 = load ptr, ptr %15, align 8
  store ptr %58, ptr %16, align 8
  %59 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 0
  %60 = load i32, ptr %59, align 8
  store i32 %60, ptr %17, align 4
  %61 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 1
  %62 = load i32, ptr %61, align 4
  store i32 %62, ptr %18, align 4
  %63 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 0
  %64 = load i32, ptr %63, align 8
  store i32 %64, ptr %19, align 4
  %65 = load i32, ptr %18, align 4
  %66 = load i32, ptr %19, align 4
  %67 = sub nsw i32 %65, %66
  store i32 %67, ptr %20, align 4
  %68 = load ptr, ptr %16, align 8
  call void @moonbit_incref_inlined(ptr noundef %68)
  %69 = load ptr, ptr %13, align 8
  call void @moonbit_incref_inlined(ptr noundef %69)
  %70 = load ptr, ptr %13, align 8
  %71 = load i32, ptr %14, align 4
  %72 = load ptr, ptr %16, align 8
  %73 = load i32, ptr %17, align 4
  %74 = load i32, ptr %20, align 4
  %75 = call i32 @"$FixedArray$$blit_from_string"(ptr noundef %70, i32 noundef %71, ptr noundef %72, i32 noundef %73, i32 noundef %74)
  %76 = load ptr, ptr %5, align 8
  %77 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %76, i32 0, i32 0
  %78 = load i32, ptr %77, align 8
  store i32 %78, ptr %21, align 4
  %79 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 1
  %80 = load i32, ptr %79, align 4
  store i32 %80, ptr %22, align 4
  %81 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 0
  %82 = load i32, ptr %81, align 8
  store i32 %82, ptr %23, align 4
  %83 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 2
  %84 = load ptr, ptr %83, align 8
  call void @moonbit_decref_inlined(ptr noundef %84)
  %85 = load i32, ptr %23, align 4
  store i32 %85, ptr %24, align 4
  %86 = load i32, ptr %22, align 4
  %87 = load i32, ptr %24, align 4
  %88 = sub nsw i32 %86, %87
  store i32 %88, ptr %25, align 4
  %89 = load i32, ptr %25, align 4
  %90 = mul nsw i32 %89, 2
  store i32 %90, ptr %26, align 4
  %91 = load i32, ptr %21, align 4
  %92 = load i32, ptr %26, align 4
  %93 = add nsw i32 %91, %92
  store i32 %93, ptr %27, align 4
  %94 = load i32, ptr %27, align 4
  %95 = load ptr, ptr %5, align 8
  %96 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %95, i32 0, i32 0
  store i32 %94, ptr %96, align 8
  %97 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %97)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary"(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca ptr, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  %19 = load ptr, ptr %4, align 8
  %20 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %19, i32 0, i32 1
  %21 = load ptr, ptr %20, align 8
  store ptr %21, ptr %6, align 8
  %22 = load ptr, ptr %6, align 8
  store ptr %22, ptr %7, align 8
  %23 = load ptr, ptr %7, align 8
  %24 = getelementptr inbounds %struct.moonbit_object, ptr %23, i64 -1
  %25 = getelementptr inbounds %struct.moonbit_object, ptr %24, i32 0, i32 1
  %26 = load i32, ptr %25, align 4
  %27 = and i32 %26, 268435455
  store i32 %27, ptr %8, align 4
  %28 = load i32, ptr %8, align 4
  store i32 %28, ptr %9, align 4
  %29 = load i32, ptr %5, align 4
  %30 = load i32, ptr %9, align 4
  %31 = icmp sle i32 %29, %30
  br i1 %31, label %32, label %34

32:                                               ; preds = %2
  %33 = load ptr, ptr %4, align 8
  call void @moonbit_decref_inlined(ptr noundef %33)
  store i32 0, ptr %3, align 4
  br label %71

34:                                               ; preds = %2
  %35 = load i32, ptr %9, align 4
  store i32 %35, ptr %10, align 4
  br label %36

36:                                               ; preds = %34, %41
  %37 = load i32, ptr %10, align 4
  store i32 %37, ptr %17, align 4
  %38 = load i32, ptr %17, align 4
  %39 = load i32, ptr %5, align 4
  %40 = icmp slt i32 %38, %39
  br i1 %40, label %41, label %45

41:                                               ; preds = %36
  %42 = load i32, ptr %10, align 4
  store i32 %42, ptr %18, align 4
  %43 = load i32, ptr %18, align 4
  %44 = mul nsw i32 %43, 2
  store i32 %44, ptr %10, align 4
  br label %36

45:                                               ; preds = %36
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %10, align 4
  store i32 %47, ptr %11, align 4
  %48 = load i32, ptr %11, align 4
  %49 = call ptr @moonbit_make_bytes(i32 noundef %48, i32 noundef 0)
  store ptr %49, ptr %12, align 8
  %50 = load ptr, ptr %4, align 8
  %51 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %50, i32 0, i32 1
  %52 = load ptr, ptr %51, align 8
  store ptr %52, ptr %13, align 8
  %53 = load ptr, ptr %13, align 8
  store ptr %53, ptr %14, align 8
  %54 = load ptr, ptr %4, align 8
  %55 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %54, i32 0, i32 0
  %56 = load i32, ptr %55, align 8
  store i32 %56, ptr %15, align 4
  %57 = load ptr, ptr %14, align 8
  call void @moonbit_incref_inlined(ptr noundef %57)
  %58 = load ptr, ptr %12, align 8
  call void @moonbit_incref_inlined(ptr noundef %58)
  %59 = load ptr, ptr %12, align 8
  %60 = load ptr, ptr %14, align 8
  %61 = load i32, ptr %15, align 4
  %62 = call i32 @"$FixedArray$$unsafe_blit$0"(ptr noundef %59, i32 noundef 0, ptr noundef %60, i32 noundef 0, i32 noundef %61)
  %63 = load ptr, ptr %4, align 8
  %64 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %63, i32 0, i32 1
  %65 = load ptr, ptr %64, align 8
  store ptr %65, ptr %16, align 8
  %66 = load ptr, ptr %16, align 8
  call void @moonbit_decref_inlined(ptr noundef %66)
  %67 = load ptr, ptr %12, align 8
  %68 = load ptr, ptr %4, align 8
  %69 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %68, i32 0, i32 1
  store ptr %67, ptr %69, align 8
  %70 = load ptr, ptr %4, align 8
  call void @moonbit_decref_inlined(ptr noundef %70)
  store i32 0, ptr %3, align 4
  br label %71

71:                                               ; preds = %46, %32
  %72 = load i32, ptr %3, align 4
  ret i32 %72
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$FixedArray$$blit_from_string"(ptr noundef %0, i32 noundef %1, ptr noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store i32 %1, ptr %7, align 4
  store ptr %2, ptr %8, align 8
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  %32 = load i32, ptr %10, align 4
  %33 = mul nsw i32 %32, 2
  store i32 %33, ptr %11, align 4
  %34 = load i32, ptr %7, align 4
  %35 = load i32, ptr %11, align 4
  %36 = add nsw i32 %34, %35
  store i32 %36, ptr %12, align 4
  %37 = load i32, ptr %12, align 4
  %38 = sub nsw i32 %37, 1
  store i32 %38, ptr %13, align 4
  %39 = load i32, ptr %9, align 4
  %40 = load i32, ptr %10, align 4
  %41 = add nsw i32 %39, %40
  store i32 %41, ptr %14, align 4
  %42 = load i32, ptr %14, align 4
  %43 = sub nsw i32 %42, 1
  store i32 %43, ptr %15, align 4
  %44 = load ptr, ptr %6, align 8
  %45 = getelementptr inbounds %struct.moonbit_object, ptr %44, i64 -1
  %46 = getelementptr inbounds %struct.moonbit_object, ptr %45, i32 0, i32 1
  %47 = load i32, ptr %46, align 4
  %48 = and i32 %47, 268435455
  store i32 %48, ptr %16, align 4
  %49 = load ptr, ptr %8, align 8
  %50 = getelementptr inbounds %struct.moonbit_object, ptr %49, i64 -1
  %51 = getelementptr inbounds %struct.moonbit_object, ptr %50, i32 0, i32 1
  %52 = load i32, ptr %51, align 4
  %53 = and i32 %52, 268435455
  store i32 %53, ptr %17, align 4
  %54 = load i32, ptr %10, align 4
  %55 = icmp sge i32 %54, 0
  br i1 %55, label %56, label %147

56:                                               ; preds = %5
  %57 = load i32, ptr %7, align 4
  %58 = icmp sge i32 %57, 0
  br i1 %58, label %59, label %147

59:                                               ; preds = %56
  %60 = load i32, ptr %13, align 4
  %61 = load i32, ptr %16, align 4
  %62 = icmp slt i32 %60, %61
  br i1 %62, label %63, label %147

63:                                               ; preds = %59
  %64 = load i32, ptr %9, align 4
  %65 = icmp sge i32 %64, 0
  br i1 %65, label %66, label %147

66:                                               ; preds = %63
  %67 = load i32, ptr %15, align 4
  %68 = load i32, ptr %17, align 4
  %69 = icmp slt i32 %67, %68
  br i1 %69, label %70, label %147

70:                                               ; preds = %66
  %71 = load i32, ptr %9, align 4
  %72 = load i32, ptr %10, align 4
  %73 = add nsw i32 %71, %72
  store i32 %73, ptr %18, align 4
  %74 = load i32, ptr %9, align 4
  store i32 %74, ptr %19, align 4
  %75 = load i32, ptr %7, align 4
  store i32 %75, ptr %20, align 4
  br label %76

76:                                               ; preds = %70, %129
  %77 = load i32, ptr %19, align 4
  %78 = load i32, ptr %18, align 4
  %79 = icmp slt i32 %77, %78
  br i1 %79, label %80, label %142

80:                                               ; preds = %76
  %81 = load ptr, ptr %8, align 8
  %82 = load i32, ptr %19, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds i16, ptr %81, i64 %83
  %85 = load i16, ptr %84, align 2
  %86 = zext i16 %85 to i32
  store i32 %86, ptr %21, align 4
  %87 = load i32, ptr %21, align 4
  store i32 %87, ptr %22, align 4
  %88 = load i32, ptr %22, align 4
  %89 = and i32 %88, 255
  store i32 %89, ptr %23, align 4
  %90 = load i32, ptr %23, align 4
  store i32 %90, ptr %24, align 4
  %91 = load i32, ptr %24, align 4
  %92 = and i32 %91, 255
  store i32 %92, ptr %25, align 4
  %93 = load i32, ptr %20, align 4
  %94 = icmp slt i32 %93, 0
  br i1 %94, label %103, label %95

95:                                               ; preds = %80
  %96 = load i32, ptr %20, align 4
  %97 = load ptr, ptr %6, align 8
  %98 = getelementptr inbounds %struct.moonbit_object, ptr %97, i64 -1
  %99 = getelementptr inbounds %struct.moonbit_object, ptr %98, i32 0, i32 1
  %100 = load i32, ptr %99, align 4
  %101 = and i32 %100, 268435455
  %102 = icmp uge i32 %96, %101
  br i1 %102, label %103, label %104

103:                                              ; preds = %95, %80
  call void @moonbit_panic() #6
  unreachable

104:                                              ; preds = %95
  %105 = load i32, ptr %25, align 4
  %106 = trunc i32 %105 to i8
  %107 = load ptr, ptr %6, align 8
  %108 = load i32, ptr %20, align 4
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds i8, ptr %107, i64 %109
  store i8 %106, ptr %110, align 1
  %111 = load i32, ptr %20, align 4
  %112 = add nsw i32 %111, 1
  store i32 %112, ptr %26, align 4
  %113 = load i32, ptr %22, align 4
  %114 = lshr i32 %113, 8
  store i32 %114, ptr %27, align 4
  %115 = load i32, ptr %27, align 4
  store i32 %115, ptr %28, align 4
  %116 = load i32, ptr %28, align 4
  %117 = and i32 %116, 255
  store i32 %117, ptr %29, align 4
  %118 = load i32, ptr %26, align 4
  %119 = icmp slt i32 %118, 0
  br i1 %119, label %128, label %120

120:                                              ; preds = %104
  %121 = load i32, ptr %26, align 4
  %122 = load ptr, ptr %6, align 8
  %123 = getelementptr inbounds %struct.moonbit_object, ptr %122, i64 -1
  %124 = getelementptr inbounds %struct.moonbit_object, ptr %123, i32 0, i32 1
  %125 = load i32, ptr %124, align 4
  %126 = and i32 %125, 268435455
  %127 = icmp uge i32 %121, %126
  br i1 %127, label %128, label %129

128:                                              ; preds = %120, %104
  call void @moonbit_panic() #6
  unreachable

129:                                              ; preds = %120
  %130 = load i32, ptr %29, align 4
  %131 = trunc i32 %130 to i8
  %132 = load ptr, ptr %6, align 8
  %133 = load i32, ptr %26, align 4
  %134 = sext i32 %133 to i64
  %135 = getelementptr inbounds i8, ptr %132, i64 %134
  store i8 %131, ptr %135, align 1
  %136 = load i32, ptr %19, align 4
  %137 = add nsw i32 %136, 1
  store i32 %137, ptr %30, align 4
  %138 = load i32, ptr %20, align 4
  %139 = add nsw i32 %138, 2
  store i32 %139, ptr %31, align 4
  %140 = load i32, ptr %30, align 4
  store i32 %140, ptr %19, align 4
  %141 = load i32, ptr %31, align 4
  store i32 %141, ptr %20, align 4
  br label %76

142:                                              ; preds = %76
  %143 = load ptr, ptr %8, align 8
  call void @moonbit_decref_inlined(ptr noundef %143)
  %144 = load ptr, ptr %6, align 8
  call void @moonbit_decref_inlined(ptr noundef %144)
  br label %145

145:                                              ; preds = %142
  br label %146

146:                                              ; preds = %145
  br label %150

147:                                              ; preds = %66, %63, %59, %56, %5
  %148 = load ptr, ptr %8, align 8
  call void @moonbit_decref_inlined(ptr noundef %148)
  %149 = load ptr, ptr %6, align 8
  call void @moonbit_decref_inlined(ptr noundef %149)
  call void @moonbit_panic() #6
  unreachable

150:                                              ; preds = %146
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @"$String$$offset_of_nth_char$inner"(ptr noundef %0, i32 noundef %1, i32 noundef %2, i64 noundef %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i64, align 8
  %10 = alloca i32, align 4
  %11 = alloca i64, align 8
  %12 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i64 %3, ptr %9, align 8
  %13 = load i64, ptr %9, align 8
  %14 = icmp eq i64 %13, 4294967296
  br i1 %14, label %15, label %21

15:                                               ; preds = %4
  %16 = load ptr, ptr %6, align 8
  %17 = getelementptr inbounds %struct.moonbit_object, ptr %16, i64 -1
  %18 = getelementptr inbounds %struct.moonbit_object, ptr %17, i32 0, i32 1
  %19 = load i32, ptr %18, align 4
  %20 = and i32 %19, 268435455
  store i32 %20, ptr %10, align 4
  br label %25

21:                                               ; preds = %4
  %22 = load i64, ptr %9, align 8
  store i64 %22, ptr %11, align 8
  %23 = load i64, ptr %11, align 8
  %24 = trunc i64 %23 to i32
  store i32 %24, ptr %10, align 4
  br label %25

25:                                               ; preds = %21, %15
  %26 = load i32, ptr %7, align 4
  %27 = icmp sge i32 %26, 0
  br i1 %27, label %28, label %34

28:                                               ; preds = %25
  %29 = load ptr, ptr %6, align 8
  %30 = load i32, ptr %7, align 4
  %31 = load i32, ptr %8, align 4
  %32 = load i32, ptr %10, align 4
  %33 = call i64 @"$String$$offset_of_nth_char_forward"(ptr noundef %29, i32 noundef %30, i32 noundef %31, i32 noundef %32)
  store i64 %33, ptr %5, align 8
  br label %42

34:                                               ; preds = %25
  %35 = load i32, ptr %7, align 4
  %36 = sub nsw i32 0, %35
  store i32 %36, ptr %12, align 4
  %37 = load ptr, ptr %6, align 8
  %38 = load i32, ptr %12, align 4
  %39 = load i32, ptr %8, align 4
  %40 = load i32, ptr %10, align 4
  %41 = call i64 @"$String$$offset_of_nth_char_backward"(ptr noundef %37, i32 noundef %38, i32 noundef %39, i32 noundef %40)
  store i64 %41, ptr %5, align 8
  br label %42

42:                                               ; preds = %34, %28
  %43 = load i64, ptr %5, align 8
  ret i64 %43
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @"$String$$offset_of_nth_char_forward"(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  %24 = load i32, ptr %8, align 4
  %25 = icmp sge i32 %24, 0
  br i1 %25, label %26, label %95

26:                                               ; preds = %4
  %27 = load i32, ptr %8, align 4
  %28 = load i32, ptr %9, align 4
  %29 = icmp sle i32 %27, %28
  br i1 %29, label %30, label %95

30:                                               ; preds = %26
  %31 = load i32, ptr %8, align 4
  store i32 %31, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %32

32:                                               ; preds = %30, %68
  %33 = load i32, ptr %10, align 4
  store i32 %33, ptr %14, align 4
  %34 = load i32, ptr %14, align 4
  %35 = load i32, ptr %9, align 4
  %36 = icmp slt i32 %34, %35
  br i1 %36, label %37, label %43

37:                                               ; preds = %32
  %38 = load i32, ptr %11, align 4
  store i32 %38, ptr %16, align 4
  %39 = load i32, ptr %16, align 4
  %40 = load i32, ptr %7, align 4
  %41 = icmp slt i32 %39, %40
  %42 = zext i1 %41 to i32
  store i32 %42, ptr %15, align 4
  br label %44

43:                                               ; preds = %32
  store i32 0, ptr %15, align 4
  br label %44

44:                                               ; preds = %43, %37
  %45 = load i32, ptr %15, align 4
  %46 = icmp ne i32 %45, 0
  br i1 %46, label %47, label %72

47:                                               ; preds = %44
  %48 = load i32, ptr %10, align 4
  store i32 %48, ptr %17, align 4
  %49 = load ptr, ptr %6, align 8
  %50 = load i32, ptr %17, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds i16, ptr %49, i64 %51
  %53 = load i16, ptr %52, align 2
  %54 = zext i16 %53 to i32
  store i32 %54, ptr %18, align 4
  %55 = load i32, ptr %18, align 4
  %56 = icmp sle i32 55296, %55
  br i1 %56, label %57, label %64

57:                                               ; preds = %47
  %58 = load i32, ptr %18, align 4
  %59 = icmp sle i32 %58, 56319
  br i1 %59, label %60, label %64

60:                                               ; preds = %57
  %61 = load i32, ptr %10, align 4
  store i32 %61, ptr %20, align 4
  %62 = load i32, ptr %20, align 4
  %63 = add nsw i32 %62, 2
  store i32 %63, ptr %10, align 4
  br label %68

64:                                               ; preds = %57, %47
  %65 = load i32, ptr %10, align 4
  store i32 %65, ptr %21, align 4
  %66 = load i32, ptr %21, align 4
  %67 = add nsw i32 %66, 1
  store i32 %67, ptr %10, align 4
  br label %68

68:                                               ; preds = %64, %60
  %69 = load i32, ptr %11, align 4
  store i32 %69, ptr %19, align 4
  %70 = load i32, ptr %19, align 4
  %71 = add nsw i32 %70, 1
  store i32 %71, ptr %11, align 4
  br label %32

72:                                               ; preds = %44
  %73 = load ptr, ptr %6, align 8
  call void @moonbit_decref_inlined(ptr noundef %73)
  br label %74

74:                                               ; preds = %72
  br label %75

75:                                               ; preds = %74
  %76 = load i32, ptr %11, align 4
  store i32 %76, ptr %12, align 4
  %77 = load i32, ptr %12, align 4
  %78 = load i32, ptr %7, align 4
  %79 = icmp slt i32 %77, %78
  br i1 %79, label %80, label %81

80:                                               ; preds = %75
  store i32 1, ptr %13, align 4
  br label %87

81:                                               ; preds = %75
  %82 = load i32, ptr %10, align 4
  store i32 %82, ptr %22, align 4
  %83 = load i32, ptr %22, align 4
  %84 = load i32, ptr %9, align 4
  %85 = icmp sge i32 %83, %84
  %86 = zext i1 %85 to i32
  store i32 %86, ptr %13, align 4
  br label %87

87:                                               ; preds = %81, %80
  %88 = load i32, ptr %13, align 4
  %89 = icmp ne i32 %88, 0
  br i1 %89, label %90, label %91

90:                                               ; preds = %87
  store i64 4294967296, ptr %5, align 8
  br label %98

91:                                               ; preds = %87
  %92 = load i32, ptr %10, align 4
  store i32 %92, ptr %23, align 4
  %93 = load i32, ptr %23, align 4
  %94 = sext i32 %93 to i64
  store i64 %94, ptr %5, align 8
  br label %98

95:                                               ; preds = %26, %4
  %96 = load ptr, ptr %6, align 8
  call void @moonbit_decref_inlined(ptr noundef %96)
  %97 = call i64 @"$moonbitlang$core$builtin$abort$3"(ptr noundef getelementptr inbounds (%struct.anon.12, ptr @moonbit_string_literal_3, i32 0, i32 2), ptr noundef getelementptr inbounds (%struct.anon.16, ptr @moonbit_string_literal_4, i32 0, i32 2))
  store i64 %97, ptr %5, align 8
  br label %98

98:                                               ; preds = %95, %91, %90
  %99 = load i64, ptr %5, align 8
  ret i64 %99
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @"$String$$offset_of_nth_char_backward"(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 0, ptr %10, align 4
  %26 = load i32, ptr %9, align 4
  store i32 %26, ptr %11, align 4
  br label %27

27:                                               ; preds = %4, %67
  %28 = load i32, ptr %11, align 4
  store i32 %28, ptr %14, align 4
  %29 = load i32, ptr %14, align 4
  %30 = sub nsw i32 %29, 1
  store i32 %30, ptr %15, align 4
  %31 = load i32, ptr %15, align 4
  %32 = load i32, ptr %8, align 4
  %33 = icmp sge i32 %31, %32
  br i1 %33, label %34, label %40

34:                                               ; preds = %27
  %35 = load i32, ptr %10, align 4
  store i32 %35, ptr %17, align 4
  %36 = load i32, ptr %17, align 4
  %37 = load i32, ptr %7, align 4
  %38 = icmp slt i32 %36, %37
  %39 = zext i1 %38 to i32
  store i32 %39, ptr %16, align 4
  br label %41

40:                                               ; preds = %27
  store i32 0, ptr %16, align 4
  br label %41

41:                                               ; preds = %40, %34
  %42 = load i32, ptr %16, align 4
  %43 = icmp ne i32 %42, 0
  br i1 %43, label %44, label %71

44:                                               ; preds = %41
  %45 = load i32, ptr %11, align 4
  store i32 %45, ptr %18, align 4
  %46 = load i32, ptr %18, align 4
  %47 = sub nsw i32 %46, 1
  store i32 %47, ptr %19, align 4
  %48 = load ptr, ptr %6, align 8
  %49 = load i32, ptr %19, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds i16, ptr %48, i64 %50
  %52 = load i16, ptr %51, align 2
  %53 = zext i16 %52 to i32
  store i32 %53, ptr %20, align 4
  %54 = load i32, ptr %20, align 4
  %55 = icmp sle i32 56320, %54
  br i1 %55, label %56, label %63

56:                                               ; preds = %44
  %57 = load i32, ptr %20, align 4
  %58 = icmp sle i32 %57, 57343
  br i1 %58, label %59, label %63

59:                                               ; preds = %56
  %60 = load i32, ptr %11, align 4
  store i32 %60, ptr %22, align 4
  %61 = load i32, ptr %22, align 4
  %62 = sub nsw i32 %61, 2
  store i32 %62, ptr %11, align 4
  br label %67

63:                                               ; preds = %56, %44
  %64 = load i32, ptr %11, align 4
  store i32 %64, ptr %23, align 4
  %65 = load i32, ptr %23, align 4
  %66 = sub nsw i32 %65, 1
  store i32 %66, ptr %11, align 4
  br label %67

67:                                               ; preds = %63, %59
  %68 = load i32, ptr %10, align 4
  store i32 %68, ptr %21, align 4
  %69 = load i32, ptr %21, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, ptr %10, align 4
  br label %27

71:                                               ; preds = %41
  %72 = load ptr, ptr %6, align 8
  call void @moonbit_decref_inlined(ptr noundef %72)
  br label %73

73:                                               ; preds = %71
  br label %74

74:                                               ; preds = %73
  %75 = load i32, ptr %10, align 4
  store i32 %75, ptr %12, align 4
  %76 = load i32, ptr %12, align 4
  %77 = load i32, ptr %7, align 4
  %78 = icmp slt i32 %76, %77
  br i1 %78, label %79, label %80

79:                                               ; preds = %74
  store i32 1, ptr %13, align 4
  br label %86

80:                                               ; preds = %74
  %81 = load i32, ptr %11, align 4
  store i32 %81, ptr %24, align 4
  %82 = load i32, ptr %24, align 4
  %83 = load i32, ptr %8, align 4
  %84 = icmp slt i32 %82, %83
  %85 = zext i1 %84 to i32
  store i32 %85, ptr %13, align 4
  br label %86

86:                                               ; preds = %80, %79
  %87 = load i32, ptr %13, align 4
  %88 = icmp ne i32 %87, 0
  br i1 %88, label %89, label %90

89:                                               ; preds = %86
  store i64 4294967296, ptr %5, align 8
  br label %94

90:                                               ; preds = %86
  %91 = load i32, ptr %11, align 4
  store i32 %91, ptr %25, align 4
  %92 = load i32, ptr %25, align 4
  %93 = sext i32 %92 to i64
  store i64 %93, ptr %5, align 8
  br label %94

94:                                               ; preds = %90, %89
  %95 = load i64, ptr %5, align 8
  ret i64 %95
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @"$moonbitlang$core$builtin$abort$3"(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %9 = load ptr, ptr %3, align 8
  %10 = call ptr @moonbit_add_string(ptr noundef %9, ptr noundef getelementptr inbounds (%struct.anon.2, ptr @moonbit_string_literal_15, i32 0, i32 2))
  store ptr %10, ptr %5, align 8
  %11 = load ptr, ptr %4, align 8
  %12 = call ptr @"$$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1"(ptr noundef %11)
  store ptr %12, ptr %6, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = load ptr, ptr %6, align 8
  %15 = call ptr @moonbit_add_string(ptr noundef %13, ptr noundef %14)
  store ptr %15, ptr %7, align 8
  %16 = load ptr, ptr %7, align 8
  %17 = call ptr @moonbit_add_string(ptr noundef %16, ptr noundef getelementptr inbounds (%struct.anon.13, ptr @moonbit_string_literal_16, i32 0, i32 2))
  store ptr %17, ptr %8, align 8
  %18 = load ptr, ptr %8, align 8
  %19 = call i64 @"$moonbitlang$core$abort$abort$3"(ptr noundef %18)
  ret i64 %19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$String$$char_length_ge$inner"(ptr noundef %0, i32 noundef %1, i32 noundef %2, i64 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i64, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i64 %3, ptr %8, align 8
  %22 = load i64, ptr %8, align 8
  %23 = icmp eq i64 %22, 4294967296
  br i1 %23, label %24, label %30

24:                                               ; preds = %4
  %25 = load ptr, ptr %5, align 8
  %26 = getelementptr inbounds %struct.moonbit_object, ptr %25, i64 -1
  %27 = getelementptr inbounds %struct.moonbit_object, ptr %26, i32 0, i32 1
  %28 = load i32, ptr %27, align 4
  %29 = and i32 %28, 268435455
  store i32 %29, ptr %9, align 4
  br label %34

30:                                               ; preds = %4
  %31 = load i64, ptr %8, align 8
  store i64 %31, ptr %12, align 8
  %32 = load i64, ptr %12, align 8
  %33 = trunc i64 %32 to i32
  store i32 %33, ptr %9, align 4
  br label %34

34:                                               ; preds = %30, %24
  %35 = load i32, ptr %7, align 4
  store i32 %35, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %36

36:                                               ; preds = %34, %81, %91
  %37 = load i32, ptr %10, align 4
  %38 = load i32, ptr %9, align 4
  %39 = icmp slt i32 %37, %38
  br i1 %39, label %40, label %98

40:                                               ; preds = %36
  %41 = load i32, ptr %11, align 4
  %42 = load i32, ptr %6, align 4
  %43 = icmp slt i32 %41, %42
  br i1 %43, label %44, label %98

44:                                               ; preds = %40
  %45 = load ptr, ptr %5, align 8
  %46 = load i32, ptr %10, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds i16, ptr %45, i64 %47
  %49 = load i16, ptr %48, align 2
  %50 = zext i16 %49 to i32
  store i32 %50, ptr %13, align 4
  %51 = load i32, ptr %13, align 4
  %52 = icmp sle i32 55296, %51
  br i1 %52, label %53, label %63

53:                                               ; preds = %44
  %54 = load i32, ptr %13, align 4
  %55 = icmp sle i32 %54, 56319
  br i1 %55, label %56, label %63

56:                                               ; preds = %53
  %57 = load i32, ptr %10, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, ptr %17, align 4
  %59 = load i32, ptr %17, align 4
  %60 = load i32, ptr %9, align 4
  %61 = icmp slt i32 %59, %60
  %62 = zext i1 %61 to i32
  store i32 %62, ptr %14, align 4
  br label %64

63:                                               ; preds = %53, %44
  store i32 0, ptr %14, align 4
  br label %64

64:                                               ; preds = %63, %56
  %65 = load i32, ptr %14, align 4
  %66 = icmp ne i32 %65, 0
  br i1 %66, label %67, label %91

67:                                               ; preds = %64
  %68 = load i32, ptr %10, align 4
  %69 = add nsw i32 %68, 1
  store i32 %69, ptr %18, align 4
  %70 = load ptr, ptr %5, align 8
  %71 = load i32, ptr %18, align 4
  %72 = sext i32 %71 to i64
  %73 = getelementptr inbounds i16, ptr %70, i64 %72
  %74 = load i16, ptr %73, align 2
  %75 = zext i16 %74 to i32
  store i32 %75, ptr %19, align 4
  %76 = load i32, ptr %19, align 4
  %77 = icmp sle i32 56320, %76
  br i1 %77, label %78, label %88

78:                                               ; preds = %67
  %79 = load i32, ptr %19, align 4
  %80 = icmp sle i32 %79, 57343
  br i1 %80, label %81, label %88

81:                                               ; preds = %78
  %82 = load i32, ptr %10, align 4
  %83 = add nsw i32 %82, 2
  store i32 %83, ptr %20, align 4
  %84 = load i32, ptr %11, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, ptr %21, align 4
  %86 = load i32, ptr %20, align 4
  store i32 %86, ptr %10, align 4
  %87 = load i32, ptr %21, align 4
  store i32 %87, ptr %11, align 4
  br label %36

88:                                               ; preds = %78, %67
  %89 = call i32 @"$moonbitlang$core$builtin$abort$0"(ptr noundef getelementptr inbounds (%struct.anon.1, ptr @moonbit_string_literal_5, i32 0, i32 2), ptr noundef getelementptr inbounds (%struct.anon, ptr @moonbit_string_literal_6, i32 0, i32 2))
  br label %90

90:                                               ; preds = %88
  br label %91

91:                                               ; preds = %90, %64
  %92 = load i32, ptr %10, align 4
  %93 = add nsw i32 %92, 1
  store i32 %93, ptr %15, align 4
  %94 = load i32, ptr %11, align 4
  %95 = add nsw i32 %94, 1
  store i32 %95, ptr %16, align 4
  %96 = load i32, ptr %15, align 4
  store i32 %96, ptr %10, align 4
  %97 = load i32, ptr %16, align 4
  store i32 %97, ptr %11, align 4
  br label %36

98:                                               ; preds = %40, %36
  %99 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %99)
  %100 = load i32, ptr %11, align 4
  %101 = load i32, ptr %6, align 4
  %102 = icmp sge i32 %100, %101
  %103 = zext i1 %102 to i32
  ret i32 %103
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$moonbitlang$core$builtin$abort$0"(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %9 = load ptr, ptr %3, align 8
  %10 = call ptr @moonbit_add_string(ptr noundef %9, ptr noundef getelementptr inbounds (%struct.anon.2, ptr @moonbit_string_literal_15, i32 0, i32 2))
  store ptr %10, ptr %5, align 8
  %11 = load ptr, ptr %4, align 8
  %12 = call ptr @"$$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1"(ptr noundef %11)
  store ptr %12, ptr %6, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = load ptr, ptr %6, align 8
  %15 = call ptr @moonbit_add_string(ptr noundef %13, ptr noundef %14)
  store ptr %15, ptr %7, align 8
  %16 = load ptr, ptr %7, align 8
  %17 = call ptr @moonbit_add_string(ptr noundef %16, ptr noundef getelementptr inbounds (%struct.anon.13, ptr @moonbit_string_literal_16, i32 0, i32 2))
  store ptr %17, ptr %8, align 8
  %18 = load ptr, ptr %8, align 8
  %19 = call i32 @"$moonbitlang$core$abort$abort$0"(ptr noundef %18)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$moonbitlang$core$builtin$dec_count32"(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = load i32, ptr %3, align 4
  %5 = icmp uge i32 %4, 100000
  br i1 %5, label %6, label %23

6:                                                ; preds = %1
  %7 = load i32, ptr %3, align 4
  %8 = icmp uge i32 %7, 10000000
  br i1 %8, label %9, label %18

9:                                                ; preds = %6
  %10 = load i32, ptr %3, align 4
  %11 = icmp uge i32 %10, 1000000000
  br i1 %11, label %12, label %13

12:                                               ; preds = %9
  store i32 10, ptr %2, align 4
  br label %40

13:                                               ; preds = %9
  %14 = load i32, ptr %3, align 4
  %15 = icmp uge i32 %14, 100000000
  br i1 %15, label %16, label %17

16:                                               ; preds = %13
  store i32 9, ptr %2, align 4
  br label %40

17:                                               ; preds = %13
  store i32 8, ptr %2, align 4
  br label %40

18:                                               ; preds = %6
  %19 = load i32, ptr %3, align 4
  %20 = icmp uge i32 %19, 1000000
  br i1 %20, label %21, label %22

21:                                               ; preds = %18
  store i32 7, ptr %2, align 4
  br label %40

22:                                               ; preds = %18
  store i32 6, ptr %2, align 4
  br label %40

23:                                               ; preds = %1
  %24 = load i32, ptr %3, align 4
  %25 = icmp uge i32 %24, 1000
  br i1 %25, label %26, label %31

26:                                               ; preds = %23
  %27 = load i32, ptr %3, align 4
  %28 = icmp uge i32 %27, 10000
  br i1 %28, label %29, label %30

29:                                               ; preds = %26
  store i32 5, ptr %2, align 4
  br label %40

30:                                               ; preds = %26
  store i32 4, ptr %2, align 4
  br label %40

31:                                               ; preds = %23
  %32 = load i32, ptr %3, align 4
  %33 = icmp uge i32 %32, 100
  br i1 %33, label %34, label %35

34:                                               ; preds = %31
  store i32 3, ptr %2, align 4
  br label %40

35:                                               ; preds = %31
  %36 = load i32, ptr %3, align 4
  %37 = icmp uge i32 %36, 10
  br i1 %37, label %38, label %39

38:                                               ; preds = %35
  store i32 2, ptr %2, align 4
  br label %40

39:                                               ; preds = %35
  store i32 1, ptr %2, align 4
  br label %40

40:                                               ; preds = %39, %38, %34, %30, %29, %22, %21, %17, %16, %12
  %41 = load i32, ptr %2, align 4
  ret i32 %41
}

declare ptr @moonbit_make_string(i32 noundef, i16 noundef zeroext) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$moonbitlang$core$builtin$int_to_string_dec"(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  %37 = alloca i32, align 4
  %38 = alloca i32, align 4
  %39 = alloca i32, align 4
  %40 = alloca i32, align 4
  %41 = alloca i32, align 4
  %42 = alloca i32, align 4
  %43 = alloca i32, align 4
  %44 = alloca i32, align 4
  %45 = alloca i32, align 4
  %46 = alloca i32, align 4
  %47 = alloca i32, align 4
  %48 = alloca i32, align 4
  %49 = alloca i32, align 4
  %50 = alloca i32, align 4
  %51 = alloca i32, align 4
  %52 = alloca i32, align 4
  %53 = alloca i32, align 4
  %54 = alloca i32, align 4
  %55 = alloca i32, align 4
  %56 = alloca i32, align 4
  %57 = alloca i32, align 4
  %58 = alloca i32, align 4
  %59 = alloca i32, align 4
  %60 = alloca i32, align 4
  %61 = alloca i32, align 4
  %62 = alloca i32, align 4
  %63 = alloca i32, align 4
  %64 = alloca i32, align 4
  %65 = alloca i32, align 4
  %66 = alloca i32, align 4
  %67 = alloca i32, align 4
  %68 = alloca i32, align 4
  %69 = alloca i32, align 4
  %70 = alloca i32, align 4
  %71 = alloca i32, align 4
  %72 = alloca i32, align 4
  %73 = alloca i32, align 4
  %74 = alloca i32, align 4
  %75 = alloca i32, align 4
  %76 = alloca i32, align 4
  %77 = alloca i32, align 4
  %78 = alloca i32, align 4
  %79 = alloca i32, align 4
  %80 = alloca i32, align 4
  %81 = alloca i32, align 4
  %82 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %83 = load i32, ptr %6, align 4
  store i32 %83, ptr %9, align 4
  %84 = load i32, ptr %8, align 4
  %85 = load i32, ptr %7, align 4
  %86 = sub nsw i32 %84, %85
  store i32 %86, ptr %10, align 4
  br label %87

87:                                               ; preds = %4, %91
  %88 = load i32, ptr %9, align 4
  store i32 %88, ptr %14, align 4
  %89 = load i32, ptr %14, align 4
  %90 = icmp uge i32 %89, 10000
  br i1 %90, label %91, label %181

91:                                               ; preds = %87
  %92 = load i32, ptr %9, align 4
  store i32 %92, ptr %15, align 4
  %93 = load i32, ptr %15, align 4
  %94 = udiv i32 %93, 10000
  store i32 %94, ptr %16, align 4
  %95 = load i32, ptr %9, align 4
  store i32 %95, ptr %17, align 4
  %96 = load i32, ptr %17, align 4
  %97 = urem i32 %96, 10000
  store i32 %97, ptr %18, align 4
  %98 = load i32, ptr %18, align 4
  store i32 %98, ptr %19, align 4
  %99 = load i32, ptr %16, align 4
  store i32 %99, ptr %9, align 4
  %100 = load i32, ptr %19, align 4
  %101 = sdiv i32 %100, 100
  store i32 %101, ptr %20, align 4
  %102 = load i32, ptr %19, align 4
  %103 = srem i32 %102, 100
  store i32 %103, ptr %21, align 4
  %104 = load i32, ptr %10, align 4
  store i32 %104, ptr %22, align 4
  %105 = load i32, ptr %22, align 4
  %106 = sub nsw i32 %105, 4
  store i32 %106, ptr %10, align 4
  %107 = load i32, ptr %20, align 4
  %108 = sdiv i32 %107, 10
  store i32 %108, ptr %23, align 4
  %109 = load i32, ptr %23, align 4
  %110 = add nsw i32 48, %109
  store i32 %110, ptr %24, align 4
  %111 = load i32, ptr %24, align 4
  %112 = trunc i32 %111 to i16
  %113 = zext i16 %112 to i32
  store i32 %113, ptr %25, align 4
  %114 = load i32, ptr %20, align 4
  %115 = srem i32 %114, 10
  store i32 %115, ptr %26, align 4
  %116 = load i32, ptr %26, align 4
  %117 = add nsw i32 48, %116
  store i32 %117, ptr %27, align 4
  %118 = load i32, ptr %27, align 4
  %119 = trunc i32 %118 to i16
  %120 = zext i16 %119 to i32
  store i32 %120, ptr %28, align 4
  %121 = load i32, ptr %21, align 4
  %122 = sdiv i32 %121, 10
  store i32 %122, ptr %29, align 4
  %123 = load i32, ptr %29, align 4
  %124 = add nsw i32 48, %123
  store i32 %124, ptr %30, align 4
  %125 = load i32, ptr %30, align 4
  %126 = trunc i32 %125 to i16
  %127 = zext i16 %126 to i32
  store i32 %127, ptr %31, align 4
  %128 = load i32, ptr %21, align 4
  %129 = srem i32 %128, 10
  store i32 %129, ptr %32, align 4
  %130 = load i32, ptr %32, align 4
  %131 = add nsw i32 48, %130
  store i32 %131, ptr %33, align 4
  %132 = load i32, ptr %33, align 4
  %133 = trunc i32 %132 to i16
  %134 = zext i16 %133 to i32
  store i32 %134, ptr %34, align 4
  %135 = load i32, ptr %10, align 4
  store i32 %135, ptr %35, align 4
  %136 = load i32, ptr %7, align 4
  %137 = load i32, ptr %35, align 4
  %138 = add nsw i32 %136, %137
  store i32 %138, ptr %36, align 4
  %139 = load i32, ptr %25, align 4
  %140 = trunc i32 %139 to i16
  %141 = load ptr, ptr %5, align 8
  %142 = load i32, ptr %36, align 4
  %143 = sext i32 %142 to i64
  %144 = getelementptr inbounds i16, ptr %141, i64 %143
  store i16 %140, ptr %144, align 2
  %145 = load i32, ptr %10, align 4
  store i32 %145, ptr %37, align 4
  %146 = load i32, ptr %7, align 4
  %147 = load i32, ptr %37, align 4
  %148 = add nsw i32 %146, %147
  store i32 %148, ptr %38, align 4
  %149 = load i32, ptr %38, align 4
  %150 = add nsw i32 %149, 1
  store i32 %150, ptr %39, align 4
  %151 = load i32, ptr %28, align 4
  %152 = trunc i32 %151 to i16
  %153 = load ptr, ptr %5, align 8
  %154 = load i32, ptr %39, align 4
  %155 = sext i32 %154 to i64
  %156 = getelementptr inbounds i16, ptr %153, i64 %155
  store i16 %152, ptr %156, align 2
  %157 = load i32, ptr %10, align 4
  store i32 %157, ptr %40, align 4
  %158 = load i32, ptr %7, align 4
  %159 = load i32, ptr %40, align 4
  %160 = add nsw i32 %158, %159
  store i32 %160, ptr %41, align 4
  %161 = load i32, ptr %41, align 4
  %162 = add nsw i32 %161, 2
  store i32 %162, ptr %42, align 4
  %163 = load i32, ptr %31, align 4
  %164 = trunc i32 %163 to i16
  %165 = load ptr, ptr %5, align 8
  %166 = load i32, ptr %42, align 4
  %167 = sext i32 %166 to i64
  %168 = getelementptr inbounds i16, ptr %165, i64 %167
  store i16 %164, ptr %168, align 2
  %169 = load i32, ptr %10, align 4
  store i32 %169, ptr %43, align 4
  %170 = load i32, ptr %7, align 4
  %171 = load i32, ptr %43, align 4
  %172 = add nsw i32 %170, %171
  store i32 %172, ptr %44, align 4
  %173 = load i32, ptr %44, align 4
  %174 = add nsw i32 %173, 3
  store i32 %174, ptr %45, align 4
  %175 = load i32, ptr %34, align 4
  %176 = trunc i32 %175 to i16
  %177 = load ptr, ptr %5, align 8
  %178 = load i32, ptr %45, align 4
  %179 = sext i32 %178 to i64
  %180 = getelementptr inbounds i16, ptr %177, i64 %179
  store i16 %176, ptr %180, align 2
  br label %87

181:                                              ; preds = %87
  br label %182

182:                                              ; preds = %181
  %183 = load i32, ptr %9, align 4
  store i32 %183, ptr %11, align 4
  %184 = load i32, ptr %11, align 4
  store i32 %184, ptr %12, align 4
  br label %185

185:                                              ; preds = %182, %189
  %186 = load i32, ptr %12, align 4
  store i32 %186, ptr %46, align 4
  %187 = load i32, ptr %46, align 4
  %188 = icmp sge i32 %187, 100
  br i1 %188, label %189, label %236

189:                                              ; preds = %185
  %190 = load i32, ptr %12, align 4
  store i32 %190, ptr %47, align 4
  %191 = load i32, ptr %47, align 4
  %192 = sdiv i32 %191, 100
  store i32 %192, ptr %48, align 4
  %193 = load i32, ptr %12, align 4
  store i32 %193, ptr %49, align 4
  %194 = load i32, ptr %49, align 4
  %195 = srem i32 %194, 100
  store i32 %195, ptr %50, align 4
  %196 = load i32, ptr %48, align 4
  store i32 %196, ptr %12, align 4
  %197 = load i32, ptr %10, align 4
  store i32 %197, ptr %51, align 4
  %198 = load i32, ptr %51, align 4
  %199 = sub nsw i32 %198, 2
  store i32 %199, ptr %10, align 4
  %200 = load i32, ptr %50, align 4
  %201 = sdiv i32 %200, 10
  store i32 %201, ptr %52, align 4
  %202 = load i32, ptr %52, align 4
  %203 = add nsw i32 48, %202
  store i32 %203, ptr %53, align 4
  %204 = load i32, ptr %53, align 4
  %205 = trunc i32 %204 to i16
  %206 = zext i16 %205 to i32
  store i32 %206, ptr %54, align 4
  %207 = load i32, ptr %50, align 4
  %208 = srem i32 %207, 10
  store i32 %208, ptr %55, align 4
  %209 = load i32, ptr %55, align 4
  %210 = add nsw i32 48, %209
  store i32 %210, ptr %56, align 4
  %211 = load i32, ptr %56, align 4
  %212 = trunc i32 %211 to i16
  %213 = zext i16 %212 to i32
  store i32 %213, ptr %57, align 4
  %214 = load i32, ptr %10, align 4
  store i32 %214, ptr %58, align 4
  %215 = load i32, ptr %7, align 4
  %216 = load i32, ptr %58, align 4
  %217 = add nsw i32 %215, %216
  store i32 %217, ptr %59, align 4
  %218 = load i32, ptr %54, align 4
  %219 = trunc i32 %218 to i16
  %220 = load ptr, ptr %5, align 8
  %221 = load i32, ptr %59, align 4
  %222 = sext i32 %221 to i64
  %223 = getelementptr inbounds i16, ptr %220, i64 %222
  store i16 %219, ptr %223, align 2
  %224 = load i32, ptr %10, align 4
  store i32 %224, ptr %60, align 4
  %225 = load i32, ptr %7, align 4
  %226 = load i32, ptr %60, align 4
  %227 = add nsw i32 %225, %226
  store i32 %227, ptr %61, align 4
  %228 = load i32, ptr %61, align 4
  %229 = add nsw i32 %228, 1
  store i32 %229, ptr %62, align 4
  %230 = load i32, ptr %57, align 4
  %231 = trunc i32 %230 to i16
  %232 = load ptr, ptr %5, align 8
  %233 = load i32, ptr %62, align 4
  %234 = sext i32 %233 to i64
  %235 = getelementptr inbounds i16, ptr %232, i64 %234
  store i16 %231, ptr %235, align 2
  br label %185

236:                                              ; preds = %185
  br label %237

237:                                              ; preds = %236
  %238 = load i32, ptr %12, align 4
  store i32 %238, ptr %13, align 4
  %239 = load i32, ptr %13, align 4
  %240 = icmp sge i32 %239, 10
  br i1 %240, label %241, label %284

241:                                              ; preds = %237
  %242 = load i32, ptr %10, align 4
  store i32 %242, ptr %63, align 4
  %243 = load i32, ptr %63, align 4
  %244 = sub nsw i32 %243, 2
  store i32 %244, ptr %10, align 4
  %245 = load i32, ptr %12, align 4
  store i32 %245, ptr %64, align 4
  %246 = load i32, ptr %64, align 4
  %247 = sdiv i32 %246, 10
  store i32 %247, ptr %65, align 4
  %248 = load i32, ptr %65, align 4
  %249 = add nsw i32 48, %248
  store i32 %249, ptr %66, align 4
  %250 = load i32, ptr %66, align 4
  %251 = trunc i32 %250 to i16
  %252 = zext i16 %251 to i32
  store i32 %252, ptr %67, align 4
  %253 = load i32, ptr %12, align 4
  store i32 %253, ptr %68, align 4
  %254 = load i32, ptr %68, align 4
  %255 = srem i32 %254, 10
  store i32 %255, ptr %69, align 4
  %256 = load i32, ptr %69, align 4
  %257 = add nsw i32 48, %256
  store i32 %257, ptr %70, align 4
  %258 = load i32, ptr %70, align 4
  %259 = trunc i32 %258 to i16
  %260 = zext i16 %259 to i32
  store i32 %260, ptr %71, align 4
  %261 = load i32, ptr %10, align 4
  store i32 %261, ptr %72, align 4
  %262 = load i32, ptr %7, align 4
  %263 = load i32, ptr %72, align 4
  %264 = add nsw i32 %262, %263
  store i32 %264, ptr %73, align 4
  %265 = load i32, ptr %67, align 4
  %266 = trunc i32 %265 to i16
  %267 = load ptr, ptr %5, align 8
  %268 = load i32, ptr %73, align 4
  %269 = sext i32 %268 to i64
  %270 = getelementptr inbounds i16, ptr %267, i64 %269
  store i16 %266, ptr %270, align 2
  %271 = load i32, ptr %10, align 4
  store i32 %271, ptr %74, align 4
  %272 = load i32, ptr %7, align 4
  %273 = load i32, ptr %74, align 4
  %274 = add nsw i32 %272, %273
  store i32 %274, ptr %75, align 4
  %275 = load i32, ptr %75, align 4
  %276 = add nsw i32 %275, 1
  store i32 %276, ptr %76, align 4
  %277 = load i32, ptr %71, align 4
  %278 = trunc i32 %277 to i16
  %279 = load ptr, ptr %5, align 8
  %280 = load i32, ptr %76, align 4
  %281 = sext i32 %280 to i64
  %282 = getelementptr inbounds i16, ptr %279, i64 %281
  store i16 %278, ptr %282, align 2
  %283 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %283)
  br label %305

284:                                              ; preds = %237
  %285 = load i32, ptr %10, align 4
  store i32 %285, ptr %77, align 4
  %286 = load i32, ptr %77, align 4
  %287 = sub nsw i32 %286, 1
  store i32 %287, ptr %10, align 4
  %288 = load i32, ptr %10, align 4
  store i32 %288, ptr %78, align 4
  %289 = load i32, ptr %7, align 4
  %290 = load i32, ptr %78, align 4
  %291 = add nsw i32 %289, %290
  store i32 %291, ptr %79, align 4
  %292 = load i32, ptr %12, align 4
  store i32 %292, ptr %80, align 4
  %293 = load i32, ptr %80, align 4
  %294 = add nsw i32 48, %293
  store i32 %294, ptr %81, align 4
  %295 = load i32, ptr %81, align 4
  %296 = trunc i32 %295 to i16
  %297 = zext i16 %296 to i32
  store i32 %297, ptr %82, align 4
  %298 = load i32, ptr %82, align 4
  %299 = trunc i32 %298 to i16
  %300 = load ptr, ptr %5, align 8
  %301 = load i32, ptr %79, align 4
  %302 = sext i32 %301 to i64
  %303 = getelementptr inbounds i16, ptr %300, i64 %302
  store i16 %299, ptr %303, align 2
  %304 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %304)
  br label %305

305:                                              ; preds = %284, %241
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$moonbitlang$core$builtin$hex_count32"(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %7 = load i32, ptr %3, align 4
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %1
  store i32 1, ptr %2, align 4
  br label %19

10:                                               ; preds = %1
  %11 = load i32, ptr %3, align 4
  %12 = call i32 @moonbit_clz32(i32 noundef %11)
  store i32 %12, ptr %4, align 4
  %13 = load i32, ptr %4, align 4
  %14 = sub nsw i32 31, %13
  store i32 %14, ptr %5, align 4
  %15 = load i32, ptr %5, align 4
  %16 = sdiv i32 %15, 4
  store i32 %16, ptr %6, align 4
  %17 = load i32, ptr %6, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, ptr %2, align 4
  br label %19

19:                                               ; preds = %10, %9
  %20 = load i32, ptr %2, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$moonbitlang$core$builtin$int_to_string_hex"(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %34 = load i32, ptr %8, align 4
  %35 = load i32, ptr %7, align 4
  %36 = sub nsw i32 %34, %35
  store i32 %36, ptr %9, align 4
  %37 = load i32, ptr %6, align 4
  store i32 %37, ptr %10, align 4
  br label %38

38:                                               ; preds = %4, %42
  %39 = load i32, ptr %9, align 4
  store i32 %39, ptr %12, align 4
  %40 = load i32, ptr %12, align 4
  %41 = icmp sge i32 %40, 2
  br i1 %41, label %42, label %95

42:                                               ; preds = %38
  %43 = load i32, ptr %9, align 4
  store i32 %43, ptr %13, align 4
  %44 = load i32, ptr %13, align 4
  %45 = sub nsw i32 %44, 2
  store i32 %45, ptr %9, align 4
  %46 = load i32, ptr %10, align 4
  store i32 %46, ptr %14, align 4
  %47 = load i32, ptr %14, align 4
  %48 = and i32 %47, 255
  store i32 %48, ptr %15, align 4
  %49 = load i32, ptr %15, align 4
  store i32 %49, ptr %16, align 4
  %50 = load i32, ptr %16, align 4
  %51 = sdiv i32 %50, 16
  store i32 %51, ptr %17, align 4
  %52 = load i32, ptr %16, align 4
  %53 = srem i32 %52, 16
  store i32 %53, ptr %18, align 4
  %54 = load i32, ptr %9, align 4
  store i32 %54, ptr %19, align 4
  %55 = load i32, ptr %7, align 4
  %56 = load i32, ptr %19, align 4
  %57 = add nsw i32 %55, %56
  store i32 %57, ptr %20, align 4
  %58 = load i32, ptr %17, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds i16, ptr getelementptr inbounds (%struct.anon.11, ptr @moonbit_string_literal_10, i32 0, i32 2), i64 %59
  %61 = load i16, ptr %60, align 2
  %62 = zext i16 %61 to i32
  store i32 %62, ptr %21, align 4
  %63 = load i32, ptr %21, align 4
  %64 = trunc i32 %63 to i16
  %65 = zext i16 %64 to i32
  store i32 %65, ptr %22, align 4
  %66 = load i32, ptr %22, align 4
  %67 = trunc i32 %66 to i16
  %68 = load ptr, ptr %5, align 8
  %69 = load i32, ptr %20, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds i16, ptr %68, i64 %70
  store i16 %67, ptr %71, align 2
  %72 = load i32, ptr %9, align 4
  store i32 %72, ptr %23, align 4
  %73 = load i32, ptr %7, align 4
  %74 = load i32, ptr %23, align 4
  %75 = add nsw i32 %73, %74
  store i32 %75, ptr %24, align 4
  %76 = load i32, ptr %24, align 4
  %77 = add nsw i32 %76, 1
  store i32 %77, ptr %25, align 4
  %78 = load i32, ptr %18, align 4
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds i16, ptr getelementptr inbounds (%struct.anon.11, ptr @moonbit_string_literal_10, i32 0, i32 2), i64 %79
  %81 = load i16, ptr %80, align 2
  %82 = zext i16 %81 to i32
  store i32 %82, ptr %26, align 4
  %83 = load i32, ptr %26, align 4
  %84 = trunc i32 %83 to i16
  %85 = zext i16 %84 to i32
  store i32 %85, ptr %27, align 4
  %86 = load i32, ptr %27, align 4
  %87 = trunc i32 %86 to i16
  %88 = load ptr, ptr %5, align 8
  %89 = load i32, ptr %25, align 4
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds i16, ptr %88, i64 %90
  store i16 %87, ptr %91, align 2
  %92 = load i32, ptr %10, align 4
  store i32 %92, ptr %28, align 4
  %93 = load i32, ptr %28, align 4
  %94 = lshr i32 %93, 8
  store i32 %94, ptr %10, align 4
  br label %38

95:                                               ; preds = %38
  br label %96

96:                                               ; preds = %95
  %97 = load i32, ptr %9, align 4
  store i32 %97, ptr %11, align 4
  %98 = load i32, ptr %11, align 4
  %99 = icmp eq i32 %98, 1
  br i1 %99, label %100, label %120

100:                                              ; preds = %96
  %101 = load i32, ptr %10, align 4
  store i32 %101, ptr %29, align 4
  %102 = load i32, ptr %29, align 4
  %103 = and i32 %102, 15
  store i32 %103, ptr %30, align 4
  %104 = load i32, ptr %30, align 4
  store i32 %104, ptr %31, align 4
  %105 = load i32, ptr %31, align 4
  %106 = sext i32 %105 to i64
  %107 = getelementptr inbounds i16, ptr getelementptr inbounds (%struct.anon.11, ptr @moonbit_string_literal_10, i32 0, i32 2), i64 %106
  %108 = load i16, ptr %107, align 2
  %109 = zext i16 %108 to i32
  store i32 %109, ptr %32, align 4
  %110 = load i32, ptr %32, align 4
  %111 = trunc i32 %110 to i16
  %112 = zext i16 %111 to i32
  store i32 %112, ptr %33, align 4
  %113 = load i32, ptr %33, align 4
  %114 = trunc i32 %113 to i16
  %115 = load ptr, ptr %5, align 8
  %116 = load i32, ptr %7, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds i16, ptr %115, i64 %117
  store i16 %114, ptr %118, align 2
  %119 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %119)
  br label %122

120:                                              ; preds = %96
  %121 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %121)
  br label %122

122:                                              ; preds = %120, %100
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$moonbitlang$core$builtin$radix_count32"(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  %12 = load i32, ptr %4, align 4
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %15

14:                                               ; preds = %2
  store i32 1, ptr %3, align 4
  br label %33

15:                                               ; preds = %2
  %16 = load i32, ptr %4, align 4
  store i32 %16, ptr %6, align 4
  %17 = load i32, ptr %5, align 4
  store i32 %17, ptr %7, align 4
  store i32 0, ptr %8, align 4
  br label %18

18:                                               ; preds = %15, %22
  %19 = load i32, ptr %6, align 4
  store i32 %19, ptr %9, align 4
  %20 = load i32, ptr %9, align 4
  %21 = icmp ugt i32 %20, 0
  br i1 %21, label %22, label %30

22:                                               ; preds = %18
  %23 = load i32, ptr %8, align 4
  store i32 %23, ptr %10, align 4
  %24 = load i32, ptr %10, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, ptr %8, align 4
  %26 = load i32, ptr %6, align 4
  store i32 %26, ptr %11, align 4
  %27 = load i32, ptr %11, align 4
  %28 = load i32, ptr %7, align 4
  %29 = udiv i32 %27, %28
  store i32 %29, ptr %6, align 4
  br label %18

30:                                               ; preds = %18
  br label %31

31:                                               ; preds = %30
  %32 = load i32, ptr %8, align 4
  store i32 %32, ptr %3, align 4
  br label %33

33:                                               ; preds = %31, %14
  %34 = load i32, ptr %3, align 4
  ret i32 %34
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$moonbitlang$core$builtin$int_to_string_generic"(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  %37 = alloca i32, align 4
  %38 = alloca i32, align 4
  %39 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  %40 = load i32, ptr %9, align 4
  %41 = load i32, ptr %8, align 4
  %42 = sub nsw i32 %40, %41
  store i32 %42, ptr %11, align 4
  %43 = load i32, ptr %7, align 4
  store i32 %43, ptr %12, align 4
  %44 = load i32, ptr %10, align 4
  store i32 %44, ptr %13, align 4
  %45 = load i32, ptr %10, align 4
  %46 = sub nsw i32 %45, 1
  store i32 %46, ptr %14, align 4
  %47 = load i32, ptr %10, align 4
  %48 = load i32, ptr %14, align 4
  %49 = and i32 %47, %48
  store i32 %49, ptr %15, align 4
  %50 = load i32, ptr %15, align 4
  %51 = icmp eq i32 %50, 0
  br i1 %51, label %52, label %97

52:                                               ; preds = %5
  %53 = load i32, ptr %10, align 4
  %54 = call i32 @moonbit_ctz32(i32 noundef %53)
  store i32 %54, ptr %16, align 4
  %55 = load i32, ptr %13, align 4
  %56 = sub i32 %55, 1
  store i32 %56, ptr %17, align 4
  br label %57

57:                                               ; preds = %52, %61
  %58 = load i32, ptr %12, align 4
  store i32 %58, ptr %18, align 4
  %59 = load i32, ptr %18, align 4
  %60 = icmp ugt i32 %59, 0
  br i1 %60, label %61, label %93

61:                                               ; preds = %57
  %62 = load i32, ptr %11, align 4
  store i32 %62, ptr %19, align 4
  %63 = load i32, ptr %19, align 4
  %64 = sub nsw i32 %63, 1
  store i32 %64, ptr %11, align 4
  %65 = load i32, ptr %12, align 4
  store i32 %65, ptr %20, align 4
  %66 = load i32, ptr %20, align 4
  %67 = load i32, ptr %17, align 4
  %68 = and i32 %66, %67
  store i32 %68, ptr %21, align 4
  %69 = load i32, ptr %21, align 4
  store i32 %69, ptr %22, align 4
  %70 = load i32, ptr %11, align 4
  store i32 %70, ptr %23, align 4
  %71 = load i32, ptr %8, align 4
  %72 = load i32, ptr %23, align 4
  %73 = add nsw i32 %71, %72
  store i32 %73, ptr %24, align 4
  %74 = load i32, ptr %22, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds i16, ptr getelementptr inbounds (%struct.anon.11, ptr @moonbit_string_literal_10, i32 0, i32 2), i64 %75
  %77 = load i16, ptr %76, align 2
  %78 = zext i16 %77 to i32
  store i32 %78, ptr %25, align 4
  %79 = load i32, ptr %25, align 4
  %80 = trunc i32 %79 to i16
  %81 = zext i16 %80 to i32
  store i32 %81, ptr %26, align 4
  %82 = load i32, ptr %26, align 4
  %83 = trunc i32 %82 to i16
  %84 = load ptr, ptr %6, align 8
  %85 = load i32, ptr %24, align 4
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds i16, ptr %84, i64 %86
  store i16 %83, ptr %87, align 2
  %88 = load i32, ptr %12, align 4
  store i32 %88, ptr %27, align 4
  %89 = load i32, ptr %27, align 4
  %90 = load i32, ptr %16, align 4
  %91 = and i32 %90, 31
  %92 = lshr i32 %89, %91
  store i32 %92, ptr %12, align 4
  br label %57

93:                                               ; preds = %57
  %94 = load ptr, ptr %6, align 8
  call void @moonbit_decref_inlined(ptr noundef %94)
  br label %95

95:                                               ; preds = %93
  br label %96

96:                                               ; preds = %95
  br label %141

97:                                               ; preds = %5
  br label %98

98:                                               ; preds = %97, %102
  %99 = load i32, ptr %12, align 4
  store i32 %99, ptr %28, align 4
  %100 = load i32, ptr %28, align 4
  %101 = icmp ugt i32 %100, 0
  br i1 %101, label %102, label %137

102:                                              ; preds = %98
  %103 = load i32, ptr %11, align 4
  store i32 %103, ptr %29, align 4
  %104 = load i32, ptr %29, align 4
  %105 = sub nsw i32 %104, 1
  store i32 %105, ptr %11, align 4
  %106 = load i32, ptr %12, align 4
  store i32 %106, ptr %30, align 4
  %107 = load i32, ptr %30, align 4
  %108 = load i32, ptr %13, align 4
  %109 = udiv i32 %107, %108
  store i32 %109, ptr %31, align 4
  %110 = load i32, ptr %12, align 4
  store i32 %110, ptr %32, align 4
  %111 = load i32, ptr %31, align 4
  %112 = load i32, ptr %13, align 4
  %113 = mul i32 %111, %112
  store i32 %113, ptr %33, align 4
  %114 = load i32, ptr %32, align 4
  %115 = load i32, ptr %33, align 4
  %116 = sub i32 %114, %115
  store i32 %116, ptr %34, align 4
  %117 = load i32, ptr %34, align 4
  store i32 %117, ptr %35, align 4
  %118 = load i32, ptr %11, align 4
  store i32 %118, ptr %36, align 4
  %119 = load i32, ptr %8, align 4
  %120 = load i32, ptr %36, align 4
  %121 = add nsw i32 %119, %120
  store i32 %121, ptr %37, align 4
  %122 = load i32, ptr %35, align 4
  %123 = sext i32 %122 to i64
  %124 = getelementptr inbounds i16, ptr getelementptr inbounds (%struct.anon.11, ptr @moonbit_string_literal_10, i32 0, i32 2), i64 %123
  %125 = load i16, ptr %124, align 2
  %126 = zext i16 %125 to i32
  store i32 %126, ptr %38, align 4
  %127 = load i32, ptr %38, align 4
  %128 = trunc i32 %127 to i16
  %129 = zext i16 %128 to i32
  store i32 %129, ptr %39, align 4
  %130 = load i32, ptr %39, align 4
  %131 = trunc i32 %130 to i16
  %132 = load ptr, ptr %6, align 8
  %133 = load i32, ptr %37, align 4
  %134 = sext i32 %133 to i64
  %135 = getelementptr inbounds i16, ptr %132, i64 %134
  store i16 %131, ptr %135, align 2
  %136 = load i32, ptr %31, align 4
  store i32 %136, ptr %12, align 4
  br label %98

137:                                              ; preds = %98
  %138 = load ptr, ptr %6, align 8
  call void @moonbit_decref_inlined(ptr noundef %138)
  br label %139

139:                                              ; preds = %137
  br label %140

140:                                              ; preds = %139
  br label %141

141:                                              ; preds = %140, %96
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @moonbit_clz32(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %9

6:                                                ; preds = %1
  %7 = load i32, ptr %2, align 4
  %8 = call i32 @llvm.ctlz.i32(i32 %7, i1 true)
  br label %9

9:                                                ; preds = %6, %5
  %10 = phi i32 [ 32, %5 ], [ %8, %6 ]
  ret i32 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @moonbit_ctz32(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %9

6:                                                ; preds = %1
  %7 = load i32, ptr %2, align 4
  %8 = call i32 @llvm.cttz.i32(i32 %7, i1 true)
  br label %9

9:                                                ; preds = %6, %5
  %10 = phi i32 [ 32, %5 ], [ %8, %6 ]
  ret i32 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca %"struct.$$moonbitlang$core$builtin$Logger", align 8
  %5 = alloca %"struct.$$moonbitlang$core$builtin$Logger", align 8
  store ptr %0, ptr %2, align 8
  %6 = call ptr @"$$moonbitlang$core$builtin$StringBuilder$$new$inner"(i32 noundef 0)
  store ptr %6, ptr %3, align 8
  %7 = load ptr, ptr %3, align 8
  call void @moonbit_incref_inlined(ptr noundef %7)
  %8 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %5, i32 0, i32 0
  %9 = load ptr, ptr @"$$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id", align 8
  store ptr %9, ptr %8, align 8
  %10 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %5, i32 0, i32 1
  %11 = load ptr, ptr %3, align 8
  store ptr %11, ptr %10, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %4, ptr align 8 %5, i64 16, i1 false)
  %12 = load ptr, ptr %2, align 8
  %13 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 0
  %14 = load ptr, ptr %13, align 8
  %15 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 1
  %16 = load ptr, ptr %15, align 8
  %17 = call i32 @"$$moonbitlang$core$builtin$Show$$$moonbitlang$core$builtin$SourceLoc$$output"(ptr noundef %12, ptr %14, ptr %16)
  %18 = load ptr, ptr %3, align 8
  %19 = call ptr @"$$moonbitlang$core$builtin$StringBuilder$$to_string"(ptr noundef %18)
  ret ptr %19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$$moonbitlang$core$builtin$StringBuilder$$new$inner"(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4
  %6 = load i32, ptr %2, align 4
  %7 = icmp slt i32 %6, 1
  br i1 %7, label %8, label %9

8:                                                ; preds = %1
  store i32 1, ptr %3, align 4
  br label %11

9:                                                ; preds = %1
  %10 = load i32, ptr %2, align 4
  store i32 %10, ptr %3, align 4
  br label %11

11:                                               ; preds = %9, %8
  %12 = load i32, ptr %3, align 4
  %13 = call ptr @moonbit_make_bytes(i32 noundef %12, i32 noundef 0)
  store ptr %13, ptr %4, align 8
  %14 = call ptr @moonbit_malloc_inlined(i64 noundef 16)
  store ptr %14, ptr %5, align 8
  %15 = load ptr, ptr %5, align 8
  %16 = getelementptr inbounds %struct.moonbit_object, ptr %15, i64 -1
  %17 = getelementptr inbounds %struct.moonbit_object, ptr %16, i32 0, i32 1
  store i32 1048832, ptr %17, align 4
  %18 = load ptr, ptr %4, align 8
  %19 = load ptr, ptr %5, align 8
  %20 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %19, i32 0, i32 1
  store ptr %18, ptr %20, align 8
  %21 = load ptr, ptr %5, align 8
  %22 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %21, i32 0, i32 0
  store i32 0, ptr %22, align 8
  %23 = load ptr, ptr %5, align 8
  ret ptr %23
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$$moonbitlang$core$builtin$StringBuilder$$to_string"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i64, align 8
  store ptr %0, ptr %2, align 8
  %9 = load ptr, ptr %2, align 8
  %10 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %9, i32 0, i32 1
  %11 = load ptr, ptr %10, align 8
  store ptr %11, ptr %3, align 8
  %12 = load ptr, ptr %3, align 8
  store ptr %12, ptr %4, align 8
  %13 = load ptr, ptr %4, align 8
  call void @moonbit_incref_inlined(ptr noundef %13)
  %14 = load ptr, ptr %4, align 8
  store ptr %14, ptr %5, align 8
  %15 = load ptr, ptr %2, align 8
  %16 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %15, i32 0, i32 0
  %17 = load i32, ptr %16, align 8
  store i32 %17, ptr %6, align 4
  %18 = load ptr, ptr %2, align 8
  call void @moonbit_decref_inlined(ptr noundef %18)
  %19 = load i32, ptr %6, align 4
  store i32 %19, ptr %7, align 4
  %20 = load i32, ptr %7, align 4
  %21 = sext i32 %20 to i64
  store i64 %21, ptr %8, align 8
  %22 = load ptr, ptr %5, align 8
  %23 = load i64, ptr %8, align 8
  %24 = call ptr @"$Bytes$$to_unchecked_string$inner"(ptr noundef %22, i32 noundef 0, i64 noundef %23)
  ret ptr %24
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0"(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca %"struct.$$moonbitlang$core$builtin$Logger", align 8
  %5 = alloca %"struct.$$moonbitlang$core$builtin$Logger", align 8
  store i32 %0, ptr %2, align 4
  %6 = call ptr @"$$moonbitlang$core$builtin$StringBuilder$$new$inner"(i32 noundef 0)
  store ptr %6, ptr %3, align 8
  %7 = load ptr, ptr %3, align 8
  call void @moonbit_incref_inlined(ptr noundef %7)
  %8 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %5, i32 0, i32 0
  %9 = load ptr, ptr @"$$moonbitlang$core$builtin$StringBuilder$as_$moonbitlang$core$builtin$Logger$static_method_table_id", align 8
  store ptr %9, ptr %8, align 8
  %10 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$Logger", ptr %5, i32 0, i32 1
  %11 = load ptr, ptr %3, align 8
  store ptr %11, ptr %10, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %4, ptr align 8 %5, i64 16, i1 false)
  %12 = load i32, ptr %2, align 4
  %13 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 0
  %14 = load ptr, ptr %13, align 8
  %15 = getelementptr inbounds { ptr, ptr }, ptr %4, i32 0, i32 1
  %16 = load ptr, ptr %15, align 8
  %17 = call i32 @"$$moonbitlang$core$builtin$Show$$Int$$output"(i32 noundef %12, ptr %14, ptr %16)
  %18 = load ptr, ptr %3, align 8
  %19 = call ptr @"$$moonbitlang$core$builtin$StringBuilder$$to_string"(ptr noundef %18)
  ret ptr %19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$StringView$$start_offset"(i64 %0, ptr %1) #0 {
  %3 = alloca %"struct.$StringView", align 8
  %4 = alloca i32, align 4
  %5 = getelementptr inbounds { i64, ptr }, ptr %3, i32 0, i32 0
  store i64 %0, ptr %5, align 8
  %6 = getelementptr inbounds { i64, ptr }, ptr %3, i32 0, i32 1
  store ptr %1, ptr %6, align 8
  %7 = getelementptr inbounds %"struct.$StringView", ptr %3, i32 0, i32 0
  %8 = load i32, ptr %7, align 8
  store i32 %8, ptr %4, align 4
  %9 = getelementptr inbounds %"struct.$StringView", ptr %3, i32 0, i32 2
  %10 = load ptr, ptr %9, align 8
  call void @moonbit_decref_inlined(ptr noundef %10)
  %11 = load i32, ptr %4, align 4
  ret i32 %11
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$StringView$$data"(i64 %0, ptr %1) #0 {
  %3 = alloca %"struct.$StringView", align 8
  %4 = alloca ptr, align 8
  %5 = getelementptr inbounds { i64, ptr }, ptr %3, i32 0, i32 0
  store i64 %0, ptr %5, align 8
  %6 = getelementptr inbounds { i64, ptr }, ptr %3, i32 0, i32 1
  store ptr %1, ptr %6, align 8
  %7 = getelementptr inbounds %"struct.$StringView", ptr %3, i32 0, i32 2
  %8 = load ptr, ptr %7, align 8
  store ptr %8, ptr %4, align 8
  %9 = load ptr, ptr %4, align 8
  ret ptr %9
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Logger$$$default_impl$$write_substring$0"(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca %"struct.$StringView", align 8
  %11 = alloca i32, align 4
  %12 = alloca i64, align 8
  %13 = alloca %struct.moonbit_result_0, align 8
  %14 = alloca %"struct.$StringView", align 8
  %15 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %16 = load i32, ptr %7, align 4
  %17 = load i32, ptr %8, align 4
  %18 = add nsw i32 %16, %17
  store i32 %18, ptr %11, align 4
  %19 = load i32, ptr %11, align 4
  %20 = sext i32 %19 to i64
  store i64 %20, ptr %12, align 8
  %21 = load ptr, ptr %6, align 8
  %22 = load i32, ptr %7, align 4
  %23 = load i64, ptr %12, align 8
  call void @"$String$$sub$inner"(ptr dead_on_unwind writable sret(%struct.moonbit_result_0) align 8 %13, ptr noundef %21, i32 noundef %22, i64 noundef %23)
  %24 = getelementptr inbounds %struct.moonbit_result_0, ptr %13, i32 0, i32 0
  %25 = load i32, ptr %24, align 8
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %29

27:                                               ; preds = %4
  %28 = getelementptr inbounds %struct.moonbit_result_0, ptr %13, i32 0, i32 1
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %14, ptr align 8 %28, i64 16, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %10, ptr align 8 %14, i64 16, i1 false)
  br label %33

29:                                               ; preds = %4
  %30 = getelementptr inbounds %struct.moonbit_result_0, ptr %13, i32 0, i32 1
  %31 = load ptr, ptr %30, align 8
  store ptr %31, ptr %15, align 8
  %32 = load ptr, ptr %15, align 8
  store ptr %32, ptr %9, align 8
  br label %34

33:                                               ; preds = %27
  br label %36

34:                                               ; preds = %29
  %35 = load ptr, ptr %9, align 8
  call void @moonbit_decref_inlined(ptr noundef %35)
  call void @moonbit_panic() #6
  unreachable

36:                                               ; preds = %33
  %37 = load ptr, ptr %5, align 8
  %38 = getelementptr inbounds { i64, ptr }, ptr %10, i32 0, i32 0
  %39 = load i64, ptr %38, align 8
  %40 = getelementptr inbounds { i64, ptr }, ptr %10, i32 0, i32 1
  %41 = load ptr, ptr %40, align 8
  %42 = call i32 @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_view"(ptr noundef %37, i64 %39, ptr %41)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @"$String$$sub$inner"(ptr dead_on_unwind noalias writable sret(%struct.moonbit_result_0) align 8 %0, ptr noundef %1, i32 noundef %2, i64 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i64, align 8
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca %"struct.$StringView", align 8
  %16 = alloca %struct.moonbit_result_0, align 8
  %17 = alloca i32, align 4
  %18 = alloca ptr, align 8
  %19 = alloca i32, align 4
  %20 = alloca ptr, align 8
  %21 = alloca %"struct.$StringView", align 8
  %22 = alloca ptr, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  store i64 %3, ptr %7, align 8
  %23 = load ptr, ptr %5, align 8
  %24 = getelementptr inbounds %struct.moonbit_object, ptr %23, i64 -1
  %25 = getelementptr inbounds %struct.moonbit_object, ptr %24, i32 0, i32 1
  %26 = load i32, ptr %25, align 4
  %27 = and i32 %26, 268435455
  store i32 %27, ptr %8, align 4
  %28 = load i64, ptr %7, align 8
  %29 = icmp eq i64 %28, 4294967296
  br i1 %29, label %30, label %32

30:                                               ; preds = %4
  %31 = load i32, ptr %8, align 4
  store i32 %31, ptr %9, align 4
  br label %45

32:                                               ; preds = %4
  %33 = load i64, ptr %7, align 8
  store i64 %33, ptr %11, align 8
  %34 = load i64, ptr %11, align 8
  %35 = trunc i64 %34 to i32
  store i32 %35, ptr %12, align 4
  %36 = load i32, ptr %12, align 4
  %37 = icmp slt i32 %36, 0
  br i1 %37, label %38, label %42

38:                                               ; preds = %32
  %39 = load i32, ptr %8, align 4
  %40 = load i32, ptr %12, align 4
  %41 = add nsw i32 %39, %40
  store i32 %41, ptr %9, align 4
  br label %44

42:                                               ; preds = %32
  %43 = load i32, ptr %12, align 4
  store i32 %43, ptr %9, align 4
  br label %44

44:                                               ; preds = %42, %38
  br label %45

45:                                               ; preds = %44, %30
  %46 = load i32, ptr %6, align 4
  %47 = icmp slt i32 %46, 0
  br i1 %47, label %48, label %52

48:                                               ; preds = %45
  %49 = load i32, ptr %8, align 4
  %50 = load i32, ptr %6, align 4
  %51 = add nsw i32 %49, %50
  store i32 %51, ptr %10, align 4
  br label %54

52:                                               ; preds = %45
  %53 = load i32, ptr %6, align 4
  store i32 %53, ptr %10, align 4
  br label %54

54:                                               ; preds = %52, %48
  %55 = load i32, ptr %10, align 4
  %56 = icmp sge i32 %55, 0
  br i1 %56, label %57, label %130

57:                                               ; preds = %54
  %58 = load i32, ptr %10, align 4
  %59 = load i32, ptr %9, align 4
  %60 = icmp sle i32 %58, %59
  br i1 %60, label %61, label %130

61:                                               ; preds = %57
  %62 = load i32, ptr %9, align 4
  %63 = load i32, ptr %8, align 4
  %64 = icmp sle i32 %62, %63
  br i1 %64, label %65, label %130

65:                                               ; preds = %61
  %66 = load i32, ptr %10, align 4
  %67 = load i32, ptr %8, align 4
  %68 = icmp slt i32 %66, %67
  br i1 %68, label %69, label %84

69:                                               ; preds = %65
  %70 = load ptr, ptr %5, align 8
  %71 = load i32, ptr %10, align 4
  %72 = sext i32 %71 to i64
  %73 = getelementptr inbounds i16, ptr %70, i64 %72
  %74 = load i16, ptr %73, align 2
  %75 = zext i16 %74 to i32
  store i32 %75, ptr %17, align 4
  %76 = load i32, ptr %17, align 4
  %77 = icmp sle i32 56320, %76
  br i1 %77, label %78, label %81

78:                                               ; preds = %69
  %79 = load i32, ptr %17, align 4
  %80 = icmp sle i32 %79, 57343
  br label %81

81:                                               ; preds = %78, %69
  %82 = phi i1 [ false, %69 ], [ %80, %78 ]
  %83 = zext i1 %82 to i32
  store i32 %83, ptr %13, align 4
  br label %85

84:                                               ; preds = %65
  store i32 0, ptr %13, align 4
  br label %85

85:                                               ; preds = %84, %81
  %86 = load i32, ptr %13, align 4
  %87 = icmp ne i32 %86, 0
  br i1 %87, label %88, label %93

88:                                               ; preds = %85
  %89 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %89)
  store ptr getelementptr inbounds (%struct.moonbit_object, ptr @moonbit_constant_constructor_0, i64 1), ptr %18, align 8
  %90 = getelementptr inbounds %struct.moonbit_result_0, ptr %0, i32 0, i32 0
  store i32 0, ptr %90, align 8
  %91 = load ptr, ptr %18, align 8
  %92 = getelementptr inbounds %struct.moonbit_result_0, ptr %0, i32 0, i32 1
  store ptr %91, ptr %92, align 8
  br label %135

93:                                               ; preds = %85
  %94 = load i32, ptr %9, align 4
  %95 = load i32, ptr %8, align 4
  %96 = icmp slt i32 %94, %95
  br i1 %96, label %97, label %112

97:                                               ; preds = %93
  %98 = load ptr, ptr %5, align 8
  %99 = load i32, ptr %9, align 4
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds i16, ptr %98, i64 %100
  %102 = load i16, ptr %101, align 2
  %103 = zext i16 %102 to i32
  store i32 %103, ptr %19, align 4
  %104 = load i32, ptr %19, align 4
  %105 = icmp sle i32 56320, %104
  br i1 %105, label %106, label %109

106:                                              ; preds = %97
  %107 = load i32, ptr %19, align 4
  %108 = icmp sle i32 %107, 57343
  br label %109

109:                                              ; preds = %106, %97
  %110 = phi i1 [ false, %97 ], [ %108, %106 ]
  %111 = zext i1 %110 to i32
  store i32 %111, ptr %14, align 4
  br label %113

112:                                              ; preds = %93
  store i32 0, ptr %14, align 4
  br label %113

113:                                              ; preds = %112, %109
  %114 = load i32, ptr %14, align 4
  %115 = icmp ne i32 %114, 0
  br i1 %115, label %116, label %121

116:                                              ; preds = %113
  %117 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %117)
  store ptr getelementptr inbounds (%struct.moonbit_object, ptr @moonbit_constant_constructor_0, i64 1), ptr %20, align 8
  %118 = getelementptr inbounds %struct.moonbit_result_0, ptr %0, i32 0, i32 0
  store i32 0, ptr %118, align 8
  %119 = load ptr, ptr %20, align 8
  %120 = getelementptr inbounds %struct.moonbit_result_0, ptr %0, i32 0, i32 1
  store ptr %119, ptr %120, align 8
  br label %135

121:                                              ; preds = %113
  %122 = getelementptr inbounds %"struct.$StringView", ptr %21, i32 0, i32 0
  %123 = load i32, ptr %10, align 4
  store i32 %123, ptr %122, align 8
  %124 = getelementptr inbounds %"struct.$StringView", ptr %21, i32 0, i32 1
  %125 = load i32, ptr %9, align 4
  store i32 %125, ptr %124, align 4
  %126 = getelementptr inbounds %"struct.$StringView", ptr %21, i32 0, i32 2
  %127 = load ptr, ptr %5, align 8
  store ptr %127, ptr %126, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %15, ptr align 8 %21, i64 16, i1 false)
  %128 = getelementptr inbounds %struct.moonbit_result_0, ptr %16, i32 0, i32 0
  store i32 1, ptr %128, align 8
  %129 = getelementptr inbounds %struct.moonbit_result_0, ptr %16, i32 0, i32 1
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %129, ptr align 8 %15, i64 16, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %0, ptr align 8 %16, i64 24, i1 false)
  br label %135

130:                                              ; preds = %61, %57, %54
  %131 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %131)
  store ptr getelementptr inbounds (%struct.moonbit_object, ptr @moonbit_constant_constructor_1, i64 1), ptr %22, align 8
  %132 = getelementptr inbounds %struct.moonbit_result_0, ptr %0, i32 0, i32 0
  store i32 0, ptr %132, align 8
  %133 = load ptr, ptr %22, align 8
  %134 = getelementptr inbounds %struct.moonbit_result_0, ptr %0, i32 0, i32 1
  store ptr %133, ptr %134, align 8
  br label %135

135:                                              ; preds = %130, %121, %116, %88
  ret void
}

; Function Attrs: noreturn
declare void @moonbit_panic() #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_string"(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %18 = load ptr, ptr %3, align 8
  %19 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %18, i32 0, i32 0
  %20 = load i32, ptr %19, align 8
  store i32 %20, ptr %5, align 4
  %21 = load ptr, ptr %4, align 8
  %22 = getelementptr inbounds %struct.moonbit_object, ptr %21, i64 -1
  %23 = getelementptr inbounds %struct.moonbit_object, ptr %22, i32 0, i32 1
  %24 = load i32, ptr %23, align 4
  %25 = and i32 %24, 268435455
  store i32 %25, ptr %6, align 4
  %26 = load i32, ptr %6, align 4
  %27 = mul nsw i32 %26, 2
  store i32 %27, ptr %7, align 4
  %28 = load i32, ptr %5, align 4
  %29 = load i32, ptr %7, align 4
  %30 = add nsw i32 %28, %29
  store i32 %30, ptr %8, align 4
  %31 = load ptr, ptr %3, align 8
  call void @moonbit_incref_inlined(ptr noundef %31)
  %32 = load ptr, ptr %3, align 8
  %33 = load i32, ptr %8, align 4
  %34 = call i32 @"$$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary"(ptr noundef %32, i32 noundef %33)
  %35 = load ptr, ptr %3, align 8
  %36 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %35, i32 0, i32 1
  %37 = load ptr, ptr %36, align 8
  store ptr %37, ptr %9, align 8
  %38 = load ptr, ptr %9, align 8
  store ptr %38, ptr %10, align 8
  %39 = load ptr, ptr %3, align 8
  %40 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %39, i32 0, i32 0
  %41 = load i32, ptr %40, align 8
  store i32 %41, ptr %11, align 4
  %42 = load ptr, ptr %4, align 8
  %43 = getelementptr inbounds %struct.moonbit_object, ptr %42, i64 -1
  %44 = getelementptr inbounds %struct.moonbit_object, ptr %43, i32 0, i32 1
  %45 = load i32, ptr %44, align 4
  %46 = and i32 %45, 268435455
  store i32 %46, ptr %12, align 4
  %47 = load ptr, ptr %10, align 8
  call void @moonbit_incref_inlined(ptr noundef %47)
  %48 = load ptr, ptr %4, align 8
  call void @moonbit_incref_inlined(ptr noundef %48)
  %49 = load ptr, ptr %10, align 8
  %50 = load i32, ptr %11, align 4
  %51 = load ptr, ptr %4, align 8
  %52 = load i32, ptr %12, align 4
  %53 = call i32 @"$FixedArray$$blit_from_string"(ptr noundef %49, i32 noundef %50, ptr noundef %51, i32 noundef 0, i32 noundef %52)
  %54 = load ptr, ptr %3, align 8
  %55 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %54, i32 0, i32 0
  %56 = load i32, ptr %55, align 8
  store i32 %56, ptr %13, align 4
  %57 = load ptr, ptr %4, align 8
  %58 = getelementptr inbounds %struct.moonbit_object, ptr %57, i64 -1
  %59 = getelementptr inbounds %struct.moonbit_object, ptr %58, i32 0, i32 1
  %60 = load i32, ptr %59, align 4
  %61 = and i32 %60, 268435455
  store i32 %61, ptr %14, align 4
  %62 = load ptr, ptr %4, align 8
  call void @moonbit_decref_inlined(ptr noundef %62)
  %63 = load i32, ptr %14, align 4
  store i32 %63, ptr %15, align 4
  %64 = load i32, ptr %15, align 4
  %65 = mul nsw i32 %64, 2
  store i32 %65, ptr %16, align 4
  %66 = load i32, ptr %13, align 4
  %67 = load i32, ptr %16, align 4
  %68 = add nsw i32 %66, %67
  store i32 %68, ptr %17, align 4
  %69 = load i32, ptr %17, align 4
  %70 = load ptr, ptr %3, align 8
  %71 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %70, i32 0, i32 0
  store i32 %69, ptr %71, align 8
  %72 = load ptr, ptr %3, align 8
  call void @moonbit_decref_inlined(ptr noundef %72)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @"$StringView$$rev_find"(i64 %0, ptr %1, i64 %2, ptr %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca %"struct.$StringView", align 8
  %7 = alloca %"struct.$StringView", align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  store i64 %0, ptr %11, align 8
  %12 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  store ptr %1, ptr %12, align 8
  %13 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  store i64 %2, ptr %13, align 8
  %14 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  store ptr %3, ptr %14, align 8
  %15 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 1
  %16 = load i32, ptr %15, align 4
  store i32 %16, ptr %8, align 4
  %17 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %18 = load i32, ptr %17, align 8
  store i32 %18, ptr %9, align 4
  %19 = load i32, ptr %8, align 4
  %20 = load i32, ptr %9, align 4
  %21 = sub nsw i32 %19, %20
  store i32 %21, ptr %10, align 4
  %22 = load i32, ptr %10, align 4
  %23 = icmp sle i32 %22, 4
  br i1 %23, label %24, label %34

24:                                               ; preds = %4
  %25 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  %26 = load i64, ptr %25, align 8
  %27 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  %28 = load ptr, ptr %27, align 8
  %29 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  %30 = load i64, ptr %29, align 8
  %31 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  %32 = load ptr, ptr %31, align 8
  %33 = call i64 @"$moonbitlang$core$builtin$brute_force_rev_find"(i64 %26, ptr %28, i64 %30, ptr %32)
  store i64 %33, ptr %5, align 8
  br label %44

34:                                               ; preds = %4
  %35 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  %36 = load i64, ptr %35, align 8
  %37 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  %38 = load ptr, ptr %37, align 8
  %39 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  %40 = load i64, ptr %39, align 8
  %41 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  %42 = load ptr, ptr %41, align 8
  %43 = call i64 @"$moonbitlang$core$builtin$boyer_moore_horspool_rev_find"(i64 %36, ptr %38, i64 %40, ptr %42)
  store i64 %43, ptr %5, align 8
  br label %44

44:                                               ; preds = %34, %24
  %45 = load i64, ptr %5, align 8
  ret i64 %45
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$moonbitlang$core$builtin$parse$parse_loc$7c$1101"(i64 %0, ptr %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca %"struct.$StringView", align 8
  %5 = alloca i32, align 4
  %6 = alloca %"struct.$StringView", align 8
  %7 = alloca i64, align 8
  %8 = alloca %"struct.$StringView", align 8
  %9 = alloca i64, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i64, align 8
  %17 = alloca %"struct.$StringView", align 8
  %18 = alloca i32, align 4
  %19 = alloca %"struct.$StringView", align 8
  %20 = alloca ptr, align 8
  %21 = alloca %"struct.$StringView", align 8
  %22 = alloca %"struct.$StringView", align 8
  %23 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 0
  store i64 %0, ptr %23, align 8
  %24 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 1
  store ptr %1, ptr %24, align 8
  %25 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5404", align 8
  %26 = getelementptr inbounds %struct.moonbit_object, ptr %25, i64 -1
  %27 = getelementptr inbounds %struct.moonbit_object, ptr %26, i32 0, i32 1
  %28 = load i32, ptr %27, align 4
  %29 = and i32 %28, 268435455
  store i32 %29, ptr %5, align 4
  %30 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5404", align 8
  call void @moonbit_incref_inlined(ptr noundef %30)
  %31 = getelementptr inbounds %"struct.$StringView", ptr %8, i32 0, i32 0
  store i32 0, ptr %31, align 8
  %32 = getelementptr inbounds %"struct.$StringView", ptr %8, i32 0, i32 1
  %33 = load i32, ptr %5, align 4
  store i32 %33, ptr %32, align 4
  %34 = getelementptr inbounds %"struct.$StringView", ptr %8, i32 0, i32 2
  %35 = load ptr, ptr @"$moonbitlang$core$builtin$parse$$2a$bind$7c$5404", align 8
  store ptr %35, ptr %34, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %6, ptr align 8 %8, i64 16, i1 false)
  %36 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 2
  %37 = load ptr, ptr %36, align 8
  call void @moonbit_incref_inlined(ptr noundef %37)
  %38 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 0
  %39 = load i64, ptr %38, align 8
  %40 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 1
  %41 = load ptr, ptr %40, align 8
  %42 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  %43 = load i64, ptr %42, align 8
  %44 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  %45 = load ptr, ptr %44, align 8
  %46 = call i64 @"$StringView$$find"(i64 %39, ptr %41, i64 %43, ptr %45)
  store i64 %46, ptr %7, align 8
  %47 = load i64, ptr %7, align 8
  %48 = icmp eq i64 %47, 4294967296
  br i1 %48, label %49, label %52

49:                                               ; preds = %2
  %50 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 2
  %51 = load ptr, ptr %50, align 8
  call void @moonbit_decref_inlined(ptr noundef %51)
  store ptr null, ptr %3, align 8
  br label %135

52:                                               ; preds = %2
  %53 = load i64, ptr %7, align 8
  store i64 %53, ptr %9, align 8
  %54 = load i64, ptr %9, align 8
  %55 = trunc i64 %54 to i32
  store i32 %55, ptr %10, align 4
  %56 = load i32, ptr %10, align 4
  %57 = icmp sgt i32 %56, 0
  br i1 %57, label %58, label %72

58:                                               ; preds = %52
  %59 = load i32, ptr %10, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %12, align 4
  %61 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 1
  %62 = load i32, ptr %61, align 4
  store i32 %62, ptr %13, align 4
  %63 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 0
  %64 = load i32, ptr %63, align 8
  store i32 %64, ptr %14, align 4
  %65 = load i32, ptr %13, align 4
  %66 = load i32, ptr %14, align 4
  %67 = sub nsw i32 %65, %66
  store i32 %67, ptr %15, align 4
  %68 = load i32, ptr %12, align 4
  %69 = load i32, ptr %15, align 4
  %70 = icmp slt i32 %68, %69
  %71 = zext i1 %70 to i32
  store i32 %71, ptr %11, align 4
  br label %73

72:                                               ; preds = %52
  store i32 0, ptr %11, align 4
  br label %73

73:                                               ; preds = %72, %58
  %74 = load i32, ptr %11, align 4
  %75 = icmp ne i32 %74, 0
  br i1 %75, label %76, label %132

76:                                               ; preds = %73
  %77 = load i32, ptr %10, align 4
  %78 = sext i32 %77 to i64
  store i64 %78, ptr %16, align 8
  %79 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 2
  %80 = load ptr, ptr %79, align 8
  call void @moonbit_incref_inlined(ptr noundef %80)
  %81 = load i64, ptr %16, align 8
  %82 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 0
  %83 = load i64, ptr %82, align 8
  %84 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 1
  %85 = load ptr, ptr %84, align 8
  %86 = call { i64, ptr } @"$StringView$$view$inner"(i64 %83, ptr %85, i32 noundef 0, i64 noundef %81)
  %87 = getelementptr inbounds { i64, ptr }, ptr %21, i32 0, i32 0
  %88 = extractvalue { i64, ptr } %86, 0
  store i64 %88, ptr %87, align 8
  %89 = getelementptr inbounds { i64, ptr }, ptr %21, i32 0, i32 1
  %90 = extractvalue { i64, ptr } %86, 1
  store ptr %90, ptr %89, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %17, ptr align 8 %21, i64 16, i1 false)
  %91 = load i32, ptr %10, align 4
  %92 = add nsw i32 %91, 1
  store i32 %92, ptr %18, align 4
  %93 = load i32, ptr %18, align 4
  %94 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 0
  %95 = load i64, ptr %94, align 8
  %96 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 1
  %97 = load ptr, ptr %96, align 8
  %98 = call { i64, ptr } @"$StringView$$view$inner"(i64 %95, ptr %97, i32 noundef %93, i64 noundef 4294967296)
  %99 = getelementptr inbounds { i64, ptr }, ptr %22, i32 0, i32 0
  %100 = extractvalue { i64, ptr } %98, 0
  store i64 %100, ptr %99, align 8
  %101 = getelementptr inbounds { i64, ptr }, ptr %22, i32 0, i32 1
  %102 = extractvalue { i64, ptr } %98, 1
  store ptr %102, ptr %101, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %19, ptr align 8 %22, i64 16, i1 false)
  %103 = call ptr @moonbit_malloc_inlined(i64 noundef 32)
  store ptr %103, ptr %20, align 8
  %104 = load ptr, ptr %20, align 8
  %105 = getelementptr inbounds %struct.moonbit_object, ptr %104, i64 -1
  %106 = getelementptr inbounds %struct.moonbit_object, ptr %105, i32 0, i32 1
  store i32 2097664, ptr %106, align 4
  %107 = getelementptr inbounds %"struct.$StringView", ptr %17, i32 0, i32 2
  %108 = load ptr, ptr %107, align 8
  %109 = load ptr, ptr %20, align 8
  %110 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %109, i32 0, i32 4
  store ptr %108, ptr %110, align 8
  %111 = getelementptr inbounds %"struct.$StringView", ptr %17, i32 0, i32 0
  %112 = load i32, ptr %111, align 8
  %113 = load ptr, ptr %20, align 8
  %114 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %113, i32 0, i32 0
  store i32 %112, ptr %114, align 8
  %115 = getelementptr inbounds %"struct.$StringView", ptr %17, i32 0, i32 1
  %116 = load i32, ptr %115, align 4
  %117 = load ptr, ptr %20, align 8
  %118 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %117, i32 0, i32 1
  store i32 %116, ptr %118, align 4
  %119 = getelementptr inbounds %"struct.$StringView", ptr %19, i32 0, i32 2
  %120 = load ptr, ptr %119, align 8
  %121 = load ptr, ptr %20, align 8
  %122 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %121, i32 0, i32 5
  store ptr %120, ptr %122, align 8
  %123 = getelementptr inbounds %"struct.$StringView", ptr %19, i32 0, i32 0
  %124 = load i32, ptr %123, align 8
  %125 = load ptr, ptr %20, align 8
  %126 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %125, i32 0, i32 2
  store i32 %124, ptr %126, align 8
  %127 = getelementptr inbounds %"struct.$StringView", ptr %19, i32 0, i32 1
  %128 = load i32, ptr %127, align 4
  %129 = load ptr, ptr %20, align 8
  %130 = getelementptr inbounds %"struct.$$3c$StringView$2a$StringView$3e$", ptr %129, i32 0, i32 3
  store i32 %128, ptr %130, align 4
  %131 = load ptr, ptr %20, align 8
  store ptr %131, ptr %3, align 8
  br label %135

132:                                              ; preds = %73
  %133 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 2
  %134 = load ptr, ptr %133, align 8
  call void @moonbit_decref_inlined(ptr noundef %134)
  store ptr null, ptr %3, align 8
  br label %135

135:                                              ; preds = %132, %76, %49
  %136 = load ptr, ptr %3, align 8
  ret ptr %136
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local { i64, ptr } @"$moonbitlang$core$builtin$abort$2"(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca %"struct.$StringView", align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %10 = load ptr, ptr %4, align 8
  %11 = call ptr @moonbit_add_string(ptr noundef %10, ptr noundef getelementptr inbounds (%struct.anon.2, ptr @moonbit_string_literal_15, i32 0, i32 2))
  store ptr %11, ptr %6, align 8
  %12 = load ptr, ptr %5, align 8
  %13 = call ptr @"$$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1"(ptr noundef %12)
  store ptr %13, ptr %7, align 8
  %14 = load ptr, ptr %6, align 8
  %15 = load ptr, ptr %7, align 8
  %16 = call ptr @moonbit_add_string(ptr noundef %14, ptr noundef %15)
  store ptr %16, ptr %8, align 8
  %17 = load ptr, ptr %8, align 8
  %18 = call ptr @moonbit_add_string(ptr noundef %17, ptr noundef getelementptr inbounds (%struct.anon.13, ptr @moonbit_string_literal_16, i32 0, i32 2))
  store ptr %18, ptr %9, align 8
  %19 = load ptr, ptr %9, align 8
  %20 = call { i64, ptr } @"$moonbitlang$core$abort$abort$2"(ptr noundef %19)
  %21 = getelementptr inbounds { i64, ptr }, ptr %3, i32 0, i32 0
  %22 = extractvalue { i64, ptr } %20, 0
  store i64 %22, ptr %21, align 8
  %23 = getelementptr inbounds { i64, ptr }, ptr %3, i32 0, i32 1
  %24 = extractvalue { i64, ptr } %20, 1
  store ptr %24, ptr %23, align 8
  %25 = load { i64, ptr }, ptr %3, align 8
  ret { i64, ptr } %25
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @"$moonbitlang$core$builtin$brute_force_rev_find"(i64 %0, ptr %1, i64 %2, ptr %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca %"struct.$StringView", align 8
  %7 = alloca %"struct.$StringView", align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca ptr, align 8
  %28 = alloca ptr, align 8
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  %37 = alloca i32, align 4
  %38 = alloca ptr, align 8
  %39 = alloca ptr, align 8
  %40 = alloca i32, align 4
  %41 = alloca i32, align 4
  %42 = alloca i32, align 4
  %43 = alloca i32, align 4
  %44 = alloca ptr, align 8
  %45 = alloca ptr, align 8
  %46 = alloca i32, align 4
  %47 = alloca i32, align 4
  %48 = alloca i32, align 4
  %49 = alloca i32, align 4
  %50 = alloca i32, align 4
  %51 = alloca i32, align 4
  %52 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  store i64 %0, ptr %52, align 8
  %53 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  store ptr %1, ptr %53, align 8
  %54 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  store i64 %2, ptr %54, align 8
  %55 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  store ptr %3, ptr %55, align 8
  %56 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 1
  %57 = load i32, ptr %56, align 4
  store i32 %57, ptr %8, align 4
  %58 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %59 = load i32, ptr %58, align 8
  store i32 %59, ptr %9, align 4
  %60 = load i32, ptr %8, align 4
  %61 = load i32, ptr %9, align 4
  %62 = sub nsw i32 %60, %61
  store i32 %62, ptr %10, align 4
  %63 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 1
  %64 = load i32, ptr %63, align 4
  store i32 %64, ptr %11, align 4
  %65 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %66 = load i32, ptr %65, align 8
  store i32 %66, ptr %12, align 4
  %67 = load i32, ptr %11, align 4
  %68 = load i32, ptr %12, align 4
  %69 = sub nsw i32 %67, %68
  store i32 %69, ptr %13, align 4
  %70 = load i32, ptr %13, align 4
  %71 = icmp sgt i32 %70, 0
  br i1 %71, label %72, label %211

72:                                               ; preds = %4
  %73 = load i32, ptr %10, align 4
  %74 = load i32, ptr %13, align 4
  %75 = icmp sge i32 %73, %74
  br i1 %75, label %76, label %206

76:                                               ; preds = %72
  store i32 0, ptr %14, align 4
  %77 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %78 = load ptr, ptr %77, align 8
  store ptr %78, ptr %15, align 8
  %79 = load ptr, ptr %15, align 8
  store ptr %79, ptr %16, align 8
  %80 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %81 = load i32, ptr %80, align 8
  store i32 %81, ptr %17, align 4
  %82 = load i32, ptr %17, align 4
  %83 = load i32, ptr %14, align 4
  %84 = add nsw i32 %82, %83
  store i32 %84, ptr %18, align 4
  %85 = load ptr, ptr %16, align 8
  %86 = load i32, ptr %18, align 4
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds i16, ptr %85, i64 %87
  %89 = load i16, ptr %88, align 2
  %90 = zext i16 %89 to i32
  store i32 %90, ptr %19, align 4
  %91 = load i32, ptr %19, align 4
  store i32 %91, ptr %20, align 4
  %92 = load i32, ptr %10, align 4
  %93 = load i32, ptr %13, align 4
  %94 = sub nsw i32 %92, %93
  store i32 %94, ptr %21, align 4
  br label %95

95:                                               ; preds = %76, %198
  %96 = load i32, ptr %21, align 4
  store i32 %96, ptr %22, align 4
  %97 = load i32, ptr %22, align 4
  %98 = icmp sge i32 %97, 0
  br i1 %98, label %99, label %199

99:                                               ; preds = %95
  br label %100

100:                                              ; preds = %99, %129
  %101 = load i32, ptr %21, align 4
  store i32 %101, ptr %24, align 4
  %102 = load i32, ptr %24, align 4
  %103 = icmp sge i32 %102, 0
  br i1 %103, label %104, label %125

104:                                              ; preds = %100
  %105 = load i32, ptr %21, align 4
  store i32 %105, ptr %26, align 4
  %106 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %107 = load ptr, ptr %106, align 8
  store ptr %107, ptr %27, align 8
  %108 = load ptr, ptr %27, align 8
  store ptr %108, ptr %28, align 8
  %109 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %110 = load i32, ptr %109, align 8
  store i32 %110, ptr %29, align 4
  %111 = load i32, ptr %29, align 4
  %112 = load i32, ptr %26, align 4
  %113 = add nsw i32 %111, %112
  store i32 %113, ptr %30, align 4
  %114 = load ptr, ptr %28, align 8
  %115 = load i32, ptr %30, align 4
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds i16, ptr %114, i64 %116
  %118 = load i16, ptr %117, align 2
  %119 = zext i16 %118 to i32
  store i32 %119, ptr %31, align 4
  %120 = load i32, ptr %31, align 4
  store i32 %120, ptr %32, align 4
  %121 = load i32, ptr %32, align 4
  %122 = load i32, ptr %20, align 4
  %123 = icmp ne i32 %121, %122
  %124 = zext i1 %123 to i32
  store i32 %124, ptr %25, align 4
  br label %126

125:                                              ; preds = %100
  store i32 0, ptr %25, align 4
  br label %126

126:                                              ; preds = %125, %104
  %127 = load i32, ptr %25, align 4
  %128 = icmp ne i32 %127, 0
  br i1 %128, label %129, label %133

129:                                              ; preds = %126
  %130 = load i32, ptr %21, align 4
  store i32 %130, ptr %33, align 4
  %131 = load i32, ptr %33, align 4
  %132 = sub nsw i32 %131, 1
  store i32 %132, ptr %21, align 4
  br label %100

133:                                              ; preds = %126
  br label %134

134:                                              ; preds = %133
  %135 = load i32, ptr %21, align 4
  store i32 %135, ptr %23, align 4
  %136 = load i32, ptr %23, align 4
  %137 = icmp sge i32 %136, 0
  br i1 %137, label %138, label %198

138:                                              ; preds = %134
  store i32 1, ptr %34, align 4
  br label %139

139:                                              ; preds = %138, %182
  %140 = load i32, ptr %34, align 4
  %141 = load i32, ptr %13, align 4
  %142 = icmp slt i32 %140, %141
  br i1 %142, label %143, label %186

143:                                              ; preds = %139
  %144 = load i32, ptr %21, align 4
  store i32 %144, ptr %36, align 4
  %145 = load i32, ptr %36, align 4
  %146 = load i32, ptr %34, align 4
  %147 = add nsw i32 %145, %146
  store i32 %147, ptr %37, align 4
  %148 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %149 = load ptr, ptr %148, align 8
  store ptr %149, ptr %38, align 8
  %150 = load ptr, ptr %38, align 8
  store ptr %150, ptr %39, align 8
  %151 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %152 = load i32, ptr %151, align 8
  store i32 %152, ptr %40, align 4
  %153 = load i32, ptr %40, align 4
  %154 = load i32, ptr %37, align 4
  %155 = add nsw i32 %153, %154
  store i32 %155, ptr %41, align 4
  %156 = load ptr, ptr %39, align 8
  %157 = load i32, ptr %41, align 4
  %158 = sext i32 %157 to i64
  %159 = getelementptr inbounds i16, ptr %156, i64 %158
  %160 = load i16, ptr %159, align 2
  %161 = zext i16 %160 to i32
  store i32 %161, ptr %42, align 4
  %162 = load i32, ptr %42, align 4
  store i32 %162, ptr %43, align 4
  %163 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %164 = load ptr, ptr %163, align 8
  store ptr %164, ptr %44, align 8
  %165 = load ptr, ptr %44, align 8
  store ptr %165, ptr %45, align 8
  %166 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %167 = load i32, ptr %166, align 8
  store i32 %167, ptr %46, align 4
  %168 = load i32, ptr %46, align 4
  %169 = load i32, ptr %34, align 4
  %170 = add nsw i32 %168, %169
  store i32 %170, ptr %47, align 4
  %171 = load ptr, ptr %45, align 8
  %172 = load i32, ptr %47, align 4
  %173 = sext i32 %172 to i64
  %174 = getelementptr inbounds i16, ptr %171, i64 %173
  %175 = load i16, ptr %174, align 2
  %176 = zext i16 %175 to i32
  store i32 %176, ptr %48, align 4
  %177 = load i32, ptr %48, align 4
  store i32 %177, ptr %49, align 4
  %178 = load i32, ptr %43, align 4
  %179 = load i32, ptr %49, align 4
  %180 = icmp ne i32 %178, %179
  br i1 %180, label %181, label %182

181:                                              ; preds = %143
  br label %194

182:                                              ; preds = %143
  %183 = load i32, ptr %34, align 4
  %184 = add nsw i32 %183, 1
  store i32 %184, ptr %50, align 4
  %185 = load i32, ptr %50, align 4
  store i32 %185, ptr %34, align 4
  br label %139

186:                                              ; preds = %139
  %187 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %188 = load ptr, ptr %187, align 8
  call void @moonbit_decref_inlined(ptr noundef %188)
  %189 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %190 = load ptr, ptr %189, align 8
  call void @moonbit_decref_inlined(ptr noundef %190)
  %191 = load i32, ptr %21, align 4
  store i32 %191, ptr %51, align 4
  %192 = load i32, ptr %51, align 4
  %193 = sext i32 %192 to i64
  store i64 %193, ptr %5, align 8
  br label %218

194:                                              ; preds = %181
  %195 = load i32, ptr %21, align 4
  store i32 %195, ptr %35, align 4
  %196 = load i32, ptr %35, align 4
  %197 = sub nsw i32 %196, 1
  store i32 %197, ptr %21, align 4
  br label %198

198:                                              ; preds = %194, %134
  br label %95

199:                                              ; preds = %95
  %200 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %201 = load ptr, ptr %200, align 8
  call void @moonbit_decref_inlined(ptr noundef %201)
  %202 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %203 = load ptr, ptr %202, align 8
  call void @moonbit_decref_inlined(ptr noundef %203)
  br label %204

204:                                              ; preds = %199
  br label %205

205:                                              ; preds = %204
  store i64 4294967296, ptr %5, align 8
  br label %218

206:                                              ; preds = %72
  %207 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %208 = load ptr, ptr %207, align 8
  call void @moonbit_decref_inlined(ptr noundef %208)
  %209 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %210 = load ptr, ptr %209, align 8
  call void @moonbit_decref_inlined(ptr noundef %210)
  store i64 4294967296, ptr %5, align 8
  br label %218

211:                                              ; preds = %4
  %212 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %213 = load ptr, ptr %212, align 8
  call void @moonbit_decref_inlined(ptr noundef %213)
  %214 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %215 = load ptr, ptr %214, align 8
  call void @moonbit_decref_inlined(ptr noundef %215)
  %216 = load i32, ptr %10, align 4
  %217 = sext i32 %216 to i64
  store i64 %217, ptr %5, align 8
  br label %218

218:                                              ; preds = %211, %206, %205, %186
  %219 = load i64, ptr %5, align 8
  ret i64 %219
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @"$moonbitlang$core$builtin$boyer_moore_horspool_rev_find"(i64 %0, ptr %1, i64 %2, ptr %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca %"struct.$StringView", align 8
  %7 = alloca %"struct.$StringView", align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca ptr, align 8
  %20 = alloca ptr, align 8
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca ptr, align 8
  %29 = alloca ptr, align 8
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  %37 = alloca i32, align 4
  %38 = alloca ptr, align 8
  %39 = alloca ptr, align 8
  %40 = alloca i32, align 4
  %41 = alloca i32, align 4
  %42 = alloca i32, align 4
  %43 = alloca i32, align 4
  %44 = alloca ptr, align 8
  %45 = alloca ptr, align 8
  %46 = alloca i32, align 4
  %47 = alloca i32, align 4
  %48 = alloca i32, align 4
  %49 = alloca i32, align 4
  %50 = alloca i32, align 4
  %51 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  store i64 %0, ptr %51, align 8
  %52 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  store ptr %1, ptr %52, align 8
  %53 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  store i64 %2, ptr %53, align 8
  %54 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  store ptr %3, ptr %54, align 8
  %55 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 1
  %56 = load i32, ptr %55, align 4
  store i32 %56, ptr %8, align 4
  %57 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %58 = load i32, ptr %57, align 8
  store i32 %58, ptr %9, align 4
  %59 = load i32, ptr %8, align 4
  %60 = load i32, ptr %9, align 4
  %61 = sub nsw i32 %59, %60
  store i32 %61, ptr %10, align 4
  %62 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 1
  %63 = load i32, ptr %62, align 4
  store i32 %63, ptr %11, align 4
  %64 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %65 = load i32, ptr %64, align 8
  store i32 %65, ptr %12, align 4
  %66 = load i32, ptr %11, align 4
  %67 = load i32, ptr %12, align 4
  %68 = sub nsw i32 %66, %67
  store i32 %68, ptr %13, align 4
  %69 = load i32, ptr %13, align 4
  %70 = icmp sgt i32 %69, 0
  br i1 %70, label %71, label %238

71:                                               ; preds = %4
  %72 = load i32, ptr %10, align 4
  %73 = load i32, ptr %13, align 4
  %74 = icmp sge i32 %72, %73
  br i1 %74, label %75, label %233

75:                                               ; preds = %71
  %76 = load i32, ptr %13, align 4
  %77 = call ptr @moonbit_make_int32_array(i32 noundef 256, i32 noundef %76)
  store ptr %77, ptr %14, align 8
  %78 = load i32, ptr %13, align 4
  %79 = sub nsw i32 %78, 1
  store i32 %79, ptr %15, align 4
  %80 = load i32, ptr %15, align 4
  store i32 %80, ptr %16, align 4
  br label %81

81:                                               ; preds = %75, %113
  %82 = load i32, ptr %16, align 4
  %83 = icmp sgt i32 %82, 0
  br i1 %83, label %84, label %122

84:                                               ; preds = %81
  %85 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %86 = load ptr, ptr %85, align 8
  store ptr %86, ptr %19, align 8
  %87 = load ptr, ptr %19, align 8
  store ptr %87, ptr %20, align 8
  %88 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %89 = load i32, ptr %88, align 8
  store i32 %89, ptr %21, align 4
  %90 = load i32, ptr %21, align 4
  %91 = load i32, ptr %16, align 4
  %92 = add nsw i32 %90, %91
  store i32 %92, ptr %22, align 4
  %93 = load ptr, ptr %20, align 8
  %94 = load i32, ptr %22, align 4
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds i16, ptr %93, i64 %95
  %97 = load i16, ptr %96, align 2
  %98 = zext i16 %97 to i32
  store i32 %98, ptr %23, align 4
  %99 = load i32, ptr %23, align 4
  store i32 %99, ptr %24, align 4
  %100 = load i32, ptr %24, align 4
  %101 = and i32 %100, 255
  store i32 %101, ptr %25, align 4
  %102 = load i32, ptr %25, align 4
  %103 = icmp slt i32 %102, 0
  br i1 %103, label %112, label %104

104:                                              ; preds = %84
  %105 = load i32, ptr %25, align 4
  %106 = load ptr, ptr %14, align 8
  %107 = getelementptr inbounds %struct.moonbit_object, ptr %106, i64 -1
  %108 = getelementptr inbounds %struct.moonbit_object, ptr %107, i32 0, i32 1
  %109 = load i32, ptr %108, align 4
  %110 = and i32 %109, 268435455
  %111 = icmp uge i32 %105, %110
  br i1 %111, label %112, label %113

112:                                              ; preds = %104, %84
  call void @moonbit_panic() #6
  unreachable

113:                                              ; preds = %104
  %114 = load i32, ptr %16, align 4
  %115 = load ptr, ptr %14, align 8
  %116 = load i32, ptr %25, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds i32, ptr %115, i64 %117
  store i32 %114, ptr %118, align 4
  %119 = load i32, ptr %16, align 4
  %120 = sub nsw i32 %119, 1
  store i32 %120, ptr %26, align 4
  %121 = load i32, ptr %26, align 4
  store i32 %121, ptr %16, align 4
  br label %81

122:                                              ; preds = %81
  br label %123

123:                                              ; preds = %122
  %124 = load i32, ptr %10, align 4
  %125 = load i32, ptr %13, align 4
  %126 = sub nsw i32 %124, %125
  store i32 %126, ptr %17, align 4
  %127 = load i32, ptr %17, align 4
  store i32 %127, ptr %18, align 4
  br label %128

128:                                              ; preds = %123, %215
  %129 = load i32, ptr %18, align 4
  %130 = icmp sge i32 %129, 0
  br i1 %130, label %131, label %225

131:                                              ; preds = %128
  store i32 0, ptr %27, align 4
  br label %132

132:                                              ; preds = %131, %174
  %133 = load i32, ptr %27, align 4
  %134 = load i32, ptr %13, align 4
  %135 = icmp slt i32 %133, %134
  br i1 %135, label %136, label %178

136:                                              ; preds = %132
  %137 = load i32, ptr %18, align 4
  %138 = load i32, ptr %27, align 4
  %139 = add nsw i32 %137, %138
  store i32 %139, ptr %37, align 4
  %140 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %141 = load ptr, ptr %140, align 8
  store ptr %141, ptr %38, align 8
  %142 = load ptr, ptr %38, align 8
  store ptr %142, ptr %39, align 8
  %143 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %144 = load i32, ptr %143, align 8
  store i32 %144, ptr %40, align 4
  %145 = load i32, ptr %40, align 4
  %146 = load i32, ptr %37, align 4
  %147 = add nsw i32 %145, %146
  store i32 %147, ptr %41, align 4
  %148 = load ptr, ptr %39, align 8
  %149 = load i32, ptr %41, align 4
  %150 = sext i32 %149 to i64
  %151 = getelementptr inbounds i16, ptr %148, i64 %150
  %152 = load i16, ptr %151, align 2
  %153 = zext i16 %152 to i32
  store i32 %153, ptr %42, align 4
  %154 = load i32, ptr %42, align 4
  store i32 %154, ptr %43, align 4
  %155 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %156 = load ptr, ptr %155, align 8
  store ptr %156, ptr %44, align 8
  %157 = load ptr, ptr %44, align 8
  store ptr %157, ptr %45, align 8
  %158 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %159 = load i32, ptr %158, align 8
  store i32 %159, ptr %46, align 4
  %160 = load i32, ptr %46, align 4
  %161 = load i32, ptr %27, align 4
  %162 = add nsw i32 %160, %161
  store i32 %162, ptr %47, align 4
  %163 = load ptr, ptr %45, align 8
  %164 = load i32, ptr %47, align 4
  %165 = sext i32 %164 to i64
  %166 = getelementptr inbounds i16, ptr %163, i64 %165
  %167 = load i16, ptr %166, align 2
  %168 = zext i16 %167 to i32
  store i32 %168, ptr %48, align 4
  %169 = load i32, ptr %48, align 4
  store i32 %169, ptr %49, align 4
  %170 = load i32, ptr %43, align 4
  %171 = load i32, ptr %49, align 4
  %172 = icmp ne i32 %170, %171
  br i1 %172, label %173, label %174

173:                                              ; preds = %136
  br label %186

174:                                              ; preds = %136
  %175 = load i32, ptr %27, align 4
  %176 = add nsw i32 %175, 1
  store i32 %176, ptr %50, align 4
  %177 = load i32, ptr %50, align 4
  store i32 %177, ptr %27, align 4
  br label %132

178:                                              ; preds = %132
  %179 = load ptr, ptr %14, align 8
  call void @moonbit_decref_inlined(ptr noundef %179)
  %180 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %181 = load ptr, ptr %180, align 8
  call void @moonbit_decref_inlined(ptr noundef %181)
  %182 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %183 = load ptr, ptr %182, align 8
  call void @moonbit_decref_inlined(ptr noundef %183)
  %184 = load i32, ptr %18, align 4
  %185 = sext i32 %184 to i64
  store i64 %185, ptr %5, align 8
  br label %245

186:                                              ; preds = %173
  %187 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %188 = load ptr, ptr %187, align 8
  store ptr %188, ptr %28, align 8
  %189 = load ptr, ptr %28, align 8
  store ptr %189, ptr %29, align 8
  %190 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %191 = load i32, ptr %190, align 8
  store i32 %191, ptr %30, align 4
  %192 = load i32, ptr %30, align 4
  %193 = load i32, ptr %18, align 4
  %194 = add nsw i32 %192, %193
  store i32 %194, ptr %31, align 4
  %195 = load ptr, ptr %29, align 8
  %196 = load i32, ptr %31, align 4
  %197 = sext i32 %196 to i64
  %198 = getelementptr inbounds i16, ptr %195, i64 %197
  %199 = load i16, ptr %198, align 2
  %200 = zext i16 %199 to i32
  store i32 %200, ptr %32, align 4
  %201 = load i32, ptr %32, align 4
  store i32 %201, ptr %33, align 4
  %202 = load i32, ptr %33, align 4
  %203 = and i32 %202, 255
  store i32 %203, ptr %34, align 4
  %204 = load i32, ptr %34, align 4
  %205 = icmp slt i32 %204, 0
  br i1 %205, label %214, label %206

206:                                              ; preds = %186
  %207 = load i32, ptr %34, align 4
  %208 = load ptr, ptr %14, align 8
  %209 = getelementptr inbounds %struct.moonbit_object, ptr %208, i64 -1
  %210 = getelementptr inbounds %struct.moonbit_object, ptr %209, i32 0, i32 1
  %211 = load i32, ptr %210, align 4
  %212 = and i32 %211, 268435455
  %213 = icmp uge i32 %207, %212
  br i1 %213, label %214, label %215

214:                                              ; preds = %206, %186
  call void @moonbit_panic() #6
  unreachable

215:                                              ; preds = %206
  %216 = load ptr, ptr %14, align 8
  %217 = load i32, ptr %34, align 4
  %218 = sext i32 %217 to i64
  %219 = getelementptr inbounds i32, ptr %216, i64 %218
  %220 = load i32, ptr %219, align 4
  store i32 %220, ptr %35, align 4
  %221 = load i32, ptr %18, align 4
  %222 = load i32, ptr %35, align 4
  %223 = sub nsw i32 %221, %222
  store i32 %223, ptr %36, align 4
  %224 = load i32, ptr %36, align 4
  store i32 %224, ptr %18, align 4
  br label %128

225:                                              ; preds = %128
  %226 = load ptr, ptr %14, align 8
  call void @moonbit_decref_inlined(ptr noundef %226)
  %227 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %228 = load ptr, ptr %227, align 8
  call void @moonbit_decref_inlined(ptr noundef %228)
  %229 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %230 = load ptr, ptr %229, align 8
  call void @moonbit_decref_inlined(ptr noundef %230)
  br label %231

231:                                              ; preds = %225
  br label %232

232:                                              ; preds = %231
  store i64 4294967296, ptr %5, align 8
  br label %245

233:                                              ; preds = %71
  %234 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %235 = load ptr, ptr %234, align 8
  call void @moonbit_decref_inlined(ptr noundef %235)
  %236 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %237 = load ptr, ptr %236, align 8
  call void @moonbit_decref_inlined(ptr noundef %237)
  store i64 4294967296, ptr %5, align 8
  br label %245

238:                                              ; preds = %4
  %239 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %240 = load ptr, ptr %239, align 8
  call void @moonbit_decref_inlined(ptr noundef %240)
  %241 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %242 = load ptr, ptr %241, align 8
  call void @moonbit_decref_inlined(ptr noundef %242)
  %243 = load i32, ptr %10, align 4
  %244 = sext i32 %243 to i64
  store i64 %244, ptr %5, align 8
  br label %245

245:                                              ; preds = %238, %233, %232, %178
  %246 = load i64, ptr %5, align 8
  ret i64 %246
}

declare ptr @moonbit_make_int32_array(i32 noundef, i32 noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @"$moonbitlang$core$builtin$brute_force_find"(i64 %0, ptr %1, i64 %2, ptr %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca %"struct.$StringView", align 8
  %7 = alloca %"struct.$StringView", align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca ptr, align 8
  %29 = alloca ptr, align 8
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  %37 = alloca i32, align 4
  %38 = alloca i32, align 4
  %39 = alloca ptr, align 8
  %40 = alloca ptr, align 8
  %41 = alloca i32, align 4
  %42 = alloca i32, align 4
  %43 = alloca i32, align 4
  %44 = alloca i32, align 4
  %45 = alloca ptr, align 8
  %46 = alloca ptr, align 8
  %47 = alloca i32, align 4
  %48 = alloca i32, align 4
  %49 = alloca i32, align 4
  %50 = alloca i32, align 4
  %51 = alloca i32, align 4
  %52 = alloca i32, align 4
  %53 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  store i64 %0, ptr %53, align 8
  %54 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  store ptr %1, ptr %54, align 8
  %55 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  store i64 %2, ptr %55, align 8
  %56 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  store ptr %3, ptr %56, align 8
  %57 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 1
  %58 = load i32, ptr %57, align 4
  store i32 %58, ptr %8, align 4
  %59 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %60 = load i32, ptr %59, align 8
  store i32 %60, ptr %9, align 4
  %61 = load i32, ptr %8, align 4
  %62 = load i32, ptr %9, align 4
  %63 = sub nsw i32 %61, %62
  store i32 %63, ptr %10, align 4
  %64 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 1
  %65 = load i32, ptr %64, align 4
  store i32 %65, ptr %11, align 4
  %66 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %67 = load i32, ptr %66, align 8
  store i32 %67, ptr %12, align 4
  %68 = load i32, ptr %11, align 4
  %69 = load i32, ptr %12, align 4
  %70 = sub nsw i32 %68, %69
  store i32 %70, ptr %13, align 4
  %71 = load i32, ptr %13, align 4
  %72 = icmp sgt i32 %71, 0
  br i1 %72, label %73, label %215

73:                                               ; preds = %4
  %74 = load i32, ptr %10, align 4
  %75 = load i32, ptr %13, align 4
  %76 = icmp sge i32 %74, %75
  br i1 %76, label %77, label %210

77:                                               ; preds = %73
  store i32 0, ptr %14, align 4
  %78 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %79 = load ptr, ptr %78, align 8
  store ptr %79, ptr %15, align 8
  %80 = load ptr, ptr %15, align 8
  store ptr %80, ptr %16, align 8
  %81 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %82 = load i32, ptr %81, align 8
  store i32 %82, ptr %17, align 4
  %83 = load i32, ptr %17, align 4
  %84 = load i32, ptr %14, align 4
  %85 = add nsw i32 %83, %84
  store i32 %85, ptr %18, align 4
  %86 = load ptr, ptr %16, align 8
  %87 = load i32, ptr %18, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds i16, ptr %86, i64 %88
  %90 = load i16, ptr %89, align 2
  %91 = zext i16 %90 to i32
  store i32 %91, ptr %19, align 4
  %92 = load i32, ptr %19, align 4
  store i32 %92, ptr %20, align 4
  %93 = load i32, ptr %10, align 4
  %94 = load i32, ptr %13, align 4
  %95 = sub nsw i32 %93, %94
  store i32 %95, ptr %21, align 4
  store i32 0, ptr %22, align 4
  br label %96

96:                                               ; preds = %77, %202
  %97 = load i32, ptr %22, align 4
  store i32 %97, ptr %23, align 4
  %98 = load i32, ptr %23, align 4
  %99 = load i32, ptr %21, align 4
  %100 = icmp sle i32 %98, %99
  br i1 %100, label %101, label %203

101:                                              ; preds = %96
  br label %102

102:                                              ; preds = %101, %132
  %103 = load i32, ptr %22, align 4
  store i32 %103, ptr %25, align 4
  %104 = load i32, ptr %25, align 4
  %105 = load i32, ptr %21, align 4
  %106 = icmp sle i32 %104, %105
  br i1 %106, label %107, label %128

107:                                              ; preds = %102
  %108 = load i32, ptr %22, align 4
  store i32 %108, ptr %27, align 4
  %109 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %110 = load ptr, ptr %109, align 8
  store ptr %110, ptr %28, align 8
  %111 = load ptr, ptr %28, align 8
  store ptr %111, ptr %29, align 8
  %112 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %113 = load i32, ptr %112, align 8
  store i32 %113, ptr %30, align 4
  %114 = load i32, ptr %30, align 4
  %115 = load i32, ptr %27, align 4
  %116 = add nsw i32 %114, %115
  store i32 %116, ptr %31, align 4
  %117 = load ptr, ptr %29, align 8
  %118 = load i32, ptr %31, align 4
  %119 = sext i32 %118 to i64
  %120 = getelementptr inbounds i16, ptr %117, i64 %119
  %121 = load i16, ptr %120, align 2
  %122 = zext i16 %121 to i32
  store i32 %122, ptr %32, align 4
  %123 = load i32, ptr %32, align 4
  store i32 %123, ptr %33, align 4
  %124 = load i32, ptr %33, align 4
  %125 = load i32, ptr %20, align 4
  %126 = icmp ne i32 %124, %125
  %127 = zext i1 %126 to i32
  store i32 %127, ptr %26, align 4
  br label %129

128:                                              ; preds = %102
  store i32 0, ptr %26, align 4
  br label %129

129:                                              ; preds = %128, %107
  %130 = load i32, ptr %26, align 4
  %131 = icmp ne i32 %130, 0
  br i1 %131, label %132, label %136

132:                                              ; preds = %129
  %133 = load i32, ptr %22, align 4
  store i32 %133, ptr %34, align 4
  %134 = load i32, ptr %34, align 4
  %135 = add nsw i32 %134, 1
  store i32 %135, ptr %22, align 4
  br label %102

136:                                              ; preds = %129
  br label %137

137:                                              ; preds = %136
  %138 = load i32, ptr %22, align 4
  store i32 %138, ptr %24, align 4
  %139 = load i32, ptr %24, align 4
  %140 = load i32, ptr %21, align 4
  %141 = icmp sle i32 %139, %140
  br i1 %141, label %142, label %202

142:                                              ; preds = %137
  store i32 1, ptr %35, align 4
  br label %143

143:                                              ; preds = %142, %186
  %144 = load i32, ptr %35, align 4
  %145 = load i32, ptr %13, align 4
  %146 = icmp slt i32 %144, %145
  br i1 %146, label %147, label %190

147:                                              ; preds = %143
  %148 = load i32, ptr %22, align 4
  store i32 %148, ptr %37, align 4
  %149 = load i32, ptr %37, align 4
  %150 = load i32, ptr %35, align 4
  %151 = add nsw i32 %149, %150
  store i32 %151, ptr %38, align 4
  %152 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %153 = load ptr, ptr %152, align 8
  store ptr %153, ptr %39, align 8
  %154 = load ptr, ptr %39, align 8
  store ptr %154, ptr %40, align 8
  %155 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %156 = load i32, ptr %155, align 8
  store i32 %156, ptr %41, align 4
  %157 = load i32, ptr %41, align 4
  %158 = load i32, ptr %38, align 4
  %159 = add nsw i32 %157, %158
  store i32 %159, ptr %42, align 4
  %160 = load ptr, ptr %40, align 8
  %161 = load i32, ptr %42, align 4
  %162 = sext i32 %161 to i64
  %163 = getelementptr inbounds i16, ptr %160, i64 %162
  %164 = load i16, ptr %163, align 2
  %165 = zext i16 %164 to i32
  store i32 %165, ptr %43, align 4
  %166 = load i32, ptr %43, align 4
  store i32 %166, ptr %44, align 4
  %167 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %168 = load ptr, ptr %167, align 8
  store ptr %168, ptr %45, align 8
  %169 = load ptr, ptr %45, align 8
  store ptr %169, ptr %46, align 8
  %170 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %171 = load i32, ptr %170, align 8
  store i32 %171, ptr %47, align 4
  %172 = load i32, ptr %47, align 4
  %173 = load i32, ptr %35, align 4
  %174 = add nsw i32 %172, %173
  store i32 %174, ptr %48, align 4
  %175 = load ptr, ptr %46, align 8
  %176 = load i32, ptr %48, align 4
  %177 = sext i32 %176 to i64
  %178 = getelementptr inbounds i16, ptr %175, i64 %177
  %179 = load i16, ptr %178, align 2
  %180 = zext i16 %179 to i32
  store i32 %180, ptr %49, align 4
  %181 = load i32, ptr %49, align 4
  store i32 %181, ptr %50, align 4
  %182 = load i32, ptr %44, align 4
  %183 = load i32, ptr %50, align 4
  %184 = icmp ne i32 %182, %183
  br i1 %184, label %185, label %186

185:                                              ; preds = %147
  br label %198

186:                                              ; preds = %147
  %187 = load i32, ptr %35, align 4
  %188 = add nsw i32 %187, 1
  store i32 %188, ptr %51, align 4
  %189 = load i32, ptr %51, align 4
  store i32 %189, ptr %35, align 4
  br label %143

190:                                              ; preds = %143
  %191 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %192 = load ptr, ptr %191, align 8
  call void @moonbit_decref_inlined(ptr noundef %192)
  %193 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %194 = load ptr, ptr %193, align 8
  call void @moonbit_decref_inlined(ptr noundef %194)
  %195 = load i32, ptr %22, align 4
  store i32 %195, ptr %52, align 4
  %196 = load i32, ptr %52, align 4
  %197 = sext i32 %196 to i64
  store i64 %197, ptr %5, align 8
  br label %221

198:                                              ; preds = %185
  %199 = load i32, ptr %22, align 4
  store i32 %199, ptr %36, align 4
  %200 = load i32, ptr %36, align 4
  %201 = add nsw i32 %200, 1
  store i32 %201, ptr %22, align 4
  br label %202

202:                                              ; preds = %198, %137
  br label %96

203:                                              ; preds = %96
  %204 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %205 = load ptr, ptr %204, align 8
  call void @moonbit_decref_inlined(ptr noundef %205)
  %206 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %207 = load ptr, ptr %206, align 8
  call void @moonbit_decref_inlined(ptr noundef %207)
  br label %208

208:                                              ; preds = %203
  br label %209

209:                                              ; preds = %208
  store i64 4294967296, ptr %5, align 8
  br label %221

210:                                              ; preds = %73
  %211 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %212 = load ptr, ptr %211, align 8
  call void @moonbit_decref_inlined(ptr noundef %212)
  %213 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %214 = load ptr, ptr %213, align 8
  call void @moonbit_decref_inlined(ptr noundef %214)
  store i64 4294967296, ptr %5, align 8
  br label %221

215:                                              ; preds = %4
  %216 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %217 = load ptr, ptr %216, align 8
  call void @moonbit_decref_inlined(ptr noundef %217)
  %218 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %219 = load ptr, ptr %218, align 8
  call void @moonbit_decref_inlined(ptr noundef %219)
  %220 = load i64, ptr @"$moonbitlang$core$builtin$brute_force_find$constr$69", align 8
  store i64 %220, ptr %5, align 8
  br label %221

221:                                              ; preds = %215, %210, %209, %190
  %222 = load i64, ptr %5, align 8
  ret i64 %222
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @"$moonbitlang$core$builtin$boyer_moore_horspool_find"(i64 %0, ptr %1, i64 %2, ptr %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca %"struct.$StringView", align 8
  %7 = alloca %"struct.$StringView", align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca ptr, align 8
  %19 = alloca ptr, align 8
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca ptr, align 8
  %34 = alloca ptr, align 8
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  %37 = alloca i32, align 4
  %38 = alloca i32, align 4
  %39 = alloca i32, align 4
  %40 = alloca i32, align 4
  %41 = alloca i32, align 4
  %42 = alloca i32, align 4
  %43 = alloca ptr, align 8
  %44 = alloca ptr, align 8
  %45 = alloca i32, align 4
  %46 = alloca i32, align 4
  %47 = alloca i32, align 4
  %48 = alloca i32, align 4
  %49 = alloca ptr, align 8
  %50 = alloca ptr, align 8
  %51 = alloca i32, align 4
  %52 = alloca i32, align 4
  %53 = alloca i32, align 4
  %54 = alloca i32, align 4
  %55 = alloca i32, align 4
  %56 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 0
  store i64 %0, ptr %56, align 8
  %57 = getelementptr inbounds { i64, ptr }, ptr %6, i32 0, i32 1
  store ptr %1, ptr %57, align 8
  %58 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 0
  store i64 %2, ptr %58, align 8
  %59 = getelementptr inbounds { i64, ptr }, ptr %7, i32 0, i32 1
  store ptr %3, ptr %59, align 8
  %60 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 1
  %61 = load i32, ptr %60, align 4
  store i32 %61, ptr %8, align 4
  %62 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %63 = load i32, ptr %62, align 8
  store i32 %63, ptr %9, align 4
  %64 = load i32, ptr %8, align 4
  %65 = load i32, ptr %9, align 4
  %66 = sub nsw i32 %64, %65
  store i32 %66, ptr %10, align 4
  %67 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 1
  %68 = load i32, ptr %67, align 4
  store i32 %68, ptr %11, align 4
  %69 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %70 = load i32, ptr %69, align 8
  store i32 %70, ptr %12, align 4
  %71 = load i32, ptr %11, align 4
  %72 = load i32, ptr %12, align 4
  %73 = sub nsw i32 %71, %72
  store i32 %73, ptr %13, align 4
  %74 = load i32, ptr %13, align 4
  %75 = icmp sgt i32 %74, 0
  br i1 %75, label %76, label %255

76:                                               ; preds = %4
  %77 = load i32, ptr %10, align 4
  %78 = load i32, ptr %13, align 4
  %79 = icmp sge i32 %77, %78
  br i1 %79, label %80, label %250

80:                                               ; preds = %76
  %81 = load i32, ptr %13, align 4
  %82 = call ptr @moonbit_make_int32_array(i32 noundef 256, i32 noundef %81)
  store ptr %82, ptr %14, align 8
  %83 = load i32, ptr %13, align 4
  %84 = sub nsw i32 %83, 1
  store i32 %84, ptr %15, align 4
  store i32 0, ptr %16, align 4
  br label %85

85:                                               ; preds = %80, %123
  %86 = load i32, ptr %16, align 4
  %87 = load i32, ptr %15, align 4
  %88 = icmp slt i32 %86, %87
  br i1 %88, label %89, label %132

89:                                               ; preds = %85
  %90 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %91 = load ptr, ptr %90, align 8
  store ptr %91, ptr %18, align 8
  %92 = load ptr, ptr %18, align 8
  store ptr %92, ptr %19, align 8
  %93 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %94 = load i32, ptr %93, align 8
  store i32 %94, ptr %20, align 4
  %95 = load i32, ptr %20, align 4
  %96 = load i32, ptr %16, align 4
  %97 = add nsw i32 %95, %96
  store i32 %97, ptr %21, align 4
  %98 = load ptr, ptr %19, align 8
  %99 = load i32, ptr %21, align 4
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds i16, ptr %98, i64 %100
  %102 = load i16, ptr %101, align 2
  %103 = zext i16 %102 to i32
  store i32 %103, ptr %22, align 4
  %104 = load i32, ptr %22, align 4
  store i32 %104, ptr %23, align 4
  %105 = load i32, ptr %23, align 4
  %106 = and i32 %105, 255
  store i32 %106, ptr %24, align 4
  %107 = load i32, ptr %13, align 4
  %108 = sub nsw i32 %107, 1
  store i32 %108, ptr %25, align 4
  %109 = load i32, ptr %25, align 4
  %110 = load i32, ptr %16, align 4
  %111 = sub nsw i32 %109, %110
  store i32 %111, ptr %26, align 4
  %112 = load i32, ptr %24, align 4
  %113 = icmp slt i32 %112, 0
  br i1 %113, label %122, label %114

114:                                              ; preds = %89
  %115 = load i32, ptr %24, align 4
  %116 = load ptr, ptr %14, align 8
  %117 = getelementptr inbounds %struct.moonbit_object, ptr %116, i64 -1
  %118 = getelementptr inbounds %struct.moonbit_object, ptr %117, i32 0, i32 1
  %119 = load i32, ptr %118, align 4
  %120 = and i32 %119, 268435455
  %121 = icmp uge i32 %115, %120
  br i1 %121, label %122, label %123

122:                                              ; preds = %114, %89
  call void @moonbit_panic() #6
  unreachable

123:                                              ; preds = %114
  %124 = load i32, ptr %26, align 4
  %125 = load ptr, ptr %14, align 8
  %126 = load i32, ptr %24, align 4
  %127 = sext i32 %126 to i64
  %128 = getelementptr inbounds i32, ptr %125, i64 %127
  store i32 %124, ptr %128, align 4
  %129 = load i32, ptr %16, align 4
  %130 = add nsw i32 %129, 1
  store i32 %130, ptr %27, align 4
  %131 = load i32, ptr %27, align 4
  store i32 %131, ptr %16, align 4
  br label %85

132:                                              ; preds = %85
  br label %133

133:                                              ; preds = %132
  store i32 0, ptr %17, align 4
  br label %134

134:                                              ; preds = %133, %232
  %135 = load i32, ptr %10, align 4
  %136 = load i32, ptr %13, align 4
  %137 = sub nsw i32 %135, %136
  store i32 %137, ptr %28, align 4
  %138 = load i32, ptr %17, align 4
  %139 = load i32, ptr %28, align 4
  %140 = icmp sle i32 %138, %139
  br i1 %140, label %141, label %242

141:                                              ; preds = %134
  %142 = load i32, ptr %13, align 4
  %143 = sub nsw i32 %142, 1
  store i32 %143, ptr %29, align 4
  store i32 0, ptr %30, align 4
  br label %144

144:                                              ; preds = %141, %186
  %145 = load i32, ptr %30, align 4
  %146 = load i32, ptr %29, align 4
  %147 = icmp sle i32 %145, %146
  br i1 %147, label %148, label %190

148:                                              ; preds = %144
  %149 = load i32, ptr %17, align 4
  %150 = load i32, ptr %30, align 4
  %151 = add nsw i32 %149, %150
  store i32 %151, ptr %42, align 4
  %152 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %153 = load ptr, ptr %152, align 8
  store ptr %153, ptr %43, align 8
  %154 = load ptr, ptr %43, align 8
  store ptr %154, ptr %44, align 8
  %155 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %156 = load i32, ptr %155, align 8
  store i32 %156, ptr %45, align 4
  %157 = load i32, ptr %45, align 4
  %158 = load i32, ptr %42, align 4
  %159 = add nsw i32 %157, %158
  store i32 %159, ptr %46, align 4
  %160 = load ptr, ptr %44, align 8
  %161 = load i32, ptr %46, align 4
  %162 = sext i32 %161 to i64
  %163 = getelementptr inbounds i16, ptr %160, i64 %162
  %164 = load i16, ptr %163, align 2
  %165 = zext i16 %164 to i32
  store i32 %165, ptr %47, align 4
  %166 = load i32, ptr %47, align 4
  store i32 %166, ptr %48, align 4
  %167 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %168 = load ptr, ptr %167, align 8
  store ptr %168, ptr %49, align 8
  %169 = load ptr, ptr %49, align 8
  store ptr %169, ptr %50, align 8
  %170 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 0
  %171 = load i32, ptr %170, align 8
  store i32 %171, ptr %51, align 4
  %172 = load i32, ptr %51, align 4
  %173 = load i32, ptr %30, align 4
  %174 = add nsw i32 %172, %173
  store i32 %174, ptr %52, align 4
  %175 = load ptr, ptr %50, align 8
  %176 = load i32, ptr %52, align 4
  %177 = sext i32 %176 to i64
  %178 = getelementptr inbounds i16, ptr %175, i64 %177
  %179 = load i16, ptr %178, align 2
  %180 = zext i16 %179 to i32
  store i32 %180, ptr %53, align 4
  %181 = load i32, ptr %53, align 4
  store i32 %181, ptr %54, align 4
  %182 = load i32, ptr %48, align 4
  %183 = load i32, ptr %54, align 4
  %184 = icmp ne i32 %182, %183
  br i1 %184, label %185, label %186

185:                                              ; preds = %148
  br label %198

186:                                              ; preds = %148
  %187 = load i32, ptr %30, align 4
  %188 = add nsw i32 %187, 1
  store i32 %188, ptr %55, align 4
  %189 = load i32, ptr %55, align 4
  store i32 %189, ptr %30, align 4
  br label %144

190:                                              ; preds = %144
  %191 = load ptr, ptr %14, align 8
  call void @moonbit_decref_inlined(ptr noundef %191)
  %192 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %193 = load ptr, ptr %192, align 8
  call void @moonbit_decref_inlined(ptr noundef %193)
  %194 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %195 = load ptr, ptr %194, align 8
  call void @moonbit_decref_inlined(ptr noundef %195)
  %196 = load i32, ptr %17, align 4
  %197 = sext i32 %196 to i64
  store i64 %197, ptr %5, align 8
  br label %261

198:                                              ; preds = %185
  %199 = load i32, ptr %17, align 4
  %200 = load i32, ptr %13, align 4
  %201 = add nsw i32 %199, %200
  store i32 %201, ptr %31, align 4
  %202 = load i32, ptr %31, align 4
  %203 = sub nsw i32 %202, 1
  store i32 %203, ptr %32, align 4
  %204 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %205 = load ptr, ptr %204, align 8
  store ptr %205, ptr %33, align 8
  %206 = load ptr, ptr %33, align 8
  store ptr %206, ptr %34, align 8
  %207 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 0
  %208 = load i32, ptr %207, align 8
  store i32 %208, ptr %35, align 4
  %209 = load i32, ptr %35, align 4
  %210 = load i32, ptr %32, align 4
  %211 = add nsw i32 %209, %210
  store i32 %211, ptr %36, align 4
  %212 = load ptr, ptr %34, align 8
  %213 = load i32, ptr %36, align 4
  %214 = sext i32 %213 to i64
  %215 = getelementptr inbounds i16, ptr %212, i64 %214
  %216 = load i16, ptr %215, align 2
  %217 = zext i16 %216 to i32
  store i32 %217, ptr %37, align 4
  %218 = load i32, ptr %37, align 4
  store i32 %218, ptr %38, align 4
  %219 = load i32, ptr %38, align 4
  %220 = and i32 %219, 255
  store i32 %220, ptr %39, align 4
  %221 = load i32, ptr %39, align 4
  %222 = icmp slt i32 %221, 0
  br i1 %222, label %231, label %223

223:                                              ; preds = %198
  %224 = load i32, ptr %39, align 4
  %225 = load ptr, ptr %14, align 8
  %226 = getelementptr inbounds %struct.moonbit_object, ptr %225, i64 -1
  %227 = getelementptr inbounds %struct.moonbit_object, ptr %226, i32 0, i32 1
  %228 = load i32, ptr %227, align 4
  %229 = and i32 %228, 268435455
  %230 = icmp uge i32 %224, %229
  br i1 %230, label %231, label %232

231:                                              ; preds = %223, %198
  call void @moonbit_panic() #6
  unreachable

232:                                              ; preds = %223
  %233 = load ptr, ptr %14, align 8
  %234 = load i32, ptr %39, align 4
  %235 = sext i32 %234 to i64
  %236 = getelementptr inbounds i32, ptr %233, i64 %235
  %237 = load i32, ptr %236, align 4
  store i32 %237, ptr %40, align 4
  %238 = load i32, ptr %17, align 4
  %239 = load i32, ptr %40, align 4
  %240 = add nsw i32 %238, %239
  store i32 %240, ptr %41, align 4
  %241 = load i32, ptr %41, align 4
  store i32 %241, ptr %17, align 4
  br label %134

242:                                              ; preds = %134
  %243 = load ptr, ptr %14, align 8
  call void @moonbit_decref_inlined(ptr noundef %243)
  %244 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %245 = load ptr, ptr %244, align 8
  call void @moonbit_decref_inlined(ptr noundef %245)
  %246 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %247 = load ptr, ptr %246, align 8
  call void @moonbit_decref_inlined(ptr noundef %247)
  br label %248

248:                                              ; preds = %242
  br label %249

249:                                              ; preds = %248
  store i64 4294967296, ptr %5, align 8
  br label %261

250:                                              ; preds = %76
  %251 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %252 = load ptr, ptr %251, align 8
  call void @moonbit_decref_inlined(ptr noundef %252)
  %253 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %254 = load ptr, ptr %253, align 8
  call void @moonbit_decref_inlined(ptr noundef %254)
  store i64 4294967296, ptr %5, align 8
  br label %261

255:                                              ; preds = %4
  %256 = getelementptr inbounds %"struct.$StringView", ptr %7, i32 0, i32 2
  %257 = load ptr, ptr %256, align 8
  call void @moonbit_decref_inlined(ptr noundef %257)
  %258 = getelementptr inbounds %"struct.$StringView", ptr %6, i32 0, i32 2
  %259 = load ptr, ptr %258, align 8
  call void @moonbit_decref_inlined(ptr noundef %259)
  %260 = load i64, ptr @"$moonbitlang$core$builtin$boyer_moore_horspool_find$constr$55", align 8
  store i64 %260, ptr %5, align 8
  br label %261

261:                                              ; preds = %255, %250, %249, %190
  %262 = load i64, ptr %5, align 8
  ret i64 %262
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$StringView$$unsafe_charcode_at"(i64 %0, ptr %1, i32 noundef %2) #0 {
  %4 = alloca %"struct.$StringView", align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 0
  store i64 %0, ptr %12, align 8
  %13 = getelementptr inbounds { i64, ptr }, ptr %4, i32 0, i32 1
  store ptr %1, ptr %13, align 8
  store i32 %2, ptr %5, align 4
  %14 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 2
  %15 = load ptr, ptr %14, align 8
  store ptr %15, ptr %6, align 8
  %16 = load ptr, ptr %6, align 8
  store ptr %16, ptr %7, align 8
  %17 = getelementptr inbounds %"struct.$StringView", ptr %4, i32 0, i32 0
  %18 = load i32, ptr %17, align 8
  store i32 %18, ptr %8, align 4
  %19 = load i32, ptr %8, align 4
  store i32 %19, ptr %9, align 4
  %20 = load i32, ptr %9, align 4
  %21 = load i32, ptr %5, align 4
  %22 = add nsw i32 %20, %21
  store i32 %22, ptr %10, align 4
  %23 = load ptr, ptr %7, align 8
  %24 = load i32, ptr %10, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i16, ptr %23, i64 %25
  %27 = load i16, ptr %26, align 2
  %28 = zext i16 %27 to i32
  store i32 %28, ptr %11, align 4
  %29 = load ptr, ptr %7, align 8
  call void @moonbit_decref_inlined(ptr noundef %29)
  %30 = load i32, ptr %11, align 4
  ret i32 %30
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$StringView$$length"(i64 %0, ptr %1) #0 {
  %3 = alloca %"struct.$StringView", align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = getelementptr inbounds { i64, ptr }, ptr %3, i32 0, i32 0
  store i64 %0, ptr %7, align 8
  %8 = getelementptr inbounds { i64, ptr }, ptr %3, i32 0, i32 1
  store ptr %1, ptr %8, align 8
  %9 = getelementptr inbounds %"struct.$StringView", ptr %3, i32 0, i32 1
  %10 = load i32, ptr %9, align 4
  store i32 %10, ptr %4, align 4
  %11 = getelementptr inbounds %"struct.$StringView", ptr %3, i32 0, i32 0
  %12 = load i32, ptr %11, align 8
  store i32 %12, ptr %5, align 4
  %13 = getelementptr inbounds %"struct.$StringView", ptr %3, i32 0, i32 2
  %14 = load ptr, ptr %13, align 8
  call void @moonbit_decref_inlined(ptr noundef %14)
  %15 = load i32, ptr %5, align 4
  store i32 %15, ptr %6, align 4
  %16 = load i32, ptr %4, align 4
  %17 = load i32, ptr %6, align 4
  %18 = sub nsw i32 %16, %17
  ret i32 %18
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$Int$$is_trailing_surrogate"(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp sle i32 56320, %3
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load i32, ptr %2, align 4
  %7 = icmp sle i32 %6, 57343
  br label %8

8:                                                ; preds = %5, %1
  %9 = phi i1 [ false, %1 ], [ %7, %5 ]
  %10 = zext i1 %9 to i32
  ret i32 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$Int$$is_leading_surrogate"(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp sle i32 55296, %3
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load i32, ptr %2, align 4
  %7 = icmp sle i32 %6, 56319
  br label %8

8:                                                ; preds = %5, %1
  %9 = phi i1 [ false, %1 ], [ %7, %5 ]
  %10 = zext i1 %9 to i32
  ret i32 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Logger$$$moonbitlang$core$builtin$StringBuilder$$write_char"(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %13, i32 0, i32 0
  %15 = load i32, ptr %14, align 8
  store i32 %15, ptr %5, align 4
  %16 = load i32, ptr %5, align 4
  %17 = add nsw i32 %16, 4
  store i32 %17, ptr %6, align 4
  %18 = load ptr, ptr %3, align 8
  call void @moonbit_incref_inlined(ptr noundef %18)
  %19 = load ptr, ptr %3, align 8
  %20 = load i32, ptr %6, align 4
  %21 = call i32 @"$$moonbitlang$core$builtin$StringBuilder$$grow_if_necessary"(ptr noundef %19, i32 noundef %20)
  %22 = load ptr, ptr %3, align 8
  %23 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %22, i32 0, i32 1
  %24 = load ptr, ptr %23, align 8
  store ptr %24, ptr %7, align 8
  %25 = load ptr, ptr %7, align 8
  store ptr %25, ptr %8, align 8
  %26 = load ptr, ptr %3, align 8
  %27 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %26, i32 0, i32 0
  %28 = load i32, ptr %27, align 8
  store i32 %28, ptr %9, align 4
  %29 = load ptr, ptr %8, align 8
  call void @moonbit_incref_inlined(ptr noundef %29)
  %30 = load ptr, ptr %8, align 8
  %31 = load i32, ptr %9, align 4
  %32 = load i32, ptr %4, align 4
  %33 = call i32 @"$FixedArray$$set_utf16le_char"(ptr noundef %30, i32 noundef %31, i32 noundef %32)
  store i32 %33, ptr %10, align 4
  %34 = load ptr, ptr %3, align 8
  %35 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %34, i32 0, i32 0
  %36 = load i32, ptr %35, align 8
  store i32 %36, ptr %11, align 4
  %37 = load i32, ptr %11, align 4
  %38 = load i32, ptr %10, align 4
  %39 = add nsw i32 %37, %38
  store i32 %39, ptr %12, align 4
  %40 = load i32, ptr %12, align 4
  %41 = load ptr, ptr %3, align 8
  %42 = getelementptr inbounds %"struct.$$moonbitlang$core$builtin$StringBuilder", ptr %41, i32 0, i32 0
  store i32 %40, ptr %42, align 8
  %43 = load ptr, ptr %3, align 8
  call void @moonbit_decref_inlined(ptr noundef %43)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$FixedArray$$set_utf16le_char"(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  %37 = load i32, ptr %7, align 4
  store i32 %37, ptr %8, align 4
  %38 = load i32, ptr %8, align 4
  store i32 %38, ptr %9, align 4
  %39 = load i32, ptr %9, align 4
  %40 = icmp ult i32 %39, 65536
  br i1 %40, label %41, label %91

41:                                               ; preds = %3
  %42 = load i32, ptr %9, align 4
  %43 = and i32 %42, 255
  store i32 %43, ptr %10, align 4
  %44 = load i32, ptr %10, align 4
  store i32 %44, ptr %11, align 4
  %45 = load i32, ptr %11, align 4
  %46 = and i32 %45, 255
  store i32 %46, ptr %12, align 4
  %47 = load i32, ptr %6, align 4
  %48 = icmp slt i32 %47, 0
  br i1 %48, label %57, label %49

49:                                               ; preds = %41
  %50 = load i32, ptr %6, align 4
  %51 = load ptr, ptr %5, align 8
  %52 = getelementptr inbounds %struct.moonbit_object, ptr %51, i64 -1
  %53 = getelementptr inbounds %struct.moonbit_object, ptr %52, i32 0, i32 1
  %54 = load i32, ptr %53, align 4
  %55 = and i32 %54, 268435455
  %56 = icmp uge i32 %50, %55
  br i1 %56, label %57, label %58

57:                                               ; preds = %49, %41
  call void @moonbit_panic() #6
  unreachable

58:                                               ; preds = %49
  %59 = load i32, ptr %12, align 4
  %60 = trunc i32 %59 to i8
  %61 = load ptr, ptr %5, align 8
  %62 = load i32, ptr %6, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds i8, ptr %61, i64 %63
  store i8 %60, ptr %64, align 1
  %65 = load i32, ptr %6, align 4
  %66 = add nsw i32 %65, 1
  store i32 %66, ptr %13, align 4
  %67 = load i32, ptr %9, align 4
  %68 = lshr i32 %67, 8
  store i32 %68, ptr %14, align 4
  %69 = load i32, ptr %14, align 4
  store i32 %69, ptr %15, align 4
  %70 = load i32, ptr %15, align 4
  %71 = and i32 %70, 255
  store i32 %71, ptr %16, align 4
  %72 = load i32, ptr %13, align 4
  %73 = icmp slt i32 %72, 0
  br i1 %73, label %82, label %74

74:                                               ; preds = %58
  %75 = load i32, ptr %13, align 4
  %76 = load ptr, ptr %5, align 8
  %77 = getelementptr inbounds %struct.moonbit_object, ptr %76, i64 -1
  %78 = getelementptr inbounds %struct.moonbit_object, ptr %77, i32 0, i32 1
  %79 = load i32, ptr %78, align 4
  %80 = and i32 %79, 268435455
  %81 = icmp uge i32 %75, %80
  br i1 %81, label %82, label %83

82:                                               ; preds = %74, %58
  call void @moonbit_panic() #6
  unreachable

83:                                               ; preds = %74
  %84 = load i32, ptr %16, align 4
  %85 = trunc i32 %84 to i8
  %86 = load ptr, ptr %5, align 8
  %87 = load i32, ptr %13, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds i8, ptr %86, i64 %88
  store i8 %85, ptr %89, align 1
  %90 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %90)
  store i32 2, ptr %4, align 4
  br label %207

91:                                               ; preds = %3
  %92 = load i32, ptr %9, align 4
  %93 = icmp ult i32 %92, 1114112
  br i1 %93, label %94, label %204

94:                                               ; preds = %91
  %95 = load i32, ptr %9, align 4
  %96 = sub i32 %95, 65536
  store i32 %96, ptr %17, align 4
  %97 = load i32, ptr %17, align 4
  %98 = lshr i32 %97, 10
  store i32 %98, ptr %18, align 4
  %99 = load i32, ptr %18, align 4
  %100 = or i32 %99, 55296
  store i32 %100, ptr %19, align 4
  %101 = load i32, ptr %17, align 4
  %102 = and i32 %101, 1023
  store i32 %102, ptr %20, align 4
  %103 = load i32, ptr %20, align 4
  %104 = or i32 %103, 56320
  store i32 %104, ptr %21, align 4
  %105 = load i32, ptr %19, align 4
  %106 = and i32 %105, 255
  store i32 %106, ptr %22, align 4
  %107 = load i32, ptr %22, align 4
  store i32 %107, ptr %23, align 4
  %108 = load i32, ptr %23, align 4
  %109 = and i32 %108, 255
  store i32 %109, ptr %24, align 4
  %110 = load i32, ptr %6, align 4
  %111 = icmp slt i32 %110, 0
  br i1 %111, label %120, label %112

112:                                              ; preds = %94
  %113 = load i32, ptr %6, align 4
  %114 = load ptr, ptr %5, align 8
  %115 = getelementptr inbounds %struct.moonbit_object, ptr %114, i64 -1
  %116 = getelementptr inbounds %struct.moonbit_object, ptr %115, i32 0, i32 1
  %117 = load i32, ptr %116, align 4
  %118 = and i32 %117, 268435455
  %119 = icmp uge i32 %113, %118
  br i1 %119, label %120, label %121

120:                                              ; preds = %112, %94
  call void @moonbit_panic() #6
  unreachable

121:                                              ; preds = %112
  %122 = load i32, ptr %24, align 4
  %123 = trunc i32 %122 to i8
  %124 = load ptr, ptr %5, align 8
  %125 = load i32, ptr %6, align 4
  %126 = sext i32 %125 to i64
  %127 = getelementptr inbounds i8, ptr %124, i64 %126
  store i8 %123, ptr %127, align 1
  %128 = load i32, ptr %6, align 4
  %129 = add nsw i32 %128, 1
  store i32 %129, ptr %25, align 4
  %130 = load i32, ptr %19, align 4
  %131 = lshr i32 %130, 8
  store i32 %131, ptr %26, align 4
  %132 = load i32, ptr %26, align 4
  store i32 %132, ptr %27, align 4
  %133 = load i32, ptr %27, align 4
  %134 = and i32 %133, 255
  store i32 %134, ptr %28, align 4
  %135 = load i32, ptr %25, align 4
  %136 = icmp slt i32 %135, 0
  br i1 %136, label %145, label %137

137:                                              ; preds = %121
  %138 = load i32, ptr %25, align 4
  %139 = load ptr, ptr %5, align 8
  %140 = getelementptr inbounds %struct.moonbit_object, ptr %139, i64 -1
  %141 = getelementptr inbounds %struct.moonbit_object, ptr %140, i32 0, i32 1
  %142 = load i32, ptr %141, align 4
  %143 = and i32 %142, 268435455
  %144 = icmp uge i32 %138, %143
  br i1 %144, label %145, label %146

145:                                              ; preds = %137, %121
  call void @moonbit_panic() #6
  unreachable

146:                                              ; preds = %137
  %147 = load i32, ptr %28, align 4
  %148 = trunc i32 %147 to i8
  %149 = load ptr, ptr %5, align 8
  %150 = load i32, ptr %25, align 4
  %151 = sext i32 %150 to i64
  %152 = getelementptr inbounds i8, ptr %149, i64 %151
  store i8 %148, ptr %152, align 1
  %153 = load i32, ptr %6, align 4
  %154 = add nsw i32 %153, 2
  store i32 %154, ptr %29, align 4
  %155 = load i32, ptr %21, align 4
  %156 = and i32 %155, 255
  store i32 %156, ptr %30, align 4
  %157 = load i32, ptr %30, align 4
  store i32 %157, ptr %31, align 4
  %158 = load i32, ptr %31, align 4
  %159 = and i32 %158, 255
  store i32 %159, ptr %32, align 4
  %160 = load i32, ptr %29, align 4
  %161 = icmp slt i32 %160, 0
  br i1 %161, label %170, label %162

162:                                              ; preds = %146
  %163 = load i32, ptr %29, align 4
  %164 = load ptr, ptr %5, align 8
  %165 = getelementptr inbounds %struct.moonbit_object, ptr %164, i64 -1
  %166 = getelementptr inbounds %struct.moonbit_object, ptr %165, i32 0, i32 1
  %167 = load i32, ptr %166, align 4
  %168 = and i32 %167, 268435455
  %169 = icmp uge i32 %163, %168
  br i1 %169, label %170, label %171

170:                                              ; preds = %162, %146
  call void @moonbit_panic() #6
  unreachable

171:                                              ; preds = %162
  %172 = load i32, ptr %32, align 4
  %173 = trunc i32 %172 to i8
  %174 = load ptr, ptr %5, align 8
  %175 = load i32, ptr %29, align 4
  %176 = sext i32 %175 to i64
  %177 = getelementptr inbounds i8, ptr %174, i64 %176
  store i8 %173, ptr %177, align 1
  %178 = load i32, ptr %6, align 4
  %179 = add nsw i32 %178, 3
  store i32 %179, ptr %33, align 4
  %180 = load i32, ptr %21, align 4
  %181 = lshr i32 %180, 8
  store i32 %181, ptr %34, align 4
  %182 = load i32, ptr %34, align 4
  store i32 %182, ptr %35, align 4
  %183 = load i32, ptr %35, align 4
  %184 = and i32 %183, 255
  store i32 %184, ptr %36, align 4
  %185 = load i32, ptr %33, align 4
  %186 = icmp slt i32 %185, 0
  br i1 %186, label %195, label %187

187:                                              ; preds = %171
  %188 = load i32, ptr %33, align 4
  %189 = load ptr, ptr %5, align 8
  %190 = getelementptr inbounds %struct.moonbit_object, ptr %189, i64 -1
  %191 = getelementptr inbounds %struct.moonbit_object, ptr %190, i32 0, i32 1
  %192 = load i32, ptr %191, align 4
  %193 = and i32 %192, 268435455
  %194 = icmp uge i32 %188, %193
  br i1 %194, label %195, label %196

195:                                              ; preds = %187, %171
  call void @moonbit_panic() #6
  unreachable

196:                                              ; preds = %187
  %197 = load i32, ptr %36, align 4
  %198 = trunc i32 %197 to i8
  %199 = load ptr, ptr %5, align 8
  %200 = load i32, ptr %33, align 4
  %201 = sext i32 %200 to i64
  %202 = getelementptr inbounds i8, ptr %199, i64 %201
  store i8 %198, ptr %202, align 1
  %203 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %203)
  store i32 4, ptr %4, align 4
  br label %207

204:                                              ; preds = %91
  %205 = load ptr, ptr %5, align 8
  call void @moonbit_decref_inlined(ptr noundef %205)
  %206 = call i32 @"$moonbitlang$core$builtin$abort$1"(ptr noundef getelementptr inbounds (%struct.anon.7, ptr @moonbit_string_literal_13, i32 0, i32 2), ptr noundef getelementptr inbounds (%struct.anon.3, ptr @moonbit_string_literal_14, i32 0, i32 2))
  store i32 %206, ptr %4, align 4
  br label %207

207:                                              ; preds = %204, %196, %83
  %208 = load i32, ptr %4, align 4
  ret i32 %208
}

declare ptr @moonbit_make_bytes(i32 noundef, i32 noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$FixedArray$$unsafe_blit$0"(ptr noundef %0, i32 noundef %1, ptr noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store i32 %1, ptr %7, align 4
  store ptr %2, ptr %8, align 8
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  %22 = load ptr, ptr %6, align 8
  %23 = load ptr, ptr %8, align 8
  %24 = icmp eq ptr %22, %23
  br i1 %24, label %25, label %85

25:                                               ; preds = %5
  %26 = load i32, ptr %7, align 4
  %27 = load i32, ptr %9, align 4
  %28 = icmp slt i32 %26, %27
  br i1 %28, label %29, label %85

29:                                               ; preds = %25
  store i32 0, ptr %11, align 4
  br label %30

30:                                               ; preds = %29, %70
  %31 = load i32, ptr %11, align 4
  %32 = load i32, ptr %10, align 4
  %33 = icmp slt i32 %31, %32
  br i1 %33, label %34, label %80

34:                                               ; preds = %30
  %35 = load i32, ptr %7, align 4
  %36 = load i32, ptr %11, align 4
  %37 = add nsw i32 %35, %36
  store i32 %37, ptr %12, align 4
  %38 = load i32, ptr %9, align 4
  %39 = load i32, ptr %11, align 4
  %40 = add nsw i32 %38, %39
  store i32 %40, ptr %13, align 4
  %41 = load i32, ptr %13, align 4
  %42 = icmp slt i32 %41, 0
  br i1 %42, label %51, label %43

43:                                               ; preds = %34
  %44 = load i32, ptr %13, align 4
  %45 = load ptr, ptr %8, align 8
  %46 = getelementptr inbounds %struct.moonbit_object, ptr %45, i64 -1
  %47 = getelementptr inbounds %struct.moonbit_object, ptr %46, i32 0, i32 1
  %48 = load i32, ptr %47, align 4
  %49 = and i32 %48, 268435455
  %50 = icmp uge i32 %44, %49
  br i1 %50, label %51, label %52

51:                                               ; preds = %43, %34
  call void @moonbit_panic() #6
  unreachable

52:                                               ; preds = %43
  %53 = load ptr, ptr %8, align 8
  %54 = load i32, ptr %13, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds i8, ptr %53, i64 %55
  %57 = load i8, ptr %56, align 1
  %58 = zext i8 %57 to i32
  store i32 %58, ptr %14, align 4
  %59 = load i32, ptr %12, align 4
  %60 = icmp slt i32 %59, 0
  br i1 %60, label %69, label %61

61:                                               ; preds = %52
  %62 = load i32, ptr %12, align 4
  %63 = load ptr, ptr %6, align 8
  %64 = getelementptr inbounds %struct.moonbit_object, ptr %63, i64 -1
  %65 = getelementptr inbounds %struct.moonbit_object, ptr %64, i32 0, i32 1
  %66 = load i32, ptr %65, align 4
  %67 = and i32 %66, 268435455
  %68 = icmp uge i32 %62, %67
  br i1 %68, label %69, label %70

69:                                               ; preds = %61, %52
  call void @moonbit_panic() #6
  unreachable

70:                                               ; preds = %61
  %71 = load i32, ptr %14, align 4
  %72 = trunc i32 %71 to i8
  %73 = load ptr, ptr %6, align 8
  %74 = load i32, ptr %12, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds i8, ptr %73, i64 %75
  store i8 %72, ptr %76, align 1
  %77 = load i32, ptr %11, align 4
  %78 = add nsw i32 %77, 1
  store i32 %78, ptr %15, align 4
  %79 = load i32, ptr %15, align 4
  store i32 %79, ptr %11, align 4
  br label %30

80:                                               ; preds = %30
  %81 = load ptr, ptr %8, align 8
  call void @moonbit_decref_inlined(ptr noundef %81)
  %82 = load ptr, ptr %6, align 8
  call void @moonbit_decref_inlined(ptr noundef %82)
  br label %83

83:                                               ; preds = %80
  br label %84

84:                                               ; preds = %83
  br label %143

85:                                               ; preds = %25, %5
  %86 = load i32, ptr %10, align 4
  %87 = sub nsw i32 %86, 1
  store i32 %87, ptr %16, align 4
  %88 = load i32, ptr %16, align 4
  store i32 %88, ptr %17, align 4
  br label %89

89:                                               ; preds = %85, %128
  %90 = load i32, ptr %17, align 4
  %91 = icmp sge i32 %90, 0
  br i1 %91, label %92, label %138

92:                                               ; preds = %89
  %93 = load i32, ptr %7, align 4
  %94 = load i32, ptr %17, align 4
  %95 = add nsw i32 %93, %94
  store i32 %95, ptr %18, align 4
  %96 = load i32, ptr %9, align 4
  %97 = load i32, ptr %17, align 4
  %98 = add nsw i32 %96, %97
  store i32 %98, ptr %19, align 4
  %99 = load i32, ptr %19, align 4
  %100 = icmp slt i32 %99, 0
  br i1 %100, label %109, label %101

101:                                              ; preds = %92
  %102 = load i32, ptr %19, align 4
  %103 = load ptr, ptr %8, align 8
  %104 = getelementptr inbounds %struct.moonbit_object, ptr %103, i64 -1
  %105 = getelementptr inbounds %struct.moonbit_object, ptr %104, i32 0, i32 1
  %106 = load i32, ptr %105, align 4
  %107 = and i32 %106, 268435455
  %108 = icmp uge i32 %102, %107
  br i1 %108, label %109, label %110

109:                                              ; preds = %101, %92
  call void @moonbit_panic() #6
  unreachable

110:                                              ; preds = %101
  %111 = load ptr, ptr %8, align 8
  %112 = load i32, ptr %19, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds i8, ptr %111, i64 %113
  %115 = load i8, ptr %114, align 1
  %116 = zext i8 %115 to i32
  store i32 %116, ptr %20, align 4
  %117 = load i32, ptr %18, align 4
  %118 = icmp slt i32 %117, 0
  br i1 %118, label %127, label %119

119:                                              ; preds = %110
  %120 = load i32, ptr %18, align 4
  %121 = load ptr, ptr %6, align 8
  %122 = getelementptr inbounds %struct.moonbit_object, ptr %121, i64 -1
  %123 = getelementptr inbounds %struct.moonbit_object, ptr %122, i32 0, i32 1
  %124 = load i32, ptr %123, align 4
  %125 = and i32 %124, 268435455
  %126 = icmp uge i32 %120, %125
  br i1 %126, label %127, label %128

127:                                              ; preds = %119, %110
  call void @moonbit_panic() #6
  unreachable

128:                                              ; preds = %119
  %129 = load i32, ptr %20, align 4
  %130 = trunc i32 %129 to i8
  %131 = load ptr, ptr %6, align 8
  %132 = load i32, ptr %18, align 4
  %133 = sext i32 %132 to i64
  %134 = getelementptr inbounds i8, ptr %131, i64 %133
  store i8 %130, ptr %134, align 1
  %135 = load i32, ptr %17, align 4
  %136 = sub nsw i32 %135, 1
  store i32 %136, ptr %21, align 4
  %137 = load i32, ptr %21, align 4
  store i32 %137, ptr %17, align 4
  br label %89

138:                                              ; preds = %89
  %139 = load ptr, ptr %8, align 8
  call void @moonbit_decref_inlined(ptr noundef %139)
  %140 = load ptr, ptr %6, align 8
  call void @moonbit_decref_inlined(ptr noundef %140)
  br label %141

141:                                              ; preds = %138
  br label %142

142:                                              ; preds = %141
  br label %143

143:                                              ; preds = %142, %84
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$$moonbitlang$core$builtin$Default$$Byte$$default"() #0 {
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$moonbitlang$core$builtin$abort$1"(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %9 = load ptr, ptr %3, align 8
  %10 = call ptr @moonbit_add_string(ptr noundef %9, ptr noundef getelementptr inbounds (%struct.anon.2, ptr @moonbit_string_literal_15, i32 0, i32 2))
  store ptr %10, ptr %5, align 8
  %11 = load ptr, ptr %4, align 8
  %12 = call ptr @"$$moonbitlang$core$builtin$Show$$$default_impl$$to_string$1"(ptr noundef %11)
  store ptr %12, ptr %6, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = load ptr, ptr %6, align 8
  %15 = call ptr @moonbit_add_string(ptr noundef %13, ptr noundef %14)
  store ptr %15, ptr %7, align 8
  %16 = load ptr, ptr %7, align 8
  %17 = call ptr @moonbit_add_string(ptr noundef %16, ptr noundef getelementptr inbounds (%struct.anon.13, ptr @moonbit_string_literal_16, i32 0, i32 2))
  store ptr %17, ptr %8, align 8
  %18 = load ptr, ptr %8, align 8
  %19 = call i32 @"$moonbitlang$core$abort$abort$1"(ptr noundef %18)
  ret i32 %19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$UInt$$to_byte"(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %4 = load i32, ptr %2, align 4
  store i32 %4, ptr %3, align 4
  %5 = load i32, ptr %3, align 4
  %6 = and i32 %5, 255
  ret i32 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$Char$$to_uint"(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %4 = load i32, ptr %2, align 4
  store i32 %4, ptr %3, align 4
  %5 = load i32, ptr %3, align 4
  ret i32 %5
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$Bytes$$to_unchecked_string$inner"(ptr noundef %0, i32 noundef %1, i64 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i64, align 8
  %11 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i64 %2, ptr %6, align 8
  %12 = load ptr, ptr %4, align 8
  %13 = getelementptr inbounds %struct.moonbit_object, ptr %12, i64 -1
  %14 = getelementptr inbounds %struct.moonbit_object, ptr %13, i32 0, i32 1
  %15 = load i32, ptr %14, align 4
  %16 = and i32 %15, 268435455
  store i32 %16, ptr %7, align 4
  %17 = load i64, ptr %6, align 8
  %18 = icmp eq i64 %17, 4294967296
  br i1 %18, label %19, label %23

19:                                               ; preds = %3
  %20 = load i32, ptr %7, align 4
  %21 = load i32, ptr %5, align 4
  %22 = sub nsw i32 %20, %21
  store i32 %22, ptr %8, align 4
  br label %27

23:                                               ; preds = %3
  %24 = load i64, ptr %6, align 8
  store i64 %24, ptr %10, align 8
  %25 = load i64, ptr %10, align 8
  %26 = trunc i64 %25 to i32
  store i32 %26, ptr %8, align 4
  br label %27

27:                                               ; preds = %23, %19
  %28 = load i32, ptr %5, align 4
  %29 = icmp sge i32 %28, 0
  br i1 %29, label %30, label %43

30:                                               ; preds = %27
  %31 = load i32, ptr %8, align 4
  %32 = icmp sge i32 %31, 0
  br i1 %32, label %33, label %41

33:                                               ; preds = %30
  %34 = load i32, ptr %5, align 4
  %35 = load i32, ptr %8, align 4
  %36 = add nsw i32 %34, %35
  store i32 %36, ptr %11, align 4
  %37 = load i32, ptr %11, align 4
  %38 = load i32, ptr %7, align 4
  %39 = icmp sle i32 %37, %38
  %40 = zext i1 %39 to i32
  store i32 %40, ptr %9, align 4
  br label %42

41:                                               ; preds = %30
  store i32 0, ptr %9, align 4
  br label %42

42:                                               ; preds = %41, %33
  br label %44

43:                                               ; preds = %27
  store i32 0, ptr %9, align 4
  br label %44

44:                                               ; preds = %43, %42
  %45 = load i32, ptr %9, align 4
  %46 = icmp ne i32 %45, 0
  br i1 %46, label %47, label %52

47:                                               ; preds = %44
  %48 = load ptr, ptr %4, align 8
  %49 = load i32, ptr %5, align 4
  %50 = load i32, ptr %8, align 4
  %51 = call ptr @moonbit_unsafe_bytes_sub_string(ptr noundef %48, i32 noundef %49, i32 noundef %50)
  ret ptr %51

52:                                               ; preds = %44
  %53 = load ptr, ptr %4, align 8
  call void @moonbit_decref_inlined(ptr noundef %53)
  call void @moonbit_panic() #6
  unreachable
}

declare ptr @moonbit_unsafe_bytes_sub_string(ptr noundef, i32 noundef, i32 noundef) #2

declare ptr @moonbit_add_string(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @"$moonbitlang$core$abort$abort$3"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @moonbit_println(ptr noundef %3)
  %4 = load ptr, ptr %2, align 8
  call void @moonbit_decref_inlined(ptr noundef %4)
  call void @moonbit_panic() #6
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local { i64, ptr } @"$moonbitlang$core$abort$abort$2"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @moonbit_println(ptr noundef %3)
  %4 = load ptr, ptr %2, align 8
  call void @moonbit_decref_inlined(ptr noundef %4)
  call void @moonbit_panic() #6
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$moonbitlang$core$abort$abort$1"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @moonbit_println(ptr noundef %3)
  %4 = load ptr, ptr %2, align 8
  call void @moonbit_decref_inlined(ptr noundef %4)
  call void @moonbit_panic() #6
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$moonbitlang$core$abort$abort$0"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @moonbit_println(ptr noundef %3)
  %4 = load ptr, ptr %2, align 8
  call void @moonbit_decref_inlined(ptr noundef %4)
  call void @moonbit_panic() #6
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @moonbit_init() #0 {
  store ptr getelementptr inbounds (%struct.anon.18, ptr @"$username$moonbit_examples$cmd$hof$_init$2a$$double$7c$2$dyncall$closure", i32 0, i32 2), ptr @"$username$moonbit_examples$cmd$hof$_init$2a$$double$7c$2$clo", align 8
  store ptr getelementptr inbounds (%struct.anon.19, ptr @"$username$moonbit_examples$cmd$hof$_init$2a$$square$7c$4$dyncall$closure", i32 0, i32 2), ptr @"$username$moonbit_examples$cmd$hof$_init$2a$$square$7c$4$clo", align 8
  store i64 0, ptr @"$moonbitlang$core$builtin$boyer_moore_horspool_find$constr$55", align 8
  store i64 0, ptr @"$moonbitlang$core$builtin$brute_force_find$constr$69", align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %12 = load i32, ptr %4, align 4
  %13 = load ptr, ptr %5, align 8
  call void @moonbit_runtime_init(i32 noundef %12, ptr noundef %13)
  call void @moonbit_init()
  %14 = load ptr, ptr @"$username$moonbit_examples$cmd$hof$_init$2a$$double$7c$2$clo", align 8
  call void @moonbit_incref_inlined(ptr noundef %14)
  %15 = load ptr, ptr @"$username$moonbit_examples$cmd$hof$_init$2a$$double$7c$2$clo", align 8
  %16 = call i32 @"$username$moonbit_examples$cmd$hof$apply"(ptr noundef %15, i32 noundef 5)
  store i32 %16, ptr %6, align 4
  %17 = load i32, ptr %6, align 4
  %18 = call ptr @"$$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0"(i32 noundef %17)
  store ptr %18, ptr %7, align 8
  %19 = load ptr, ptr %7, align 8
  %20 = call ptr @moonbit_add_string(ptr noundef getelementptr inbounds (%struct.anon.15, ptr @moonbit_string_literal_17, i32 0, i32 2), ptr noundef %19)
  store ptr %20, ptr %8, align 8
  %21 = load ptr, ptr %8, align 8
  %22 = call i32 @"$moonbitlang$core$builtin$println$0"(ptr noundef %21)
  %23 = load ptr, ptr @"$username$moonbit_examples$cmd$hof$_init$2a$$square$7c$4$clo", align 8
  call void @moonbit_incref_inlined(ptr noundef %23)
  %24 = load ptr, ptr @"$username$moonbit_examples$cmd$hof$_init$2a$$square$7c$4$clo", align 8
  %25 = call i32 @"$username$moonbit_examples$cmd$hof$apply"(ptr noundef %24, i32 noundef 5)
  store i32 %25, ptr %9, align 4
  %26 = load i32, ptr %9, align 4
  %27 = call ptr @"$$moonbitlang$core$builtin$Show$$$default_impl$$to_string$0"(i32 noundef %26)
  store ptr %27, ptr %10, align 8
  %28 = load ptr, ptr %10, align 8
  %29 = call ptr @moonbit_add_string(ptr noundef getelementptr inbounds (%struct.anon.8, ptr @moonbit_string_literal_18, i32 0, i32 2), ptr noundef %28)
  store ptr %29, ptr %11, align 8
  %30 = load ptr, ptr %11, align 8
  %31 = call i32 @"$moonbitlang$core$builtin$println$0"(ptr noundef %30)
  ret i32 0
}

declare void @moonbit_runtime_init(i32 noundef, ptr noundef) #2

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #4

declare void @moonbit_drop_object(ptr noundef) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.ctlz.i32(i32, i1 immarg) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.cttz.i32(i32, i1 immarg) #5

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { noreturn }
attributes #7 = { allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
