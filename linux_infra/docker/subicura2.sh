docker run --rm  -d \
	-p 4568:4567 \
	-e ENDPOINT=https://workshop-docker-kr.herokuapp.com/ \
	-e PARAM_NAME=yoohaha \
	--name subicura2 \
	subicura/docker-workshop-app:2
