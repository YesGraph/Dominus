#!/bin/sh

echo "[DOMINUS]: Loading Dominus..."

DOWNLOAD_URI='https://github.com/YesGraph/Dominus/archive/master.zip'
TARGET_DIR="."

mkdir -p "${TARGET_DIR}/Dominus/"
curl -L $DOWNLOAD_URI | tar xvz -C "${TARGET_DIR}/Dominus/" --strip-components=1

echo "[DOMINUS]: Downloaded & Unpacked from GitHub."
echo "[DOMINUS]: Running integration system..."

chmod +x "${TARGET_DIR}/Dominus/dominus.sh"
"${TARGET_DIR}/Dominus/dominus.sh" integrate
