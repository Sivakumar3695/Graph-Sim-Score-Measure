%% SIMILARITY MEASURE - Log Divergence Distance
function RetVal = log_div_dist_calc( M1, M2 )
M1 = floor(M1) + ceil( (M1-floor(M1))/0.00005) * 0.00005;
M2 = floor(M2) + ceil( (M2-floor(M2))/0.00005) * 0.00005;
dist = log(abs(det( (M1 + M2) / 2 ))) - ( 0.5 * log( abs(det (M1 * M2)) ));
% disp('log divergence dist');

%dist = log( abs(dist) );

Si_ld = exp( -dist );
    %if( Si_ld > 1 )
     %   Si_ld = 1;
  %dist = abs(det(M1) - det(M2));
% Si_ld = 4 * 1 / dist;
RetVal = Si_ld;

end