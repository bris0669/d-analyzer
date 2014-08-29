TARGET = DEscapeAnalysisTest
PRODUCTION_FILES=../../DEscapeAnalysis/DSourceCodeInstrumenter.d  ../../DEscapeAnalysis/DEscapeAnalysisEngine.d ../../DEscapeAnalysis/DWarningsGenerator.d

all: build

build:
	ldc2 -gc *.d ../../Shared/*.d ../../ThirdParty/dunit/*.d $(PRODUCTION_FILES) -of=../../bin/$(TARGET)

test:
	cd ../../bin && pwd && ./$(TARGET)

clean:
	rm ../../bin/$(TARGET)
