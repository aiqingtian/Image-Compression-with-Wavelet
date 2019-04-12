% Image Compression with Binary Haar Wavelet
clc;
clear;
close all;

I = imread('lena512.bmp');
% I = imresize(I, [512, 512]);
I = double(I);
[imh, imw] = size(I);
% n = sqrt(imh);
n = 2;

% Decomposition
res = I;
for i = 1:n
    average_w = (res(1:imh, 1:2:imw) + res(1:imh, 2:2:imw))/2;
    res(1:imh, 1:imw)=[average_w    res(1:imh, 1:2:imw)- average_w];
    average_h = (res(1:2:imh,1:imw)+res(2:2:imh,1:imw))/2;
    res(1:imh,1:imw)=[average_h; res(1:2:imh,1:imw)- average_h];
    imw = imw/2;
    imh = imh/2;
end
figure;
imshow(res, []);

% Reconstruction
[reh, rew] = size(res);
reh = reh/(2^(n-1));
rew = rew/(2^(n-1));
for i= 1:n
    up = res(1: reh/2, 1: rew);
    down = res(reh/2 +1: reh, 1:rew);
    p1 = (up + down);
    p2 = (up - down);
    res(1:2:reh, 1:rew) = p1;
    res(2:2:reh, 1:rew) = p2;
    left = res(1: reh, 1: rew/2);
    right = res(1: reh, rew/2+1:rew);
    p3 = (left + right);
    p4 = (left - right);
    res(1:reh, 1:2:rew) = p3;
    res(1:reh, 2:2:rew) = p4;
    reh = reh*2;rew = rew*2;
end

% Show Result Image
figure;
imshow(res, [])



