#include "tracker_mrcf.h"

TrackerMRCF::TrackerMRCF() {

}

TrackerMRCF::~TrackerMRCF() {

}

void TrackerMRCF::init(cv::Mat &img, const cv::Rect &roi) {
    pos.x = roi.x + roi.width/2;
    pos.y = roi.y + roi.height/2;
    target_sz = roi.size();
    init_sz = target_sz;
    
    cv::Size init_target_sz = target_sz;

    search_area = init_target_sz.area() * param.search_area_scale;
    if (search_area > param.max_image_sample_size) 
        currentScaleFactor = std::sqrt(search_area / param.max_image_sample_size);
    else if ( search_area < param.min_image_sample_size)
        currentScaleFactor = std::sqrt(search_area / param.min_image_sample_size);
    else 
        currentScaleFactor = 1.0f;

    
    base_target_sz = cv::Size(target_sz.width / currentScaleFactor, target_sz.height / currentScaleFactor);

    // search_area_shape = 'proportional'
    img_sample_sz = cv::Size(
            std::floor(base_target_sz.width * param.search_area_scale),
            std::floor(base_target_sz.height * param.search_area_scale));


    
    

}

bool TrackerMRCF::update(cv::Mat &img, cv::Rect boundingBox) {

}



