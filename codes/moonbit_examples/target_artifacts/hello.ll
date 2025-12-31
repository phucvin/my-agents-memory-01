; ModuleID = '/app/codes/moonbit_examples/target_artifacts/hello.c'
source_filename = "/app/codes/moonbit_examples/target_artifacts/hello.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.anon = type { i32, i32, [16 x i16] }
%struct.moonbit_object = type { i32, i32 }

@moonbit_string_literal_0 = dso_local constant %struct.anon { i32 -1, i32 -1879048177, [16 x i16] [i16 72, i16 101, i16 108, i16 108, i16 111, i16 44, i16 32, i16 77, i16 111, i16 111, i16 110, i16 66, i16 105, i16 116, i16 33, i16 0] }, align 4

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

declare void @moonbit_println(ptr noundef) #1

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
define dso_local ptr @"$$moonbitlang$core$builtin$Show$$String$$to_string"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @moonbit_init() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %6 = load i32, ptr %4, align 4
  %7 = load ptr, ptr %5, align 8
  call void @moonbit_runtime_init(i32 noundef %6, ptr noundef %7)
  call void @moonbit_init()
  %8 = call i32 @"$moonbitlang$core$builtin$println$0"(ptr noundef getelementptr inbounds (%struct.anon, ptr @moonbit_string_literal_0, i32 0, i32 2))
  ret i32 0
}

declare void @moonbit_runtime_init(i32 noundef, ptr noundef) #1

declare void @moonbit_drop_object(ptr noundef) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
