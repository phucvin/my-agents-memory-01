import subprocess
import os
import shutil
import sys

def main():
    # Configuration
    project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    cmd_dir = os.path.join(project_root, "cmd")
    artifact_dir = os.path.join(project_root, "target_artifacts")
    target_dir = os.path.join(project_root, "target")

    # Check for dependencies
    moon_cmd = shutil.which("moon")
    if not moon_cmd:
        # Fallback to ~/.moon/bin/moon if not in PATH
        home_moon = os.path.expanduser("~/.moon/bin/moon")
        if os.path.exists(home_moon):
            moon_cmd = home_moon
        else:
            print("Error: 'moon' CLI not found in PATH or ~/.moon/bin/")
            sys.exit(1)

    # Ensure artifact dir exists
    if os.path.exists(artifact_dir):
        shutil.rmtree(artifact_dir)
    os.makedirs(artifact_dir)

    # Change to project root for moon build
    os.chdir(project_root)

    dirs = ["hello", "fibonacci", "factorial", "arrays", "structs", "enums", "hof", "option", "generics", "traits"]

    # Build all targets
    print(f"Building all targets (js, native, wasm, wasm-gc) with --output-wat...")
    cmd = [moon_cmd, "build", "--target", "all", "--output-wat"]
    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error building targets: {e}")
        sys.exit(1)

    print("Copying artifacts...")
    for d in dirs:
        # 1. Copy C files (from native target)
        c_src = os.path.join(target_dir, "native/release/build/cmd", d, f"{d}.c")
        c_dst = os.path.join(artifact_dir, f"{d}.c")
        if os.path.exists(c_src):
            shutil.copy(c_src, c_dst)
            print(f"Copied {d}.c")
        else:
            print(f"Warning: {c_src} not found")

        # 2. Copy WAT (Standard)
        wat_src = os.path.join(target_dir, "wasm/release/build/cmd", d, f"{d}.wat")
        if os.path.exists(wat_src):
            wat_dst = os.path.join(artifact_dir, f"{d}.wat")
            shutil.copy(wat_src, wat_dst)
            print(f"Copied {d}.wat")
        else:
            print(f"Warning: {wat_src} not found")

        # 3. Copy WAT (GC)
        wat_gc_src = os.path.join(target_dir, "wasm-gc/release/build/cmd", d, f"{d}.wat")
        if os.path.exists(wat_gc_src):
            wat_gc_dst = os.path.join(artifact_dir, f"{d}.gc.wat")
            shutil.copy(wat_gc_src, wat_gc_dst)
            print(f"Copied {d}.gc.wat")
        else:
            print(f"Warning: {wat_gc_src} not found")

        # 4. Copy JS
        js_src = os.path.join(target_dir, "js/release/build/cmd", d, f"{d}.js")
        if os.path.exists(js_src):
            js_dst = os.path.join(artifact_dir, f"{d}.js")
            shutil.copy(js_src, js_dst)
            print(f"Copied {d}.js")
        else:
            print(f"Warning: {js_src} not found")

        # 5. Copy LLVM IR
        ll_src = os.path.join(target_dir, "native/release/build/cmd", d, f"{d}.ll")
        if os.path.exists(ll_src):
            ll_dst = os.path.join(artifact_dir, f"{d}.ll")
            shutil.copy(ll_src, ll_dst)
            print(f"Copied {d}.ll")
        else:
            print(f"Warning: {ll_src} not found")

    print("Done.")

if __name__ == "__main__":
    main()
