#!/usr/bin/env bash
javac -sourcepath src -classpath classes:lib/* src/* -d classes
java -classpath classes:lib/* GenAndroidCode
