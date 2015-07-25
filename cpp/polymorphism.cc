/******************************************
* File Name: polymorphism.cc
* Purpose:
* Creation Date: 22-07-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/
#include <iostream>
using namespace std;

class Polygon {
  protected:
    int width, height;

  public:
    void set_values (int a, int b) {width=a; height=b;}
    virtual int area () {return 0;}
    virtual void tryThis() {cout << "ORIGINAL" << endl;}
};

class Rectangle: public Polygon {
  public:
    int area () {return width * height;}
    void tryThis() {cout << "OVERWRITTEN - RECT" << endl;}
};

class Triangle: public Polygon {
  public:
    int area () {return (width * height / 2);}
    void tryThis() {cout << "OVERWRITTEN - TRGL" << endl;}
};

int main () {
  Rectangle rect;
  Triangle trgl;
  Polygon poly;
  Polygon * ppoly1 = &rect;
  Polygon * ppoly2 = &trgl;
  Polygon * ppoly3 = &poly;
  ppoly1->set_values (4,5);
  ppoly2->set_values (4,5);
  ppoly3->set_values (4,5);
  //cout << ppoly1->area() << '\n';
  //cout << ppoly2->area() << '\n';
  //cout << ppoly3->area() << '\n';
  cout << "Testing virtual func with polymorphism - rect: " << endl;
  ppoly1->tryThis();
  cout << "Testing virtual func with polymorphism - trgl: " << endl;
  ppoly2->tryThis();
  cout << "Testing virtual func with polymorphism - poly: " << endl;
  ppoly3->tryThis();
  return 0;
}
