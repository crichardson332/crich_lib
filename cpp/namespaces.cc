/******************************************
* File Name: namespaces.cc
* Purpose: Testing out namespace code
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
}

namespace bar
{
  const double pi = 3.1416;
  double value() { return 2*pi; }
}


int main () {
  cout << foo::value() << endl;
  cout << bar::value() << endl;
  cout << bar::pi << endl;
  return 0;
}
