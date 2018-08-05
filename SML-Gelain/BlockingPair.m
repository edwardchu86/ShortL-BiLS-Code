function [f] = BlockingPair(menList,womenList,mi,wi,mj,wj)
%Given two pairs (mi,wi) and (mj,wj) in a matching
%a pair (mi,wj) is a blocking pair iff mi and wj are not partners
%but mi prefers wj to wi and wj prefers mi to mj 
f = false;
if ((PersonRank(menList,mi,wj)<PersonRank(menList,mi,wi))&&(PersonRank(womenList,wj,mi)<PersonRank(womenList,wj,mj)))
    f = true;
end
end
%--------------------------------------------------
function [r] = PersonRank(personList,p1,p2)
%rank p2 in preference list PL of p1
r = find(personList(p1,:) == p2);
end
%--------------------------------------------------