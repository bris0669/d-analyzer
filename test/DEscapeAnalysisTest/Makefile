TARGET = DEscapeAnalysisTest
PRODUCTION_FILES=../../DEscapeAnalysis/DSourceCodeInstrumenter.d ../../DEscapeAnalysis/Subprocess.d ../../DEscapeAnalysis/DEscapeAnalysisEngine.d

all: build

build:
	ldc2 -gc *.d ../../Shared/*.d ../../ThirdParty/dunit/*.d $(PRODUCTION_FILES) -of=../../bin/$(TARGET)

test:
	../../bin/$(TARGET)

clean:
	rm ../../bin/$(TARGET)
