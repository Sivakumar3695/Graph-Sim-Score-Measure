function ret = maininterface()
    clc;
    clear;
    close all;
    k_order = 7;
    page_output_immediately(1);

    # collab, redit, synthetic, imdb-binary
    # 0-1 ,1-2 ,2-3 ,3-4 ,4-5 ,5-6 ,6-7 ,7-8 ,8-8.5 ,8.5-9 ,9-9.5, 9.5-10
    isomorphic_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    c1_isomorphic_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    highly_sim = "";
    highly_sim_other_cls = "";
    dataset_dir = './Graph_Datasets/AIDS/';
    graph_cnt = 400;
    graph_comp_cnt_max = 1999;
    cur_graph_comp_cnt = 0;
    compare_diff_classes = 1;
    compare_same_class = 1;
    disp('process started...');
    inc_count = 0;


    ##{
    tic
    directory_ls =  dir(dataset_dir);
    adj_mat_arr = struct();
    h = waitbar (0, '0.00%');
    for k =  3:3
      directory_ls(k).name

      class_dir = strcat(dataset_dir, directory_ls(k).name, '/')
      [adj_mat_arr, file_list] = get_adj_matrices(class_dir, adj_mat_arr);
      lim = 3 #length(file_list)
      for i = 3 : lim
        adj_mat_1 = adj_mat_arr.(file_list(i).name);
        disp(file_list(i).name)
        if compare_same_class
          [highly_sim, isomorphic_scores, cur_graph_comp_cnt] = file_read_sim_comparison(adj_mat_1, file_list, adj_mat_arr, i+1, k_order, highly_sim,
          isomorphic_scores, file_list(i).name, graph_comp_cnt_max, cur_graph_comp_cnt, h);
        end
        %disp('Same class done')
        if compare_diff_classes
          for l = k+1 : length(directory_ls)
            sec_class_dir = strcat(dataset_dir, directory_ls(l).name, '/');
            sec_class_files = dir(sec_class_dir);
            try
              adj_mat_arr.(sec_class_files(1).name)
            catch
              [adj_mat_arr, sec_class_files] = get_adj_matrices(sec_class_dir, adj_mat_arr);
            end_try_catch
            [highly_sim_other_cls, c1_isomorphic_scores, cur_graph_comp_cnt] = file_read_sim_comparison(adj_mat_1, sec_class_files, adj_mat_arr, 3, k_order, highly_sim_other_cls,
             c1_isomorphic_scores, file_list(i).name, graph_comp_cnt_max, cur_graph_comp_cnt, h);
          end
        end

        #disp(isomorphic_scores);
        #disp(c1_isomorphic_scores);
      end
    end

    close (h);
    toc;
    #}

    # for test purpose alone
    #{
      adj_mat_1 = importdata(strcat('./Graph_Datasets/Dummy/Dodecahedron.txt'));
      adj_mat_2 = importdata(strcat('./Graph_Datasets/Dummy/Desargues.txt'));

      sim = similarity_score(adj_mat_1, adj_mat_2, k_order);
      disp(strcat('Total Score:' , num2str(sim)))
    #}

    #disp(highly_sim_other_cls);

    disp('Same-class results:')
    sprintf('%.0f,', isomorphic_scores)(1:end-1)
    disp('Inter-class results:')
    sprintf('%.0f,', c1_isomorphic_scores)(1:end-1)
    ret = 1;