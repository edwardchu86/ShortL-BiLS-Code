function [f] = CountBlockingPair(menList,womenList,M)
n = size(M,2);
f = 0;
for i = 1 : n 
    mi = i;
    wi = M(i);         
    for j = 1 : n
        mj = j;
        wj = M(j);
        %check blocking pair (mi,wj)
        if (BlockingPair(menList,womenList,mi,wi,mj,wj) == true)
          f = f + 1;          
        end
    end    
end 
end
%--------------------------------------------------
