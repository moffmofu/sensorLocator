function copy=getLoc(filename,varargin)
% import & translate the senseor layouts from the file exported by GPS system
% param.1 : filename to read
% param.2 : mode("xy"=2dim_xyPlane , "3"=3dim)

if nargin==1
    mode="xy";
elseif nargin>2
    error("too many param.")
else
    mode=varargin{2};
    if strcmpi(mode,"xy")||strcmpi(mode,"3")
    else
        error("invalid param.")
    end
end

%% readfile
if contains(filename,'.xml')
    % .xml(export for MFF)
    data=readxml(filename);
    copy=zeros(3,129);
    for cnt=1:129
        out(1,cnt)=data.Children(2).Children(4).Children(cnt).;
        copy(2,cnt)=data(cnt).y;
    end
elseif contains(filename,'.sfp')
    % .sfp(export for BESA)
    data=readllllllllll();
elseif contains(filename,'.nsi')
    % .nsi(export for NSI)
    data=readrrrrrrrrrrr();
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
end




end

function cutXYPlane()
    %create base plane from nasion, LPA, RPA
    %set Cz location as normal vecter
    %shadow each point by normal vecter
end