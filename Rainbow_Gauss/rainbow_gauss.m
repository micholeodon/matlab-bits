clear; close all; clc;
X = [];
figHandle = []; 
numIters = 1000;
%%
figure
for iIter = 1:numIters
    e = randn(1);
    X = [X e];
    scatter(e, 0)
    hold on
    delete(figHandle)
    figHandle = histogram(X);
    drawnow
    title(['iter = ', num2str(iIter), ' / ', num2str(numIters)])
%     pause(0.01)

end
hold off