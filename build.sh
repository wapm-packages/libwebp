#!/usr/bin/env sh

JPEGLIB_VERSION=9c
LIBWEBP_VERSION=1.0.2

JPEGLIB_DIR=`pwd`/jpeg-9c


configure="emconfigure ./configure --host=wasm32"
make="emmake make -j"


echo "Dependency: JpegLib"

rm -rf jpeg-${JPEGLIB_VERSION} jpegsrc.v${JPEGLIB_VERSION}*
wget http://www.ijg.org/files/jpegsrc.v${JPEGLIB_VERSION}.tar.gz
tar xf jpegsrc.v${JPEGLIB_VERSION}.tar.gz

(
  cd ${JPEGLIB_DIR}

  $configure || exit $?
  $make || exit $?
) || exit $?

rm -rf libwebp-${LIBWEBP_VERSION} v${LIBWEBP_VERSION}*
wget https://github.com/webmproject/libwebp/archive/v${LIBWEBP_VERSION}.tar.gz
tar xf v${LIBWEBP_VERSION}.tar.gz
cd libwebp-${LIBWEBP_VERSION}

echo "Configure"
./autogen.sh

$configure \
  --enable-jpeg \
  --with-jpegincludedir=${JPEGLIB_DIR} \
  --with-jpeglibdir=${JPEGLIB_DIR}/.libs \
  || exit $?

echo "Build"
$make || exit $?

# Generate `.wasm` files
echo "Link"
mv examples/cwebp examples/cwebp.o
emcc examples/cwebp.o -o ../cwebp.wasm

mv examples/dwebp examples/dwebp.o
emcc examples/dwebp.o -o ../dwebp.wasm

echo "Clean"
cd ..

rm -rf jpeg-${JPEGLIB_VERSION} jpegsrc.v${JPEGLIB_VERSION}*
rm -rf libwebp-${LIBWEBP_VERSION} v${LIBWEBP_VERSION}*

echo "Add executable permissions"
chmod +x cwebp.wasm
chmod +x dwebp.wasm

echo "Done"
