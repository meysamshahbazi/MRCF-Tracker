#pragma once 

#include <opencv2/tracking.hpp>

class TrackerMRCF {
public:
    TrackerMRCF();
    ~TrackerMRCF();
    void init(cv::Mat &img, const cv::Rect &roi);
    bool update(cv::Mat &img, cv::Rect boundingBox);

    struct Param {
        float search_area_scale = 5.0; //The scaling of the target size to get the search area
        int min_image_sample_size = 150*150; // Minimum area of image samples
        int max_image_sample_size = 200*200; // Maximum area of image samples
    };
    
private:
    Param param;
    cv::Point pos;
    cv::Size target_sz, init_sz, base_target_sz, img_sample_sz;

    float search_area, currentScaleFactor;



};


