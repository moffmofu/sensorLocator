function out=getLoc(filename,varargin)
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
    % .xml
    data=readxml(filename);
elseif contains(filename,'.')
    % 
    data=readllllllllll();
elseif contains(filename,'.txt')
    %
    data=readrrrrrrrrrrr();
else
    % invalid extension
    msg=strcat("Given file style is not supported.\n",...
        "Choose mff, or in export menu of GPS Solver.");
    error("getLoc:invalidParam",msg);
end

%% reform data
if strcmpi(mode,"xy")
    out=zeros(2,129);
    for cnt=1:129
        out(:,cnt)=[data(cnt).x,data(cnt).y];
    end
    out=out-1; %adjust location
elseif strcmpi(mode,"3")
    out=zeros(3,129);
    for cnt=1:129
        out(:,cnt)=[data(cnt).x,data(cnt).y];
    end
    out=out-1; %adjust location
end



end