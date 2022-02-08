function [isomorphic_scores, cur_graph_comp_cnt] = file_read_sim_comparison(adj_mat_1, file_list, adj_mat_arr, start_index,
    k_order, isomorphic_scores, mat_1_file_name, graph_comp_cnt_max, cur_graph_comp_cnt, tw_arr
  )
  prev_tens_completion = floor(cur_graph_comp_cnt * 10 / graph_comp_cnt_max);
  for j = start_index : length(file_list)
      %j = 4;
      adj_mat_2 = adj_mat_arr.(file_list(j).name);
      sim = similarity_score(adj_mat_1, adj_mat_2, k_order, tw_arr.(mat_1_file_name), tw_arr.(file_list(j).name));
      #sim = similarity_score(adj_mat_1, adj_mat_2, k_order, NA, NA);
      %disp(strcat(file_list(i).name , ':', file_list(j).name))    
      %disp(strcat('Total Score:', mat_1_file_name , '::', file_list(j).name, '=', num2str(sim)))

      if ceil(sim * 10) <= 8
       isomorphic_scores(ceil(sim * 10)) = isomorphic_scores(ceil(sim * 10)) + 1;
      elseif round(sim * 100) <= 85
       isomorphic_scores(9) = isomorphic_scores(9) + 1;
      elseif round(sim * 100) <= 90
       isomorphic_scores(10) = isomorphic_scores(10) + 1;
      elseif round(sim * 100) <= 95
       isomorphic_scores(11) = isomorphic_scores(11) + 1;
      #elseif round(sim * 100) <= 100
      # isomorphic_scores(12) = isomorphic_scores(12) + 1;
      elseif single(sim) == 1
        isomorphic_scores(15) = isomorphic_scores(15) + 1;
      elseif (sim * 1000) < 998
        isomorphic_scores(12) = isomorphic_scores(12) + 1;
      elseif (sim * 1000) < 999
        isomorphic_scores(13) = isomorphic_scores(13) + 1;
      elseif (sim * 1000) < 1000
        isomorphic_scores(14) = isomorphic_scores(14) + 1;
      end

      cur_graph_comp_cnt = cur_graph_comp_cnt + 1;
      completion_percent = cur_graph_comp_cnt/graph_comp_cnt_max;

      tens_completion = floor(completion_percent * 10);
      if tens_completion * 10 > (10 * prev_tens_completion)
        prev_tens_completion = prev_tens_completion + 1;
        disp(strcat('Completed', ':', num2str(10 * (tens_completion)), '% of the process.'))
      end
   end
end