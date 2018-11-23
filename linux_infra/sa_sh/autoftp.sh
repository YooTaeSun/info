#!/bin/sh

# FTP 접속설정
#(1)
server="13.125.195.148"
user="root"
password="Km~UKo[SArZ!MS3y5S_"
dir="/workspace/test"
filename="1.txt"

#(2)
ftp -n "$server" << __EOT__
user "$user" "$password"
binary
cd "$dir"
get "$filename"
__EOT__


ftp -n "$server" << __EOT__


#sftp -oPort=52209  townsi@13.125.195.148