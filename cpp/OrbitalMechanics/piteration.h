/******************************************
* File Name: piteration.h
* Purpose:
* Creation Date: 23-06-2015
* Last Modified: Wed Jun 24 08:17:45 2015
* Created By: Chris Richardson
*******************************************/
#ifndef P_ITERATION_H_
#define P_ITERATION_H_

#include <stidlib.h>
#include <math.h>
#include <stdbool.h>

const double *pit(const Vector3 *r1,
            const Vector3 *r2,
            const double TOF,
            const bool shortway,
            const double mu);


#endif
