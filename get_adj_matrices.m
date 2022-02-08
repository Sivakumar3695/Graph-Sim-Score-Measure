function [adj_mat_arr, file_list] = get_adj_matrices(class_dir, adj_mat_arr)
  file_list = dir(class_dir);
  try
    adj_mat_arr.(file_list(3).name);
    adj_mat_arr = adj_mat_arr;
  catch
    disp(strcat("Computing Adjacency matrices of the directory:", class_dir))
    for i = 3:length(file_list)
        adj_mat_arr.(file_list(i).name) = importdata(strcat(class_dir, file_list(i).name));
    end
  end_try_catch