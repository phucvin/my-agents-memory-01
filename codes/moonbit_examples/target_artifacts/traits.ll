; ModuleID = '/app/codes/moonbit_examples/target_artifacts/traits.c'
source_filename = "/app/codes/moonbit_examples/target_artifacts/traits.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.anon = type { i32, i32, [6 x i16] }
%struct.anon.0 = type { i32, i32, [12 x i16] }
%struct.anon.1 = type { i32, i32, [12 x i16] }
%struct.anon.2 = type { i32, i32, [9 x i16] }
%struct.anon.3 = type { i32, i32, %"struct.$Dog" }
%"struct.$Dog" = type { ptr }
%struct.anon.4 = type { i32, i32, %"struct.$Cat" }
%"struct.$Cat" = type { ptr }
%struct.moonbit_object = type { i32, i32 }

@moonbit_string_literal_0 = dso_local constant %struct.anon { i32 -1, i32 -1879048187, [6 x i16] [i16 66, i16 117, i16 100, i16 100, i16 121, i16 0] }, align 4
@moonbit_string_literal_2 = dso_local constant %struct.anon.0 { i32 -1, i32 -1879048181, [12 x i16] [i16 77, i16 101, i16 111, i16 119, i16 33, i16 32, i16 73, i16 32, i16 97, i16 109, i16 32, i16 0] }, align 4
@moonbit_string_literal_3 = dso_local constant %struct.anon.1 { i32 -1, i32 -1879048181, [12 x i16] [i16 87, i16 111, i16 111, i16 102, i16 33, i16 32, i16 73, i16 32, i16 97, i16 109, i16 32, i16 0] }, align 4
@moonbit_string_literal_1 = dso_local constant %struct.anon.2 { i32 -1, i32 -1879048184, [9 x i16] [i16 87, i16 104, i16 105, i16 115, i16 107, i16 101, i16 114, i16 115, i16 0] }, align 4
@"$username$moonbit_examples$cmd$traits$_main$dog$7$object" = dso_local global %struct.anon.3 { i32 -1, i32 256, %"struct.$Dog" { ptr getelementptr (i8, ptr @moonbit_string_literal_0, i64 8) } }, align 8
@"$username$moonbit_examples$cmd$traits$_main$dog$7" = dso_local global ptr getelementptr (i8, ptr @"$username$moonbit_examples$cmd$traits$_main$dog$7$object", i64 8), align 8
@"$username$moonbit_examples$cmd$traits$_main$cat$8$object" = dso_local global %struct.anon.4 { i32 -1, i32 256, %"struct.$Cat" { ptr getelementptr (i8, ptr @moonbit_string_literal_1, i64 8) } }, align 8
@"$username$moonbit_examples$cmd$traits$_main$cat$8" = dso_local global ptr getelementptr (i8, ptr @"$username$moonbit_examples$cmd$traits$_main$cat$8$object", i64 8), align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$username$moonbit_examples$cmd$traits$introduce$1"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %8 = load ptr, ptr %2, align 8
  %9 = getelementptr inbounds %"struct.$Cat", ptr %8, i32 0, i32 0
  %10 = load ptr, ptr %9, align 8
  store ptr %10, ptr %3, align 8
  %11 = load ptr, ptr %2, align 8
  %12 = getelementptr inbounds %struct.moonbit_object, ptr %11, i64 -1
  %13 = getelementptr inbounds %struct.moonbit_object, ptr %12, i32 0, i32 0
  %14 = load i32, ptr %13, align 4
  store i32 %14, ptr %4, align 4
  %15 = load i32, ptr %4, align 4
  %16 = icmp sgt i32 %15, 1
  br i1 %16, label %17, label %25

17:                                               ; preds = %1
  %18 = load ptr, ptr %3, align 8
  call void @moonbit_incref_inlined(ptr noundef %18)
  %19 = load i32, ptr %4, align 4
  %20 = sub nsw i32 %19, 1
  store i32 %20, ptr %7, align 4
  %21 = load i32, ptr %7, align 4
  %22 = load ptr, ptr %2, align 8
  %23 = getelementptr inbounds %struct.moonbit_object, ptr %22, i64 -1
  %24 = getelementptr inbounds %struct.moonbit_object, ptr %23, i32 0, i32 0
  store i32 %21, ptr %24, align 4
  br label %32

25:                                               ; preds = %1
  %26 = load i32, ptr %4, align 4
  %27 = icmp eq i32 %26, 1
  br i1 %27, label %28, label %31

