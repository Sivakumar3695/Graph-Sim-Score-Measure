clc;
clear;
close all;
k_order = 7;

isomorphic_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
c1_isomorphic_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
highly_sim = "";
highly_sim_other_cls = "";
dataset_dir = './Graph_Datasets/Highly_Similar_Graph/primary/';
compare_diff_classes = 0;
disp('process started...');
inc_count = 0;

%#{
directory_ls =  dir(dataset_dir);
for k = 12 : 12
  class_dir = strcat(dataset_dir, directory_ls(k).name, '/')
  file_list = dir(class_dir);
  for i = 3 : length(file_list)
    strcat(class_dir, file_list(i).name)
    adj_mat_1 = importdata(strcat(class_dir, file_list(i).name));
    [highly_sim, isomorphic_scores] = file_read_sim_comparison(adj_mat_1, class_dir, file_list, i+1, k_order, highly_sim, isomorphic_scores, file_list(i).name);
  
    if compare_diff_classes
      for l = k+1 : length(directory_ls)
        sec_class_dir = strcat(dataset_dir, directory_ls(l).name, '/');
        sec_class_files = dir(sec_class_dir);
        [highly_sim_other_cls, c1_isomorphic_scores] = file_read_sim_comparison(adj_mat_1, sec_class_dir, sec_class_files, 3, k_order, highly_sim_other_cls, c1_isomorphic_scores, file_list(i).name);
      end
    end
  end
  disp(isomorphic_scores);
end
#}

%#{
  %adj_mat_1 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/20_nodes', '/', '20V-6,4rem.txt'));
  %adj_mat_1 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/60_nodes', '/', '60V-47,59rem.txt'));
  %adj_mat_2 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/20_nodes', '/', '20V-6,4rem.txt'));
  adj_mat_1 = importdata(strcat('./Graph_Datasets/Dummy/Test_4.txt'));
  adj_mat_2 = importdata(strcat('./Graph_Datasets/Dummy/Test_5.txt'));
  %adj_mat_1 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/primary/mayazaki-new/mayazaki1_twisted.txt'));
  %adj_mat_2 = importdata(strcat('./Graph_Datasets/Highly_Similar_Graph/primary/mayazaki-new/mayazaki2_twisted.txt'));
  sim = similarity_score(adj_mat_1, adj_mat_2, k_order);
  disp(strcat('Total Score:' , num2str(sim)))
#}
disp(isomorphic_scores);
disp(c1_isomorphic_scores)
disp(inc_count);
disp(highly_sim_other_cls);
