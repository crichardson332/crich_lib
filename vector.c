/******************************************
* File Name: vector.c
* Purpose:
* Creation Date: 20-06-2015
* Last Modified: Sat Jun 20 22:00:45 2015
* Created By: Chris Richardson
*******************************************/

#include "vector.h"
#include <stdio.h>
#include <stdlib.h>

/* Init with no size given */
void vector_init(Vector *vector) {
  vector->size = 0;
  vector->capacity = VECTOR_INITIAL_CAPACITY;
  vector->data = malloc(sizeof(size_t) * vector->capacity);
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
