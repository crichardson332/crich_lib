/******************************************
* File Name: namespaces.cc
* Purpose: Testing namespaces
* Creation Date: 26-07-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include <iostream>

using std::cout;
using std::endl;

namespace foo
{
    int value() { return 5; }
    double x;
}

namespace bar
{
    const double pi = 3.1416;
    double value() { return 2*pi; }
}


int main () {
    double y;
    cout << foo::x << endl;
    cout << y << endl;
    return 0;
}
