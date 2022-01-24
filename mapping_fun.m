
function RetVal = mapping_fun( A, n, z) 
% Input Param
% A - Adjaceny Matrix nxn
% n - num of nodes
% z - z order krylov subspace

% Output Param - Graph Signature of size k*k

% phi_g = gen_signature_euclidean(A, n); % phi-0 (initialized to one)
phi_g = ones(n, 1);
P = [];
for idx_i = 1 : z
   temp_val = A * phi_g;
   phi_g = n * ( temp_val / sum(temp_val));
   %phi_g = round(phi_g * 10^3) / (10^3);  
   P = [P phi_g];
end

RetVal = P;