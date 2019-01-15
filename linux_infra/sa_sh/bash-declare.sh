#!/bin/bash

url_template="http://www.example.org/download/img_%03d.jpg"

# 카운터 변수 count를 정수형으로 선언
#(1)
declare -i count=0

while [ $count -le 10 ]
do
  url=$(printf "$
" $count)
  curl -O "$url"

  # count를 1 늘림. expr 명령어 없이 계산식만으로 가능
  #(2)
  count=count+1
done

/*

2.표현식
※주의사항: [ 뒤와, ] 앞에는 반드시 공백이 있어야 한다.

[ $A -eq $B ] A와B의 값이 같은 경우
[ $A -ne $B ] A와B의 값이 다른 경우
[ $A -gt $B ] A가B보다 큰경우
[ $A -lt $B ] A가B보다 작은경우
[ $A -ge $B ] A가B보다 크거나 같은 경우
[ $A -le $B ] A가B보다 작거나 같은 경우

[ -s 파일명 ] 파일이 존재하면서 크기가 0보다 큰경우
[ -f 파일명 ] 디렉토리가 아닌 파일일경우 (크기 0인 경우 포함)
[ -d 디렉토리 ] 파일이 아닌 디렉토리인 경우
[ -w 파일명 ] 쓰기가 가능한 경우
[ -r 파일명 ] 읽기가 가능한 경우
[ ! -option 파일명 ] 옵션의 조건이 거짓이 되는 경우

[ "문자열1" = "문자열2" ] 두문자열이 같은 경우
[ "문자열1" != "문자열2" ] 두문자열이 다른 경우
[ -z "문자열" ] 문자열이 길이가 0인 경우
[ -n "문자열" ] 문자열이 길이가 0이 아닌 경우

*/