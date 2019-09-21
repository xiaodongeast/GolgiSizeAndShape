function [ c] =IrinaGolgiXD( aStr )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 
sl=length(aStr);
c=struct('Cellname',[],'aveDis',[],'withScale',[],'check_D',[],'compactness',[]);

for i=1:sl
    A=aStr(i);
    [cc,cor,chk,comp]=IrinaGolgiCal(A,i);
    c(i).Cellname=A.name;
    c(i).aveDis=cc;
    c(i).withScale=cor;
    c(i).check_D=chk;
    c(i).compactness=comp;
end

    
end



function [c,a,chkd,compactness]=IrinaGolgiCal(A,i)
a=A.value.data;
xCol=2;
yCol=3;
zCol=4;
scaleXY=0.16;
scaleZ=0.4;
a(:,xCol)=a(:,xCol).*scaleXY;
a(:,yCol)=a(:,yCol).*scaleXY;
a(:,zCol)=a(:,zCol).*scaleZ;
x=a(:,xCol)
y=a(:,yCol)
z=a(:,zCol)
mmmm=a(:,xCol:zCol);
%plotGolgi(a(:,xCol),a(:,yCol),a(:,zCol));

size1=8
size2=58

if size(mmmm,1)>1
 dD=pdist(mmmm);
 
averNear=mean(dD);
c=averNear;
chkd =squareform(dD);
else
    c=0;
    chkd=0;
end

[idx,center]=kmeans(mmmm,1);
distances = sqrt((x-center(1)).^2 + (y-center(2)).^2+(z-center(3)).^2);
compactness = mean(distances);
figure(i)
scatter3(a(:,xCol),a(:,yCol),a(:,zCol),size1,'bo');
alpha=0.5
hold
[s_x, s_y,s_z] = sphere;
surf(s_x*compactness+center(1),s_y*compactness+center(2),s_z*compactness+center(3),'FaceAlpha',0.5)
scatter3(center(1),center(2),center(3),size2,'ro','filled');
view(30,10)
hold off


xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis, imageHeight');
shading flat

end
 
 

