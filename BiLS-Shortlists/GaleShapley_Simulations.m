function GaleShapley_Simulations()
clc;
clear all;
close all;
for i = 25:25:500
    f_arr_cost0 = [];
    f_arr_costt = [];
    for j = i:i+9
        filename1 = ['..\inputs\test\men',num2str(j),'.mat'];
        filename2 = ['..\inputs\test\women',num2str(j),'.mat'];
        %define man preference list
        load(filename1);
        load(filename2);
        [f_cost0,f_costt] = Gale_Shapley(menList,womenList);
        f_arr_cost0(:,end+1) = f_cost0;
        f_arr_costt(:,end+1) = f_costt;
    end
    fprintf('\ni = %d',i);   
    %save to file
    filename_out = ['..\outputs\test1\Gale_Shapley',num2str(i),'.mat'];
    save(filename_out,'f_arr_cost0','f_arr_costt');
end
end
%============================================================
function [f_cost0,f_costt] = Gale_Shapley(menList,womenList)
%man optimal and woman optimal solution
[menShortlist0,womenShortlist0,M0] = GSManOptimalShortlists(menList,womenList);
[womenShortlist_t,menShortlist_t,Mt] = GSWomanOptimalShortlists(womenList,menList);

[fm,sm,sw] = MatchingCost(menList,womenList,M0);
f_cost0 = [sm,sw];
[fm,sm,sw] = MatchingCost(menList,womenList,Mt);
f_costt = [sm,sw];
end
