% erosion, dilation, opening, closing tests

%%
clear; close all; clc;

I = imread('lena512.bmp');
figure
imshow(I)
title('orig')

a = 7; % ADJUST KERNEL SIZE !
K = strel('rectangle',[a a])

I_d = imdilate(I,K);
figure
imshow(I_d)
title('dilated')

I_e = imerode(I,K);
figure
imshow(I_e)
title('eroded')

I_c = imclose(I,K); % close = 1.dilate 2.erode
figure
imshow(I_c)
title('closed')

I_o = imopen(I,K); % open = 1.erode 2.dilate
figure
imshow(I_o)
title('opened')