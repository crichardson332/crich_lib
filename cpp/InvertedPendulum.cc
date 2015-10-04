/******************************************
* File Name: InvertedPendulum.cc
* Purpose:
* Creation Date: 03-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include "SimODE.h"

std::vector<double> thetaDot(std::vector<double> theta, double time) {
    std::vector<double> theta_dot(theta.size());
    for (int i=0;i<theta.size();i++) {
        theta_dot[i] = -theta[i];
    }
    return theta_dot;
}

int main() {
    SimODE sim;
    IntegType integrator = euler;
    std::vector<double> initial_state {1,-1}; // This requires c++11 to work
    // Set parameters for sim
    sim.setInitialState(initial_state);
    sim.setInitialTime(0.0);
    sim.setIntegratorType(integrator);
    sim.setStepSize(0.01);
    sim.setDerivFunction(&thetaDot);

    sim.reset();
    // Set initial conditions
    std::vector<double> state1(100), state2(100);
    std::fill(state1.begin(), state1.end(), 0.0);
    std::fill(state2.begin(), state2.end(), 0.0);
    state1[0] = initial_state[0];
    state2[0] = initial_state[1];
    for (int i=1;i<=99;i++) {
        if (i == 50) {
            sim.reset();
        }
        sim.step();
        state1[i] = sim.getState()[0];
        state2[i] = sim.getState()[1];
        std::cout << "x1: " << state1[i];
        std::cout << "       x2: " << state2[i] << std::endl;
    }

    return 0;
}
