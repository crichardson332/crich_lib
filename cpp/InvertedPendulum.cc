/******************************************
* File Name: InvertedPendulum.cc
* Purpose:
* Creation Date: 03-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include "SimODE.h"

int main() {
    SimODE sim1;
    IntegType integrator = rk4;
    //size_t num_states = 2;
    std::vector<double> state_vec0 {0,0}; // This requires c++11 to work
    sim1.setInitialState(state_vec0);
    sim1.setIntegratorType(integrator);
}
