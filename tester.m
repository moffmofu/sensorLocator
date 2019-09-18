clearvars;
close all;
% tester for getLoc&averageLoc
%
% 2019/9/17 MoriFukuda

names=["test1(MHT1-3-after1).xml","test2(MHT1-3-after2).xml"];
% testdata

%dim="3";
dim="xy";
unit="np1";
nameadd=strcat("_dim-",dim,"_unit-",unit);
%for save

[aves,vars,loc]=averageLoc(names,"dim",dim,"unit",unit);
vars=sqrt(vars)/2;

figure(1);
% plot average location
if strcmp(dim,"3")
    scatter3(aves(1,:),aves(2,:),aves(3,:));
    zlabel("z (+:dorsal)");
else
    scatter(aves(1,:),aves(2,:));
    grid on;
    daspect([1 1 1]);
end
xlabel("x (+:right)");
ylabel("y (+:rostal)");
title("aver.");

figure(2);
% plot series of points individually
if strcmpi(dim,"3")
    scatter3(loc(1,:,1),loc(2,:,1),loc(3,:,1));
    hold on
    scatter3(loc(1,:,2),loc(2,:,2),loc(3,:,2));
    zlabel("z (+:dorsal)");
else
    scatter(loc(1,:,1),loc(2,:,1));
    hold on
    scatter(loc(1,:,2),loc(2,:,2));
    grid on;
    daspect([1 1 1]);
end
title("indiv.")
xlabel("x (+:right)");
ylabel("y (+:rostal)");


figure(3);
% plot with S.D.
filename=strcat("withSD",nameadd);
if strcmpi(dim,"xy")
    filename = strcat(filename,'.png');
    errorbar(aves(1,:),aves(2,:),vars(1,:),vars(1,:),vars(2,:),vars(2,:),'o');
    xlabel("x (+:right)");
    ylabel("y (+:rostal)");
    grid on;
    daspect([1 1 1]);
    print('-f3',filename,'-dpng');
else
    error3d(aves(1,:),aves(2,:),aves(3,:),vars(1,:),vars(2,:),vars(3,:));
    xlabel("x (+:right)");
    ylabel("y (+:rostal)");
    zlabel("z (+:dorsal)");
    
    
    %% write gif movie
    filename = strcat(filename,'.gif');
    nImages = 70;
    sepa=50;
    fig = figure(3);
    for idx = 1:sepa
        view(-45-idx*2,30);
        drawnow;
        frame = getframe(fig);
        im{idx} = frame2im(frame);
    end
    for idx=sepa:nImages
        view(-45-sepa*2,30+(idx-sepa)*3);
        drawnow;
        frame = getframe(fig);
        im{idx} = frame2im(frame);
    end
    close;
    for idx = 1:nImages
        [A,map] = rgb2ind(im{idx},256);
        if idx == 1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
        elseif idx==nImages
            imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',3);
        else
            imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);
        end
    end
end

%% figure output
opName="resImages";
figout(2,opName,strcat("indiv",nameadd));
figout(1,opName,strcat("aver",nameadd));
movefile(filename,opName);