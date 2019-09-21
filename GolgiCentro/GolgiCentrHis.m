function [realStage,realStageSelect,realOut,hisMovie,realGolgiMovie] = GolgiCentrHis( Golgi,centr,xyScale,zScale,theta,bin,angle1,angle2 )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% this does not contain any calculation. It is just one button for all
 
% each individual function will be called here.
% assemble data into one
%% change the name of the centromse Excel data  
centr.Properties.VariableNames{1} = 'x';
centr.Properties.VariableNames{2} = 'y';
centr.Properties.VariableNames{3} = 'z';
centr.Properties.VariableNames{7} = 't';
%% (1) put together the Golgi and centrosome data, (2) find the center of the
%centrosome based on theta
realOrig=assembleK(Golgi,centr,theta);

%% show the 3dplot of Golgi, orignal centrosome in Green, the center of the centrosome/ or centrosome to be used in red 
realGolgiMovie=showGolgiCentr(realOrig,xyScale,zScale,angle1,angle2);

%% looking at the stage of the cell. If a cell is in the 2nd stage, has two centrosome in the time :N, it cannot be at the first stage at N+1 time point 
% once cells have 2 seperate centrosome, it should has 2 in the following
% time point, if not, it will be deleted. 

% realStage, is contains all the data, realStageSelect, contains only the
% correct data.
[realStage,realStageSelect]=setStageK(realOrig);


%% finally use calculateK to get the result from the selected corrected frames.
 realOut=CalculateK(realStageSelect,bin,xyScale,zScale);
% last show the final movie.
%% prepare the movie of the histogram
hisMovie=showHisAndPlotK(realOut,bin);

%% show the movie of both histogram and Golgi 3D
implay(hisMovie);
implay(realGolgiMovie);
end

