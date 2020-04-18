build:
	docker build -t eco .

run:
	mkdir -p /srv/eco \
	&& docker run --rm -it -p 3000:3000/udp -p 3001:3001 -u $(shell id -u eco):$(shell id -g daemon) --name eco -v /srv/eco:/srv/eco eco

.PHONY: build run
