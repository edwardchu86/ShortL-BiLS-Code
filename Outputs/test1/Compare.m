clc;
clear all;
close all;
%-----------------------------------
%ShortL-BiLS
load ShortL_BiLS_eg300
f_t1 = f_arr_time;
f_c1 = f_arr_cost;
%ShortL-BFS
load ShortL_BFS_eg300
f_t2 = f_arr_time;
f_c2 = f_arr_cost;
%
%evaluate
d1 = 0;
d2 = 0;
d3 = 0;
for i = 1:size(f_c1,2)
    if (f_c1(i) == f_c2(i))
        d1 = d1 + 1;
    else
        if (f_c1(i) == f_arr_cost2(i))
            d2 = d2 + 1;
        else
            if (f_c1(i) == f_arr_cost3(i))
            d3 = d3 + 1;
            end
        end
    end
end
fprintf('\n ShortL_BiLS: Avg. time = %f',mean(f_t1));
fprintf('\n ShortL_BFS:  Avg. time = %f',mean(f_t2));
fprintf('\n Best = %f',d1*2);
fprintf('\n Second best = %f',d2*2);
fprintf('\n Third best  = %f',d3*2);
fprintf('\n Others      = %f\n',100-(d1+d2+d3)*2);
%------------------------
%maximize zoom and crop figure
figure;
subplot(2,2,1);
hold on;
h1 = plot(log10(f_t1),'--b*');
h2 = plot(log10(f_t2),'--ko');
hand = legend([h1,h2],'ShortL-BiLS','ShortL-BFS',...
       'Location','northwest','Orientation','horizontal');
set(hand,'fontsize',11,'FontAngle','italic');  
legend('boxoff')
set(gcf,'color','w');
xlabel('SM instance');
ylabel('Execution time (s)');
box
%=======================================
subplot(2,2,2);
hold on;
h1 = plot(f_c1,'--b*');

h2 = plot(f_c2,'--ko');
hand = legend([h1,h2],'ShortL-BiLS','ShortL-BFS',...
       'Location','northwest','Orientation','horizontal');
set(hand,'fontsize',11,'FontAngle','italic');
legend('boxoff'); 
xlabel('SM instance');
ylabel('Egalitarian cost');
%ylabel('Sex-equality cost');
box
