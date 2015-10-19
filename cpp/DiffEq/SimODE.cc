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
    
void SimODE::setInitialState(std::valarray<double> init_state) {
    initial_state = init_state;
}

void SimODE::setStepSize(double st_size) {
    step_size = st_size;
}

std::valarray<double> SimODE::getState() {
    return current_state;
}

double SimODE::getTime() {
    return current_time;
}

void SimODE::setStopTime(double t_final) {
    stop_time = t_final;
}

void SimODE::setDerivFunction(std::valarray<double> (*dFuncPointer)(std::valarray<double>, double, std::valarray<double>)) {
    deriv_func = dFuncPointer;
}

void SimODE::setParams(std::valarray<double> params_vec) {
    params = params_vec;
}

void SimODE::reset() {
    current_time = initial_time;
    current_state = initial_state;
} 

bool SimODE::step() {
    switch (integrator_type) {
        case euler: {
            //do euler integration
            deriv = deriv_func(current_state, current_time, params);
            for (int i=0;i<current_state.size();i++) {
                current_state[i] += step_size * deriv[i];
            }
            current_time += step_size;
            break;
        }
        case rk4: {
            k1 = deriv_func(current_state, current_time, params);
            k2 = deriv_func(current_state + k1 * (step_size / 2),
                            current_time + step_size / 2, params);
            k3 = deriv_func(current_state + k2 * (step_size / 2),
                            current_time + step_size / 2, params);
            k4 = deriv_func(current_state + k2 * step_size,
                            current_time + step_size, params);
            current_state += (k1 + k2 * 2 + k3 * 2 + k4) * (step_size / 6);
            current_time += step_size;
            break;
        }
    }
    return (current_time <= stop_time);
}
