clear; close all; clc;

a = 0:(pi/12):(2*pi)
%f = @(x) (exp(i*x) + exp(-i*x))/2
X = cos(a)
Y = sin(a)

V = [X', Y']
n = size(V,1);

% diverse amplitudes
rng(1)
A = abs(100*randn(1,n))';
V = [A.*V(:,1) A.*V(:,2)];

figure
n = size(V,1);
for k = 1:n
    v = V(k,:);
%     scatter(v(1),v(2))
    plotv([v(1);v(2)])
    hold on
    xlim(150*[-1.5 1.5])
    ylim(150*[-1.5 1.5])
    %pause(0.25)
    axis square
end
hold off
xlabel('x')
ylabel('y')
grid on
title('Vectors')

figure
metricType = 'euclidean';
C = squareform(pdist(V, metricType));
imagesc(C)
set(gca, 'YDir', 'normal')
xlabel('p_i')
ylabel('p_j')
axis square
colorbar
title([metricType , ' distance between each pair of vectors'])
% colormap winter
colormap autumn


figure
metricType = 'cosine';
C = squareform(pdist(V, metricType));
imagesc(C)
set(gca, 'YDir', 'normal')
xlabel('p_i')
ylabel('p_j')
axis square
colorbar
title([metricType , ' distance between each pair of vectors'])
% colormap winter
colormap autumn