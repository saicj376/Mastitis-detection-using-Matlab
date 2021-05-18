close all;

clear all;
clc;
img=imread('mb.jpg');
bw=im2bw(img,0.5);
label=bwlabel(bw);
stats=regionprops(label,'Solidity','Area');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.3;
max_area=max(area(high_dense_area));
r_label=find(area==max_area);
r=ismember(label,r_label);
se=strel('square',5);
r=imdilate(r,se);
figure();
subplot(1,3,1);
imshow(img);
title('Breast MRI');
[B,L]=bwboundaries(r,'noholes');
subplot(1,3,2);
imshow(r);
hold on
for i=1:length(B)
    plot(B{i}(:,2),B{i}(:,1), 'r' ,'linewidth',2.5);
end
hold off;
title('clot Alone');
[B,L]=bwboundaries(r,'noholes');
subplot(1,3,3);
imshow(img);
hold on
for i=1:length(B)
    plot(B{i}(:,2),B{i}(:,1), 'y' ,'linewidth',1.5);
end

title('Detected clot');
hold off;