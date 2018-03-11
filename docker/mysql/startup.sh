apt-get install locales

export LANGUAGE=ko_KR.UTF-8 
export LANG=ko_KR.UTF-8
locale-gen ko_KR ko_KR.UTF-8
update-locale LANG=ko_KR.UTF-8
dpkg-reconfigure locales
