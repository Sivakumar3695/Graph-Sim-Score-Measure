clc;
clear;
close all
%NNCD values for Kn - ( 3 .. 20)
nncd = [ 3.8355 2.9053 2.1702 1.5582 1.4671 1.2964 1.1257 1.007 0.9643 0.9281 0.8362 0.7827 0.7143 0.6518 0.6176 0.5237 0.4002 0.3127];
                





for idx_i = 1 : 18
    for idx_j = 1 : 18
    output(idx_i,idx_j) = exp(-abs(nncd(idx_i) - nncd(idx_j)));
    
    end
end
%disp(output);



h=HeatMap(output,'Colormap',redbluecmap(11));
