TARGET = service

all: build

build:
	ldc2 *.d ../Shared/Log.d -of=../www/cgi-bin/$(TARGET)

clean:
	rm ../www/cgi-bin/$(TARGET)
