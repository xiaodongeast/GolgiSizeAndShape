function [ out ] = CalculateK( Dstage2, bin,xyScale,zScale )
% xyScale and zScale is only for the Golgi px
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%xyScale=0.238;
%zScale=0.8;
meanDis=0;
out=struct;

xyScale2=1;
zScale2=1;
% for each time point get centrosome matrix, Golgi matrix
for i=1:height(Dstage2)
    centr=Dstage2.center_centrosome(i).value;
    Golgi=Dstage2.GolgiCor(i).data(:,2:4);
    out(i).time=Dstage2.timePoint(i);
    out(i).bin=bin;
    [cm,cn]=size(centr);
    [gm,gn]=size(Golgi);
Golgi=[Golgi(:,1)*xyScale,Golgi(:,2)*xyScale,Golgi(:,3)*zScale];
centr=[centr(:,1)*xyScale2,centr(:,2)*xyScale2,centr(:,3)*zScale2]; 
% if the number of the centrosome is 1 get the distance

d=zeros(gm,1);
if cm==1
    for jj=1:gm
        d(jj)=disK(centr(1,:),Golgi(jj,:));
    end  
end   
% if the number of the centrosome is 2 get the min distance
if cm==2
    
    for j=1:gm
        d1=disK(centr(1,:),Golgi(j,:));
        d2=disK(centr(2,:),Golgi(j,:));
      
      if (d1<=d2)
        d(j)=d1;
      else
        d(j)=d2;
      end        
    end  
end
% get the output: 1. average min distance
meanDis=mean(d);
%2. histogram with a userinput bin
hisDis=histogram(d,bin);
count=hisDis.Values;
%3. percentage of the histogram with the same user input bin
countp=count./sum(count);
% assemble the output into a data structure
out(i).meanDis=meanDis;
out(i).count=count;
out(i).countp=countp;
% end for 
end    

end
function[dd]= disK(c,g)
    
dd=sqrt((c(1)-g(1))^2+(c(2)-g(2))^2+(c(3)-g(3))^2);
end
