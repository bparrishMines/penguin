#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

javac -d $SCRIPT_DIR/classes -classpath $SCRIPT_DIR/classes:$SCRIPT_DIR/lib/* $(find $SCRIPT_DIR -name '*.java')
java -classpath $SCRIPT_DIR/classes:$SCRIPT_DIR/lib/* GenAndroidCode "$@"
