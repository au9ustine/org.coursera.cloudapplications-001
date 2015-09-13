#!/bin/bash

target=TitleCount

# Compile
hadoop com.sun.tools.javac.Main "$target".java -d build

# Packaging
jar -cvf "$target".jar -C build/ ./

# Clean
hadoop fs -rm -r /mp2/A-output

# Run
hadoop jar "$target".jar "$target" -D stopwords=/mp2/misc/stopwords.txt -D delimiters=/mp2/misc/delimiters.txt /mp2/titles /mp2/A-output

# Check result
hadoop fs -cat /mp2/A-output/part* | sort -n -k2 -r | head -10

