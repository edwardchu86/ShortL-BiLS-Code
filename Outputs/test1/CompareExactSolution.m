clc;
clear all;
close all;
%-----------------------------------
ShL_BiLS_eg_cost = [];
ShL_BiLS_se_cost = [];
FuL_BiLS_eg_cost = [];
FuL_BiLS_se_cost = [];
HiC_eg_cost = [];
HiC_se_cost = [];
LSf_eg_cost = [];
LSf_se_cost = [];
ShL_BFS_eg_cost = [];
ShL_BFS_se_cost = [];
for i = 25:25:500
    %---------------------------------------
    %ShortL-BiLS
    filename_eg = ['ShortL_BiLS_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    ShortL_BiLS_eg_cost = f_arr_cost;
    %
    filename_se = ['ShortL_BiLS_se',num2str(i),'.mat'];    
    load(filename_se);    
    ShortL_BiLS_se_cost = f_arr_cost;
    %---------------------------------------
    %FullL-BiLS
    filename_eg = ['FullL_BiLS_eg',num2str(i),'.mat'];    
    load(filename_eg);  
    FullL_BiLS_eg_cost = f_arr_cost;
    %
    filename_se = ['FullL_BiLS_se',num2str(i),'.mat'];    
    load(filename_se);
    FullL_BiLS_se_cost = f_arr_cost;
    %---------------------------------------
    %Hill Climbing
    filename_eg = ['HillClimbing_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    HillClimbing_eg_cost = f_arr_cost;
    %
    filename_se = ['HillClimbing_se',num2str(i),'.mat'];    
    load(filename_se);    
    HillClimbing_se_cost = f_arr_cost;
    %----------------------------------------   
    %SLS
    filename_eg = ['LSBestSoFar_eg',num2str(i),'.mat'];    
    load(filename_eg);    
    LSSofar_eg_cost = f_arr_cost;
    %
    filename_se = ['LSBestSoFar_se',num2str(i),'.mat'];    
    load(filename_se);    
    LSSofar_se_cost = f_arr_cost;
    %----------------------------------------
    %ShortL-BFS
    filename_bfs = ['ShortL_BFS',num2str(i),'.mat'];    
    load(filename_bfs);    
    ShortL_BFS_eg_cost = f_arr_cost_eg;
    ShortL_BFS_se_cost = f_arr_cost_se;
    
    eg1 = 0; se1 = 0;
    eg2 = 0; se2 = 0;
    eg3 = 0; se3 = 0;
    eg4 = 0; se4 = 0;
    for j = 1:10
        %ShortL-BiLS
        if ShortL_BiLS_eg_cost(j) == ShortL_BFS_eg_cost(j)
            eg1 = eg1 + 1;
        end
        if ShortL_BiLS_se_cost(j) == ShortL_BFS_se_cost(j)
            se1 = se1 + 1;
        end
        %FullL-BiLS
        if FullL_BiLS_eg_cost(j) == ShortL_BFS_eg_cost(j)
            eg2 = eg2 + 1;
        end
        if FullL_BiLS_se_cost(j) == ShortL_BFS_se_cost(j)
            se2 = se2 + 1;
        end
        %HillClimbing
        if HillClimbing_eg_cost(j) == ShortL_BFS_eg_cost(j)
            eg3 = eg3 + 1;
        end
        if HillClimbing_se_cost(j) == ShortL_BFS_se_cost(j)
            se3 = se3 + 1;
        end
        %SLS 
        if LSSofar_eg_cost(j) == ShortL_BFS_eg_cost(j)
            eg4 = eg4 + 1;
        end
        if LSSofar_se_cost(j) == ShortL_BFS_se_cost(j)
            se4 = se4 + 1;
        end
    end 
    ShL_BiLS_eg_cost(end+1) = eg1;    
    ShL_BiLS_se_cost(end+1) = se1;
    FuL_BiLS_eg_cost(end+1) = eg2;
    FuL_BiLS_se_cost(end+1) = se2;    
    HiC_eg_cost(end+1) = eg3;
    HiC_se_cost(end+1) = se3;
    LSf_eg_cost(end+1) = eg4;
    LSf_se_cost(end+1) = se4;    
end
% %------------------------
fprintf('\n exact egalitarian solutions of ShortL-BiLS = %f',sum(ShL_BiLS_eg_cost)/200);
fprintf('\n exact sex-equal solutions of ShortL-BiLS = %f',sum(ShL_BiLS_se_cost)/200);
%
fprintf('\n exact egalitarian solutions of FullL-BiLS = %f',sum(FuL_BiLS_eg_cost)/200);
fprintf('\n exact sex-equal solutions of FullL-BiLS = %f',sum(FuL_BiLS_se_cost)/200);
%
fprintf('\n exact egalitarian solutions of HillClimbing = %f',sum(HiC_eg_cost)/200);
fprintf('\n exact sex-equal solutions of HillClimbing = %f',sum(HiC_se_cost)/200);
%
fprintf('\n exact egalitarian solutions of SLS = %f',sum(LSf_eg_cost)/200);
fprintf('\n exact sex-equal solutions of SLS = %f',sum(LSf_se_cost)/200);


%maximize zoom and crop figure
figure;
%subplot(2,1,1);
hold on;

h = bar([ShL_BiLS_eg_cost',FuL_BiLS_eg_cost',HiC_eg_cost',LSf_eg_cost'],0.5);
%h = bar([ShL_BiLS_se_cost',FuL_BiLS_se_cost',HiC_se_cost',LSf_se_cost'],0.5);

hand = legend(h,'ShortL-BiLS','FullL-BiLS','Hill-Climbing','SLS',...
                'Location','northwest','Orientation','horizontal');

set(hand,'fontsize',13,'FontAngle','italic');  
legend('boxoff')
set(gcf,'color','w');
%xlim([0 10]);
xticks(1:20);
xticklabels({'25','50','75','100','125','150','175','200','225','250',...
            '275','300','325','350','375','400','425','450','475','500'})
ylim([0,10]);
yticks(0:10);
hx = xlabel('SM instance sizes');
set(hx, 'FontSize', 13)
hxa = get(gca,'XTickLabel');
set(gca,'XTickLabel',hxa,'fontsize',13)

hy = ylabel('Number of exact solutions');
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
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1.1, 0.65]);
% %=======================================
