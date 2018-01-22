function [ ft2 ] = showHisAndPlotK( resultStruct,bin )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
resultTable=struct2table(resultStruct);
bin2=bin(2:end); 
 axis manual;
    ylim([0,1.2]);
    xlim([0,max(bin)]);
    ax = gca;
for i=1:length(resultStruct)
     ax.NextPlot = 'replaceChildren';
     drawnow;
     frameNo=num2str(resultStruct(i).time);
     t=strcat('this is the timePoint',frameNo);
     title(t);
     bar(bin2,resultStruct(i).countp);
    ft2(i)=getframe(gcf);
    
end


figure;
title('mean distance between Golgi and centrosome');
plot(resultTable.time, resultTable.meanDis);
hold on;
plot(resultTable.time, resultTable.meanDis, '*');
implay(ft2);
% use VideoWriter to save it as a avi once satisfied
end

