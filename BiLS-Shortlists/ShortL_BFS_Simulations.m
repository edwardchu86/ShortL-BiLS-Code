function ShortL_BFS_Simulations()
clc;
clear all;
close all;
for i = 425
    arr_time = [];
    arr_size = [];
    f_arr_cost_eg = [];
    f_arr_cost_se = [];
    for j = i:i+9
        filename1 = ['..\inputs\test\men',num2str(j),'.mat'];
        filename2 = ['..\inputs\test\women',num2str(j),'.mat'];
        %define man preference list
        load(filename1);
        load(filename2);
        [f_time,f_cost_eg,f_cost_se,f_size] = ShortL_BFS(menList,womenList);
        arr_time(end+1) = f_time;  
        arr_size(end+1) = f_size;
        f_arr_cost_eg(end+1) = f_cost_eg;
        f_arr_cost_se(end+1) = f_cost_se;
    end
    f_arr_time = mean(arr_time);
    f_arr_size = mean(arr_size);
    fprintf('\ni = %d, time = %f,size = %f',i,f_arr_time,f_arr_size);   
    %save to file
    filename_out = ['..\outputs\test1\ShortL_BFS',num2str(i),'.mat'];
    save(filename_out,'f_arr_time','f_arr_cost_eg','f_arr_cost_se','f_arr_size');               
end
end
%========================================================
function [f_time,f_cost_eg,f_cost_se,f_size] = ShortL_BFS(menList,womenList)
%ref. McVitie and Wilson.The stable marriage problem,CACM
%man optimal and woman optimal solution
[menShortlist0,womenShortlist0,M0] = GSManOptimalShortlists(menList,womenList);
[womenShortlist_t,menShortlist_t,Mt] = GSWomanOptimalShortlists(womenList,menList);
%merge shortlists to obtain the better shortlists
%the size of SMP
n = size(menShortlist0,1);
menShortlist = zeros(n,n);
womenShortlist = zeros(n,n);
for i = 1:n
    for j = 1:n
        if (menShortlist0(i,j) == menShortlist_t(i,j))
            menShortlist(i,j) = menShortlist0(i,j);
        end
        if (womenShortlist0(i,j) == womenShortlist_t(i,j))
            womenShortlist(i,j) = womenShortlist0(i,j);
        end
    end
end
%the best solution
M_best = M0;
fM_best = MatchingCost(menShortlist,womenShortlist,M_best);
%for generate the search tree
parentMen = 1:n;
parentLinks = [0,0,0];
%generate all stable matchings
parentSet = M0;
stableMatchingSet = parentSet;
tic;
t = 1;
while (true)   
    %find the stable neighbor matchings
    childSet = [];
    childMen = [];
    for i = 1:size(parentSet,1)
        M_parent = parentSet(i,:);
        startMan = parentMen(i);
        for m = startMan:n
            M_child = BreakMarriageMan(menShortlist,womenShortlist,M_parent,m,Mt);             
            if ~isempty(M_child)                       
                childSet(end+1,:) = M_child;                    
                childMen(end+1) = m;                
                stableMatchingSet(end+1,:) = M_child;                   
                %for display the search tree                
                parentIdx = find(ismember(stableMatchingSet,M_parent,'rows'));
                childIdx = find(ismember(stableMatchingSet,M_child,'rows'));
                parentLinks(end+1,:) = [parentIdx-1,m,childIdx-1];                                               
                %
                %find the best solution
                fM_child = MatchingCost(menShortlist,womenShortlist,M_child);
                if (fM_best > fM_child)
                    M_best = M_child;
                    fM_best = fM_child;
                end                 
            end
        end
    end
    if (isempty(childSet))
        break;
    end    
    %for next level
    parentSet = childSet;
    parentMen = childMen;
    %fprintf('\n t = %d,size of neighbors = %d',t,size(childSet,1));
    t = t + 1;
end
f_time = toc;
%display the stable matchings
%DisplayMatching(menShortlist,womenShortlist,M_best);
%fprintf('\n size of all stable matching set = %d',matchingSize);
%fprintf('\n Open file outputs\\example1.txt to see all stable matchings\n');
%DisplayMatchingSet(menShortlist,womenShortlist,stableMatchingSet,parentLinks,'..\outputs\example1.txt');
[fm,sm,sw] = MatchingCost(menShortlist,womenShortlist,M_best);
f_cost_eg = fm;
f_size = size(stableMatchingSet,1);
%Determine the SE-cost
M = stableMatchingSet(1,:);
f_cost_se = MatchingCost1(menShortlist,womenShortlist,M);
for i = 2:f_size
    M = stableMatchingSet(i,:);
    [fm,sm,sw] = MatchingCost1(menShortlist,womenShortlist,M);
    if f_cost_se > fm
        f_cost_se = fm;
    end
end
end
%---------------------------------------------------------------