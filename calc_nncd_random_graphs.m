
function RetVal = calc_nncd_random_graphs()
clc;
clear;
close all
k_order = 7;
aidsdb_nncd = [];
active = [];
inactive = [];
tic




abs_path = 'D:\RESEARCH\code anddataset - as on 2.11.16\Random graphs\total\';

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
    curfilename = strcat('D:\RESEARCH\code anddataset - as on 2.11.16\Random graphs\total\',allnames{idx});
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
  
    
    
    
    
    
    end
   end
Vector = aidsdb_nncd;

  
   
   for idx_i = 1 : max(size(Vector))
    for idx_j = 1 : max(size(Vector))
%     output1(idx_i,idx_j) = exp(-abs(Vector(idx_i) - Vector(idx_j)));
output1(idx_i,idx_j) = sqrt ( abs( Vector(idx_i) - Vector(idx_j))^.2 );
sim(idx_i,idx_j) = exp(-output1(idx_i,idx_j));
    end
   end
   
   
toc

%disp(output1);
% h=HeatMap(output1,'Colormap',redbluecmap(11));
figure;surf(sim);colormap(map);




T = clusterdata(sim,'maxclust',3);
scatter3(Vector(:,1),term(:,2),Vector(:,3),100,T,'filled');

RetVal = output1;

end

