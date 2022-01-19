
function RetVal = gen_signature_euclidean( A, num_of_nodes ) 
e = ones(1,num_of_nodes)';
degV = A * e;
tic
% A new matrix say W? R^(|V|X|V|) is proposed in 
% which the (i,j)th entry specifies the inverse-distance between vertex vi to vj 
    for idx_i = 1 : num_of_nodes
        for idx_j = 1 : num_of_nodes
            wt = 0;
            
            for idx_k = 1 : num_of_nodes
                wt = wt + abs(A(idx_i,idx_k) - A(idx_j,idx_k))^.2;
            end
            t = degV(idx_i) + degV(idx_j) - wt;
            if ( t > 0 )
                ie_score(idx_i,idx_j) = 1/sqrt(t);
            else
                ie_score(idx_i,idx_j) = 1/sqrt(degV(idx_i) + degV(idx_j));
            end
            
            if( wt > 0 ) 
                W(idx_i,idx_j) = 1/ sqrt(wt);
            else
                W(idx_i,idx_j) = 0;
            end
        end
    end
% Time Complexity : O(n^3)  
%disp(W);

% disp('IE matrix');
%disp(sum(ie_score));
% Let the sum of the ith row of W matrix be topological weight of v_i?G 
% denoted as TW_i
    for idx_i = 1:num_of_nodes
        TW(idx_i) = sum(W(idx_i,:));
    end

% TW ? R^|V|X1
    RetVal = TW;
toc;
end
