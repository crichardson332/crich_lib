/******************************************
* File Name: vector.h
* Purpose:
* Creation Date: 20-06-2015
* Last Modified: Sat Jun 20 16:34:04 2015
* Created By: Chris Richardson
*******************************************/

#ifndef VECTOR_H_
#define VECTOR_H_
#define VECTOR_INITIAL_CAPACITY 100

typedef struct {
  size_t size;     /* slots used so far */
  size_t capacity; /* total available slots */
  int *data;       /* array of integers we're storing */
} Vector;

void vector_init(Vector *vector);
void vector_append(Vector *vector, int value);
int vector_get(Vector *vector, int index);
void vector_set(Vector *vector, int index, int value);
void vector_double_capacity_if_full(Vector *vector);
void vector_free(Vector *vector);

#endif
