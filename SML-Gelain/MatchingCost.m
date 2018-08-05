function [fm,sm,sw] = MatchingCost(menList,womenList,M)
n = size(M,2);
sm = 0;
sw = 0;
for i = 1 : n 
    mi = i;
    wi = M(i);
    mr = find(menList(mi,:) == wi);
    wr = find(womenList(wi,:) == mi);
    sm = sm + mr;
    sw = sw + wr;    
end 
%women-optimal cost
%fm = sw;
%egalitarian cost
fm = sm+sw;
%sex-equal cost
%fm = abs(sm-sw);
end
%-------------------------------------------------