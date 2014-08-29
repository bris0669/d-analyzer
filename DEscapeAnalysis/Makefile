TARGET = DEscapeAnalysis

all: build

build:
	ldc2 -gc *.d ../Shared/Log.d ../Shared/ProcessResult.d ../Shared/Subprocess.d ../Shared/StaticAnalysisWarning.d -of=../bin/$(TARGET)

clean:
	rm ../bin/$(TARGET)
