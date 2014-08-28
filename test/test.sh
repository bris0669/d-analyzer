#!/usr/bin/env bash

set -x

cd ../bin

cd ../CodeToCompilerRepresentation
make
EXITSTATUS=$?
if (($EXITSTATUS > 0)); then
  exit $EXITSTATUS
fi
cd ../bin

cd ../DEscapeAnalysis
make
EXITSTATUS=$?
if (($EXITSTATUS > 0)); then
  exit $EXITSTATUS
fi
cd ../bin

cd ../test
bash testCodeToCompilerRepresentation.sh
EXITSTATUS=$?
if (($EXITSTATUS > 0)); then
  exit $EXITSTATUS
fi
cd ../bin

cd .
bash ../test/testDEscapeAnalysis.sh
EXITSTATUS=$?
if (($EXITSTATUS > 0)); then
  exit $EXITSTATUS
fi

cd ../test/DEscapeAnalysisTest
make && make test
/EXITSTATUS=$?
if (($EXITSTATUS > 0)); then
  exit $EXITSTATUS
fi
cd ../../bin
