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

    wasm2wat_cmd = shutil.which("wasm2wat")
    if not wasm2wat_cmd:
        print("Warning: 'wasm2wat' not found. generated .wat files will be skipped.")

    # Ensure artifact dir exists
    if os.path.exists(artifact_dir):
        shutil.rmtree(artifact_dir)
    os.makedirs(artifact_dir)

    # Change to project root for moon build
    os.chdir(project_root)

    dirs = ["hello", "fibonacci", "factorial", "arrays", "structs", "enums", "hof", "option", "generics", "traits"]
    targets = ["native", "wasm", "wasm-gc"]

    print(f"Building targets: {targets}...")
    for t in targets:
        try:
            subprocess.run([moon_cmd, "build", "--target", t], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error building target {t}: {e}")
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

        # 2. Convert Wasm to WAT (Standard)
        if wasm2wat_cmd:
            wasm_src = os.path.join(target_dir, "wasm/release/build/cmd", d, f"{d}.wasm")
            if os.path.exists(wasm_src):
                wat_dst = os.path.join(artifact_dir, f"{d}.wat")
                try:
                    subprocess.run([wasm2wat_cmd, wasm_src, "-o", wat_dst], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                    print(f"Generated {d}.wat")
                except subprocess.CalledProcessError:
                    print(f"Failed to convert {d}.wasm to wat")

            # 3. Convert Wasm to WAT (GC)
            wasm_gc_src = os.path.join(target_dir, "wasm-gc/release/build/cmd", d, f"{d}.wasm")
            if os.path.exists(wasm_gc_src):
                wat_gc_dst = os.path.join(artifact_dir, f"{d}.gc.wat")
                try:
                    subprocess.run([wasm2wat_cmd, "--enable-all", wasm_gc_src, "-o", wat_gc_dst], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                    print(f"Generated {d}.gc.wat")
                except subprocess.CalledProcessError:
                    print(f"Failed to convert {d}.wasm (GC) to wat (might require newer wasm2wat or specific flags)")

    print("Done.")

if __name__ == "__main__":
    main()
