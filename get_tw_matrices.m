function tw_arr = get_tw_matrices(class_dir, tw_arr, adj_mat_arr, ds_name)
    file_list = dir(class_dir);
    try
        tw_arr.(file_list(3).name);
        tw_arr = tw_arr;
    catch
        disp(strcat("Computing TW of the directory:", class_dir))
        for i = 3:length(file_list)
            if exist(strcat('./temp_tw_', ds_name, '/', file_list(i).name))
                tw_arr.(file_list(i).name) = importdata(strcat('./temp_tw_', ds_name, '/', file_list(i).name));
                continue
            end
            adj_mat = adj_mat_arr.(file_list(i).name);
            temp_var = gen_signature_euclidean(adj_mat, max(size(adj_mat)));
            tw_arr.(file_list(i).name) = temp_var;
            tw_temp_file = strcat('./temp_tw_', ds_name, '/', file_list(i).name);
            save('-ascii', tw_temp_file, 'temp_var');
        end
    end_try_catch