#!/bin/bash
set -e

SHERMES=../hermes_build/build_release/bin/shermes

if [ ! -f "$SHERMES" ]; then
    echo "Error: shermes binary not found at $SHERMES"
    exit 1
fi

for js_file in *.js; do
    base_name=$(basename "$js_file" .js)
    c_file="${base_name}.c"

    echo "Compiling $js_file to $c_file..."
    "$SHERMES" -O -emit-c -exported-unit="$base_name" -o "$c_file" "$js_file"
done

echo "All examples compiled successfully."
