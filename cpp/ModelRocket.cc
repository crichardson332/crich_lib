/******************************************
* File Name: InvertedPendulum.cc
* Purpose:
* Creation Date: 03-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include "SimODE.h"
#include <math.h>
#include <fstream>
#include <cstdlib>
#include <assert.h>

std::vector<double> xDot(std::vector<double> x, double time) {
    std::vector<double> x_dot(x.size());
    const double m = 1.0;
    const double g = 9.81;
    const double CD = 0.1;
    const double F0 = 2*m*g;
    const double T = 200.0 / F0;
    // Differential equation for rocket in atmosphere
    const double F = F0 * (time <= T);
    if (x[0] >= 0) {
        x_dot[0] = x[1];
        x_dot[1] = F / m - ((x[1] > 0) - (x[1] < 0))*CD * pow(x[1],2) / m - g;
    } else {
        x_dot[0] = 0.0;
        x_dot[1] = 0.0;
    }
    return x_dot;
}

int main(int argc, char* argv[]) {
    assert(argc == 3);
    double timestep = atof(argv[1]); // Have timestep as input to program
    double stop_time = atof(argv[2]); // Have timestep as input to program
    SimODE sim;
    IntegType integrator = euler;
    std::vector<double> initial_state {0.0,0.0}; // This requires c++11 to work
    // Set parameters for sim
    sim.setInitialState(initial_state);
    sim.setInitialTime(0.0);
    sim.setIntegratorType(integrator);
    sim.setStepSize(timestep);
    sim.setDerivFunction(&xDot);
    sim.setStopTime(stop_time);
    sim.reset();
    // Open csv file for storing data
    std::ofstream myfile;
    myfile.open("model_rocket.csv");
    myfile << sim.getTime() << " " << sim.getState()[0] << " " << sim.getState()[1] << "\n";
    // Step through the simulation until the stop time
    while (sim.step()) {
        myfile << sim.getTime() << " " << sim.getState()[0] << " " << sim.getState()[1] << "\n";
    }
    myfile.close();

    return 0;
}
