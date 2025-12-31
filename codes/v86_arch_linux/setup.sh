#!/bin/bash
mkdir -p bios images
echo "Downloading BIOS..."
curl -L -o bios/seabios.bin https://github.com/copy/v86/raw/master/bios/seabios.bin
curl -L -o bios/vgabios.bin https://github.com/copy/v86/raw/master/bios/vgabios.bin

echo "Downloading Damn Small Linux ISO (50MB)..."
# Using a mirror or archive link if main site is slow.
curl -L -o images/dsl.iso http://distro.ibiblio.org/damnsmall/current/dsl-4.4.10.iso

echo "Setup complete. You can now run 'node index.js'."
