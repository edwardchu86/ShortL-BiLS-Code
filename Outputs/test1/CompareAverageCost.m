clc;
clear all;
close all;
%-----------------------------------
ShortL_BiLS_eg_cost = [];
ShortL_BiLS_se_cost = [];
FullL_BiLS_eg_cost = [];
FullL_BiLS_se_cost = [];
HillClimbing_eg_cost = [];
HillClimbing_se_cost = [];
LSSofar_eg_cost = [];
LSSofar_se_cost = [];
ShortL_BFS_eg_cost = [];
ShortL_BFS_se_cost = [];

for i = 25:25:500
    %---------------------------------------
    %ShortL-BiLS
    filename_eg = ['ShortL_BiLS_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_cost(end+1) = mean(f_arr_cost);
    %
    filename_se = ['ShortL_BiLS_se',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_cost(end+1) = mean(f_arr_cost);
    %---------------------------------------
    %FullL-BiLS
    filename_eg = ['FullL_BiLS_eg',num2str(i),'.mat'];    
    load(filename_eg);  
    FullL_BiLS_eg_cost(end+1) = mean(f_arr_cost);
    %
    filename_se = ['FullL_BiLS_se',num2str(i),'.mat'];    
    load(filename_se);
    FullL_BiLS_se_cost(end+1) = mean(f_arr_cost);
    %---------------------------------------
    %Hill Climbing
    filename_eg = ['HillClimbing_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    HillClimbing_eg_cost(end+1) = mean(f_arr_cost);
    %
    filename_se = ['HillClimbing_se',num2str(i),'.mat'];    
    load(filename_se);    
    HillClimbing_se_cost(end+1) = mean(f_arr_cost);
    %----------------------------------------   
    %SLS
    filename_eg = ['LSBestSoFar_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    LSSofar_eg_cost(end+1) = mean(f_arr_cost);
    %
    filename_se = ['LSBestSoFar_se',num2str(i),'.mat'];    
    load(filename_se);    
    LSSofar_se_cost(end+1) = mean(f_arr_cost);
    %----------------------------------------
    %ShortL-BFS
    filename_bfs = ['ShortL_BFS',num2str(i),'.mat'];    
    load(filename_bfs);    
    ShortL_BFS_eg_cost(end+1) = mean(f_arr_cost_eg);
    ShortL_BFS_se_cost(end+1) = mean(f_arr_cost_se);           
end
% %------------------------
% c1 = ShortL_BiLS_eg_cost./ShortL_BFS_eg_cost;
% c2 = FullL_BiLS_eg_cost./ShortL_BFS_eg_cost;
% c3 = HillClimbing_eg_cost./ShortL_BFS_eg_cost;
% c4 = LSSofar_eg_cost./ShortL_BFS_eg_cost;
% c5 = ShortL_BFS_eg_cost./ShortL_BFS_eg_cost;

c1 = ShortL_BiLS_eg_cost - ShortL_BFS_eg_cost;
c2 = FullL_BiLS_eg_cost - ShortL_BFS_eg_cost;
c3 = HillClimbing_eg_cost - ShortL_BFS_eg_cost;
c4 = LSSofar_eg_cost - ShortL_BFS_eg_cost;
%c5 = ShortL_BFS_eg_cost -ShortL_BFS_eg_cost;

% c1 = ShortL_BiLS_eg_cost;
% c2 = FullL_BiLS_eg_cost;
% c3 = HillClimbing_eg_cost;
% c4 = LSSofar_eg_cost;
% c5 = ShortL_BFS_eg_cost;

%
d1 = ShortL_BiLS_se_cost - ShortL_BFS_se_cost;
d2 = FullL_BiLS_se_cost - ShortL_BFS_se_cost;
d3 = HillClimbing_se_cost - ShortL_BFS_se_cost;
d4 = LSSofar_se_cost - ShortL_BFS_se_cost;
%d5 = ShortL_BFS_se_cost - ShortL_BFS_se_cost;
%
%maximize zoom and crop figure
figure;
%subplot(2,1,1);
hold on;
%h = bar(log10([c1',c2',c3',c4']),0.5);
h = bar(log10([d1',d2',d3',d4']),0.5);

hand = legend(h,'ShortL-BiLS','FullL-BiLS','Hill-Climbing','SLS',...
                'Location','northwest','Orientation','horizontal');

set(hand,'fontsize',13,'FontAngle','italic');  
legend('boxoff')
set(gcf,'color','w');
%xlim([0 10]);
xticks(1:20);
xticklabels({'25','50','75','100','125','150','175','200','225','250',...
            '275','300','325','350','375','400','425','450','475','500'})
% ylim([0,10]);
% yticks(0:10);
hx = xlabel('SM instance sizes');
set(hx, 'FontSize', 13)
hxa = get(gca,'XTickLabel');
set(gca,'XTickLabel',hxa,'fontsize',13)

%hy = ylabel('The difference of the average egalitarian costs (log10)');
hy = ylabel('The difference of the average sex-equality costs (log10)');
set(hy,'FontSize',13)
%set grid
grid on
ax = gca;
set(ax,'GridLineStyle','--') 
ax.XGrid = 'off';
ax.YGrid = 'on';
ax.GridColor = [0 0 0];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.5;
box on
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1.1, 0.65]);
% %=======================================
