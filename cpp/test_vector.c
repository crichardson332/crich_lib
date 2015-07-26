/******************************************
* File Name: test_vector3.c
* Purpose:
* Creation Date: 20-06-2015
* Last Modified: Tue Jun 23 09:47:31 2015
* Created By: Chris Richardson
*******************************************/

/* ADDING TEST COMMENT */

#include <stdio.h>
#include "vector.h"

int main() {
  Vector3 vec1;
  Vector3 vec2;
  vector3_init(&vec1);
  vector3_init(&vec2);

  /* Verify initialization with zeros */
  printf("Vec1 data: [%f, %f, %f]\n", vec1.data[0], vec1.data[1], vec1.data[2]);
  printf("Vec2 data: [%f, %f, %f]\n", vec2.data[0], vec2.data[1], vec2.data[2]);
  
  /* Verify dot product, cross product, and magnitude */
  vec1.data[0] = 0.7;
  vec1.data[1] = 1.7;
  vec1.data[2] = -0.4;
  vec2.data[0] = 2.7;
  vec2.data[1] = -1.1;
  vec2.data[2] = -0.75;
  printf("Vec1 mag: %f\n", vector3_magnitude(&vec1));
  printf("Vec1 dot vec2: %f\n", vector3_dot(&vec1, &vec2));

  /* Check the cross product function */
  Vector3 vec3;
  vector3_init(&vec3);
  vector3_cross(&vec1, &vec2, &vec3);
  printf("\nCross products:\n\n");
  printf("Vec1 data: [%f, %f, %f]\n", vec1.data[0], vec1.data[1], vec1.data[2]);
  printf("Vec2 data: [%f, %f, %f]\n", vec2.data[0], vec2.data[1], vec2.data[2]);
  printf("Vec3: [%f, %f, %f]\n", vec3.data[0], vec3.data[1], vec3.data[2]);

}
