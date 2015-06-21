/******************************************
* File Name: vector.h
* Purpose:
* Creation Date: 20-06-2015
* Last Modified: Sat Jun 20 21:49:40 2015
* Created By: Chris Richardson
*******************************************/

#ifndef VECTOR_H_
#define VECTOR_H_
#define VECTOR_INITIAL_CAPACITY 100

#include <stddef.h>

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

#endif
