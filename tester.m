clearvars;
close all;
%
%
%
%
%

names=["test1(MHT1-3-after1).xml","test2(MHT1-3-after2).xml"];

dim="3";
unit="np1";

[aves,vars,loc]=averageLoc(names,"dim",dim,"unit",unit);
vars=sqrt(vars)/2;

figure(1);
scatter3(aves(1,:),aves(2,:),aves(3,:));
title("aver.")

figure(2);
scatter3(loc(1,:,1),loc(2,:,1),loc(3,:,1));
hold on
scatter3(loc(1,:,2),loc(2,:,2),loc(3,:,2));
%scatter3(tester(1,129:132),tester(2,129:132),tester(3,129:132))
title("indiv.")

figure(3);
error3d(aves(1,:),aves(2,:),aves(3,:),vars(1,:),vars(2,:),vars(3,:));