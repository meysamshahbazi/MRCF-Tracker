#include "mrcf_utils.h"

using namespace cv;

cv::Mat circshift(cv::Mat matrix, int dx, int dy)
{
    Mat matrix_out = matrix.clone();
    int idx_y = 0;
    int idx_x = 0;
    for(int i=0; i<matrix.rows; i++) {
        for(int j=0; j<matrix.cols; j++) {
            idx_y = modul(i+dy+1, matrix.rows);
            idx_x = modul(j+dx+1, matrix.cols);
            matrix_out.at<float>(idx_y, idx_x) = matrix.at<float>(i,j);
        }
    }
    return matrix_out;
}
