%   This function runs the IBRI tracker on the video specified in 
%   "configSeqs".
%   This function is based on STRCF paper.
%   Details of some parameters are not presented in the paper, you can
%   refer to BACF/DSST/ECO paper for more details.

function results = run_DCCF(seq, rp, bSaveImage)%                     加了正则项的IBRI
% Feature specific parameters
hog_params.cell_size = 4;
hog_params.compressed_dim = 10;
hog_params.nDim = 31;

grayscale_params.colorspace='gray';
grayscale_params.cell_size = 4;

cn_params.tablename = 'CNnorm';
cn_params.useForGray = false;
cn_params.cell_size = 4;
cn_params.nDim = 10;

% Which features to include
params.t_features = {
    struct('getFeature',@get_colorspace, 'fparams',grayscale_params),...    
    struct('getFeature',@get_fhog,'fparams',hog_params),...
    struct('getFeature',@get_table_feature, 'fparams',cn_params),...
};

% Global feature parameters1s
params.t_global.cell_size = 4;                  % Feature cell size

% Image sample parameters
params.search_area_shape = 'square';    % The shape of the samples
params.search_area_scale = 5;         % The scaling of the target size to get the search area
params.min_image_sample_size = 150^2;   % Minimum area of image samples
params.max_image_sample_size = 200^2;   % Maximum area of image samples

% Spatial regularization window_parameters
params.feature_downsample_ratio = [4]; %  Feature downsample ratio
params.reg_window_max = 1e5;           % The maximum value of the regularization window
params.reg_window_min = 1e-3;           % the minimum value of the regularization window

% Detection parameters
params.refinement_iterations = 1;       % Number of iterations used to refine the resulting position in a frame
params.newton_iterations = 5;           % The number of Newton iterations used for optimizing the detection score
params.clamp_position = false;          % Clamp the target position to be inside the image

% Learning parameters
params.output_sigma_factor = 0.0625;%0.0595;%1/16;		% Label function sigma
params.temporal_regularization_factor = [15 15]; % The temporal regularization parameters

% ADMM parameters
params.max_iterations = [2 2];
params.init_penalty_factor = [1 1];
params.max_penalty_factor = [0.1, 0.1];
params.penalty_scale_step = [10, 10];

params.num_scales = 33;
params.hog_scale_cell_size = 4;
params.learning_rate_scale = 0.025;%seq.spatial;%0.025;
params.scale_sigma_factor = 0.5;%1/2;
params.scale_model_factor = 1.0;
params.scale_step = 1.03;
params.scale_model_max_area = 32*16;
params.scale_lambda = 1e-4;

params.learning_rate_1 = 0.019;%0.0131;
params.learning_rate_2 = 0.019;%0.019;


params.F = 2;%historical interval length

params.mu = 1;%0.844
params.admm_lambda =  0.01;%Regularization parameter
params.admm_lambda_2 = 0.41;
params.admm_lambda_3 = 47.4;

params.admm_iterations = 3;%Number of ADMM iterations

% Test parameters
if isfield(seq, 'tuning_param')
    % 在调参数
    params.learning_rate_1 = seq.tuning_param(1);
    params.learning_rate_2 = seq.tuning_param(1);
%     params.mu = seq.tuning_param(3);% 
%     params.admm_lambda = seq.tuning_param(2);
    params.admm_lambda_2 = seq.tuning_param(2);
    params.admm_lambda_3 = seq.tuning_param(3);
    %     params.admm_lambda_3 = seq.tuning_param(3);
end


% Visualization
params.visualization = 0;               % Visualiza tracking and detection scores

% GPU
params.use_gpu = false;                 % Enable GPU or not
params.gpu_id = [];                     % Set the GPU id, or leave empty to use default

% Initialize
params.seq = seq;
% Run tracker
results = tracker(params);
