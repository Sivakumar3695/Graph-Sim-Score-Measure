function ret = maininterface(DATASET_NAME, from_arg,to_arg)
    k_order = 7;
    page_output_immediately(1);

    disp(DATASET_NAME)


    isomorphic_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    c1_isomorphic_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    dataset_dir = strcat('./DS/', DATASET_NAME, '/');
    graph_cnt = get_graph_cnt(DATASET_NAME);
    if !isnan(to_arg)
        total_terms = to_arg - from_arg + 1;
        graph_comp_cnt_max = graph_cnt * (to_arg-from_arg+1) - (total_terms/2) * ( 2*(from_arg-2) + (total_terms-1)*1)
    else
        to_arg = graph_cnt;
        from_arg = 3;
        graph_comp_cnt_max = graph_cnt * (graph_cnt-1) / 2
    end
    cur_graph_comp_cnt = 0;

    compare_diff_classes = 1;
    compare_same_class = 1;
    for_test = 0; # 1 - for evaluation on Graph Datasets , 0 - for testing the code.

    disp('process started...');

    if !for_test
        tic
        directory_ls =  dir(dataset_dir);
        adj_mat_arr = struct();
        tw_arr = struct();

        for k =  3:length(directory_ls)
          directory_ls(k).name

          class_dir = strcat(dataset_dir, directory_ls(k).name, '/')
          [adj_mat_arr, file_list] = get_adj_matrices(class_dir, adj_mat_arr);
          tw_arr = get_tw_matrices(class_dir, tw_arr, adj_mat_arr);
          lim = min(to_arg, length(file_list))
          for i = from_arg : lim
            adj_mat_1 = adj_mat_arr.(file_list(i).name);
            disp(file_list(i).name)
            if compare_same_class
              [isomorphic_scores, cur_graph_comp_cnt] = file_read_sim_comparison(adj_mat_1, file_list, adj_mat_arr, i+1, k_order,
              isomorphic_scores, file_list(i).name, graph_comp_cnt_max, cur_graph_comp_cnt, tw_arr);
            end

            if compare_diff_classes
              for l = k+1 : length(directory_ls)
                sec_class_dir = strcat(dataset_dir, directory_ls(l).name, '/');
                sec_class_files = dir(sec_class_dir);
                try
                  adj_mat_arr.(sec_class_files(1).name)
                catch
                  [adj_mat_arr, sec_class_files] = get_adj_matrices(sec_class_dir, adj_mat_arr);
                  tw_arr = get_tw_matrices(sec_class_dir, tw_arr, adj_mat_arr);
                end_try_catch
                [c1_isomorphic_scores, cur_graph_comp_cnt] = file_read_sim_comparison(adj_mat_1, sec_class_files, adj_mat_arr, 3, k_order,
                 c1_isomorphic_scores, file_list(i).name, graph_comp_cnt_max, cur_graph_comp_cnt, tw_arr);
              end
            end
          end
        end

        toc;
    else
      adj_mat_1 = importdata(strcat('./DS/Dummy/Dodecahedron.txt'));
      adj_mat_2 = importdata(strcat('./DS/Dummy/Desargues.txt'));

      sim = similarity_score(adj_mat_1, adj_mat_2, k_order);
      disp(strcat('Total Score:' , num2str(sim)))
    end

    disp('Same-class results:')
    iso_str = sprintf('%.0f,', isomorphic_scores)(1:end-1)
    disp('Inter-class results:')
    c1_iso_str = sprintf('%.0f,', c1_isomorphic_scores)(1:end-1)

    file_name = strcat('./output/', DATASET_NAME, '.txt');
    fid = fopen (file_name, "w");
    fprintf(fid, 'Same-class Isomorphic score:\n');
    fputs (fid, iso_str);
    fprintf(fid, '\nDiff-class Isomorphic score:\n');
    fputs(fid, c1_iso_str);
    fclose (fid);

    ret = 1;