function[allHis]= GolgiCentrosomDis(centrosome,Golgi,bin)
tCol=4;
GolgiXCol=2;
GolgiZCol=4;
centrosome.Properties.VariableNames{tCol} = 't';
[G,ID]=findgroups(centrosome.t);
allGolgiCentroDis=cell(length(ID),1);
allHis=zeros(length(bin)-1,length(ID));
for ii=1:length(ID)
    rows=centrosome.t==ii;
    % get centrosome for the point
    tcentrosome=[centrosome.x(rows),centrosome.y(rows),centrosome.z(rows)];
    tGolgi=Golgi(ii).value.data;
    tGolgi=tGolgi(:,GolgiXCol:GolgiZCol);
    [dis,aveDis,result]=groupCentrosome(tcentrosome,tGolgi);
    allGolgiCentroDis(ii)={dis};
    a=histogram(dis,bin);
    count=a.Values;
    allHis(:,ii)=count';
    
end

end

function [d, ave,result ] = groupCentrosome( X,temp )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% first need to remove outlier based on K's real data
xyScale=0.238;
zScale=0.8;

%i=1; % assume I am working on the time point 1. So I will pass the centrosome 
%position for time1 X, and Golgi pixel value A
%% get the center of the two group of centrosomes.
opts = statset('Display','final');
[idx,C] = kmeans(X,2,'Distance','cityblock',...
    'Replicates',5,'Options',opts);
% each row is a data (x, y,z)

%% this part need to modify, here I accept 
 
temp=[temp(:,1)*xyScale,temp(:,2)*xyScale,temp(:,3)*zScale];
C=[C(:,1)*xyScale,C(:,2)*xyScale,C(:,3)*zScale];
%% caculate distance for C1, and C2 to every point in temp
sum=0;
d=zeros(length(temp),1);
for i=1:length(temp)
    d1=dis(C(1,:),temp(i,:));
    d2=dis(C(2,:),temp(i,:));
    if (d1<=d2)
        d(i)=d1;
    else
        d(i)=d2;
    end    
 sum=sum+d(i);       

end
ave=mean(sum);
result=[temp,d];
end

function[d]= dis(c,g)
    
d=sqrt((c(1)-g(1))^2+(c(2)-g(2))^2+(c(3)-g(3))^2);
end

