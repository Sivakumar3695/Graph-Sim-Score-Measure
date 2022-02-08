function count = get_graph_cnt(ds_name)
    if strcmpi(ds_name,'AIDS')
        count = 2000;
    elseif strcmpi(ds_name,'COLLAB')
        count = 5000;
    elseif strcmpi(ds_name,'MUTAG')
        count = 188;
    elseif strcmpi(ds_name,'ENZYMES')
        count = 600;
    elseif strcmpi(ds_name,'IMDB-BINARY')
        count = 1000;
    elseif strcmpi(ds_name,'MSRC_9')
        count = 221;
    elseif strcmpi(ds_name,'MSRC_21C')
        count = 209;
    elseif strcmpi(ds_name,'PROTEINS')
        count = 1113;
    elseif strcmpi(ds_name,'REDDIT-MULTI-5K')
        count = 4999;
    elseif strcmpi(ds_name,'SYNTHETIC')
        count = 300;
    elseif strcmpi(ds_name,'Synthie')
        count = 400;
    end