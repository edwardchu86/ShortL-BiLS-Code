clc;
clear all;
close all;
%-----------------------------------
ShortL_BiLS_eg_time = [];
ShortL_BiLS_se_time = [];
FullL_BiLS_eg_time = [];
FullL_BiLS_se_time = [];
HillClimbing_eg_time = [];
HillClimbing_se_time = [];
LSSofar_eg_time = [];
LSSofar_se_time = [];
ShortL_BFS_time = [];

for i = 25:25:500
    %---------------------------------------
    %ShortL-BiLS
    filename_eg = ['ShortL_BiLS_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_time(end+1) = f_arr_time;
    %
    filename_se = ['ShortL_BiLS_se',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_time(end+1) = f_arr_time;
    %---------------------------------------
    %FullL-BiLS
    filename_eg = ['FullL_BiLS_eg',num2str(i),'.mat'];    
    load(filename_eg);  
    FullL_BiLS_eg_time(end+1) = f_arr_time;
    %
    filename_se = ['FullL_BiLS_se',num2str(i),'.mat'];    
    load(filename_se);
    FullL_BiLS_se_time(end+1) = f_arr_time;
    %---------------------------------------
    %Hill Climbing
    filename_eg = ['HillClimbing_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    HillClimbing_eg_time(end+1) = f_arr_time;
    %
    filename_se = ['HillClimbing_se',num2str(i),'.mat'];    
    load(filename_se);    
    HillClimbing_se_time(end+1) = f_arr_time;
    %----------------------------------------   
    %SLS
    filename_eg = ['LSBestSoFar_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    LSSofar_eg_time(end+1) = f_arr_time;
    %
    filename_se = ['LSBestSoFar_se',num2str(i),'.mat'];    
    load(filename_se);    
    LSSofar_se_time(end+1) = f_arr_time;
    %----------------------------------------
    %ShortL-BFS
    filename_time = ['ShortL_BFS',num2str(i),'.mat'];    
    load(filename_time);    
    ShortL_BFS_time(end+1) = f_arr_time;
end
%------------------------
% i = 25:25:500;
% [i',ShortL_BiLS_eg_time', HillClimbing_eg_time']
% 
 sum(LSSofar_eg_time)/sum(ShortL_BiLS_eg_time)
% %print
 i = 25:25:500;
%[i',HillClimbing_eg_time',HillClimbing_se_time',ShortL_BiLS_eg_time',ShortL_BiLS_se_time',FullL_BiLS_eg_time',...
%    FullL_BiLS_se_time',LSSofar_eg_time',LSSofar_se_time',ShortL_BFS_time']
%[sum(HillClimbing_eg_time),sum(HillClimbing_se_time),sum(ShortL_BiLS_eg_time),sum(ShortL_BiLS_se_time),sum(FullL_BiLS_eg_time),...
% sum(FullL_BiLS_se_time),sum(LSSofar_eg_time),sum(LSSofar_se_time),sum(ShortL_BFS_time)]

%
%maximize zoom and crop figure
figure;
%subplot(2,1,1);
hold on;
%ShortL-BiLS
h1 = plot(log10(ShortL_BiLS_eg_time),'--r*');
h2 = plot(log10(ShortL_BiLS_se_time),'--ro');
%FullL-BiLS
h3 = plot(log10(FullL_BiLS_eg_time),'--b^');
h4 = plot(log10(FullL_BiLS_se_time),'--bv');
%Hill Climbing
color = [0 0.5 0.12];
h5 = plot(log10(HillClimbing_eg_time),'-->','color',color);
h6 = plot(log10(HillClimbing_se_time),'--<','color',color);
%SLS
h7 = plot(log10(LSSofar_eg_time),'--ms');
h8 = plot(log10(LSSofar_se_time),'--md');
%ShortL-BFS
h9 = plot(log10(ShortL_BFS_time),'--kp');

hand = legend([h1,h2,h3,h4,h5,h6,h7,h8,h9],...
       'ShortL-BiLS for finding egalitarian',...
       'ShortL-BiLS for finding sex-equality',...      
       'FullL-BiLS for finding egalitarian',...
       'FullL-BiLS for finding sex-equality',... 
       'Hill-Climbing for finding egalitarian',...
       'Hill-Climbing for finding sex-equality',... 
       'SLS for finding egalitarian',...
       'SLS for finding sex-equality',... 
       'ShortL-BFS for finding egalitarian or sex-equality');        
   
set(hand,'fontsize',13,'FontAngle','italic');  
legend('boxoff')
set(gcf,'color','w');
xlim([1 20]);
xticks(1:20);
xticklabels({'25','50','75','100','125','150','175','200','225','250',...
            '275','300','325','350','375','400','425','450','475','500'})
ylim([-2,3]);
hx = xlabel('SM instance sizes');
set(hx, 'FontSize', 13)
hxa = get(gca,'XTickLabel');
set(gca,'XTickLabel',hxa,'fontsize',13)

hy = ylabel('Average execution time (log10)');
set(hy,'FontSize',13)

grid on
ax = gca;
set(ax,'GridLineStyle','--') 
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.GridColor = [0 0 0];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.4;
box on
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1.2, 0.95]);
% %=======================================
