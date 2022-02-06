function RetVal = calc_alpha_centrality( A, num_of_nodes ) 
%disp(size(A))
%disp(size(degV))
%disp(size(total))
% A new matrix say W? R^(|V|X|V|) is proposed in 
% which the (i,j)th entry specifies the inverse-distance between vertex vi to vj

##{
x0 = zeros(1,num_of_nodes);
x1 = ones(1, num_of_nodes) / num_of_nodes;
beta = 0.8;
lim = 1 / (10^2);

domeig = max(eig(eye(size(A)) * A));
alpha = (1/domeig) * 0.95;

RetVal = linsolve(eye(size(A)) - (alpha * A'), ones(num_of_nodes, 1));
#RetVal = round(temp_val .* (10^12))
#RetVal = RetVal ./(10^12)
#(eye(size(A)) - (alpha * A')) * round(RetVal * (10^12))/(10^12)
#t = linsolve(eye(5) - (alpha * A'), ones(num_of_nodes, 1))
#(eye(size(A)) - (alpha * A')) * round(t * (10^12))/(10^12)

#{
while(sum(abs(x0 - x1)) > lim)
  x0 = x1;
  x1 = alpha * (x1 * A) + beta;
end
RetVal = x1';
#}

#}
#{
tic
total = zeros(num_of_nodes,num_of_nodes);
a_pow = eye(size(A));
alpha = 1/(num_of_nodes);
for i = 1:50
  a_pow = a_pow * A;
  total = total + (a_pow * alpha^i);  
end
RetVal = total * ones(num_of_nodes, 1);
toc
#}

end
