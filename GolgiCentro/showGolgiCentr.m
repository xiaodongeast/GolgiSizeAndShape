function [ ft ] = showGolgiCentr( D )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
for i=min(D.timePoint):max(D.timePoint)
    Golgi=D.GolgiCor(i).data;
    Golgi=Golgi(:,2:4);
    centr=D.centroCor(i).value;
    center=D.center_centrosome(i).value;
    axis manual;
    ylim([0,512]);
    xlim([0,512]);
    zlim([0,30]);
   ax = gca;
   ax.NextPlot = 'replaceChildren';
   drawnow;
   scatter3(centr(:,1),centr(:,2),centr(:,3),'MarkerFaceColor',[0 1 0]);
   hold on
    scatter3(center(:,1),center(:,2),center(:,3),'MarkerEdgeColor',[1 0 0]);
   scatter3(Golgi(:,1),Golgi(:,2),Golgi(:,3),'*');
   hold off
   ft(i)=getframe(gcf);
    
end

end

