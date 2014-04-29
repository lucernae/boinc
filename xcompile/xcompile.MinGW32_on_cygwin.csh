set echo
cd ..
setenv TARGET_HOST i686-pc-mingw32
setenv XCOMPILE_ROOT "/usr/${TARGET_HOST}/sys-root/mingw"
set guess=`./config.guess`
setenv BUILD_HOST `./config.sub ${guess}`

setenv CC `which ${TARGET_HOST}-gcc`
setenv CXX `which ${TARGET_HOST}-g++`
setenv AR `which ${TARGET_HOST}-ar`
senenv LD `which ${TARGET_HOST}-ld`
setenv RANLIB `which ${TARGET_HOST}-ranlib`
setenv WINDRES `which ${TARGET_HOST}-windres`
setenv CPPFLAGS "-D_WIN32_WINDOWS=0x0410 -DMINGW_WIN32"
setenv CXXFLAGS "-gstabs -g3"
setenv CURL_CONFIG "${XCOMPILE_ROOT}/bin/curl-config"
setenv WX_CONFIG_PATH "${XCOMPILE_ROOT}/bin/wx-config"
set pkgsearchpath="dummy"
foreach dir ( `find /usr/${TARGET_HOST} -name pkgconfig` ) 
  set pkgsearchpath="${pkgsearchpath}:${dir}"
end
foreach dir ( `find /usr/lib -name pkgconfig` ) 
  set pkgsearchpath="${pkgsearchpath}:${dir}"
end
foreach dir ( `find /usr/share -name pkgconfig` ) 
  set pkgsearchpath="${pkgsearchpath}:${dir}"
end
setenv PKG_CONFIG_PATH `echo ${pkgsearchpath} | sed 's/dummy://'`
bash -x ./configure -C --host=$TARGET_HOST --build=$BUILD_HOST --exec-prefix=/.  --prefix=/. --mandir=/usr/man --docdir=/usr/share/doc/curl --datarootdir=/usr/share --enable-static --disable-shared --enable-libraries --enable-manager --enable-client --disable-server
unset echo
