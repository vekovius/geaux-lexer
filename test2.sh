#!/bin/bash

# --------------------------------------
# Setup CLASSPATH
# --------------------------------------
export CLASSPATH=$CLASSPATH:$(pwd)
export CLASSPATH=$CLASSPATH:$(pwd)/.solution/
export CLASSPATH=$CLASSPATH:$(pwd)/bin/
export CLASSPATH=$CLASSPATH:$(pwd)/lib/*

# --------------------------------------
# Build once
# --------------------------------------
echo "Building lexer..."
rm -rf bin
rm -rf Parse/antlr_build

# Generate lexer code
java -jar ./lib/antlr-4.13.2-complete.jar Parse/gLexer.g4 -o ./Parse/antlr_build

# Compile all Java sources
find . -name "*.java" > sources.txt
javac -d bin @sources.txt
rm sources.txt
echo "Build complete."

# --------------------------------------
# Run all tests
# --------------------------------------
echo "Running tests..."
testfiles=($(find ./tests/ -type f))

# Clean report
echo "################################################################################" > report.txt

for testfile in "${testfiles[@]}"; do
    echo "################################################################################" >> report.txt
    cat "$testfile" >> report.txt
    echo -e "\n" >> report.txt
    echo "$testfile" >> report.txt
    java Parse.LexerDriver "$testfile" >> report.txt 2>&1
done

# Optional: run solution if you want to compare
echo "Running solution..."
echo "################################################################################" > solution_report.txt
for testfile in "${testfiles[@]}"; do
    echo "################################################################################" >> solution_report.txt
    cat "$testfile" >> solution_report.txt
    echo -e "\n" >> solution_report.txt
    echo "$testfile" >> solution_report.txt
    ./run_solution.sh "$testfile" >> solution_report.txt 2>&1
done

# Compare
diff -u report.txt solution_report.txt >> final_report.txt
echo "Tests complete. Check report.txt and final_report.txt."
