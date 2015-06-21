/******************************************
* File Name: classVariables.h
* Purpose:
* Creation Date: 27-05-2015
* Last Modified: Fri Jun 12 23:54:19 2015
* Created By: Chris Richardson
*******************************************/
#ifndef PYTHONLIB_CPP_CLASS_VARIABLES_H_ 
#define PYTHONLIB_CPP_CLASS_VARIABLES_H_ 

#include <iostream>
#include <string>
#include <exception>
#include <stdexcept>

class testClass {
    public:
        testClass(); // Constructor
        void changeVars();
        void printVars();
        testClass getTestClass();

    private:
        int var1;
        double var2;
        std::string str1;
};
#endif
