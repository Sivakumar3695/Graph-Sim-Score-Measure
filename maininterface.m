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
    dataset_dir = './Graph_Datasets/Highly_Similar_Graph/primary/';
    compare_diff_classes = 0;
    compare_same_class = 1;
    disp('process started...');
    inc_count = 0;


    #{
    directory_ls =  dir(dataset_dir);
    adj_mat_arr = struct();
    if length(directory_ls) > 0
      lim = length(directory_ls);
    else
      lim = 3
    end
    for k =  12:12
      directory_ls(k).name
      class_dir = strcat(dataset_dir, directory_ls(k).name, '/')
      [adj_mat_arr, file_list] = get_adj_matrices(class_dir, adj_mat_arr);
      length(file_list)
      for i = 3 : length(file_list)
        tic
        adj_mat_1 = adj_mat_arr.(file_list(i).name);
        disp(file_list(i).name)
        if compare_same_class
          [highly_sim, isomorphic_scores] = file_read_sim_comparison(adj_mat_1, file_list, adj_mat_arr, i+1, k_order, highly_sim, isomorphic_scores, file_list(i).name);
        end
        %disp('Same class done')
        if compare_diff_classes
          for l = k+1 : lim
            sec_class_dir = strcat(dataset_dir, directory_ls(l).name, '/');
            sec_class_files = dir(sec_class_dir);
            try
              adj_mat_arr.(sec_class_files(1).name)
            catch
              [adj_mat_arr, sec_class_files] = get_adj_matrices(sec_class_dir, adj_mat_arr);
            end_try_catch
            [highly_sim_other_cls, c1_isomorphic_scores] = file_read_sim_comparison(adj_mat_1, sec_class_files, adj_mat_arr, 3, k_order, highly_sim_other_cls, c1_isomorphic_scores, file_list(i).name);
          end
        end
        disp(isomorphic_scores);
        #disp(c1_isomorphic_scores);
        toc
      end
    end


    #}

    ##{
      %adj_mat_1 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/primary/20_nodes', '/', '20V_6_4rem.txt'));
      %adj_mat_1 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/primary/60_nodes', '/', '60V_47_59_rem.txt'));
      %adj_mat_2 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/primary/20_nodes', '/', '20V_2_12rem.txt'));
      adj_mat_1 = importdata(strcat('./Graph_Datasets/Dummy/Isomorphic/5_nodes/1.txt'));
      adj_mat_2 = importdata(strcat('./Graph_Datasets/Dummy/Isomorphic/5_nodes/10.txt'));
      adj_mat_1 = importdata(strcat('./Graph_Datasets/Dummy/Dodecahedron.txt'));
      adj_mat_2 = importdata(strcat('./Graph_Datasets/Dummy/Desargues.txt'));

      #adj_mat_1 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/primary_2/20_nodes', '/', '1_20V_20nodesref.txt'));
      #adj_mat_2 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/primary_2/20_nodes', '/', '3_20V_20nodes_2rem.txt'));

      %adj_mat_1 = importdata(strcat('./Graph_Datasets/AIDS/Class_0/1492.txt'));
      %adj_mat_2 = importdata(strcat('./Graph_Datasets/AIDS/Class_1/1001.txt'));
      #adj_mat_1 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/primary/mayazaki-new/mayazaki1_twisted.txt'));
      #adj_mat_2 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/primary/mayazaki-new/mayazaki2_twisted.txt'));
      sim = similarity_score(adj_mat_1, adj_mat_2, k_order);
      disp(strcat('Total Score:' , num2str(sim)))
    #}

    #disp(highly_sim_other_cls);

    disp(isomorphic_scores);
    sprintf('%.0f,', isomorphic_scores)(1:end-1)
    disp(c1_isomorphic_scores);
    sprintf('%.0f,', c1_isomorphic_scores)(1:end-1)

    disp(inc_count);
