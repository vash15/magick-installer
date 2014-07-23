#!/bin/sh
set -e

function download() {
  url=$1
  base=$(basename $1)

  if [[ ! -e $base ]]; then
    echo "curling $url"
    curl -O -L $url
  fi
}

# mkdir magick-installer
cd magick-installer

download http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
download http://download.savannah.gnu.org/releases/freetype/freetype-2.5.3.tar.gz
download http://freefr.dl.sourceforge.net/project/libpng/libpng16/1.6.12/libpng-1.6.12.tar.gz
download http://www.ijg.org/files/jpegsrc.v9.tar.gz
download http://download.osgeo.org/libtiff/tiff-4.0.3.tar.gz
download http://downloads.sourceforge.net/lcms/lcms2-2.5.tar.gz
# download http://downloads.ghostscript.com/public/ghostscript-9.10.tar.gz
download https://ghostscript.googlecode.com/files/ghostscript-fonts-std-8.11.tar.gz
download http://www.imagemagick.org/download/ImageMagick-6.8.9-5.tar.gz


#
# Compile under /opt/local
# 

tar xzvf libiconv-1.14.tar.gz
cd libiconv-1.14
cd libcharset
./configure --prefix=/opt/local
make
sudo make install
cd ../..

tar xzvf freetype-2.5.3.tar.gz
cd freetype-2.5.3
./configure --prefix=/opt/local
make clean
make
sudo make install
cd ..

tar xzvf libpng-1.6.12.tar.gz
cd libpng-1.6.12
./configure --prefix=/opt/local
make clean
make
sudo make install
cd ..

tar xzvf jpegsrc.v9a.tar.gz
cd jpeg-9a
./configure --enable-shared --prefix=/opt/local
make clean
make
sudo make install
cd ..

tar xzvf tiff-4.0.3.tar.gz
cd tiff-4.0.3
./configure --prefix=/opt/local
make clean
make
sudo make install
cd ..

tar xzvf lcms2-2.5.tar.gz
cd lcms2-2.5
./configure
make clean
make
sudo make install
cd ..

# Does not work in OS X
# tar zxvf ghostscript-9.10.tar.gz
# cd ghostscript-9.10
# ./configure  --prefix=/opt/local
# make clean
# make
# sudo make install
# cd ..

tar zxvf ghostscript-fonts-std-8.11.tar.gz
sudo mkdir -p /opt/local/share/ghostscript/fonts
sudo mv -f fonts/* /opt/local/share/ghostscript/fonts

tar xzvf ImageMagick-6.8.9-5.tar.gz
cd ImageMagick-6.8.9-5
export CPPFLAGS=-I/opt/local/include
export LDFLAGS=-L/opt/local/lib
./configure --prefix=/opt/local --disable-static --without-fontconfig --with-modules --without-perl --without-magick-plus-plus --with-quantum-depth=8 --with-gs-font-dir=/opt/local/share/ghostscript/fonts --disable-openmp
make clean
make
sudo make install
cd ..

sudo ln -s /opt/local/include/ImageMagick/wand /opt/local/include/wand
sudo ln -s /opt/local/include/ImageMagick/magick /opt/local/include/magick

# I have problem width convert launch width daemon or ngix. Ad example: convert test.ai test.png
sudo ln -s /opt/local/bin/gs /usr/bin/gs

echo "ImageMagick successfully installed!"
