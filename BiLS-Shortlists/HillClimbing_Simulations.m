function HillClimbing_Simulations()
clc;
clear all;
close all;
for i = 425
    arr_time = [];
    f_arr_cost = [];
    for j = i:i+9
        filename1 = ['..\inputs\test\men',num2str(j),'.mat'];
        filename2 = ['..\inputs\test\women',num2str(j),'.mat'];
        %define man preference list
        load(filename1);
        load(filename2);
        [f_time,f_cost] = HillClimbingSearch(menList,womenList);
        arr_time(end+1) = f_time;  
        f_arr_cost(end+1) = f_cost;
    end
    f_arr_time = mean(arr_time);
    fprintf('\ni = %d, mean of time = %f',i,f_arr_time);   
    %save to file
    filename_out = ['..\outputs\test1\HillClimbing_se',num2str(i),'.mat'];
    save(filename_out,'f_arr_time','f_arr_cost');
end
end
%=======================================================================
function [f_time,f_cost] = HillClimbingSearch(menList,womenList)
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
%propability
p = 0.05;
%
%the best solution
M_best = M0;
tic;
t = 1;
while (true)   
    neighborSet = [];
    %find the stable neighbor matchings
    for m = 1:n
        M_child = BreakMarriageMan(menShortlist,womenShortlist,M_best,m,Mt);                
        if ~isempty(M_child)           
            neighborSet(end+1,:) = M_child;            
        end
    end    
    if isempty(neighborSet)
         break;
    end
    %find the best neighbor matchings
    neighborCost = [];
    for i = 1:size(neighborSet,1)
        M_child = neighborSet(i,:);
        fM_child = MatchingCost(menShortlist,womenShortlist,M_child);
        neighborCost(end+1) = fM_child;
    end        
    if (rand() <= p)
        j = randi([1,size(neighborSet,1)]);
    else
        [val,j]  = min(neighborCost);
    end
    M_next = neighborSet(j,:);
    fM_next = MatchingCost(menShortlist,womenShortlist,M_next);
    fM_best = MatchingCost(menShortlist,womenShortlist,M_best);
    if (fM_next >= fM_best)   
        break;
    end
    %for next iteration
    M_best = M_next;
    %fprintf('\n t = %d,size of neighbors = %d',t,size(neighborSet,1));    
    t = t + 1;
end
f_time = toc;
%print solution
%fprintf('\n the optimal solution:\n');
%DisplayMatching(menShortlist,womenShortlist,M_best);
[fm,sm,sw] = MatchingCost(menShortlist,womenShortlist,M_best);
f_cost = fm;
%fprintf('(sm = %d, sw = %d, sm + sw = %d,|sm - sw| = %d)\n',sm, sw, sm + sw, abs(sm - sw));
end