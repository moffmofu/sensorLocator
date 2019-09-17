function out=getLoc(filename,varargin)
% import & translate the senseor layouts from the file exported by GPS system
% param.1 : filename to read
% param.x : 
%   dim("xy"=2dim_xyPlane , "3"=3dim)
%   unit("raw","np1"=-1~1,"01"=0~1)

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

%% readfile
pntNum=129+3; %ChNum+nasion+LPA
if contains(filename,'.xml')
    % .xml(export for MFF)
    data=readxml(filename);
    data=data.Children(2).Children(4);
    copy=zeros(3,pntNum);
    for cnt=1:pntNum
        xloc=data.Children(2*cnt).Children(8).Children.Data;
        copy(1,cnt)=str2double(xloc);
        yloc=data.Children(2*cnt).Children(10).Children.Data;
        copy(2,cnt)=str2double(yloc);
        zloc=data.Children(2*cnt).Children(12).Children.Data;
        copy(3,cnt)=str2double(zloc);
    end
elseif contains(filename,'.sfp')
    % .sfp(export for BESA)
    data=readsfp(filename);
    copy=data;
elseif contains(filename,'.nsi')
    % .nsi(export for NSI)
    data=readnsi(filename);
    copy=data;
else
    % invalid extension
    msg=strcat("Given file style is not supported.\n",...
        "Choose mff, or in export menu of GPS Solver.");
    error("getLoc:invalidParam",msg);
end

%% reform data


if strcmpi(dim,"xy")
    out=cutXYPlane(copy);
    
elseif strcmpi(dim,"3")||strcmpi("3d")
    % Žg‚¢•û‚ðŒ©‚ÄŒˆ‚ß‚é
    out=copy;
end

if strcmpi(unit,"raw")
    
elseif strcmpi(unit,"np1")
    ref=out;
    ref=ref.^2;
    ref=sqrt(sum(ref,1));
    [ref,ind]=max(ref);
    out=out/ref;
    fprintf("ref:%d",ind)
    
    
elseif strcmpi(unit,"01")
    ref=out(:,17);
    ref=ref.^2;
    ref=sqrt(sum(ref,1));
    [ref,ind]=max(ref);
    out=out/ref;
    fprintf("ref:%d",ind)
    out=out+1;
end


end

function output=cutXYPlane(input)
output=input(1:2,:);
%rotate & set 
input=cart2pol(input);
dLPA=pi-input(:,130);
dRPA=0-input(:,131);
%shadow each point by normal vecter
end

function output=adjust4CreateTopo(input)
%pull(-1~1)
output=input;

%push(0~1)
end

function main3d
test=getLoc("test4(MHT1-3-before2).xml","dim","3","unit","np1");
scatter3(test(1,:),test(2,:),test(3,:))
hold on
scatter3(test(1,129:132),test(2,129:132),test(3,129:132))
grid on
scatter3(test(1,81),test(2,81),test(3,81))
end