function [orgData   ] =assembleK(Golgi,centro, theta)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% input Data: Golgi this is the structure whold all Golgi pixel info at
% each timepoint

% centro: this is the table imported from excel, with all the info of the
% centrosome coordinate
%% set the image scale for centrosome 
scaleX=0.23;
scaleY=0.23;
scaleZ=0.8;
%% set Cluster Ana
opts = statset('Display','final');
%%
Golgi=struct2table(Golgi);
orgData=table;
orgData.name=Golgi.name;
[timePoint,missGolgi ] = testTimeK(Golgi,'_t','bin' );
orgData.timePoint=timePoint;
orgData.GolgiCor=Golgi.value;
orgData.missGolgi=zeros(length(timePoint),1)+missGolgi;

% initilize all the timepoint with no centrosome;
% if the maxium distance above theta this will be 2;
% else set this to 1
% if no centrosome set to 0;
orgData.centroGroup=zeros(length(timePoint),1);

% initilize all the timpoint at Stage '0'; 
%this value should be set to '1' indicate there are only one centrosome or
%'2' indicate there will be 2 very well seperate centrosomes.

orgData.maxCentrDis=zeros(length(timePoint),1);
orgData.stage=zeros(length(timePoint),1); 

orgData.missCentrosome=zeros(length(timePoint),1);
% put time at the 4th colum
newCentr=[centro.x centro.y centro.z centro.t];
tempCentr=struct();
tempCentr.value=[0,0,0];
center=struct();
tempCentr.value=[0,0,0];
orgData.centroCor(1)=tempCentr;
orgData.center_centrosome(1)=tempCentr;
for i=1:length(timePoint)
    centrDetect=newCentr(newCentr(:,4)==i,:);
    centrDetect=centrDetect(:,1:3);
    tempCentr.value=centrDetect;
    
    % when there is no centrosome detected by Imaris
    if isempty(centrDetect)
        orgData.missCentrosome(i)=1;
        orgData.centrosomeImarisNumber(i)=0;
        tempCentr.value=[0,0,0];
         orgData.centroCor(i)=tempCentr;
   % if there is centrosome detected by Imaris
    else
        [m,n]=size(centrDetect);
        orgData.centrosomeImarisNumber(i)=m;
        orgData.centroCor(i)=tempCentr;    
    end
      % calculate dis
     
    centrScale=[centrDetect(:,1).*scaleX, centrDetect(:,2).*scaleY, centrDetect(:,3).*scaleZ];
    centrScale=centrScale';
    [m,n]=size(centrScale);
    orgData.maxCentrDis(i)=max(max(dist(centrScale)));
    
    if  sum(sum(centrScale))==0
        % sum of all is 0 means everyValue is 0
        orgData.centroGroup(i)=0;
        center.value=centrDetect;
        orgData.center_centrosome(i)=center;
    % otherwise if there is only one elment    
    elseif n==1 
          orgData.centroGroup(i)=1;
          center.value=centrDetect;
        orgData.center_centrosome(i)=center;
      % for whatever reason the dis ins zero  
    elseif max(max(dist(centrScale)))==0
           orgData.centroGroup(i)=0;
           center.value=centrDetect;
        orgData.center_centrosome(i)=center;
      % compare with user threshod find the center  
    elseif max(max(dist(centrScale)))<=theta
    orgData.centroGroup(i)=1;
       [idx,C] = kmeans(centrDetect,1,'Distance','cityblock',...
    'Replicates',1,'Options',opts);
         center.value=C;
        orgData.center_centrosome(i)=center;
        
        % compare with user input  find the center, and put everything into 
        % two clusters
    elseif max(max(dist(centrScale)))>theta
        orgData.centroGroup(i)=2;   
        [idx,C] = kmeans(centrDetect,2,'Distance','cityblock',...
    'Replicates',5,'Options',opts);
         center.value=C;
        orgData.center_centrosome(i)=center;
          
    end
    
    
end    

end

