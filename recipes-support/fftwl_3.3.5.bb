require fftw.inc

# conflicts with fftw and fftwf
EXCLUDE_FROM_WORLD = "1"

EXTRA_OECONF += "--enable-long-double"

SRC_URI[md5sum] = "6cc08a3b9c7ee06fdd5b9eb02e06f569"
SRC_URI[sha256sum] = "8ecfe1b04732ec3f5b7d279fdb8efcad536d555f9d1e8fabd027037d45ea8bcf"
