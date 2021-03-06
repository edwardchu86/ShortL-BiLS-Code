function BreakMarriageTest()
%clc;
clear all;
close all;
menList   = ReadFile('..\inputs\examples\men19viet.txt');
womenList = ReadFile('..\inputs\examples\women19viet.txt');
BreakMarriageManTest(menList,womenList);
%BreakMarriageWomanTest(menList,womenList);
end
%---------------------------------------------------------------
function BreakMarriageManTest(menList,womenList)
%man optimal solution
[menShortlist0,womenShortlist0,M0] = GSManOptimalShortlists(menList,womenList);
%woman optimal solution
[womenShortlist_t,menShortlist_t,Mt] = GSWomanOptimalShortlists(womenList,menList);
%-------------------------------------------------------
%and cua 2 shortlists
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
%display
M = M0
fprintf('-------------------\n');
%
%initialize
sm_cost = [];
sw_cost = [];
neighborSet = [];
menSet = [];
for mi = 1:size(M,2)    
    stableMatching = BreakMarriageMan(menShortlist,womenShortlist,M,mi,Mt); 
    if ~isempty(stableMatching)        
        neighborSet(end+1,:) = stableMatching;   
        menSet(end+1) = mi;
        [fm,sm,sw] = MatchingCost(menList,womenList,stableMatching);
        sm_cost(end+1) = sm;
        sw_cost(end+1) = sw;
    end
end
for i = 1:size(neighborSet,1)
    for j = 1:size(neighborSet,2)
        fprintf('%3d',neighborSet(i,j));        
    end
    fprintf('%5d%5d%5d%5d',sm_cost(i),sw_cost(i),sm_cost(i)+sw_cost(i),abs(sm_cost(i)-sw_cost(i)));        
    fprintf(' - generated from man = %d\n',menSet(i))
end
end
%---------------------------------------------------------------
function BreakMarriageWomanTest(menList,womenList)
%man optimal solution
[menShortlist0,womenShortlist0,M0] = GSManOptimalShortlists(menList,womenList);
%woman optimal solution
[womenShortlist_t,menShortlist_t,Mt] = GSWomanOptimalShortlists(womenList,menList);
%-------------------------------------------------------
%and cua 2 shortlists
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

%display
M = Mt     
%M = [7  8  1  6  3  4  2  5]
%M = [5  8  3  6  7  4  2  1]
fprintf('-------------------\n');
%
%initialize
sm_cost = [];
sw_cost = [];
neighborSet = [];
menSet = [];
for mi = 1:size(M,2)    
    stableMatching = BreakMarriageWoman(womenShortlist,menShortlist,M,mi,M0);     
    if ~isempty(stableMatching)        
        neighborSet(end+1,:) = stableMatching;   
        menSet(end+1) = mi;
        [fm,sm,sw] = MatchingCost(menList,womenList,stableMatching);
        sm_cost(end+1) = sm;
        sw_cost(end+1) = sw;
    end
end
for i = 1:size(neighborSet,1)
    for j = 1:size(neighborSet,2)
        fprintf('%3d',neighborSet(i,j));        
    end
    fprintf('%5d%5d%5d%5d',sm_cost(i),sw_cost(i),sm_cost(i)+sw_cost(i),abs(sm_cost(i)-sw_cost(i)));        
    fprintf(' - generated from man = %d\n',menSet(i))
end
end