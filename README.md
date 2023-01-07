# tlt

### Install 
Download
  https://sourceforge.net/projects/freetdswindows/files/FreeTDS-1.00/FreeTDS-1.00-x86.zip/download

Decompress it to C:\freetds-1.00

git clone https://github.com/dniman/tlt

cd tlt

gem install tiny_tds -- --with-freetds-dir=C:\freetds-1.00

bundle install

During the development was added the trace flag 8780 gives the sql optimizer more time to find the most effective (e.g. quickest) way to retrieve the data.

After convert execute
  exec MSS_OBJECTS_CACHE_SAVE @bUpdAll=1
  exec MSS_OBJECTS_STRUELEM_UPDTREE @bRebuildAll = 1
  bug 180501

