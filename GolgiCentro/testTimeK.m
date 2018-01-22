
% Step1. Check the Golgi pixel value data has the correct time point

% this is a funtion to make sure the Golgi data from the image plugin 
% has 1. no missing time point,
%     2. have the proper sequence.


function [ test,tag ] = testTimeK(A, sub1,sub2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%A=struct2table(A);
t=A.name;

% assume there is a  'name'

test=zeros(length(t),1);
tag=0;
for i=1:length(t)
    a=extractBetween(t{i},sub1,sub2);
    % did not handle if a is not exit, sub1, sub2 not in 
    test(i)=str2num(a{1});
    if (i>1 && (test (i)-test(i-1))~=1)
        tag=1;
        disp('identfiy mistake');
        disp(i);
    end
        
end
end


