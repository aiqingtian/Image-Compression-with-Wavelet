% Image Compression Integer Haar Wavelet
clc;
clear;
close all;

I = imread('lena512.bmp');
I = double(I);
[imh, imw] = size(I);
% n = sqrt(imh);
n = 2;

% Decomposition
res2 = I;
for i = 1:n
    average_w = floor((res2(1:imh, 1:2:imw) + res2(1:imh, 2:2:imw))/2);
    res2(1:imh, 1:imw)=[average_w    res2(1:imh, 1:2:imw)- res2(1:imh, 2:2:imw)];
    average_h = floor((res2(1:2:imh, 1:imw) + res2(2:2:imh, 1:imw))/2);
    res2(1:imh,1:imw)=[average_h; res2(1:2:imh,1:imw)- res2(2:2:imh, 1:imw)];
    imw = imw/2;
    imh = imh/2;
end
figure;
imshow(res2, []);

% Reconstruction
[reh, rew] = size(res2);
reh = reh/(2^(n-1));
rew = rew/(2^(n-1));
for i= 1:n
    up = res2(1: reh/2, 1: rew);
    down = res2(reh/2 +1: reh, 1:rew);
    p2 = (up - floor(down/2));
    p1 = (down + p2);
    res2(1:2:reh, 1:rew) = p1;
    res2(2:2:reh, 1:rew) = p2;
    left = res2(1: reh, 1: rew/2);
    right = res2(1: reh, rew/2+1:rew);
    p4 = (left - floor(right/2));
    p3 = (right + p4);
    res2(1:reh, 1:2:rew) = p3;
    res2(1:reh, 2:2:rew) = p4;
    reh = reh*2;rew = rew*2;
end

% Show Result Image
figure;
imshow(res2, [])
