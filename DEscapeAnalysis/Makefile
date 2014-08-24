binary = DEscapeAnalysis

all: build

build:
	ldc2 -gc *.d ../Shared/*.d -of=../bin/$(binary)

clean:
	rm ../bin/$(binary)
