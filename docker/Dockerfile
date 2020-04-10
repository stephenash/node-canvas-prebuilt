FROM debian:10

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
    pkg-config \
    python \
    python3-pip \
    wget \
    x11proto-xext-dev \
    zlib1g

# Previous 1.2.8
ARG ZLIB_VERION=1.2.11
RUN curl -O https://zlib.net/fossils/zlib-${ZLIB_VERION}.tar.gz && \
  tar -xvf zlib-${ZLIB_VERION}.tar.gz && \
  cd zlib-${ZLIB_VERION} && \
  ./configure && make && make install

RUN pip3 install meson ninja

RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH "$PATH:/root/.cargo/bin"

# Previous 5.1.4
ARG GIFLIB_VERSION=5.2.1
RUN curl -LO https://downloads.sourceforge.net/project/giflib/giflib-${GIFLIB_VERSION}.tar.gz && \
  tar -xvf giflib-${GIFLIB_VERSION}.tar.gz && \
  cd giflib-${GIFLIB_VERSION} && \
  make && make install

# Previous 3.2.1
ARG LIBFFI_VERSION=3.3
RUN curl -O https://sourceware.org/ftp/libffi/libffi-${LIBFFI_VERSION}.tar.gz && \
  tar -xvf libffi-${LIBFFI_VERSION}.tar.gz && \
  cd libffi-${LIBFFI_VERSION} && \
  ./configure && make && make install

# Previous 1.6.35
ARG LIBPNG_VERSION=1.6.37
RUN curl -LO https://download.sourceforge.net/libpng/libpng-${LIBPNG_VERSION}.tar.gz && \
  tar -xvf libpng-${LIBPNG_VERSION}.tar.gz && \
  cd libpng-${LIBPNG_VERSION} && \
  ./configure && make && make install

# Previous 1.5.2
ARG LIBJPEG_TURBO_VERSION=1.5.3
RUN curl -LO https://downloads.sourceforge.net/project/libjpeg-turbo/${LIBJPEG_TURBO_VERSION}/libjpeg-turbo-${LIBJPEG_TURBO_VERSION}.tar.gz && \
  tar -xvf libjpeg-turbo-${LIBJPEG_TURBO_VERSION}.tar.gz && \
  cd libjpeg-turbo-${LIBJPEG_TURBO_VERSION} && \
  ./configure --prefix=/usr/local && \
  make && make install

# Previous 8.41
ARG PCRE_VERSION=8.44
RUN curl -O https://ftp.pcre.org/pub/pcre/pcre-${PCRE_VERSION}.tar.bz2 && \
  tar -xvf pcre-${PCRE_VERSION}.tar.bz2 && \
  cd pcre-${PCRE_VERSION} && \
  ./configure --enable-pcre16 --enable-pcre32 --enable-utf --enable-unicode-properties && \
  make && make install

RUN ldconfig

# Previous 2.52.3
ARG GLIB_VERSION=2.64.2
RUN GLIB_VERSION_SHORT=$(echo ${GLIB_VERSION} | sed 's/\.[0-9]*$//g') && \
  curl -LO http://ftp.gnome.org/pub/gnome/sources/glib/${GLIB_VERSION_SHORT}/glib-${GLIB_VERSION}.tar.xz && \
  tar -xvf glib-${GLIB_VERSION}.tar.xz && \
  cd glib-${GLIB_VERSION} && \
  meson _build && ninja -C _build && ninja -C _build install

# Previous 2.9.1
ARG FREETYPE_VERSION=2.10.1
RUN curl -LO https://downloads.sourceforge.net/project/freetype/freetype2/${FREETYPE_VERSION}/freetype-${FREETYPE_VERSION}.tar.gz && \
  tar -xvf freetype-${FREETYPE_VERSION}.tar.gz && \
  cd freetype-${FREETYPE_VERSION} && \
  ./configure && make && make install

# Previous 1.4.7
ARG HARFBUZZ_VERSION=2.6.4
RUN curl -O https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-${HARFBUZZ_VERSION}.tar.xz && \
  tar -xvf harfbuzz-${HARFBUZZ_VERSION}.tar.xz && \
  cd harfbuzz-${HARFBUZZ_VERSION} && \
  ./configure && make && make install

# Previous 2.2.0
ARG EXPAT_VERSION=2.2.9
RUN curl -LO https://downloads.sourceforge.net/project/expat/expat/${EXPAT_VERSION}/expat-${EXPAT_VERSION}.tar.bz2 && \
  tar -xvf expat-${EXPAT_VERSION}.tar.bz2 && \
  cd expat-${EXPAT_VERSION} && \
  ./configure && make && make install

RUN ldconfig

