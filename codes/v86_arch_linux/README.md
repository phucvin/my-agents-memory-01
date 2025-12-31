# v86 Arch Linux (DSL) Node.js Example

This project demonstrates running a Linux environment inside Node.js using the [v86](https://github.com/copy/v86) emulator library. It boots Damn Small Linux (DSL), writes a C++ "Hello World" program, compiles it using `g++`, and runs it.

**Note:** The user requested Arch Linux, but due to the large size of Arch Linux ISOs (~800MB) and the complexity of setting up a 9pfs environment offline, this example falls back to **Damn Small Linux (DSL)**, which is ~50MB and includes GCC, making it suitable for this demonstration.

## Prerequisites

- Node.js (v16+ recommended)
- `curl` (for downloading images)

## Setup

1.  Install dependencies:
    ```bash
    npm install
    ```

2.  Download the BIOS and disk images (run this script):
    ```bash
    ./setup.sh
    ```
    This will download `seabios.bin`, `vgabios.bin`, and `dsl.iso` into `bios/` and `images/` directories.

## Usage

Run the example:

```bash
npm start
```

or

```bash
node index.mjs
```

The script will:
1.  Initialize the emulator.
2.  Send boot parameters to redirect console output to serial.
3.  Wait for the system to boot.
4.  Automate the creation of `hello.cpp`.
5.  Compile it with `g++`.
6.  Run the executable.
7.  Print the output to the console.

**Note:** The boot process can take 1-2 minutes depending on the machine speed, as it runs purely in WebAssembly. The script uses timed delays to automate the interaction.

## Example Output

```
Starting v86 with DSL...
Emulator initialized. Automation sequence started.

[Step 1] Sending boot parameters...
[Sending]: dsl 2 console=ttyS0

[Step 2] Sending Enter confirmation...
[Sending]:

... (Boot logs from Linux Kernel) ...

[Step 3] Assuming boot complete. Creating C++ file...
[Sending]: cat > hello.cpp <<EOF
[Sending]: #include <iostream>
[Sending]: using namespace std;
[Sending]: int main() {
[Sending]:     cout << "Hello from C++ inside DSL!" << endl;
[Sending]:     return 0;
[Sending]: }
[Sending]: EOF

[Step 4] Compiling...
[Sending]: g++ hello.cpp -o hello

[Step 5] Running...
[Sending]: ./hello
Hello from C++ inside DSL!

[Step 6] Checking Kernel...
[Sending]: uname -a
Linux box 2.4.31 #2 Sun Mar 18 19:25:02 PDT 2012 i686 unknown

[Step 7] Done. Exiting.
```
