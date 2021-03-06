%% SIMILARITY MEASURE - Bhattacharya Distance

% Bhattacharya distance:
% D = (1/2) * [ln(det(mean_covariance)/sqrt(det(cov1) * det(cov2)))] 
%       + 1/8 * [(mu1 - mu2)' * inv(mean_covariance) * (mu1 - mu2)]  

function RetVal = bhat_dist_calc(M1, M2, n1, n2, k)
round_term = 10^6;
%#{
#custom cov calculation

mu = ones(k, 1);
cov1 = zeros(k, k);
cov2 = zeros(k, k);

for i = 1:n1
  cov1 = cov1 + ((M1(i, :) - mu) .* (M1(i, :) - mu)');
end
cov1 = round((cov1 / n1) * round_term) / round_term;
cov1 = cov1 + (0.000015 * eye(k,k));

for i = 1:n2
  cov2 = cov2 + ((M2(i, :) - mu) .* (M2(i, :) - mu)');
end
cov2 = round((cov2 / n2) * round_term) / round_term;
cov2 = cov2 + (0.000015 * eye(k,k));

#}

#{
cov1 = cov(M1);
cov2 = cov(M2);
#}


% Term-1 : (1/2) * [ln(det(mean_covariance)/sqrt(det(cov1) * det(cov2)))]
% det1 & det2 cannot be less than or equal to Zero, but unexpectedly we have this unexpected det value in some cases
mean_cov = (cov1 + cov2) / 2;
det1 = abs(det(cov1));
det2 = abs(det(cov2));
det_mean_cov = abs(det(mean_cov));
if det1 == 0
  det1 = 1;
end
if det2 == 0
  det2 = 1;
end
if det_mean_cov == 0
  det_mean_cov = 1;
end
sqrt_term = sqrt(det1 * det2);
first_term = (1/2) * (log(det_mean_cov / sqrt_term));

% Term-2 : 1/8 * [(mu1 - mu2)' * inv(mean_covariance) * (mu1 - mu2)]
% Term-2 will always be zero as mu1 and mu2 are equal always.

% Bhattacharya Distance = Term_1 + Term_2
dist = first_term;

RetVal = real(exp((-1/25) * dist));
end