/******************************************
* File Name: UnforcedPendulum.cc
* Purpose:
* Creation Date: 03-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include "SimODE.h"
#include <math.h>
#include <assert.h>
#include <fstream>
#include <cstdlib>

std::valarray<double> xDot(std::valarray<double> x, double time, std::valarray<double> params) {
    std::valarray<double> x_dot(x.size());
    double L = 1.0;
    double g = 9.81;
    x_dot[0] = x[1];
    x_dot[1] = -g / L * sin(x[0]);
    
    //for (int i=0;i<x.size();i++) {
    //    x_dot[i] = -x[i];
    //}
    return x_dot;
}

int main(int argc, char* argv[]) {
    assert(argc == 2);
    double timestep = atof(argv[1]); // Have timestep as input to program
    SimODE sim;
    IntegType integrator = rk4;
    std::valarray<double> initial_state {1.0,-0.5}; // This requires c++11 to work
    // Set parameters for sim
    sim.setInitialState(initial_state);
    sim.setInitialTime(0.0);
    sim.setIntegratorType(integrator);
    sim.setStepSize(timestep);
    sim.setDerivFunction(&xDot);
    sim.setStopTime(20.0);
    sim.reset();
    // Open csv file for storing data
    std::ofstream myfile;
    myfile.open("pendulum.csv");
    //myfile << "XT = [" << sim.getTime() << "," << sim.getState()[0] << "," << sim.getState()[1] << ";" << "\n";
    myfile << sim.getTime() << " " << sim.getState()[0] << " " << sim.getState()[1] << "\n";
    // Step through the simulation until the stop time
    while (sim.step()) {
        //myfile << sim.getTime() << "," << sim.getState()[0] << "," << sim.getState()[1] << ";" << "\n";
        myfile << sim.getTime() << " " << sim.getState()[0] << " " << sim.getState()[1] << "\n";
    }
    myfile.close();

    return 0;
}
