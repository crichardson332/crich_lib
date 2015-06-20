/******************************************
* File Name: classVariables.cpp
* Purpose: Test class variables
* Creation Date: 27-05-2015
* Last Modified: Fri Jun 12 23:54:23 2015
* Created By: Chris Richardson
*******************************************/
#include "classVariables.h"

testClass::testClass() {
    var1 = 0;
    var2 = 0;
    str1 = "Unchanged";
}

void testClass::changeVars() {
    var1 = 5;
    var2 = 2.734996;
    str1 = "This string has now been changed";
}

void testClass::printVars() {
    std::cout << "Var1 is: " << var1 << std::endl;
    std::cout << "Var2 is: " << var2 << std::endl;
    std::cout << "Str1 is: \n" << str1 << std::endl;
    std::cout << "-------------" << std::endl;
}

testClass testClass::getTestClass() {
    std::cout << "MOAR TEST CLASS" << std::endl;
    testClass obj;
    return obj;
}

