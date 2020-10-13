function reg_window=construct_regwindow(sz,target_sz)

reg_window_power = 2;
    
    % normalization factor
    reg_scale = 0.5 * target_sz;
    reg_window_edge=5;
    reg_window_min=1;
    % construct grid
    wrg = -(sz(1)-1)/2:(sz(1)-1)/2;
    wcg = -(sz(2)-1)/2:(sz(2)-1)/2;
    [wrs, wcs] = ndgrid(wrg, wcg);
    
    % construct the regukarization window
    reg_window = (reg_window_edge - reg_window_min) * (abs(wrs/reg_scale(1)).^reg_window_power + abs(wcs/reg_scale(2)).^reg_window_power) + reg_window_min;
    reg_window = 0.5*(reg_window-min(reg_window(:)))/(max(reg_window(:))-min(reg_window(:)))+reg_window_min;%ϵ������ǰ��
    pos = max(round(sz/2 - (1*target_sz)/2 - 1),1);
    reg_window = reg_window - (reg_window(pos(1),pos(2))- min(reg_window(:)));
    reg_window(reg_window<1) = 1;
end