#!/bin/bash
C3C="/tmp/c3_dist/c3c"
mkdir -p output

for file in *.c3; do
    if [ "$file" == "test.c3" ]; then continue; fi
    base="${file%.*}"
    echo "Running $base..."
    $C3C compile-run "$file" > "output/$base.txt" 2>&1
    if [ $? -ne 0 ]; then
        echo "Error running $base"
        cat "output/$base.txt"
    else
        echo "Success: $base"
    fi
done
