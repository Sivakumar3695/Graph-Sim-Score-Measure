function ret_val = alpha_centrality_diff(graph_1, graph_2, num_of_nodes_g1, num_of_nodes_g2)
  alpha1 = calc_alpha_centrality( graph_1, num_of_nodes_g1);
  alpha2 = calc_alpha_centrality( graph_2, num_of_nodes_g2);

  p_alpha1= ((alpha1 * num_of_nodes_g1) - sum(alpha1)) / num_of_nodes_g1;
  p_alpha2= ((alpha2 * num_of_nodes_g2) - sum(alpha2)) / num_of_nodes_g2;

  p_alpha1 = sort(p_alpha1);
  p_alpha2 = sort(p_alpha2);
  
  diff = 0;
  a1_itr = 1;
  a2_itr = 1;
  
  alpha_c1_size = max(size(p_alpha1));
  alpha_c2_size = max(size(p_alpha2));
  
  max_limit  = max(max(alpha_c1_size), max(alpha_c2_size));
  
  for z = 1 : max_limit
#    disp(single(p_alpha1(a1_itr)))
 #   disp(single(p_alpha2(a2_itr)))
    if( a1_itr >  alpha_c1_size || a2_itr > alpha_c2_size )
      diff = diff + 1;
    elseif (single(p_alpha1(a1_itr)) ~= single(p_alpha2(a2_itr)))
      #a1_itr
      #round(p_alpha1(a1_itr) * 10^16) / 10^16 - round(p_alpha2(a2_itr) * 10^16) / 10^16
      #abs(p_alpha1(a1_itr) - p_alpha2(a2_itr))
      diff = diff + max(0.01, abs(p_alpha1(a1_itr) - p_alpha2(a2_itr)));
      #diff = diff + 1;
    end
    if a1_itr <= alpha_c1_size
      a1_itr++;
    end
    if a2_itr <= alpha_c2_size
      a2_itr++;
    end
  end
  ret_val = diff / max_limit;
end