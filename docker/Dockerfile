# Keeping this as an old version of debian to maximize libc version compatibility
FROM debian:8

RUN apt-get update && \
  apt-get -y install \
    bzip2 \
    curl \
    g++ \
    gcc \
    gettext \
    git \
    gperf \
    gtk-doc-tools \
    libmount-dev \
    libssl-dev \
    make \
    nasm \
    openssl \
    pax-utils \
    pkg-config \
    wget \
    x11proto-xext-dev

# https://www.zlib.net/
RUN ZLIB_VERION=1.2.11 && \
  curl -O https://zlib.net/fossils/zlib-${ZLIB_VERION}.tar.gz && \
  tar -xvf zlib-${ZLIB_VERION}.tar.gz && \
  cd zlib-${ZLIB_VERION} && \
  ./configure && make && make install && \
  cd .. && rm -rf zlib-${ZLIB_VERION}* && \
  ldconfig

# https://www.python.org/downloads/
# debian:8 installs an older version of python that is not supported by meson, so cannot `apt-get install python`.
# Python 3.7.0+ does not compile with the ssl module because incompatible version of openssl
RUN PYTHON_VERSION=3.6.9 && \
  curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
  tar -xvf Python-${PYTHON_VERSION}.tgz && \
  cd Python-${PYTHON_VERSION} && \
  ./configure --enable-shared --with-ensurepip=yes && \
  make && make install && \
  cd .. && rm -rf Python-${PYTHON_VERSION}* && \
  ldconfig

# Install meson/ninja via pip instead of apt since some packages require building with a newer version of those tools.
RUN pip3 install meson ninja

RUN curl -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal
ENV PATH "$PATH:/root/.cargo/bin"

# https://sourceforge.net/projects/giflib/files/
RUN GIFLIB_VERSION=5.2.1 && \
  curl -LO https://downloads.sourceforge.net/project/giflib/giflib-${GIFLIB_VERSION}.tar.gz && \
  tar -xvf giflib-${GIFLIB_VERSION}.tar.gz && \
  cd giflib-${GIFLIB_VERSION} && \
  make && make install && \
  cd .. && rm -rf giflib-${GIFLIB_VERSION}* && \
  ldconfig

# https://sourceware.org/libffi/
RUN LIBFFI_VERSION=3.3 && \
  curl -O https://sourceware.org/ftp/libffi/libffi-${LIBFFI_VERSION}.tar.gz && \
  tar -xvf libffi-${LIBFFI_VERSION}.tar.gz && \
  cd libffi-${LIBFFI_VERSION} && \
  ./configure && make && make install && \
  cd .. && rm -rf libffi-${LIBFFI_VERSION}* && \
  ldconfig

# http://www.libpng.org/pub/png/libpng.html
RUN LIBPNG_VERSION=1.6.37 && \
  curl -LO https://download.sourceforge.net/libpng/libpng-${LIBPNG_VERSION}.tar.gz && \
  tar -xvf libpng-${LIBPNG_VERSION}.tar.gz && \
  cd libpng-${LIBPNG_VERSION} && \
  # Pass in custom libs, otherwise fails to link against old zlib system dependency (not the version installed above)
  LDFLAGS="-L=/usr/local/lib" ./configure && \
  make && make install && \
  cd .. && rm -rf libpng-${LIBPNG_VERSION}* && \
  ldconfig

# https://github.com/libjpeg-turbo/libjpeg-turbo/releases
# Unsure if 2.x versions can be used
RUN LIBJPEG_TURBO_VERSION=1.5.3 && \
  curl -LO https://downloads.sourceforge.net/project/libjpeg-turbo/${LIBJPEG_TURBO_VERSION}/libjpeg-turbo-${LIBJPEG_TURBO_VERSION}.tar.gz && \
  tar -xvf libjpeg-turbo-${LIBJPEG_TURBO_VERSION}.tar.gz && \
  cd libjpeg-turbo-${LIBJPEG_TURBO_VERSION} && \
  ./configure --prefix=/usr/local && \
  make && make install && \
  cd .. && rm -rf libjpeg-turbo-${LIBJPEG_TURBO_VERSION}* && \
  ldconfig

# https://www.pcre.org/
RUN PCRE_VERSION=8.44 && \
  curl -O https://ftp.pcre.org/pub/pcre/pcre-${PCRE_VERSION}.tar.bz2 && \
  tar -xvf pcre-${PCRE_VERSION}.tar.bz2 && \
  cd pcre-${PCRE_VERSION} && \
  ./configure --enable-pcre16 --enable-pcre32 --enable-utf --enable-unicode-properties && \
  make && make install && \
  cd .. && rm -rf pcre-${PCRE_VERSION}* && \
  ldconfig

