#!/usr/bin/env sh

LIBWEBP_VERSION=1.0.2

rm -rf libwebp-${LIBWEBP_VERSION} v${LIBWEBP_VERSION}*
wget https://github.com/webmproject/libwebp/archive/v${LIBWEBP_VERSION}.tar.gz
tar xf v${LIBWEBP_VERSION}.tar.gz
cd libwebp-${LIBWEBP_VERSION}

echo "Configure"
./autogen.sh

emconfigure ./configure \
  --host=wasm32 || exit $?

echo "Build"
emmake make || exit $?

# Generate `.wasm` files
echo "Link"
mv examples/cwebp examples/cwebp.o
emcc examples/cwebp.o -o ../cwebp.wasm

mv examples/dwebp examples/dwebp.o
emcc examples/dwebp.o -o ../dwebp.wasm

echo "Clean"
cd ..
rm -rf libwebp-${LIBWEBP_VERSION} v${LIBWEBP_VERSION}*

echo "Done"
