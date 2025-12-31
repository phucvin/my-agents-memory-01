import { V86 } from 'v86';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Configuration
const BIOS_PATH = path.join(__dirname, 'bios/seabios.bin');
const VGA_BIOS_PATH = path.join(__dirname, 'bios/vgabios.bin');
const CDROM_PATH = path.join(__dirname, 'images/dsl.iso');

// Validation
if (!fs.existsSync(BIOS_PATH) || !fs.existsSync(VGA_BIOS_PATH) || !fs.existsSync(CDROM_PATH)) {
    console.error("Missing BIOS or ISO files. Please run ./setup.sh first.");
    process.exit(1);
}

console.log('Starting v86 with DSL...');
console.log('BIOS:', BIOS_PATH);
console.log('CDROM:', CDROM_PATH);

// Initialize the emulator
const emulator = new V86({
    bios: { url: BIOS_PATH },
    vga_bios: { url: VGA_BIOS_PATH },
    cdrom: { url: CDROM_PATH },
    autostart: true,
    memory_size: 64 * 1024 * 1024,
    vga_memory_size: 2 * 1024 * 1024,
    // v86 package usually locates wasm automatically if not specified,
    // or we point to the build in node_modules relative to the script location.
    wasm_path: path.join(__dirname, 'node_modules/v86/build/v86.wasm'),
    disable_keyboard: true,
    disable_mouse: true,
});

let output_buffer = '';

// Helper to send text to serial port
function send_serial(text) {
    console.log(`[Sending]: ${text.trim()}`);
    for (let i = 0; i < text.length; i++) {
        emulator.bus.send('serial0-input', text.charCodeAt(i));
    }
}

// Listen to serial output
emulator.add_listener('serial0-output-char', function(char) {
    // Write to stdout (for log)
    process.stdout.write(char);
    output_buffer += char;
});

emulator.add_listener('emulator-loaded', function() {
    console.log('[Emulator Loaded]');
});

// Automate interaction
const STEPS = [
    // Step 1: Wait for boot loader and send boot command
    {
        delay: 5000,
        action: () => {
            console.log('\n[Step 1] Sending boot parameters...');
            send_serial('dsl 2 console=ttyS0\n');
        }
    },
    // Step 2: Confirm boot command (sometimes needed if first input was missed)
    {
        delay: 5000,
        action: () => {
            console.log('\n[Step 2] Sending Enter confirmation...');
            send_serial('\n');
        }
    },
    // Step 3: Wait for boot (can take a while) and create file
    {
        delay: 60000, // Wait 1 minute for boot
        action: () => {
            console.log('\n[Step 3] Assuming boot complete. Creating C++ file...');
            const cpp_code = `
#include <iostream>
using namespace std;
int main() {
    cout << "Hello from C++ inside DSL!" << endl;
    return 0;
}
`;
            send_serial('cat > hello.cpp <<EOF\n');
            setTimeout(() => {
                const lines = cpp_code.split('\n');
                lines.forEach((line, idx) => {
                    setTimeout(() => send_serial(line + '\n'), idx * 100);
                });
                setTimeout(() => send_serial('EOF\n'), lines.length * 100 + 500);
            }, 500);
        }
    },
    // Step 4: Compile
    {
        delay: 10000,
        action: () => {
            console.log('\n[Step 4] Compiling...');
            send_serial('g++ hello.cpp -o hello\n');
        }
    },
    // Step 5: Run
    {
        delay: 10000,
        action: () => {
            console.log('\n[Step 5] Running...');
            send_serial('./hello\n');
        }
    },
    // Step 6: Finish
    {
        delay: 5000,
        action: () => {
            console.log('\n[Step 6] Done. Exiting.');
            process.exit(0);
        }
    }
];

// Execute steps
let current_delay = 0;
for (const step of STEPS) {
    current_delay += step.delay;
    setTimeout(step.action, current_delay);
}

// Handle errors
emulator.add_listener('emulator-error', function(e) {
    console.error('Emulator Error:', e);
});

console.log('Emulator initialized. Automation sequence started.');