# https://github.com/GNOME/glib/releases
RUN GLIB_VERSION=2.64.2 && \
  GLIB_VERSION_SHORT=$(echo ${GLIB_VERSION} | sed 's/\.[0-9]*$//g') && \
  curl -LO http://ftp.gnome.org/pub/gnome/sources/glib/${GLIB_VERSION_SHORT}/glib-${GLIB_VERSION}.tar.xz && \
  tar -xvf glib-${GLIB_VERSION}.tar.xz && \
  cd glib-${GLIB_VERSION} && \
  meson _build && ninja -C _build && ninja -C _build install && \
  cd .. && rm -rf glib-${GLIB_VERSION}* && \
  ldconfig

# https://www.freetype.org/
RUN FREETYPE_VERSION=2.10.1 && \
  curl -LO https://downloads.sourceforge.net/project/freetype/freetype2/${FREETYPE_VERSION}/freetype-${FREETYPE_VERSION}.tar.gz && \
  tar -xvf freetype-${FREETYPE_VERSION}.tar.gz && \
  cd freetype-${FREETYPE_VERSION} && \
  ./configure && make && make install && \
  cd .. && rm -rf freetype-${FREETYPE_VERSION}* && \
  ldconfig

# https://github.com/harfbuzz/harfbuzz/releases
RUN HARFBUZZ_VERSION=2.6.5 && \
  curl -LO https://github.com/harfbuzz/harfbuzz/releases/download/${HARFBUZZ_VERSION}/harfbuzz-${HARFBUZZ_VERSION}.tar.xz && \
  tar -xvf harfbuzz-${HARFBUZZ_VERSION}.tar.xz && \
  cd harfbuzz-${HARFBUZZ_VERSION} && \
  ./configure && make && make install && \
  cd .. && rm -rf harfbuzz-${HARFBUZZ_VERSION}* && \
  ldconfig

# https://libexpat.github.io/
RUN EXPAT_VERSION=2.2.9 && \
  curl -LO https://downloads.sourceforge.net/project/expat/expat/${EXPAT_VERSION}/expat-${EXPAT_VERSION}.tar.bz2 && \
  tar -xvf expat-${EXPAT_VERSION}.tar.bz2 && \
  cd expat-${EXPAT_VERSION} && \
  ./configure && make && make install && \
  cd .. && rm -rf expat-${EXPAT_VERSION}* && \
  ldconfig

# https://www.freedesktop.org/wiki/Software/fontconfig/
# 2.13.9x are labeled as 2.14-RC builds
RUN FONTCONFIG_VERSION=2.13.1 && \
  curl -O https://www.freedesktop.org/software/fontconfig/release/fontconfig-${FONTCONFIG_VERSION}.tar.bz2 && \
  tar -xvf fontconfig-${FONTCONFIG_VERSION}.tar.bz2 && \
  cd fontconfig-${FONTCONFIG_VERSION} && \
  ./configure --enable-static --sysconfdir=/etc --localstatedir=/var && \
  make && make install && \
  cd .. && rm -rf fontconfig-${FONTCONFIG_VERSION}* && \
  ldconfig

# https://www.cairographics.org/releases/
RUN PIXMAN_VERSION=0.38.4 && \
  curl -O https://www.cairographics.org/releases/pixman-${PIXMAN_VERSION}.tar.gz && \
  tar -xvf pixman-${PIXMAN_VERSION}.tar.gz && \
  cd pixman-${PIXMAN_VERSION} && \
  ./configure && make && make install && \
  cd .. && rm -rf pixman-${PIXMAN_VERSION}* && \
  ldconfig

# https://www.cairographics.org/releases/
# 1.17.2 is considered a "snapshot" version
RUN CAIRO_VERSION=1.16.0 && \
  curl -O https://cairographics.org/releases/cairo-${CAIRO_VERSION}.tar.xz && \
  tar -xvf cairo-${CAIRO_VERSION}.tar.xz && \
  cd cairo-${CAIRO_VERSION} && \
  ./configure && make && make install && \
  cd .. && rm -rf cairo-${CAIRO_VERSION}* && \
  ldconfig