28:                                               ; preds = %25
  %29 = load ptr, ptr %2, align 8
  %30 = getelementptr inbounds %struct.moonbit_object, ptr %29, i64 -1
  call void @free(ptr noundef %30)
  br label %31

31:                                               ; preds = %28, %25
  br label %32

32:                                               ; preds = %31, %17
  %33 = load ptr, ptr %3, align 8
  store ptr %33, ptr %5, align 8
  %34 = load ptr, ptr %5, align 8
  %35 = call ptr @moonbit_add_string(ptr noundef getelementptr inbounds (%struct.anon.0, ptr @moonbit_string_literal_2, i32 0, i32 2), ptr noundef %34)
  store ptr %35, ptr %6, align 8
  %36 = load ptr, ptr %6, align 8
  %37 = call i32 @"$moonbitlang$core$builtin$println$0"(ptr noundef %36)
  ret i32 0
}

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

declare void @free(ptr noundef) #1

declare ptr @moonbit_add_string(ptr noundef, ptr noundef) #1

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

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"$username$moonbit_examples$cmd$traits$introduce$0"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %8 = load ptr, ptr %2, align 8
  %9 = getelementptr inbounds %"struct.$Dog", ptr %8, i32 0, i32 0
  %10 = load ptr, ptr %9, align 8
  store ptr %10, ptr %3, align 8
  %11 = load ptr, ptr %2, align 8
  %12 = getelementptr inbounds %struct.moonbit_object, ptr %11, i64 -1
  %13 = getelementptr inbounds %struct.moonbit_object, ptr %12, i32 0, i32 0
  %14 = load i32, ptr %13, align 4
  store i32 %14, ptr %4, align 4
  %15 = load i32, ptr %4, align 4
  %16 = icmp sgt i32 %15, 1
  br i1 %16, label %17, label %25

17:                                               ; preds = %1
  %18 = load ptr, ptr %3, align 8
  call void @moonbit_incref_inlined(ptr noundef %18)
  %19 = load i32, ptr %4, align 4
  %20 = sub nsw i32 %19, 1
  store i32 %20, ptr %7, align 4
  %21 = load i32, ptr %7, align 4
  %22 = load ptr, ptr %2, align 8
  %23 = getelementptr inbounds %struct.moonbit_object, ptr %22, i64 -1
  %24 = getelementptr inbounds %struct.moonbit_object, ptr %23, i32 0, i32 0
  store i32 %21, ptr %24, align 4
  br label %32

25:                                               ; preds = %1
  %26 = load i32, ptr %4, align 4
  %27 = icmp eq i32 %26, 1
  br i1 %27, label %28, label %31

28:                                               ; preds = %25
  %29 = load ptr, ptr %2, align 8
  %30 = getelementptr inbounds %struct.moonbit_object, ptr %29, i64 -1
  call void @free(ptr noundef %30)
  br label %31

31:                                               ; preds = %28, %25
  br label %32

32:                                               ; preds = %31, %17
  %33 = load ptr, ptr %3, align 8
  store ptr %33, ptr %5, align 8
  %34 = load ptr, ptr %5, align 8
  %35 = call ptr @moonbit_add_string(ptr noundef getelementptr inbounds (%struct.anon.1, ptr @moonbit_string_literal_3, i32 0, i32 2), ptr noundef %34)
  store ptr %35, ptr %6, align 8
  %36 = load ptr, ptr %6, align 8
  %37 = call i32 @"$moonbitlang$core$builtin$println$0"(ptr noundef %36)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$$username$moonbit_examples$cmd$traits$Speak$$$username$moonbit_examples$cmd$traits$Cat$$speak"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %7 = load ptr, ptr %2, align 8
  %8 = getelementptr inbounds %"struct.$Cat", ptr %7, i32 0, i32 0
  %9 = load ptr, ptr %8, align 8
  store ptr %9, ptr %3, align 8
  %10 = load ptr, ptr %2, align 8
  %11 = getelementptr inbounds %struct.moonbit_object, ptr %10, i64 -1
  %12 = getelementptr inbounds %struct.moonbit_object, ptr %11, i32 0, i32 0
  %13 = load i32, ptr %12, align 4
  store i32 %13, ptr %4, align 4
  %14 = load i32, ptr %4, align 4
  %15 = icmp sgt i32 %14, 1
  br i1 %15, label %16, label %24

