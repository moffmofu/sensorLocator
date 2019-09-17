function [out,vars,space]=averageLoc(fileNames,varargin)
% input:
%  filenames    - list of file name including extension(like ".xml")
%  mode(option) - 2d(xyplane) or 3d
% output:
%  out  - averages
%  vars - variances
%  space- locations
% @2019/9/17 Mori Fukuda

if nargin>1
    mode=cell2mat(varargin{1});
else
    mode="3";
end

if strcmpi(mode,"xy")
    outWid=2;
elseif strcmpi(mode,"3")||strcmpi(mode,"3d")
    outWid=3;
end
tangoLen=length(fileNames);
space=zeros(outWid,132,tangoLen);
%等方性を仮定。距離の分散とする。

for cnt=1:tangoLen
    space(:,:,cnt)=getLoc(fileNames(cnt),mode);
end
out=mean(space,3);
diffs=space-out;
diffs=diffs.^2;
diffs=sqrt(sum(diffs,1));
vars=var(diffs,0,3);
end
