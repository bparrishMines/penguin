#!/usr/bin/env bash

android_gen=tool/android-gen

javac -d $android_gen/classes -classpath $android_gen/classes:$android_gen/lib/* $(find $android_gen -name '*.java')
java -classpath $android_gen/classes:$android_gen/lib/* GenAndroidCode "$@"
