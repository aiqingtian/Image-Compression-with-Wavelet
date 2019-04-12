% Image Compression with Integer ternary Haar Wavelet 
clc;
clear;
close all;

I = imread('lena512.bmp');
I = imresize(I, [243, 243]);
I = double(I);
[imh, imw] = size(I);
% n = sqrt(imh);
n = 1;

% Decomposition
res2 = I;
for i = 1:n
    average_w = floor((res2(1:imh, 1:3:imw) + res2(1:imh, 2:3:imw) + res2(1:imh, 3:3:imw))/3);
    res2(1:imh, 1:imw)=[average_w    res2(1:imh, 1:3:imw) - res2(1:imh, 2:3:imw)  res2(1:imh, 1:3:imw) - res2(1:imh, 3:3:imw)];
    average_h = floor((res2(1:3:imh, 1:imw) + res2(2:3:imh, 1:imw) + res2(3:3:imh, 1:imw))/3);
    res2(1:imh,1:imw)=[average_h; res2(1:3:imh, 1:imw) - res2(2:3:imh,1:imw); res2(1:3:imh, 1:imw) - res2(3:3:imh, 1:imw)];
    imw = imw/3;
    imh = imh/3;
end
figure;
imshow(res2, []);

% Reconstruction
[reh, rew] = size(res2);
reh = reh/(3^(n-1));
rew = rew/(3^(n-1));
for i= 1:n
    up = res2(1: reh/3, 1: rew);
    mid = res2(reh/3 +1: 2/3*reh, 1:rew);
    down = res2(2*reh/3+1:reh, 1:rew);
    p3 = (up - floor((2*mid + 2*down)/3) + mid);
    p1 = (down + p3);
    p2 = (p1 - mid);
    res2(1:3:reh, 1:rew) = p1;
    res2(2:3:reh, 1:rew) = p2;
    res2(3:3:reh, 1:rew) = p3;
    left = res2(1: reh, 1: rew/3);
    mid_lr = res2(1: reh, rew/3+1:2/3*rew);
    right = res2(1:reh, 2/3*rew +1 : rew);
    p6 = (left - floor((2*mid_lr + 2* right)/3) + mid_lr);
    p4 = (right + p6);
    p5 = (p4 - mid_lr);
    res2(1:reh, 1:3:rew) = p4;
    res2(1:reh, 2:3:rew) = p5;
    res2(1:reh, 3:3:rew) = p6;
    reh = reh*3;rew = rew*3;
end

% Show Result Image
figure;
imshow(res2, [])