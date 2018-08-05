function ShortL_BiLS()
clc;
clear all;
close all;
%define man preference list   
menList   = ReadFile('..\inputs\examples\men19viet.txt');
womenList = ReadFile('..\inputs\examples\women19viet.txt');
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
%% initialize the solution
M_left = M0;
fM_left = MatchingCost(menShortlist,womenShortlist,M_left);
M_right = Mt;
fM_right = MatchingCost(menShortlist,womenShortlist,M_right);
if (fM_left < fM_right)
    M_best = M_left;
    fM_best = fM_left;
    index  = 1;
else
    M_best = M_right;
    fM_best = fM_right;
    index  = 2;
end
%initialize the propability
p = 0.05;
tic;
forward  = true;
backward = true;
iter_left = 1;
iter_right = 1;
t = 1;
while (true)   
    %-------------------search forward---------------------
    if (forward)        
        neighborSet = [];  
        for m = 1:n
            M_child = BreakMarriageMan(menShortlist,womenShortlist,M_left,m,Mt);
            if ~isempty(M_child)           
                neighborSet(end+1,:) = M_child;            
            end
        end    
        if (~isempty(neighborSet))
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
            [fM_next,sm1] = MatchingCost(menShortlist,womenShortlist,M_next);
            fM_left = MatchingCost(menShortlist,womenShortlist,M_left);
            if (fM_next >= fM_left)   
                forward = false;
                %remember the best solution
                if (fM_best > fM_left)
                    M_best = M_left;
                    fM_best = fM_left;
                    index  = 1;
                end            
            end
            %for next iteration
            M_left = M_next;
        else
            forward = false;
        end
        iter_left = iter_left + 1;
    end
    %-------------------search backward---------------------
    if (backward)
        neighborSet = [];  
        for m = 1:n
            M_child = BreakMarriageWoman(womenShortlist,menShortlist,M_right,m,M0); 
            if ~isempty(M_child)           
                neighborSet(end+1,:) = M_child;            
            end
        end
        if (~isempty(neighborSet))
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
            [fM_next,sm2] = MatchingCost(menShortlist,womenShortlist,M_next);
            fM_right = MatchingCost(menShortlist,womenShortlist,M_right);
            if (fM_next >= fM_right)
                backward = false;
                %remember the best solution
                if (fM_best > fM_right)
                    M_best = M_right;
                    fM_best = fM_right;
                    index  = 2;
                end            
            end
            %for next iteration
            M_right = M_next;
        else
            backward = false;
        end
         iter_right = iter_right + 1;
    end    
    %
    if ((~forward)&&(~backward))
        if (sm1 <= sm2)
            forward = true;
            backward = true;        
        else
            break;
        end
    end
    fprintf('\n t = %d',t);
    t = t + 1;
end
toc
%fprintf('\n the algorithm stops when sm1 = %d sm2 = %d:\n',sm1,sm2);
%fprintf('\n the iteration for forward optimal solution = %d:\n',iter_left);
%fprintf('\n the iteration for backward optimal solution = %d:\n',iter_right);
%print solution
fprintf('\n the optimal solution (index = %d):\n',index);
fprintf('\n the optimal solution:\n');
DisplayMatching(menShortlist,womenShortlist,M_best);
end
