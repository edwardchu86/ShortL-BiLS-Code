clc;
clear all;
close all;
%-----------------------------------
ShortL_BiLS_eg_cost = [];
ShortL_BFS_eg_cost = [];
Gale_Shapley_eg_cost = [];
for i = 25:25:500
    %---------------------------------------
    %ShortL-BiLS
    filename_eg = ['ShortL_BiLS_eg',num2str(i),'.mat'];    
    load(filename_eg);   
    ShortL_BiLS_eg_cost = [ShortL_BiLS_eg_cost,f_arr_cost];    
    %
    %---------------------------------------   
    %ShortL-BFS
    filename_eg = ['ShortL_BFS',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BFS_eg_cost = [ShortL_BFS_eg_cost,f_arr_cost_eg]; 
    %---------------------------------------   
    %Gale-Shapley solution
    filename_gs = ['Gale_Shapley',num2str(i),'.mat'];    
    load(filename_gs);
    M0_eg_cost = f_arr_cost0(1,:) + f_arr_cost0(2,:);
    Mt_eg_cost = f_arr_costt(1,:) + f_arr_costt(2,:);
    Gale_Shapley_eg_cost = [Gale_Shapley_eg_cost,min(M0_eg_cost,Mt_eg_cost)];    
end
figure;
hold on;
c1 = ShortL_BiLS_eg_cost - ShortL_BFS_eg_cost;
c2 = Gale_Shapley_eg_cost - ShortL_BiLS_eg_cost;

for i = 1:200
    x = [i,i];    
    y1 = [0,c1(i)];
    y2 = [0,c2(i)];     
    line(x,y2,'LineWidth',0.6,'LineStyle','--');
    line(x,y1,'LineWidth',0.6,'LineStyle','--');
           
    h(1) = plot(c1,'k*');
    h(2) = plot(c2,'bs');    
end
hand = legend(h,'\Delta^{(1)} = c(M_{e}) - c(M_{e}^{opt})',...
                '\Delta^{(2)} = min(c(M_0),c(M_t)) - c(M_{e})',...
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