# https://github.com/fribidi/fribidi/releases/
RUN FRIBIDI_VERSION=1.0.9 && \
  curl -LO https://github.com/fribidi/fribidi/releases/download/v${FRIBIDI_VERSION}/fribidi-${FRIBIDI_VERSION}.tar.xz && \
  tar -xvf fribidi-${FRIBIDI_VERSION}.tar.xz && \
  cd fribidi-${FRIBIDI_VERSION} && \
  meson --prefix=/usr _build && \
  cd _build && ninja && ninja install && \
  cd ../.. && rm -rf fribidi-${FRIBIDI_VERSION}* && \
  ldconfig

# http://ftp.gnome.org/pub/GNOME/sources/pango/
RUN PANGO_VERSION=1.44.7 && \
  PANGO_VERSION_SHORT=$(echo ${PANGO_VERSION} | sed 's/\.[0-9]*$//g') && \
  curl -LO http://ftp.gnome.org/pub/GNOME/sources/pango/${PANGO_VERSION_SHORT}/pango-${PANGO_VERSION}.tar.xz && \
  tar -xvf pango-${PANGO_VERSION}.tar.xz && \
  cd pango-${PANGO_VERSION} && \
  meson --prefix=/usr --sysconfdir=/etc -Dintrospection=false _build && \
  cd _build && ninja && ninja install && \
  cd ../.. && rm -rf pango-${PANGO_VERSION}* && \
  ldconfig

# https://github.com/GNOME/gdk-pixbuf/releases
RUN GDK_PIXBUF_VERSION=2.40.0 && \
  GDK_PIXBUF_VERSION_SHORT=$(echo ${GDK_PIXBUF_VERSION} | sed 's/\.[0-9]*$//g') && \
  curl -LO http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/${GDK_PIXBUF_VERSION_SHORT}/gdk-pixbuf-${GDK_PIXBUF_VERSION}.tar.xz && \
  tar -xvf gdk-pixbuf-${GDK_PIXBUF_VERSION}.tar.xz && \
  cd gdk-pixbuf-${GDK_PIXBUF_VERSION} && \
  meson --prefix=/usr -Dx11=false -Dgir=false _build && \
  cd _build && ninja && ninja install && \
  cd ../.. && rm -rf gdk-pixbuf-${GDK_PIXBUF_VERSION}* && \
  ldconfig

# ftp://xmlsoft.org/libxml2/
RUN LIBXML2_VERSION=2.9.10 && \
  curl -O http://xmlsoft.org/sources/libxml2-${LIBXML2_VERSION}.tar.gz && \
  tar -xvf libxml2-${LIBXML2_VERSION}.tar.gz && \
  cd libxml2-${LIBXML2_VERSION} && \
  ./configure --without-python && \
  make && make install && \
  cd .. && rm -rf libxml2-${LIBXML2_VERSION}* && \
  ldconfig

# https://github.com/GNOME/libcroco/releases
RUN LIBCROCO_VERSION=0.6.13 && \
  LIBCROCO_VERSION_SHORT=$(echo ${LIBCROCO_VERSION} | sed 's/\.[0-9]*$//g') && \
  curl -LO http://ftp.gnome.org/pub/gnome/sources/libcroco/${LIBCROCO_VERSION_SHORT}/libcroco-${LIBCROCO_VERSION}.tar.xz && \
  tar -xvf libcroco-${LIBCROCO_VERSION}.tar.xz && \
  cd libcroco-${LIBCROCO_VERSION} && \
  ./configure && make && make install && \
  cd .. && rm -rf libcroco-${LIBCROCO_VERSION}* && \
  ldconfig

# https://github.com/GNOME/librsvg/releases
RUN LIBRSVG_VERSION=2.48.3 && \
  LIBRSVG_VERSION_SHORT=$(echo ${LIBRSVG_VERSION} | sed 's/\.[0-9]*$//g') && \
  curl -LO  http://ftp.gnome.org/pub/gnome/sources/librsvg/${LIBRSVG_VERSION_SHORT}/librsvg-${LIBRSVG_VERSION}.tar.xz && \
  tar -xvf librsvg-${LIBRSVG_VERSION}.tar.xz && \
  cd librsvg-${LIBRSVG_VERSION} && \
  ./configure --enable-introspection=no && \
  make && make install && \
  cd .. && rm -rf librsvg-${LIBRSVG_VERSION}* && \
  ldconfig

# https://github.com/nvm-sh/nvm/releases
RUN NVM_VERSION=0.35.3 && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash

# https://nodejs.org/en/
RUN NODE_VERSION=13 && \
  export NVM_DIR=$HOME/.nvm && \
  . $NVM_DIR/nvm.sh && \
  nvm install ${NODE_VERSION}
