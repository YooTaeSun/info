#!/bin/sh

# 병렬로 여러 사이트에서 내려받기
# 각각 백그라운드에서 처리
#(1)
curl -sO http://www.example.org/download/bigfile.dat &
curl -sO http://www.example.com/files/sample.pdf &
curl -sO https://imgnews.pstatic.net/image/081/2018/11/19/0002957401_001_20181119034440123.jpg?type=w680 &
