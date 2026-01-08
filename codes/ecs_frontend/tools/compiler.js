// tools/compiler.js
import fs from 'fs';
import path from 'path';

// A simple script to "compile" (concatenate/copy) the project for distribution.
// Since we use native ES modules, we just ensure the dist folder is clean and populated.

const srcDir = 'src';
const distDir = 'dist';

function copyRecursive(src, dest) {
  if (!fs.existsSync(dest)) {
    fs.mkdirSync(dest, { recursive: true });
  }

  const entries = fs.readdirSync(src, { withFileTypes: true });
  for (const entry of entries) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);

    if (entry.isDirectory()) {
      copyRecursive(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

console.log('Compiling...');
if (fs.existsSync(distDir)) {
  fs.rmSync(distDir, { recursive: true, force: true });
}
fs.mkdirSync(distDir);

copyRecursive(srcDir, path.join(distDir, 'src'));
copyRecursive('examples', path.join(distDir, 'examples'));
copyRecursive('tests', path.join(distDir, 'tests'));

// Create a simple index.html for the example
const html = `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ECS Frontend Example</title>
</head>
<body>
    <div id="app"></div>
    <script type="module" src="./examples/main.js"></script>
</body>
</html>
`;

fs.writeFileSync(path.join(distDir, 'index.html'), html);

console.log('Build complete. Serve "dist" directory to see the example.');
