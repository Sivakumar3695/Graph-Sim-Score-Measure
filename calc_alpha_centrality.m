function RetVal = calc_alpha_centrality( A, num_of_nodes ) 
e = ones(1,num_of_nodes)';
degV = A * e;
%disp(size(A))
%disp(size(degV))
domeig = max(eig(eye(size(A)) * A));
total = zeros(num_of_nodes,num_of_nodes);
%disp(size(total))


% A new matrix say W? R^(|V|X|V|) is proposed in 
% which the (i,j)th entry specifies the inverse-distance between vertex vi to vj

%#{
x0 = zeros(1,num_of_nodes);
x1 = ones(1, num_of_nodes) / num_of_nodes;
beta = 0.8;
lim = 1 / (10^2);
alpha = (1/domeig) * 0.70;

while(sum(abs(x0 - x1)) > lim)
  x0 = x1;
  x1 = alpha * (x1 * A) + beta;
end
RetVal = x1';
#}
#{
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
#}

end
