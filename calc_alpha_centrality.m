function RetVal = calc_alpha_centrality( A, num_of_nodes ) 
  domeig = max(eig(eye(size(A)) * A));
  alpha = (1/domeig) * 0.95;
  RetVal = linsolve(eye(size(A)) - (alpha * A'), ones(num_of_nodes, 1));