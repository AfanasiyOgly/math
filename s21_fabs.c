#include "s21_math.h"

long double s21_fabs(double x) {
  long double res = x;
  if (x != s21_INF && x != s21_NINF && x != s21_NAN) {
    if (res < 0) {
      res = res * -1;
    }
  } else
    res = s21_INF;
  return res;
}