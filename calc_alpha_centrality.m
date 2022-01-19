function RetVal = calc_alpha_centrality( A, num_of_nodes ) 
e = ones(1,num_of_nodes)';
degV = A * e;
%disp(size(A))
%disp(size(degV))
domeig = max(eig(A));
total = zeros(num_of_nodes,num_of_nodes);
%disp(size(total))


% A new matrix say W? R^(|V|X|V|) is proposed in 
% which the (i,j)th entry specifies the inverse-distance between vertex vi to vj 
attenuated_param = 1 / num_of_nodes;

    for idx_i = 1 : num_of_nodes-1
        res = A;
        for idx_j = 1 : idx_i-1
           res = res * A;
        end
        res = (attenuated_param.^idx_i) * res; 
%       res = res / (.^idx_i);
        total = total + res;
    end
    %disp('Alpha Centrality');
    %disp(total);
    Result = total * degV;
    %disp(size(Result));
    RetVal = Result;

end
