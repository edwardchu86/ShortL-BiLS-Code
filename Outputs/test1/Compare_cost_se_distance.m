clc;
clear all;
close all;
%-----------------------------------
ShortL_BiLS_se_cost = [];
ShortL_BFS_se_cost = [];
Gale_Shapley_se_cost = [];

for i = 25:25:500
    %---------------------------------------
    %ShortL-BiLS
    filename_se = ['ShortL_BiLS_se',num2str(i),'.mat'];    
    load(filename_se);   
    ShortL_BiLS_se_cost = [ShortL_BiLS_se_cost,f_arr_cost];    
    %
    %---------------------------------------   
    %ShortL-BFS
    filename_se = ['ShortL_BFS',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BFS_se_cost = [ShortL_BFS_se_cost,f_arr_cost_se]; 
    %---------------------------------------   
    %Gale-Shapley solution
    filename_gs = ['Gale_Shapley',num2str(i),'.mat'];    
    load(filename_gs);
    M0_se_cost = abs(f_arr_cost0(1,:) - f_arr_cost0(2,:));
    Mt_se_cost = abs(f_arr_costt(1,:) - f_arr_costt(2,:));
    Gale_Shapley_se_cost = [Gale_Shapley_se_cost,min(M0_se_cost,Mt_se_cost)];    
end
figure;
hold on;
d1 = ShortL_BiLS_se_cost - ShortL_BFS_se_cost;
d2 = Gale_Shapley_se_cost - ShortL_BiLS_se_cost;
     
for i = 1:200
    x = [i,i];    
    y1 = [0,d1(i)];
    y2 = [0,d2(i)];     
    line(x,y2,'LineWidth',0.6,'LineStyle','--');
    line(x,y1,'LineWidth',0.6,'LineStyle','--');
           
    h(1) = plot(d1,'k*');
    h(2) = plot(d2,'bs');    
end
hand = legend(h,'\delta^{(1)} = d(M_{s}) - d(M_{s}^{opt})',...
                '\delta^{(2)} = min(d(M_0),d(M_t)) - d(M_{s})',...
                'Location','northwest','Orientation','vertical');
% 
set(hand,'fontsize',13,'FontAngle','italic');  
legend('boxoff')
set(gcf,'color','w');
xlim([0 200]);
xticks(0:10:200);
%
hx = xlabel('SM instance');
set(hx, 'FontSize', 13)
hxa = get(gca,'XTickLabel');
set(gca,'XTickLabel',hxa,'fontsize',13)
% 
hy = ylabel('The cost distance');
set(hy,'FontSize',13)
grid on
box on
% %=======================================
