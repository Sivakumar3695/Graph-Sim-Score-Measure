function RetVal = cov_test_mapping_fun( A, n, z) 
% Input Param
% A - Adjaceny Matrix nxn
% n - num of nodes
% z - z order krylov subspace

% Output Param - Graph Signature of size k*k

% phi_g = gen_signature_euclidean(A, n); % phi-0 (initialized to one)
mul = ones(n, 1);
P = [];
%disp(A * phi_g)
%disp(sum(A * phi_g))
for idx_i = 1 : z
   mul = A * mul;
   P = [P mul];
end
RetVal = P;