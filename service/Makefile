TARGET = service

all: build

build:
	ldc2 *.d ../Shared/Log.d ../Shared/Subprocess.d ../Shared/ProcessResult.d -of=../www/cgi-bin/$(TARGET)

clean:
	rm ../www/cgi-bin/$(TARGET)
