/******************************************
* File Name: fileio.cc
* Purpose:
* Creation Date: 05-10-2015
* Last Modified:
* Created By: Chris Richardson
*******************************************/

#include <limits>
#include <string>
#include <fstream>
#include <iostream>

int main() {
    std::ofstream file_out;
    file_out.open("fileio.txt");
    file_out << "hello\n";
    file_out << "world\n";
    file_out.close();

    std::ifstream file_in;
    file_in.open("fileio.txt");
    std::string line1, line2;
    file_in >> line1;
    file_in >> line2;
    std::cout << line2 << "\n"; 
    file_in.close();

    return 0;
}
