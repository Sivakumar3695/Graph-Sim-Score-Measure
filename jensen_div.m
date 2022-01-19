function RetVal = jensen_div( prol_mat, n, k ) 
% Input Param
% Prol_Mat - Proliferation Matrix which reveals closeness nxk
% n - num of nodes
% k - k order krylov subspace

% Output - Node Divergence scores for the prol matrix 


aj_div = 0;
%disp(prol_mat);
for o=1:n
    for i=1:k  %k order
         MU = sum(prol_mat(o,:))/k; % finds avg. closeness
         div = prol_mat(o,i) * log(prol_mat(o,i)/MU); % Jensen divergence
         aj_div = aj_div + div; 
    end
    node_div(o)=aj_div;
    aj_div = 0;

end
result1 = sum(node_div)/n; % num of nodes
%disp('node Div');
%disp(node_div);
%disp('Avg. of Node div');
%disp(sum(node_div));

%disp(node_div/sum(node_div));
%disp('result1');
%disp(result1);
RetVal = result1;

