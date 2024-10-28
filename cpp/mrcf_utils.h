#include "opencv2/core.hpp"

inline int modul(int a, int b)
{
    // function calculates the module of two numbers and it takes into account also negative numbers
    return ((a % b) + b) % b;
}

cv::Mat circshift(cv::Mat matrix, int dx, int dy);

cv::Mat gaussian_shaped_labels(const float sigma, const int w, const int h);