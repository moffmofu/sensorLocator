function error3d(x,y,z,ex,ey,ez)
%
%
%
%
%
scatter3(x,y,z,'.');
hold on;
grds=10;
[X,Y,Z]=sphere(grds);
cols=ones(grds+1,grds+1,3);
cols(:,:,1)=cols(:,:,1)*0.85;
cols(:,:,2)=cols(:,:,2)*0.325;
cols(:,:,3)=cols(:,:,3)*0.098;

for cnt =1:length(x)
    Xp=X*ex(cnt)+x(cnt);
    Yp=Y*ey(cnt)+y(cnt);
    Zp=Z*ez(cnt)+z(cnt);
    s=surf(Xp,Yp,Zp,cols,'FaceAlpha',0.4,'edgeColor','None');
end
hold off
end