function [ Dstage, Dstage2] = setStageK( D )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% I write this seperate one only for debugging. this cannot be use
% seperately. Data need to be exactly the output from assembleK.
% I forget I've already have a missing centrsome, so set a valid here.
Dstage=D;
timePoint=D.timePoint;
centr=D.centroGroup;
stage=D.stage;
valid=ones(length(timePoint),1);
%validTable=table;
%validTable.valid=valid;
for i=1:length(timePoint)
   currentCentr=centr(i);
   restLength=length(timePoint)-i;
   
   if currentCentr==2
       stage(i)=2;
       stage(i+1:end)=2*ones(restLength,1);
       break;
   elseif currentCentr==0
       stage(i)=-1;
   elseif currentCentr==1
       stage(i)=1;
   end
end



 for i=1:length(timePoint)
     if stage(i)~=centr(i)
         valid(i)=0;
     end
 end
 Dstage.valid=valid;
 Dstage.stage=stage;
Dstage2=Dstage;
Dstage2=sortrows(Dstage2,{'valid','timePoint'},{'descend','ascend'});
Dstage2=Dstage2(Dstage2.valid==1,:);
end

