/* vector.i */
%module vector
%{
/* Put header files here or function declarations like below */
extern typedef struct {
  size_t size;     /* slots used so far */
  size_t capacity; /* total available slots */
  double *data;
} Vector;

extern void vector_init(Vector *vector);
extern void vector_append(Vector *vector, double value);
extern double vector_get(Vector *vector, size_t index);
extern void vector_set(Vector *vector, size_t index, double value);
extern void vector_double_capacity(Vector *vector);
extern void vector_free(Vector *vector);

/* 3-vector functions */
extern typedef struct {
  double data[3];
} Vector3;

extern void vector3_init(Vector3 *vector);
extern double vector3_dot(Vector3 *vecA, Vector3 *vecB);
extern double vector3_magnitude(Vector3 *vector);
extern void vector3_cross(Vector3 *vecA, Vector3 *vecB, Vector3 *vecC);
%}

extern typedef struct {
  size_t size;     /* slots used so far */
  size_t capacity; /* total available slots */
  double *data;
} Vector;

extern void vector_init(Vector *vector);
extern void vector_append(Vector *vector, double value);
extern double vector_get(Vector *vector, size_t index);
extern void vector_set(Vector *vector, size_t index, double value);
extern void vector_double_capacity(Vector *vector);
extern void vector_free(Vector *vector);

/* 3-vector functions */
extern typedef struct {
  double data[3];
} Vector3;

extern void vector3_init(Vector3 *vector);
extern double vector3_dot(Vector3 *vecA, Vector3 *vecB);
extern double vector3_magnitude(Vector3 *vector);
extern void vector3_cross(Vector3 *vecA, Vector3 *vecB, Vector3 *vecC);
