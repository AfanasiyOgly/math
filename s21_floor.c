#include "s21_math.h"

long double s21_floor(double x) {
  long double res;
  if (s21_IS_INF(x) || s21_IS_NAN(x))
    res = x;
  else {
    int int_num = (int)x;
    int_num -= (x < 0 && (x - int_num));
    res = (long double)int_num;
  }
  return res;
}