#include "s21_math.h"

long double s21_sqrt(double x) {
  long double res = 0;
  if (x == s21_NINF) {
    res = s21_NAN;
  } else {
    res = s21_pow(x, 0.5);
  }
  return res;
}