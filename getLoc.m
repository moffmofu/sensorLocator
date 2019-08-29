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
    % xml
    data=readxml(filename);
elseif contains(filename,'.')
    %
elseif contains(filename,'.txt')
    %
    
else
    % invalid extension
    msg=strcat("Given file style is not supported.\n",...
        "Choose mff, or in export menu of GPS Solver.");
    error("getLoc:invalidParam",msg);
end

%% reform data
if strcmpi(data,"xy")
    
elseif strcmpi(data,"3")
    
end



end