/******************************************
* File Name: vector.h
* Purpose:
* Creation Date: 20-06-2015
* Last Modified: Tue Jun 23 09:52:24 2015
* Created By: Chris Richardson
*******************************************/

#ifndef VECTOR_H_
#define VECTOR_H_
#define VECTOR_INITIAL_CAPACITY 100

#include <stddef.h>
#include <math.h>

typedef struct {
  size_t size;     /* slots used so far */
  size_t capacity; /* total available slots */
  double *data;
} Vector;

void vector_init(Vector *vector);
void vector_append(Vector *vector, double value);
double vector_get(Vector *vector, size_t index);
void vector_set(Vector *vector, size_t index, double value);
void vector_double_capacity(Vector *vector);
void vector_free(Vector *vector);

/* 3-vector functions */
typedef struct {
  double data[3];
} Vector3;

void vector3_init(Vector3 *vector);
double vector3_dot(Vector3 *vecA, Vector3 *vecB);
double vector3_magnitude(Vector3 *vector);
void vector3_cross(Vector3 *vecA, Vector3 *vecB, Vector3 *vecC);

#endif
