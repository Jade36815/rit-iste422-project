compile : ./src/main/java/*.java src/test/java/*.java
    echo "Compiling source code and unit tests..."
    javac -classpath -d build src/main/java/*.java src/test/java/*.java
    if [ $? -ne 0 ] ; then echo BUILD FAILED!; exit 1; fi


run : compile
    echo "Running application..."
    java -cp build RunEdgeConvert

test : compile
    echo "Running unit tests..."
    java -cp build:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar org.junit.runner.JUnitCore EdgeConnectorTest
    if [ $? -ne 0 ] ; then echo TESTS FAILED!; exit 1; fi

clean : 
    echo "Cleaning existing classes..."
    rm -f *.class
    find . -name \*.class -exec rm {} \;

all : run test clean
    echo "Ran all"
