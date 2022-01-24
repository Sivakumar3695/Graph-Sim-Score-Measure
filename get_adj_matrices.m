function [adj_mat_arr, file_list] = get_adj_matrices(class_dir, adj_mat_arr)
  file_list = dir(class_dir);
  for i = 3:length(file_list)
    adj_mat_arr.(file_list(i).name) = importdata(strcat(class_dir, file_list(i).name));
  end