/******************************************
* File Name: SimODE.h
* Purpose:
* Creation Date: 02-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include <vector>

enum IntegType {euler, rk4};

class SimODE {
    private:
        double step_size;
        double initial_time;
        double (*deriv_func)(double);
        double current_time;
        std::vector<double> current_state;
        std::vector<double> initial_state;
        IntegType integrator_type;

    public:
        void setIntegratorType(IntegType);
        void setInitialTime(double);
        void setInitialState(std::vector<double>);
        void setStepSize(double);
        void reset();
        void step();
};
        
