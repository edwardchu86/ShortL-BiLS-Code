function ShortL_BFS_Simulations1()
%ref. McVitie and Wilson.The stable marriage problem,CACM
clc;
clear all;
close all;
%define man preference list   
%menList   = ReadFile('..\inputs\examples\men8mw.txt');
%womenList = ReadFile('..\inputs\examples\women8mw.txt');
%error for data test
%eg: 5     6     7     9    17    19    33    40    43    44    45    46
%se: 1     4    23    38    40    46    48
n = 150;
i = 9;
filename1 = ['..\inputs\test',num2str(n),'\men',num2str(i),'.mat'];
filename2 = ['..\inputs\test',num2str(n),'\women',num2str(i),'.mat'];
%define man preference list
load(filename1);
load(filename2);

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
    fprintf('\n t = %d,size of neighbors = %d',t,size(childSet,1));
    t = t + 1;
end
fprintf('\n');
elapsedTime = toc;
fprintf('\n elapsed time = %f',elapsedTime);
matchingSize = size(stableMatchingSet,1);
%display the stable matchings
c = [];
d = [];
for k = 1:matchingSize
    M = stableMatchingSet(k,:);
    sm = 0;
    sw = 0;
    for i = 1 : n 
        mi = i;
        wi = M(i);
        mr = find(menShortlist(mi,:) == wi);
        wr = find(womenShortlist(wi,:) == mi);
        sm = sm + mr;
        sw = sw + wr;    
    end    
    c(k) = sm + sw;
    d(k) = abs(sm - sw);
end
eg_min = min(c);
index1 = find(c == eg_min);
se_min = min(d);
index2 = find(d == se_min);

fM_best
eg_min
index1
se_min
index2
%[se_min,index2] = min(d)

figure;
%subplot(2,2,1);
hold on;
h1 = plot(c,'--b*');
h2 = plot(d,'--ko');
hand = legend([h1,h2],'Egalitarian cost','Sex-equality cost',...
       'Location','northwest','Orientation','horizontal');
set(hand,'fontsize',11,'FontAngle','italic');  
legend('boxoff')
set(gcf,'color','w');
xlabel('Matchings');
ylabel('Cost');
box
end
%---------------------------------------------------------------