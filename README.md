# tlt

### Install 
Download
  https://sourceforge.net/projects/freetdswindows/files/FreeTDS-1.00/FreeTDS-1.00-x86.zip/download

Decompress it to C:\freetds-1.00

git clone https://github.com/dniman/tlt &&
cd tlt

gem install tiny_tds -- --with-freetds-dir=C:\freetds-1.00
bundle install
