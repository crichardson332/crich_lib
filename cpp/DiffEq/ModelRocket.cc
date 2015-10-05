/******************************************
* File Name: ModelRocket.cc
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

std::vector<double> xDot(std::vector<double> x, double time, std::vector<double> params) {
    assert(params.size() == 1);
    std::vector<double> x_dot(x.size());
    const double m = 1.0;
    const double g = 9.81;
    const double CD = 0.1;
    const double T = params[0];
    const double F0 = 200.0 / T;
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
    assert(argc == 2);
    //double timestep = atof(argv[1]); // Timestep input to program
    //double stop_time = atof(argv[2]); // Stop time input to program
    double timestep = 0.01; // Timestep input to program
    double stop_time = 20; // Stop time input to program
    double T = atof(argv[1]);
    SimODE sim;
    IntegType integrator = euler;
    std::vector<double> initial_state {0.0,0.0}; // This requires c++11 to work
    std::vector<double> params {T};
    // Set parameters for sim
    sim.setInitialState(initial_state);
    sim.setInitialTime(0.0);
    sim.setIntegratorType(integrator);
    sim.setStepSize(timestep);
    sim.setDerivFunction(&xDot);
    sim.setStopTime(stop_time);
    sim.setParams(params);
    sim.reset();
    // Keep track of max height
    double max_height = sim.getState()[0];
    // Open csv file for storing data
    std::ofstream myfile;
    myfile.open("model_rocket.csv");
    myfile << sim.getTime() << "," << sim.getState()[0] << "," << sim.getState()[1] << "\n";
    // Step through the simulation until the stop time
    while (sim.step()) {
        myfile << sim.getTime() << "," << sim.getState()[0] << "," << sim.getState()[1] << "\n";
        if (sim.getState()[0] > max_height) {max_height = sim.getState()[0];}
    }
    myfile.close();
    std::cout << max_height << std::endl;

    return 0;
}
