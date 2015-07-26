/******************************************
* File Name: templates.cc
* Purpose:
* Creation Date: 26-07-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include <iostream>

using namespace std;

template<class T>
T sum(T a, T b) {
  T result;
  result = a + b;
  return result;
}

int main() {
  int i = 5, j = 6, k;
  double f = 2.0, g = 0.5, h;
  string str1 = "Hello, ";
  string str2 = "world!";
  string str3;
  k = sum<int>(i,j);
  h = sum<double>(f,g);
  str3 = sum<string>(str1, str2);
  cout << k << '\n';
  cout << h << '\n';
  cout << str3 << '\n';
  return 0;
}
