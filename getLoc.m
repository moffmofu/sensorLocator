function out=getLoc(filename,varargin)
% import & translate the senseor layouts from the file exported by GPS system
% param.1 : filename to read
% param.2 : mode("xy"=2dim_xyPlane , "3"=3dim)

if nargin==1
    mode="xy";
elseif nargin>2
    error("too many param.")
else
    mode=varargin{1};
    if strcmpi(mode,"xy")||strcmpi(mode,"3")
    else
        error("invalid param.")
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


if strcmpi(mode,"xy")
    out=cutXYPlane(copy);
    
elseif strcmpi(mode,"3")
    % Žg‚¢•û‚ðŒ©‚ÄŒˆ‚ß‚é
    out=copy;
end

out=adjust4CreateTopo(out);


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
tester=getLoc("test4(MHT1-3-before2).xml","3");
scatter3(tester(1,:),tester(2,:),tester(3,:))
hold on
scatter3(tester(1,129:132),tester(2,129:132),tester(3,129:132))
grid on
scatter3(tester(1,81),tester(2,81),tester(3,81))
end