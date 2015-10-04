/******************************************
* File Name: SimODE.cc
* Purpose: Provide class for doing
*          numerical integration
* Creation Date: 02-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include "SimODE.h"
#include "assert.h"

void SimODE::setIntegratorType(IntegType integ) {
    integrator_type = integ;
}

void SimODE::setInitialTime(double init_time) {
    assert(init_time >= 0);
    initial_time = init_time;
}
    
void SimODE::setInitialState(std::vector<double> init_state) {
    initial_state = init_state;
}

void SimODE::setStepSize(double st_size) {
    step_size = st_size;
}

std::vector<double> SimODE::getState() {
    return current_state;
}

double SimODE::getTime() {
    return current_time;
}

void SimODE::setDerivFunction(std::vector<double> (*dFuncPointer)(std::vector<double>, double)) {
    deriv_func = dFuncPointer;
}

void SimODE::reset() {
    current_time = initial_time;
    current_state = initial_state;
} 

void SimODE::step() {
    switch (integrator_type) {
        case euler: {
            //do euler integration
            std::vector<double> deriv(current_state.size());
            deriv = deriv_func(current_state, current_time);
            for (int i=0;i<current_state.size();i++) {
                current_state[i] += step_size * deriv[i];
            }
            current_time += step_size;
            break;
        }
        case rk4: {
            double temp = 0;
            break;
        }
    }
}
