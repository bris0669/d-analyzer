all: build_service

build_service:
	ldc2 service/*.d -of=www/cgi-bin/service

clean:
	rm www/cgi-bin/*
