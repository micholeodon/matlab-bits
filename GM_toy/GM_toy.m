function GM_toy(N)
% Generate N-data points from some GM model and use EM to estimate model
% parameters.
close all; clc;

% 1. Declare ground truth model 
disp('Ground truth Gaussian Mixture model parameters: ')
mu =   [0 0; ...
    3 -3];
S(:,:,1) = [1 0 ; 0 1];
S(:,:,2) = [3 0.5; 0.5 1];
p = [0.5 0.5];
G = gmdistribution(mu, S, p)

% plot ground truth
%figure('pos', [900 900 900 600]);
figure
subplot(1,2,1)
plotModel(mu, S)
title 'Ground truth'

% 2. Generate data from ground truth model
X = G.random(N);
% plot data
subplot(1,2,2)
scatter(X(:,1),X(:,2))
xlim(lim)
ylim(lim)
axis square
grid on
title('EM estimation')

% 3. Estimate parameters (EM algorithm)
G_est = gmdistribution.fit(X, 2)
plotModel(G_est.mu, G_est.Sigma)  


%% AUXILIARY FUNCTIONS
    
    function plotModel(mu, S)
        sdrange = [0.5 1.0 1.96 3]; % range of isolines for plotting in sd units
        Acolor = [0 0.8 0];
        Bcolor = [0.8 0 0.8];
        axis square
        grid on
        %legend 'Component 1' 'Component 2'
        lim = [-9 9];
        xlim(lim)
        ylim(lim)
        hold on
        for sd = sdrange
            hA = plot_gaussian_ellipsoid(mu(1,:), S(:,:,1), sd);
            hA.Color = Acolor;
            hB = plot_gaussian_ellipsoid(mu(2,:), S(:,:,2), sd);
            hB.Color = Bcolor;
        end
        hold off
        
    end

end