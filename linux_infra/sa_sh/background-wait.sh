#!/bin/sh

# 호스트 세 개를 병렬로 ping 실행. 6번 반복해서
# 각각 5초 대기
#(1)
ping -c 6 www.yahoo.com > host1.log &
ping -c 6 www.google.com > host2.log &
ping -c 6 www.google.com > host3.log &

# 모든 ping 명령어가 종료할 때까지 대기, 동기화
#(2)
wait

# ping 명령어 결과 출력
#(3)
cat host1.log host2.log host3.log
