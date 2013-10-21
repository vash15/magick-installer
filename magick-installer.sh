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

mkdir magick-installer
cd magick-installer

download http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
download http://download.savannah.gnu.org/releases/freetype/freetype-2.5.0.1.tar.gz
download ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng16/libpng-1.6.6.tar.gz
download http://www.ijg.org/files/jpegsrc.v9.tar.gz
download http://download.osgeo.org/libtiff/tiff-4.0.3.tar.gz
download http://downloads.sourceforge.net/lcms/lcms2-2.5.tar.gz
download http://downloads.ghostscript.com/public/ghostscript-9.10.tar.gz
download http://voxel.dl.sourceforge.net/project/gs-fonts/gs-fonts/8.11%20%28base%2035%2C%20GPL%29/ghostscript-fonts-std-8.11.tar.gz
download http://www.imagemagick.org/download/ImageMagick-6.8.7-1.tar.gz


tar xzvf libiconv-1.14.tar.gz
cd libiconv-1.14
cd libcharset
./configure --prefix=/usr/local
make
sudo make install
cd ../..

tar xzvf freetype-2.5.0.1.tar.gz
cd freetype-2.5.0.1
./configure --prefix=/usr/local
make clean
make
sudo make install
cd ..

tar xzvf libpng-1.6.6.tar.gz
cd libpng-1.6.6
./configure --prefix=/usr/local
make clean
make
sudo make install
cd ..

tar xzvf jpegsrc.v9.tar.gz
cd jpeg-9
./configure --enable-shared --prefix=/usr/local
make clean
make
sudo make install
cd ..

tar xzvf tiff-4.0.3.tar.gz
cd tiff-4.0.3
./configure --prefix=/usr/local
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

tar zxvf ghostscript-9.10.tar.gz
cd ghostscript-9.10
./configure  --prefix=/usr/local
make clean
make
sudo make install
cd ..

tar zxvf ghostscript-fonts-std-8.11.tar.gz
sudo mkdir -p /usr/local/share/ghostscript/fonts
sudo mv -f fonts/* /usr/local/share/ghostscript/fonts

tar xzvf ImageMagick-6.8.7-1.tar.gz
cd ImageMagick-6.8.7-1
export CPPFLAGS=-I/usr/local/include
export LDFLAGS=-L/usr/local/lib
./configure --prefix=/usr/local --disable-static --without-fontconfig --with-modules --without-perl --without-magick-plus-plus --with-quantum-depth=8 --with-gs-font-dir=/usr/local/share/ghostscript/fonts --disable-openmp
make clean
make
sudo make install
cd ..

sudo ln -s /usr/local/include/ImageMagick/wand /usr/local/include/wand
sudo ln -s /usr/local/include/ImageMagick/magick /usr/local/include/magick

echo "ImageMagick successfully installed!"
