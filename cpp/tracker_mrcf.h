#pragma once 

#include <opencv2/tracking.hpp>

class TrackerMRCF {
public:
    TrackerMRCF();
    ~TrackerMRCF();

    void init(cv::Mat &img, const cv::Rect &roi);
    bool update(cv::Mat &img, cv::Rect boundingBox);
private:

};


