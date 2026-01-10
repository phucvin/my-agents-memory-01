const fs = require('fs');
const path = require('path');

const filePaths = [
  path.resolve(__dirname, '../node_modules/@google/adk/dist/esm/code_executors/built_in_code_executor.js'),
  path.resolve(__dirname, '../node_modules/@google/adk/dist/cjs/code_executors/built_in_code_executor.js'),
  // Also patch the bundles if necessary, though direct modification of source files might be enough if source maps are used correctly.
  // We'll focus on the specific files identified in the debugging session.
];

// The pattern to match the throw statement
const searchPattern = /throw new Error\(`Gemini code execution tool is not supported for model \${[^}]+}`\);?/;
const replaceString = 'return;';

// Also handle the bundled index files just in case
const indexPaths = [
    path.resolve(__dirname, '../node_modules/@google/adk/dist/esm/index.js'),
    path.resolve(__dirname, '../node_modules/@google/adk/dist/cjs/index.js'),
];

const allPaths = [...filePaths, ...indexPaths];

allPaths.forEach(filePath => {
  if (fs.existsSync(filePath)) {
    try {
      let content = fs.readFileSync(filePath, 'utf8');
      if (searchPattern.test(content)) {
        console.log(`Patching ${filePath}...`);
        content = content.replace(searchPattern, replaceString);
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Successfully patched ${filePath}`);
      } else {
        console.log(`Pattern not found or already patched in ${filePath}`);
      }
    } catch (err) {
      console.error(`Error patching ${filePath}:`, err);
    }
  } else {
    console.log(`File not found: ${filePath}`);
  }
});
