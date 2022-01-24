function RetVal = jensen_div_nature(phi_g, n, k ) 
% Input Param
% Prol_Mat - Proliferation Matrix which reveals closeness nxk
% n - num of nodes
% k - k order krylov subspace

% Output - Overall Node Divergence score for the prol matrix 


% aj_div = 0;
try
  distribution = sum(sum(phi_g .* (log(phi_g))));
  if max(isnan(distribution)) == 1 || min(min(distribution)) == -Inf || max(max(distribution)) == Inf
    error('Error in Log function');
  end
catch
  distribution = 0;
  for col_idx = 1 : k
    mu = sum(phi_g(:,col_idx))/n;
    for node_idx = 1 : n
      if( phi_g(node_idx,col_idx) > 0)
        x = phi_g(node_idx,col_idx)/mu;
        val = phi_g(node_idx,col_idx) * log(x);
      else
        val = 0;
      end
      distribution = distribution + val;
    end
  end
end_try_catch
RetVal = distribution/n;
