function [out,vars,space]=averageLoc(fileNames,varargin)
% input:
%  filenames    - list of file name including extension(like ".xml")
%  dim(option) - 2d(xyplane) or 3d
% output:
%  out  - averages
%  vars - variances
%  space- locations
% @2019/9/17 Mori Fukuda

dim="xy";
unit="raw";
if nargin>1
    for cnt=1:2:nargin-1
        tango=cell2mat(varargin{cnt});
        if strcmpi(tango,"dim")
            dim=varargin{cnt+1};
            if strcmpi(dim,"xy")||strcmpi(dim,"3")||strcmpi(dim,"3d")
            else
                error("invalid param.")
            end
        elseif strcmpi(tango,"unit")
            unit=cell2mat(varargin{cnt+1});
            if strcmpi(unit,"raw")||strcmpi(unit,"np1")||strcmpi(unit,"01")
            else
                error("invalid param.")
            end
        end
        
    end
end


if strcmpi(dim,"xy")
    outWid=2;
elseif strcmpi(dim,"3")||strcmpi(dim,"3d")
    outWid=3;
end
tangoLen=length(fileNames);
space=zeros(outWid,132,tangoLen);
%“™•û«‚ğ‰¼’èB‹——£‚Ì•ªU‚Æ‚·‚éB

for cnt=1:tangoLen
    space(:,:,cnt)=getLoc(fileNames(cnt),"dim",dim,"unit",unit);
end
out=mean(space,3);
vars=var(space,0,3);
end
