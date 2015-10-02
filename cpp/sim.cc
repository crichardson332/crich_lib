/******************************************
* File Name: sim.cc
* Purpose: Provide class for doing
*          numerical integration
* Creation Date: 02-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include "sim.h"
#include <iostream>

//double thetaDot(
void Sim::setIntegratorType(IntegType integ) {
    std::cout << integ << std::endl;
}



int main() {
    Sim sim1;
    IntegType myInt = rk4;
    sim1.setIntegratorType(myInt);
}

