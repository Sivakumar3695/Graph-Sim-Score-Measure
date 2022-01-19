clc;
clear;
close all
k_order = 7;
aidsdb_nncd = [];
active = [];
inactive = [];
tic

[names, type] = textread('D:\RESEARCH\code anddataset - as on 2.11.16\subgraphmatching\input\aids_db\test_aids_db.txt','%s %s ');



abs_path = 'D:\RESEARCH\code anddataset - as on 2.11.16\other tools\IAM graphdatabase\gxltoadjacencylistconverter-python code\adjacency\backup';

file_type = '\*.txt';

D = dir([abs_path, file_type]);
   Num_of_files = length(D(not([D.isdir])));

   listing = dir(abs_path);
   allnames = {listing.name};
   %disp( allnames );
   Num_of_files = Num_of_files + 2;
   %disp(',,,,,,,,,,,,,,,,,,,,,');
   term = [ ];
%     Num_of_files = 100;
   for( idx = 1 : Num_of_files )
        %disp('File name');
        %disp(allnames{idx});
    if( strcmp(allnames{idx},'.') || strcmp(allnames{idx},'..'))
        ;
    else
    curfilename = strcat('D:\RESEARCH\code anddataset - as on 2.11.16\other tools\IAM graphdatabase\gxltoadjacencylistconverter-python code\adjacency\backup\',allnames{idx});
    rawData1 = importdata(curfilename);
    [~,name] = fileparts(curfilename);
    % STORE THE RESULT AS A 2D ADJACENCY MATRIX
    P=rawData1;
    % FIND THE SIZE OF THE MATRIX
    num_of_nodes_cur_db_graph = max(size(P)); 
%     n_o_vertices(num_of_nodes_cur_db_graph) = n_o_vertices(num_of_nodes_cur_db_graph) + 1;
    
    ADJ{1} = P;
   % TO FIND THE #NODES IN THE GIVEN TEST GRAPH   
   num_of_nodes_test_graph = max(size(ADJ{1}));
   
   TW_A = gen_signature_euclidean( ADJ{1},num_of_nodes_test_graph );
    %disp('Topological Weight of DBGraph A');
    %disp(TW_A);
   prol_test = mapping_fun( ADJ{1}, num_of_nodes_test_graph, k_order, TW_A );
   d1 = jensen_div_nature( prol_test, num_of_nodes_test_graph, k_order );
   
   nncd1 = abs(d1)/log(num_of_nodes_test_graph);
%disp(nncd1);
   aidsdb_nncd = [ aidsdb_nncd nncd1 ];      
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
f_idx= all(ismember(names,allnames{idx}),2);
linear_idx = find(f_idx);
%disp(type(linear_idx));
if( strcmp(type(linear_idx),'a') == 0)
active = [ active nncd1 ];
else
    inactive = [ inactive nncd1 ];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
a1 = calc_alpha_centrality( ADJ{1}, num_of_nodes_test_graph );

alpha1=(a1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 p_alpha1= ((alpha1 * num_of_nodes_test_graph) - sum(alpha1))/num_of_nodes_test_graph;

%disp('%disp p centrality value - sorted');
%disp(sort(p_alpha1));


 p_alpha1_sort = sort(p_alpha1);
term1 = p_alpha1_sort;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p_diff = 0;
% for z = 1 : max(size(p_alpha1_sort))
%     if( p_alpha1_sort(z) ~= p_alpha2_sort(z) )
%         p_diff = p_diff + 1/max(size(p_alpha1_sort));
%     else
%     p_diff = p_diff + (p_alpha1_sort(z) - p_alpha2_sort(z));
%     end
% end
% d = p_diff / max(size(p_alpha1_sort));
%  %disp('diff');
%  %disp(d);
%  %disp('Third term in the eq. - sqrt ( D(p_aplpha1,p_alpha2)/log 2  )');
% %disp(sqrt(d/log(2)));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate complement for each graph - used for Mayazaki graphs differentiation

g1c = graph_complement(ADJ{1}, num_of_nodes_test_graph);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a1 = calc_alpha_centrality( g1c, num_of_nodes_test_graph );


alpha1=(a1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 p_alpha1= ((alpha1 * num_of_nodes_test_graph) - sum(alpha1))/num_of_nodes_test_graph;

%disp('%disp p centrality value - sorted');
%disp(sort(p_alpha1));


 p_alpha1_sort = sort(p_alpha1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p_diff = 0;

term2 = p_alpha1_sort;


third_term = sum(term1) + sum(term2);
    
    
    term = [ term third_term];
    
    end  
    
    
    
    
    
    
    
    
    
   end
Vector = aidsdb_nncd;

   Vector = sort(Vector);
   
   
   
%    for idx_i = 1 : max(size(Vector))
%     for idx_j = 1 : max(size(Vector))
%     output1(idx_i,idx_j) = exp(-abs(Vector(idx_i) - Vector(idx_j)));
%     
%     end
%    end
%disp('Active Vector');
%disp(active);
%disp('INActive Vector');
%disp(inactive);


   Vector = [];
   Vector = active;
   Vector = [Vector inactive];
   
   for idx_i = 1 : max(size(Vector))
    for idx_j = 1 : max(size(Vector))
%     output1(idx_i,idx_j) = exp(-abs(Vector(idx_i) - Vector(idx_j)));
output1(idx_i,idx_j) = sqrt ( abs( Vector(idx_i) - Vector(idx_j))^.2 );
sim(idx_i,idx_j) = exp(-output1(idx_i,idx_j));
    end
   end
   
   
toc

%disp(output1);
h=HeatMap(output1,'Colormap',redbluecmap(11));
figure;surf(sim);colormap(map);

T = clusterdata(sim,'maxclust',3);
scatter3(sim(:,1),sim(:,2),sim(:,3),100,T,'filled');


T = clusterdata(sim,'maxclust',3);
scatter3(Vector(:,1),term(:,2),Vector(:,3),100,T,'filled');
% for z = 1 : max(size(p_alpha1_sort))
%     if( p_alpha1_sort(z) ~= p_alpha2_sort(z) )
%         p_diff = p_diff + 1/max(size(p_alpha1_sort));
%     else
%     p_diff = p_diff + (p_alpha1_sort(z) - p_alpha2_sort(z));
%     end
% end
% d = p_diff / max(size(p_alpha1_sort));
%  %disp('diff');
%  %disp(d);
%  %disp('Third term 2nd component in the eq. - sqrt ( D(p_aplpha1,p_alpha2)/log 2  )');
%  third_term2 = sqrt(d/log(2));
% %disp(third_term2);
% %disp('third term total sum is');
% %disp(third_term1+third_term2);
