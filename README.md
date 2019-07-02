# WebP

WebP is a modern image format that provides superior lossless and lossy compression for images on the web. Using WebP, webmasters and web developers can create smaller, richer images that make the web faster.

WebP lossless images are 26% smaller in size compared to PNGs. WebP lossy images are 25-34% smaller than comparable JPEG images at equivalent SSIM quality index.

Lossless WebP supports transparency (also known as alpha channel) at a cost of just 22% additional bytes. For cases when lossy RGB compression is acceptable, lossy WebP also supports transparency, typically providing 3× smaller file sizes compared to PNG.

You can install webp with:

```shell
wapm install webp
```

## Commands

WebP in wapm ships with two commands:

* `cwebp`: Encoding Tool
* `dwebp`: Decoding Tool


### Encoding tool

The easiest use for the encoding tool `cwebp` should look like:
```
$ cwebp input.png -q 80 -o output.webp
```

You can run the `cwebp` help:

```bash
$ cwebp  -longhelp
Usage:
 cwebp [-preset <...>] [options] in_file [-o out_file]

If input size (-s) for an image is not specified, it is
assumed to be a PNG, JPEG, TIFF or WebP file.

Options:
  -h / -help ............. short help
  -H / -longhelp ......... long help
  -q <float> ............. quality factor (0:small..100:big), default=75
  -alpha_q <int> ......... transparency-compression quality (0..100),
                           default=100
  -preset <string> ....... preset setting, one of:
                            default, photo, picture,
                            drawing, icon, text
     -preset must come first, as it overwrites other parameters
  -z <int> ............... activates lossless preset with given
                           level in [0:fast, ..., 9:slowest]

  -m <int> ............... compression method (0=fast, 6=slowest), default=4
  -segments <int> ........ number of segments to use (1..4), default=4
  -size <int> ............ target size (in bytes)
  -psnr <float> .......... target PSNR (in dB. typically: 42)

  -s <int> <int> ......... input size (width x height) for YUV
  -sns <int> ............. spatial noise shaping (0:off, 100:max), default=50
  -f <int> ............... filter strength (0=off..100), default=60
  -sharpness <int> ....... filter sharpness (0:most .. 7:least sharp), default=0
  -strong ................ use strong filter instead of simple (default)
  -nostrong .............. use simple filter instead of strong
  -sharp_yuv ............. use sharper (and slower) RGB->YUV conversion
  -partition_limit <int> . limit quality to fit the 512k limit on
                           the first partition (0=no degradation ... 100=full)
  -pass <int> ............ analysis pass number (1..10)
  -crop <x> <y> <w> <h> .. crop picture with the given rectangle
  -resize <w> <h> ........ resize picture (after any cropping)
  -mt .................... use multi-threading if available
  -low_memory ............ reduce memory usage (slower encoding)
  -map <int> ............. print map of extra info
  -print_psnr ............ prints averaged PSNR distortion
  -print_ssim ............ prints averaged SSIM distortion
  -print_lsim ............ prints local-similarity distortion
  -d <file.pgm> .......... dump the compressed output (PGM file)
  -alpha_method <int> .... transparency-compression method (0..1), default=1
  -alpha_filter <string> . predictive filtering for alpha plane,
                           one of: none, fast (default) or best
  -exact ................. preserve RGB values in transparent area, default=off
  -blend_alpha <hex> ..... blend colors against background color
                           expressed as RGB values written in
                           hexadecimal, e.g. 0xc0e0d0 for red=0xc0
                           green=0xe0 and blue=0xd0
  -noalpha ............... discard any transparency information
  -lossless .............. encode image losslessly, default=off
  -near_lossless <int> ... use near-lossless image
                           preprocessing (0..100=off), default=100
  -hint <string> ......... specify image characteristics hint,
                           one of: photo, picture or graph

  -metadata <string> ..... comma separated list of metadata to
                           copy from the input to the output if present.
                           Valid values: all, none (default), exif, icc, xmp

  -short ................. condense printed message
  -quiet ................. don't print anything
  -version ............... print version number and exit
  -noasm ................. disable all assembly optimizations
  -v ..................... verbose, e.g. print encoding/decoding times
  -progress .............. report encoding progress

Experimental Options:
  -jpeg_like ............. roughly match expected JPEG size
  -af .................... auto-adjust filter strength
  -pre <int> ............. pre-processing filter
```

### Decoding tool

The easiest use for the decoding tool `dwebp` should look like:
```
$ dwebp test.webp -o test.png
```

You can run the `dwebp` help:

```bash
$ dwebp  -h
Usage: dwebp in_file [options] [-o out_file]

Decodes the WebP image file to PNG format [Default]
Use following options to convert into alternate image formats:
  -pam ......... save the raw RGBA samples as a color PAM
  -ppm ......... save the raw RGB samples as a color PPM
  -bmp ......... save as uncompressed BMP format
  -tiff ........ save as uncompressed TIFF format
  -pgm ......... save the raw YUV samples as a grayscale PGM
                 file with IMC4 layout
  -yuv ......... save the raw YUV samples in flat layout

 Other options are:
  -version ..... print version number and exit
  -nofancy ..... don't use the fancy YUV420 upscaler
  -nofilter .... disable in-loop filtering
  -nodither .... disable dithering
  -dither <d> .. dithering strength (in 0..100)
  -alpha_dither  use alpha-plane dithering if needed
  -mt .......... use multi-threading
  -crop <x> <y> <w> <h> ... crop output with the given rectangle
  -resize <w> <h> ......... scale the output (*after* any cropping)
  -flip ........ flip the output vertically
  -alpha ....... only save the alpha plane
  -incremental . use incremental decoding (useful for tests)
  -h ........... this help message
  -v ........... verbose (e.g. print encoding/decoding times)
  -quiet ....... quiet mode, don't print anything
  -noasm ....... disable all assembly optimizations
```


## Building from Source

You will need Emscripten SDK (emsdk) to build `cwebp.wasm` and `dwebp.wasm` files.

Steps:

1. Setup emsdk (>= 1.38.11), see [Installation Instructions](https://github.com/juj/emsdk#installation-instructions)
2. Run `bash build.sh`
