function [ boundDoc ] = importAllTxtEM( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% this is for automatically import all the txt from the folder for my MT
% spacing analysis.
% the result is in a structure name is the orignal file name, value is the
% line scan value and result is the histogram
cellNo=4;
boundTag=5;
docDir=uigetdir;
a=dir(docDir);
nDoc=length(a);
count=1;
sample=1;
f1='name';
f2='value';
f3='result';
f4='nameOut'
f5='outBound';
f6='nameIn';
f7='innerBound';
f8='totalName';
f9='total';

outDoc=struct(f1,[],f2,[],f3,[]);
boundDoc=struct(f4,[],f5,[],f6,[],f7,[],f8,[],f9,[]);
temp=struct(f1,[],f2,[]);
for i=1:nDoc
    s=a(i).name;
    isText=strfind(s,'.txt');
   
    %disp(isText);
   % disp(s);
    if isText>1;
        importName=strcat(docDir,'/',s);
        temp(count).name=s;
        temp(count).value=importdata(importName);
        isTotal=strfind(s,'total');
         tm=temp(count).value.data;   
        [m,n]=size(tm);
         if isTotal 
            totalN=sscanf(s,'total%d');
            boundDoc(totalN).(f8)=s;
            boundDoc(totalN).(f9)=tm(:,2:3);
          
         elseif n>4
                iCellNo=tm(sample,cellNo);  
                iTag=tm(sample,boundTag);
                if iTag==-10
                    boundDoc(iCellNo).(f4)=s;
                    boundDoc(iCellNo).(f5)=tm(:,2:3);
                elseif iTag==-1
                    boundDoc(iCellNo).(f6)=s;
                    boundDoc(iCellNo).(f7)=tm(:,2:3);
                end    
         end
         
    end
        count=count+1;
end 
    
    
    
end
%%%% finish collect all the data
    
 

