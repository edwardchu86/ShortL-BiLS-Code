function SML()
clc;
clear all;
close all;
%define man preference list   
menList   = ReadFile('..\inputs\examples\men19viet.txt');
womenList = ReadFile('..\inputs\examples\women19viet.txt');
%menList
%womenList
%generate a random matching
n = size(menList,1);
x = randn(1,n);
[~,M] = sort(x);
%Count the number of blocking pairs
f = CountBlockingPair(menList,womenList,M)
%M = GSManOptimal(menList,womenList);
%f2 = CountBlockingPair(menList,womenList,M)
p = 0.05;
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
        f = CountBlockingPair(menList,womenList,M);
    else
        break;
    end    
end
M
[fm,sm,sw] = MatchingCost(menList,womenList,M);
[sm,sw,fm]
%f = CountBlockingPair(menList,womenList,M)
end
%--------------------

