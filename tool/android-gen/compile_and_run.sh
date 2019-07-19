#!/usr/bin/env bash

android_gen=tool/android-gen

javac -sourcepath $android_gen/src -classpath $android_gen/classes:$android_gen/lib/* $android_gen/src/* -d $android_gen/classes
java -classpath $android_gen/classes:$android_gen/lib/* GenAndroidCode "$@"
