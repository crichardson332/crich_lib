/******************************************
* File Name: sim.h
* Purpose:
* Creation Date: 02-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include <vector>

enum IntegType {euler, rk4};

class Sim {
    public:
        double step_size;
        std::vector<double> initial_state;
        double initial_time;

    private:
        IntegType integrator_type;
        double (*deriv_func)(double);
        double current_state;
        double current_time;

    public:
        void setIntegratorType(IntegType);
        void setInitialState(std::vector<double>);
        void step();
};
        
