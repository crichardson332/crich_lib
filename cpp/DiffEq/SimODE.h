/******************************************
* File Name: SimODE.h
* Purpose:
* Creation Date: 02-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include <valarray>
#include <valarray>
#include <iostream>

enum IntegType {euler, rk4};

class SimODE {
    private:
        double step_size;
        double initial_time;
        std::valarray<double> (*deriv_func)(std::valarray<double>, double, std::valarray<double>);
        double current_time;
        double stop_time;
        std::valarray<double> current_state, initial_state, params, 
            k1, k2, k3, k4, deriv;
        IntegType integrator_type;

    public:
        void setIntegratorType(IntegType);
        void setInitialTime(double);
        void setInitialState(std::valarray<double>);
        void setStepSize(double);
        void setStopTime(double);
        std::valarray<double> getState();
        double getTime();
        void setDerivFunction(std::valarray<double> (*deriv_func)(std::valarray<double>, double, std::valarray<double>));
        void setParams(std::valarray<double>);
        void reset();
        bool step();
};
        
