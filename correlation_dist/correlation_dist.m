% Test if my equation for correlation distance is correct
clear; close all; clc;

N = 10;
X = rand(N,3);
% definition
D = pdist(X,'correlation')


% my test
M = zeros(N,N);
for i = 1:N
    xi = X(i,:);
    xi_m = mean(xi);
    for j = 1:N
        xj = X(j,:);
        xj_m = mean(xj);
        M(i,j) = 1 - (xi-xi_m)*(xj-xj_m)'/(norm(xi-xi_m)*norm(xj-xj_m));
    end
end
Dsq = squareform(D)
M

% PASSED SUCCESSFULLY !

figure
subplot(3,1,1)
imagesc(Dsq)
title('matlab pdist')
colorbar
subplot(3,1,2)
imagesc(M)
title('my implementation')
colorbar
subplot(3,1,3)
imagesc(Dsq-M)
title('difference')
colorbar