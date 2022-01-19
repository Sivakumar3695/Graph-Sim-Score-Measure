function ret_val = similarity_score(adj_mat_1, adj_mat_2, k_order)
  % load file - first_graph
  num_of_nodes_g1 = max(size(adj_mat_1));

  % load_file - second_graph
  num_of_nodes_g2 = max(size(adj_mat_2));

  %  
  % Output = 0.5 * Term_1 + 0.3 * Term_2 + 0.2 * Term_3
  %

  % Term_1 : exp(-BhatacharyaDistance(phi(G1), phi(G2)))
  % BhatacharyaDistance is explained in the corresponding function.
  % phi(G) = [phi_1(G), phi_2(G), ..., phi_z(G)]; where z = k_order
  % phi(G) corresponds to mapping function (mapping_fun) of Graph G in Krylov subspace.

  % Term_1 calculation begins --------------------------
  phi_g1 = mapping_fun( adj_mat_1, num_of_nodes_g1, k_order);
  phi_g2 = mapping_fun( adj_mat_2, num_of_nodes_g2, k_order);
  %disp('G1');
  %disp(phi_g1);
  %disp('G1');
  %disp(phi_g2);
  term_1 = bhat_dist_calc(phi_g1, phi_g2, num_of_nodes_g1, num_of_nodes_g2);
  % Term_1 calculation ends-----------------------------

  % Term_2 calculation begins---------------------------
  d1 = jensen_div_nature( phi_g1, num_of_nodes_g1, k_order );
  d2 = jensen_div_nature( phi_g2, num_of_nodes_g2, k_order );

  %disp(d1)
  %disp(d2)
  %disp("Term2")
  nncd1 = abs(d1)/log(num_of_nodes_g1);
  %disp(nncd1)
  nncd2 = abs(d2)/log(num_of_nodes_g2);
  %disp(nncd2)

  term_2 = exp(-(abs(sqrt(nncd1) - sqrt(nncd2))));
  % Term_2 calculation ends-----------------------------

  % Term_3 = third_term1 + third_term2
  % third_term1 -> alpha centrality difference between two graphs.
  % third_term2 -> alpha centrality difference between complement of two graphs.

  % Term_3 calculation begins---------------------------
  third_term1 = alpha_centrality_diff(adj_mat_1, adj_mat_2, num_of_nodes_g1, num_of_nodes_g2);
  %third_term1 = sqrt(diff / log(2))

  % calculate complement for each graph - used for Mayazaki graphs differentiation
  g1c = graph_complement(adj_mat_1, num_of_nodes_g1);
  g2c = graph_complement(adj_mat_2, num_of_nodes_g2);

  third_term2 = alpha_centrality_diff(g1c, g2c, num_of_nodes_g1, num_of_nodes_g2);
  %third_term2 = sqrt(diff / log(2))

  term_3 = exp(-(third_term1 + third_term2)/2);
  % Term_3 calculation ends----------------------------

  disp(term_1)
  disp(term_2)
  disp(term_3)
  % output calculation
  %output = 0.5 * term_1 + 0.4 * term_2 + 0.1 * term_3;
  #output = 0.34 * term_1 + 0.33 * term_2 + 0.33 * term_3;
  #output = 0.4 * term_1 + 0.5 * term_2 + 0.1 * term_3;
  #output = 0.3 * term_1 + 0.5 * term_2 + 0.2 * term_3;
  #output = 0.2 * term_1 + 0.5 * term_2 + 0.3 * term_3;
  #output = 0.4 * term_1 + 0.2 * term_2 + 0.4 * term_3;
  #output = 0.5 * term_1 + 0.2 * term_2 + 0.3 * term_3;
  #output = 0.3 * term_1 + 0.2 * term_2 + 0.5 * term_3;
  output = 0.4 * term_1 + 0.4 * term_2 + 0.2 * term_3;
  %disp('Done');
  
  ret_val = output;
end