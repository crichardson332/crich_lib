/******************************************
* File Name: vector.c
* Purpose:
* Creation Date: 20-06-2015
* Last Modified: Sun Jun 21 22:39:05 2015
* Created By: Chris Richardson
*******************************************/

#include "vector.h"
#include <stdio.h>
#include <stdlib.h>

/* Init with no size given */
void vector_init(Vector *vector) {
  vector->size = 0;
  vector->capacity = VECTOR_INITIAL_CAPACITY;
  vector->data = malloc(sizeof(double) * vector->capacity);
}

void vector_append(Vector *vector, double value) {
  if (vector->size >= vector->capacity) {
    printf("Vectors size: %zu\n", vector->size);
    printf("Vectors capacity: %zu\n", vector->capacity);
    printf("Vector is already filled to capacity! Capacity will be doubled.\n");
    vector_double_capacity(vector);
  }
  /* append the value and increment vector->size */
  vector->data[vector->size++] = value;
}

double vector_get(Vector *vector, size_t index) {
  if (index >= vector->size) {
    printf("Index %zu out of bounds for vector of size %zu\n", index, vector->size);
    exit(1);
  }
  return vector->data[index];
}

void vector_set(Vector *vector, size_t index, double value) {
  /* zero fill the vector up to the desired index */
  while (index >= vector->size) {
    while (index >= vector->capacity) {
      vector_double_capacity(vector);
    }
    vector_append(vector, 0);
  }

  vector->data[index] = value;
}

void vector_double_capacity(Vector *vector) {
  vector->capacity *= 2;
  vector->data = realloc(vector->data, sizeof(double) * vector->capacity);
  if (!(vector->data)) {
      printf("Vector realloc failed!\n");
      exit(1);
  }
}

void vector_free(Vector *vector) {
  free(vector->data);
}

/* 
 * Functions for Vector3 struct type
 *
 */
void vector3_init(Vector3 *vector) {
  vector->data = calloc(3, sizeof(double));
}

void vector3_free(Vector3 *vector) {
  free(vector->data);
}

double vector3_dot(Vector3 *vecA, Vector3 *vecB) {
  double dot_product;
  dot_product = vecA->data[0] * vecB->data[0]
    + vecA->data[1] * vecB->data[1]
    + vecA->data[2] * vecB->data[2];
  return dot_product;
}

double vector3_magnitude(Vector3 *vector) {
  double mag;
  mag = sqrt(pow(vector->data[0],2)
    + pow(vector->data[1],2)
    + pow(vector->data[2],2));
  return mag;
}

Vector3 *vector3_cross(Vector3 *vecA, Vector3 *vecB) {
  Vector3 *vecC;
  vector3_init(vecC); 
  vecC->data[0] = vecA->data[1] * vecB->data[2]
                 -vecA->data[2] * vecB->data[1];
  vecC->data[1] = vecA->data[2] * vecB->data[0]
                 -vecA->data[0] * vecB->data[2];
  vecC->data[2] = vecA->data[0] * vecB->data[1]
                 -vecA->data[1] * vecB->data[0];
  return vecC;
}
