function [highly_sim, isomorphic_scores] = file_read_sim_comparison(adj_mat_1, file_list, adj_mat_arr, start_index, k_order,
  highly_sim, isomorphic_scores, mat_1_file_name
  )
  highly_sim = highly_sim;
  for j = start_index : length(file_list)
      %j = 4;
      adj_mat_2 = adj_mat_arr.(file_list(j).name);
      sim = similarity_score(adj_mat_1, adj_mat_2, k_order);
      %disp(strcat(file_list(i).name , ':', file_list(j).name))    
      %disp(strcat('Total Score:', mat_1_file_name , '::', file_list(j).name, '=', num2str(sim)))
      if sim < 0 || sim > 1
  %      inc_sim(inc_count) = strcat(file_list(i).name, '-', file_list(j).name);
        %inc_count = inc_count + 1;
        disp("Incorrect similarity_score");
        continue;
      elseif sim >= 0.9
        highly_sim = strcat(highly_sim, ' , ', mat_1_file_name, '-', file_list(j).name);
      end
      if ceil(sim * 10) <= 8
       isomorphic_scores(ceil(sim * 10)) = isomorphic_scores(ceil(sim * 10)) + 1;
      elseif round(sim * 100) <= 85
       isomorphic_scores(9) = isomorphic_scores(9) + 1;
      elseif round(sim * 100) <= 90
       isomorphic_scores(10) = isomorphic_scores(10) + 1;
      elseif round(sim * 100) <= 95
       isomorphic_scores(11) = isomorphic_scores(11) + 1;
      elseif round(sim * 100) <= 100
       isomorphic_scores(12) = isomorphic_scores(12) + 1;
   end
end