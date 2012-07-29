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
download http://nongnu.askapache.com/freetype/freetype-2.4.10.tar.gz
download http://iweb.dl.sourceforge.net/project/libpng/libpng15/1.5.12/libpng-1.5.12.tar.gz
download http://www.imagemagick.org/download/delegates/jpegsrc.v8b.tar.gz
download http://download.osgeo.org/libtiff/tiff-4.0.1.tar.gz
download http://voxel.dl.sourceforge.net/project/lcms/lcms/2.3/lcms2-2.3.tar.gz
download http://downloads.ghostscript.com/public/ghostscript-9.05.tar.gz
download http://voxel.dl.sourceforge.net/project/gs-fonts/gs-fonts/8.11%20%28base%2035%2C%20GPL%29/ghostscript-fonts-std-8.11.tar.gz
download ftp://ftp.sunet.se/pub/multimedia/graphics/ImageMagick/ImageMagick-6.7.8-6.tar.gz


tar xzvf libiconv-1.14.tar.gz
cd libiconv-1.14
cd libcharset
./configure --prefix=/usr/local
make
sudo make install
cd ../..

tar xzvf freetype-2.4.10.tar.gz
cd freetype-2.4.10
./configure --prefix=/usr/local
make clean
make
sudo make install
cd ..

tar xzvf libpng-1.5.12.tar.gz
cd libpng-1.5.12
./configure --prefix=/usr/local
make clean
make
sudo make install
cd ..

tar xzvf jpegsrc.v8b.tar.gz
cd jpeg-8b
./configure --enable-shared --prefix=/usr/local
make clean
make
sudo make install
cd ..

tar xzvf tiff-4.0.1.tar.gz
cd tiff-4.0.1
./configure --prefix=/usr/local
make clean
make
sudo make install
cd ..

tar xzvf lcms2-2.3.tar.gz
cd lcms2-2.3
./configure
make clean
make
sudo make install
cd ..

tar zxvf ghostscript-9.05.tar.gz
cd ghostscript-9.05
./configure  --prefix=/usr/local
make clean
make
sudo make install
cd ..

tar zxvf ghostscript-fonts-std-8.11.tar.gz
sudo mkdir -p /usr/local/share/ghostscript/fonts
sudo mv -f fonts/* /usr/local/share/ghostscript/fonts

tar xzvf ImageMagick-6.7.8-6.tar.gz
cd ImageMagick-6.7.8-6
export CPPFLAGS=-I/usr/local/include
export LDFLAGS=-L/usr/local/lib
./configure --prefix=/usr/local --disable-static --without-fontconfig --with-modules --without-perl --without-magick-plus-plus --with-quantum-depth=8 --with-gs-font-dir=/usr/local/share/ghostscript/fonts --disable-openmp
make clean
make
sudo make install
cd ..

cd ..
rm -Rf magick-installer

echo "ImageMagick successfully installed!"
