import fs from 'fs';
import path from 'path';
import binaryen from 'binaryen';
import vm from 'vm';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DIR = __dirname;
const IGNORE = ['verify.js'];

// Helper to capture stdout of JS
function runJs(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  // Hack to support print()
  try {
    const output = [];
    const context = {
      print: (...args) => output.push(args.join(' ')),
      console: { log: (...args) => output.push(args.join(' ')) }
    };
    vm.createContext(context);
    vm.runInContext(content, context);
    return output.join('\n');
  } catch (e) {
    return `Error running JS: ${e.message}`;
  }
}

// Helper to run WAT
async function runWat(filePath) {
  try {
    const watContent = fs.readFileSync(filePath, 'utf8');
    // binaryen.parseText returns a Module
    const mod = binaryen.parseText(watContent);
    mod.setFeatures(binaryen.Features.All); // Enable all features (GC, etc)

    // We need to compile to binary
    // Using binaryen to get binary buffer
    const binary = mod.emitBinary();
    mod.dispose();

    const output = [];
    // Import object
    const importObject = {
      env: {
        putchar: (c) => {
          output.push(String.fromCharCode(c));
        }
      }
    };

    const wasmModule = await WebAssembly.instantiate(binary, importObject);
    const { main } = wasmModule.instance.exports;

    if (typeof main === 'function') {
      main();
    }

    return output.join('');
  } catch (e) {
    return `Error running WAT: ${e.message}`;
  }
}

async function verify() {
  const files = fs.readdirSync(DIR);
  const jsFiles = files.filter(f => f.endsWith('.js') && !IGNORE.includes(f));

  console.log('Scanning files in ' + DIR);

  let passed = 0;
  let failed = 0;

  for (const jsFile of jsFiles) {
    const base = path.basename(jsFile, '.js');
    const watFile = base + '.wat';

    if (files.includes(watFile)) {
      console.log(`Testing ${base}...`);

      const jsOutput = runJs(path.join(DIR, jsFile)).trim();
      const watOutput = (await runWat(path.join(DIR, watFile))).trim();

      if (jsOutput === watOutput) {
        console.log(`✅ ${base} passed.`);
        passed++;
      } else {
        console.log(`❌ ${base} failed.`);
        console.log(`  JS Output:  ${JSON.stringify(jsOutput)}`);
        console.log(`  WAT Output: ${JSON.stringify(watOutput)}`);
        failed++;
      }
    }
  }

  console.log('--------------------------------------------------');
  console.log(`Summary: ${passed} passed, ${failed} failed.`);
}

verify().catch(console.error);