# Latest 2.13.92 (unstable)
ARG FONTCONFIG_VERSION=2.13.1
RUN curl -O https://www.freedesktop.org/software/fontconfig/release/fontconfig-${FONTCONFIG_VERSION}.tar.bz2 && \
  tar -xvf fontconfig-${FONTCONFIG_VERSION}.tar.bz2 && \
  cd fontconfig-${FONTCONFIG_VERSION} && \
  ./configure --enable-static --sysconfdir=/etc --localstatedir=/var && \
  make && make install

# Previous 0.34.0
ARG PIXMAN_VERSION=0.38.4
RUN curl -O https://www.cairographics.org/releases/pixman-${PIXMAN_VERSION}.tar.gz && \
  tar -xvf pixman-${PIXMAN_VERSION}.tar.gz && \
  cd pixman-${PIXMAN_VERSION} && \
  ./configure && make && make install

ARG CAIRO_VERSION=1.16.0
RUN curl -O https://cairographics.org/releases/cairo-${CAIRO_VERSION}.tar.xz && \
  tar -xvf cairo-${CAIRO_VERSION}.tar.xz && \
  cd cairo-${CAIRO_VERSION} && \
  ./configure && make && make install

# Previous 1.0.5
ARG FRIBIDI_VERSION=1.0.9
RUN curl -LO https://github.com/fribidi/fribidi/releases/download/v${FRIBIDI_VERSION}/fribidi-${FRIBIDI_VERSION}.tar.xz && \
  tar -xvf fribidi-${FRIBIDI_VERSION}.tar.xz && \
  cd fribidi-${FRIBIDI_VERSION} && \
  meson --prefix=/usr _build && \
  cd _build && ninja && ninja install

# # Previous 1.42.4
ARG PANGO_VERSION=1.44.7
RUN PANGO_VERSION_SHORT=$(echo ${PANGO_VERSION} | sed 's/\.[0-9]*$//g') && \
  curl -LO http://ftp.gnome.org/pub/GNOME/sources/pango/${PANGO_VERSION_SHORT}/pango-${PANGO_VERSION}.tar.xz && \
  tar -xvf pango-${PANGO_VERSION}.tar.xz && \
  cd pango-${PANGO_VERSION} && \
  meson --prefix=/usr --sysconfdir=/etc -Dintrospection=false _build && \
  cd _build && ninja && ninja install

RUN ldconfig

# Previous 2.38.0
ARG GDK_PIXBUF_VERSION=2.40.0
RUN GDK_PIXBUF_VERSION_SHORT=$(echo ${GDK_PIXBUF_VERSION} | sed 's/\.[0-9]*$//g') && \
  curl -LO http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/${GDK_PIXBUF_VERSION_SHORT}/gdk-pixbuf-${GDK_PIXBUF_VERSION}.tar.xz && \
  tar -xvf gdk-pixbuf-${GDK_PIXBUF_VERSION}.tar.xz && \
  cd gdk-pixbuf-${GDK_PIXBUF_VERSION} && \
  meson --prefix=/usr -Dx11=false -Dgir=false _build && \
  cd _build && ninja && ninja install

# Previous 2.9.8
ARG LIBXML2_VERSION=2.9.10
RUN curl -O http://xmlsoft.org/sources/libxml2-${LIBXML2_VERSION}.tar.gz && \
  tar -xvf libxml2-${LIBXML2_VERSION}.tar.gz && \
  cd libxml2-${LIBXML2_VERSION} && \
  ./configure --without-python && \
  make && make install

ARG LIBCROCO_VERSION=0.6.12
RUN LIBCROCO_VERSION_SHORT=$(echo ${LIBCROCO_VERSION} | sed 's/\.[0-9]*$//g') && \
  curl -LO http://ftp.gnome.org/pub/gnome/sources/libcroco/${LIBCROCO_VERSION_SHORT}/libcroco-${LIBCROCO_VERSION}.tar.xz && \
  tar -xvf libcroco-${LIBCROCO_VERSION}.tar.xz && \
  cd libcroco-${LIBCROCO_VERSION} && \
  ./configure && make && make install

# Previous 2.44.8
ARG LIBRSVG_VERSION=2.48.3
RUN LIBRSVG_VERSION_SHORT=$(echo ${LIBRSVG_VERSION} | sed 's/\.[0-9]*$//g') && \
  curl -LO  http://ftp.gnome.org/pub/gnome/sources/librsvg/${LIBRSVG_VERSION_SHORT}/librsvg-${LIBRSVG_VERSION}.tar.xz && \
  tar -xvf librsvg-${LIBRSVG_VERSION}.tar.xz && \
  cd librsvg-${LIBRSVG_VERSION} && \
  ./configure --enable-introspection=no && \
  make && make install

RUN ldconfig

# Previous 0.33.1
ARG NVM_VERSION=0.35.3
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | bash

# Previous 7
ARG NODE_VERSION=13
RUN export NVM_DIR=$HOME/.nvm && \
  . $NVM_DIR/nvm.sh && \
  nvm install ${NODE_VERSION}
