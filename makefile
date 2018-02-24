all:
	sudo rainbow --build $(shell pwd) --arch armv7 -v
	sudo rainbow --pack $(shell pwd) --arch armv7 -v

clean:
	rainbow --clean $(shell pwd) --arch armv7 -v
