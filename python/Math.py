from math import *

class Vector3():
    """Class Vector3 - standard cartesian vector in R3."""

    def __init__(self, x, y, z):
        self._x = x
        self._y = y
        self._z = z
        self._magnitude = sqrt(pow(x,2) + pow(y,2) + pow(z,2));

    def __add__(self, secondVec):
        """The '+' operator between two objects of class 'Vector3' returns the cartesian vector sum of the two vectors."""
        if not isinstance(secondVec, Vector3):
            raise TypeError('Cannot add Vector3 object to non-Vector3 type!')
        else:
            return Vector3(self._x + secondVec._x,
                           self._y + secondVec._y,
                           self._z + secondVec._z)

    def __mul__(self, secondVec):
        """The '*' operator between two objects of class 'Vector3' returns the dot product of the two vectors."""
        return (self._x * secondVec._x +
                self._y * secondVec._y +
                self._z * secondVec._z)

    def magnitude(self):
        """Returns the L2 norm of the vector."""
        return self._magnitude

    def dumpString(self):
        """Returns a string containing information about the vector."""
        dumpString  = "Vector with components: [{0}, {1}, {2}]\n".format(self._x,
                                                                         self._y,
                                                                         self._z)
        dumpString += "Magnitude:              {0}".format(self._magnitude)
        return dumpString

    def dump(self):
        """Prints information about the vector to the screen."""
        print(self.dumpString())


class Matrix33():
    """Class Matrix33 - standard matrix in R^(3x3)."""

    def __init__(self, A11, A12, A13, A21, A22, A23, A31, A32, A33):
        self._A11 = A11
        self._A12 = A12
        self._A13 = A13
        self._A21 = A21
        self._A22 = A22
        self._A23 = A23
        self._A31 = A31
        self._A32 = A32
        self._A33 = A33

    def __add__(self, secondMatrix):
        """Standard matrix addition."""
        if not isinstance(secondMatrix, Matrix33):
            raise TypeError('Cannot add Matrix33 object to non-Matrix33 type!')
        else:
            return Matrix33(self._A11 + secondMatrix._A11, self._A12 + secondMatrix._A12, self._A13 + secondMatrix._A13,
                            self._A21 + secondMatrix._A21, self._A22 + secondMatrix._A22, self._A23 + secondMatrix._A23,
                            self._A31 + secondMatrix._A31, self._A32 + secondMatrix._A32, self._A33 + secondMatrix._A33)

    def dumpString(self):
        """Returns a string containing information about the matrix."""
        dumpString  = "\n      3x3 matrix:\n" 
        dumpString +=   "                     [{0}, {1}, {2}]\n".format(self._A11,
                                                                        self._A12,
                                                                        self._A13)
        dumpString +=   "                     [{0}, {1}, {2}]\n".format(self._A21,
                                                                        self._A22,
                                                                        self._A23)
        dumpString +=   "                     [{0}, {1}, {2}]\n".format(self._A31,
                                                                        self._A32,
                                                                        self._A33)
        return dumpString

    def dump(self):
        print(self.dumpString())
