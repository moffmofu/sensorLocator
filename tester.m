clearvars;
close all;
%
%
%
%
%

names=["test1(MHT1-3-after1).xml","test2(MHT1-3-after2).xml"];

mode="3";

[aves,vars,loc]=averageLoc(names,mode);

figure(1);
scatter3(aves(1,:),aves(2,:),aves(3,:));
title("aver.")

figure(2);
scatter3(loc(1,:,1),loc(2,:,1),loc(3,:,1));
hold on
scatter3(loc(1,:,2),loc(2,:,2),loc(3,:,2));
%scatter3(tester(1,129:132),tester(2,129:132),tester(3,129:132))
title("indiv.")
