/******************************************
* File Name: main.cpp
* Purpose:
* Creation Date: 12-06-2015
* Last Modified: Fri Jun 12 23:54:23 2015
* Created By: Chris Richardson
*******************************************/
#include "classVariables.h" 

int main() {
    testClass tc1;
    testClass tc2 = tc1.getTestClass().
        getTestClass(). 
        getTestClass().
        getTestClass().
        getTestClass().
        getTestClass().
        getTestClass();
    tc2.changeVars();
    tc2.printVars();

    return 0;
}
