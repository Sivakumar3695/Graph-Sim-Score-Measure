function RetVal = gen_signature_euclidean( A, num_of_nodes ) 

#tic
for idx_i = 1 : num_of_nodes
  for idx_j = (idx_i + 1) : num_of_nodes
    wt = 0;
            
    vec_i = A(:, idx_i);
    vec_j = A(:, idx_j);
            
    wt = wt + sum(xor(vec_i, vec_j));
             
    if( wt > 0 ) 
      W(idx_i,idx_j) = 1/ sqrt(wt);
    else
      W(idx_i,idx_j) = 0;
    end
    W(idx_j, idx_i) = W(idx_i, idx_j);
  end
end
#toc
#{
tic
W = zeros(num_of_nodes, num_of_nodes);
for idx_i = 1 : num_of_nodes
  wt = 0;          
  vec_i = A(:, idx_i);   
  diff_vec = sum(xor(A, vec_i));
  diff_vec_root = 1 ./ sqrt(diff_vec);
  diff_vec_root(diff_vec == 0) = 0;
  W(idx_i, :) = diff_vec_root;
end
toc
#}

% Time Complexity : O(n^3)  

for idx_i = 1:num_of_nodes
   TW(idx_i) = sum(W(idx_i,:));
end

RetVal = TW;
