/******************************************
* File Name: SimODE.cc
* Purpose: Provide class for doing
*          numerical integration
* Creation Date: 02-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include "SimODE.h"
#include <iostream>

double thetaDot(double theta) {
    return (-theta);
}

void SimODE::setIntegratorType(IntegType integ) {
    std::cout << integ << std::endl;
}

void SimODE::setInitialState(std::vector<double> init_state) {
    initial_state = init_state;
}