16:                                               ; preds = %1
  %17 = load ptr, ptr %3, align 8
  call void @moonbit_incref_inlined(ptr noundef %17)
  %18 = load i32, ptr %4, align 4
  %19 = sub nsw i32 %18, 1
  store i32 %19, ptr %6, align 4
  %20 = load i32, ptr %6, align 4
  %21 = load ptr, ptr %2, align 8
  %22 = getelementptr inbounds %struct.moonbit_object, ptr %21, i64 -1
  %23 = getelementptr inbounds %struct.moonbit_object, ptr %22, i32 0, i32 0
  store i32 %20, ptr %23, align 4
  br label %31

24:                                               ; preds = %1
  %25 = load i32, ptr %4, align 4
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %30

27:                                               ; preds = %24
  %28 = load ptr, ptr %2, align 8
  %29 = getelementptr inbounds %struct.moonbit_object, ptr %28, i64 -1
  call void @free(ptr noundef %29)
  br label %30

30:                                               ; preds = %27, %24
  br label %31

31:                                               ; preds = %30, %16
  %32 = load ptr, ptr %3, align 8
  store ptr %32, ptr %5, align 8
  %33 = load ptr, ptr %5, align 8
  %34 = call ptr @moonbit_add_string(ptr noundef getelementptr inbounds (%struct.anon.0, ptr @moonbit_string_literal_2, i32 0, i32 2), ptr noundef %33)
  ret ptr %34
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @"$$username$moonbit_examples$cmd$traits$Speak$$$username$moonbit_examples$cmd$traits$Dog$$speak"(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %7 = load ptr, ptr %2, align 8
  %8 = getelementptr inbounds %"struct.$Dog", ptr %7, i32 0, i32 0
  %9 = load ptr, ptr %8, align 8
  store ptr %9, ptr %3, align 8
  %10 = load ptr, ptr %2, align 8
  %11 = getelementptr inbounds %struct.moonbit_object, ptr %10, i64 -1
  %12 = getelementptr inbounds %struct.moonbit_object, ptr %11, i32 0, i32 0
  %13 = load i32, ptr %12, align 4
  store i32 %13, ptr %4, align 4
  %14 = load i32, ptr %4, align 4
  %15 = icmp sgt i32 %14, 1
  br i1 %15, label %16, label %24

16:                                               ; preds = %1
  %17 = load ptr, ptr %3, align 8
  call void @moonbit_incref_inlined(ptr noundef %17)
  %18 = load i32, ptr %4, align 4
  %19 = sub nsw i32 %18, 1
  store i32 %19, ptr %6, align 4
  %20 = load i32, ptr %6, align 4
  %21 = load ptr, ptr %2, align 8
  %22 = getelementptr inbounds %struct.moonbit_object, ptr %21, i64 -1
  %23 = getelementptr inbounds %struct.moonbit_object, ptr %22, i32 0, i32 0
  store i32 %20, ptr %23, align 4
  br label %31

24:                                               ; preds = %1
  %25 = load i32, ptr %4, align 4
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %30

27:                                               ; preds = %24
  %28 = load ptr, ptr %2, align 8
  %29 = getelementptr inbounds %struct.moonbit_object, ptr %28, i64 -1
  call void @free(ptr noundef %29)
  br label %30

30:                                               ; preds = %27, %24
  br label %31

31:                                               ; preds = %30, %16
  %32 = load ptr, ptr %3, align 8
  store ptr %32, ptr %5, align 8
  %33 = load ptr, ptr %5, align 8
  %34 = call ptr @moonbit_add_string(ptr noundef getelementptr inbounds (%struct.anon.1, ptr @moonbit_string_literal_3, i32 0, i32 2), ptr noundef %33)
  ret ptr %34
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
  %8 = load ptr, ptr @"$username$moonbit_examples$cmd$traits$_main$dog$7", align 8
  call void @moonbit_incref_inlined(ptr noundef %8)
  %9 = load ptr, ptr @"$username$moonbit_examples$cmd$traits$_main$dog$7", align 8
  %10 = call i32 @"$username$moonbit_examples$cmd$traits$introduce$0"(ptr noundef %9)
  %11 = load ptr, ptr @"$username$moonbit_examples$cmd$traits$_main$cat$8", align 8
  call void @moonbit_incref_inlined(ptr noundef %11)
  %12 = load ptr, ptr @"$username$moonbit_examples$cmd$traits$_main$cat$8", align 8
  %13 = call i32 @"$username$moonbit_examples$cmd$traits$introduce$1"(ptr noundef %12)
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
