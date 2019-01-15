#!/bin/bash

# bash 브레이스 확장 {}으로 IP 주소 목록 작성
#(1)
for ipaddr in 192.168.2.{1..5}
do
  ping -c 1 "$ipaddr" > /dev/null 2>&1 #/dev/null 출력은 쓰레기통으로 보내고 2>&1 (에러가 나면 표준출력으로 ?)

echo "[ >>] -> $?"

  if [ $? -eq 0 ]; then
    echo "[OK] Ping -> $ipaddr"
  else
    echo "[NG] Ping -> $ipaddr"
  fi
done

# $? is a special variable in bash that always holds the return/exit code of the last executed command.
#
# You can view it in a terminal by running echo $?.
#
# Return codes are in the range [0; 255].
# A return code of 0 usually means everything is ok.
# Other values indicate errors.
# Most applications return 1 or custom values. If a command was not found, the variable usually contains 127
#
# If you want to set this variable to a specific value, you can easily do this with bash -c "exit 5" to return for example the return code 5.
