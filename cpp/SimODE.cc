/******************************************
* File Name: SimODE.cc
* Purpose: Provide class for doing
*          numerical integration
* Creation Date: 02-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include "sim.h"
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

int main() {
    SimODE sim1;
    IntegType integrator = rk4;
    //size_t num_states = 2;
    std::vector<double> state_vec0 {0,0}; // This requires c++11 to work
    sim1.setInitialState(state_vec0);
    sim1.setIntegratorType(integrator);
}

