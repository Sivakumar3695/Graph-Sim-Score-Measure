function RetVal = graph_complement( A, num_of_nodes )
B = zeros(num_of_nodes,num_of_nodes);
for i = 1 : num_of_nodes
  for j = 1 : num_of_nodes
    B(i,j)  = ~A(i,j);
  end
end
RetVal = B;
