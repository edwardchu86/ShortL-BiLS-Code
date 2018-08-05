function SMLTest()
clc;
clear all;
close all;
f_arr_time = [];
f_arr_cost_eg = [];
f_arr_cost_se = [];
for i = 1:1
    n = 500;
    filename1 = ['..\inputs\test',num2str(n),'\men',num2str(i),'.mat'];
    filename2 = ['..\inputs\test',num2str(n),'\women',num2str(i),'.mat'];
    %define man preference list
    load(filename1);
    load(filename2);
    [f_time,f_cost_eg,f_cost_se] = SML(menList,womenList);
    f_arr_time(end+1) = f_time;
    f_arr_cost_eg(end+1) = f_cost_eg;
    f_arr_cost_se(end+1) = f_cost_se;
    fprintf('\ni = %d,f_time = %f, f_cost_eg = %d, f_cost_se = %d',i,f_time,f_cost_eg,f_cost_se);
end
%filename_out = ['..\outputs\test5\SML_eg_se',num2str(n),'.mat'];
%save(filename_out,'f_arr_time','f_arr_cost_eg','f_arr_cost_se');
end
%============================================================
function [f_time,f_cost_eg,f_cost_se] = SML(menList,womenList)
%generate a random matching
n = size(menList,1);
x = randn(1,n);
[~,M] = sort(x);
%SML
p = 0.05;
tic;
while (true)
    neighborSet = [];
    for i = 1 : n 
        mi = i;
        wi = M(i);
        for j = 1 : n
            mj = j;
            wj = M(j);
            %check blocking pair
            if (BlockingPair(menList,womenList,mi,wi,mj,wj) == true)
              M_child = M;
              M_child(mi) = wj;
              M_child(mj) = wi;
              neighborSet(end+1,:) = M_child;                
            end
        end    
    end 
    %
    if (~isempty(neighborSet))
        %find the best neighbor matchings
        neighborCost = [];
        for i = 1:size(neighborSet,1)
            M_child = neighborSet(i,:);
            fM_child = CountBlockingPair(menList,womenList,M_child);
            neighborCost(end+1) = fM_child;
        end
        if (rand() <= p)
            j = randi([1,size(neighborSet,1)]);
        else
            [val,j]  = min(neighborCost);
        end        
        M = neighborSet(j,:);
        %f = CountBlockingPair(menList,womenList,M);
    else
        break;
    end    
end
f_time = toc;
[fm,sm,sw] = MatchingCost(menList,womenList,M);
f_cost_eg = sm+sw;
f_cost_se = abs(sm-sw);
end
%============================================================

