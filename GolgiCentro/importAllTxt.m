function [ outDoc ] = importAllTxt( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% this is for automatically import all the txt from the folder for my MT
% spacing analysis.
% the result is in a structure name is the orignal file name, value is the
% line scan value and result is the histogram
docDir=uigetdir;
a=dir(docDir);
nDoc=length(a);
count=1;
f1='name';
f2='value';
f3='result';
outDoc=struct(f1,[],f2,[],f3,[]);
for i=1:nDoc
    s=a(i).name;
    isText=strfind(s,'.txt');
    %disp(isText);
   % disp(s);
    if isText>1;
        importName=strcat(docDir,'/',s);
        outDoc(count).name=s;
        outDoc(count).value=importdata(importName);
        count=count+1;
    end 
end

    
end

