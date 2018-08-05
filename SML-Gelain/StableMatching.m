function [f] = StableMatching(menRank,womenRank,matching)
n = size(matching,2);
f = true;
for i = 1 : n 
    mi = i;
    wi = matching(i);         
    for j = 1 : n
        mj = j;
        wj = matching(j);
        %count the number of blocking pairs        
        if (blocking_pair(menRank,womenRank,mi,wi,mj,wj) == true)
          f = false;
          break;
        end
    end    
end 
end
%--------------------------------------------------
function [f] = blocking_pair(menRank,womenRank,mi,wi,mj,wj)
%blocking pair if exists (mi,wi) and (mj,wj)
%such that mi prefer wj to wi and wj prefer mi to mj 
f = false;
if ((rank(menRank,mi,wj) < rank(menRank,mi,wi)) && (rank(womenRank,wj,mi) < rank(womenRank,wj,mj)))
    f = true;
end
end
%--------------------------------------------------
function [rk] = rank(peopleRank,p1,p2)
%rank p2 in preference list PL of p1
rk = find(peopleRank(p1,:) == p2);
end
%--------------------------------------------------