clear; close all; clc;

addpath aux

%% Test 1 - one point vs set
% Finds one closest point to test point p 

% EDIT
N = 10; % number of points
D = 3; % number of dimensions
p = zeros(1,D); % test point


setB = randn(N,D);

[cp, cp_idx] = findClosestPoint(p, setB)

if(D==2)
    
    figure
    scatter(setB(:,1), setB(:,2), 200, '.b') % cloud of points
    hold on
    scatter(p(:,1), p(:,2), '*r') % test point
    scatter(cp(:,1), cp(:,2), 250, 'g') % selected closest point
    hold off
    grid on
    
end

if(D==3)
    
    figure
    scatter3(setB(:,1), setB(:,2), setB(:,3), 200, '.b') % cloud of points
    hold on
    scatter3(p(:,1), p(:,2), p(:,3), '*r') % test point
    scatter3(cp(:,1), cp(:,2), cp(:,3), 250, 'g') % selected closest point
    hold off
    grid on
    axis vis3d
end

title 'Problem: find closest point'
legend({'data', 'test point', 'solution'})
%% Test 2 - set vs set (repeats allowed)
% Creates two sets of random points (red and blue sets).
% Tries to match each point from set A to its closest neighbour from set B.
% Repeats are allowed.

% EDIT
N = 10; % number of points
D = 3; % number of dimensions



setA = randn(N,D);
setB = randn(N,D);

clear cp cp_idx
for i = 1:N
    [cp(i,:), cp_idx(i)] = findClosestPoint(setA(i,:), setB)
end
if(D==2)
    
    figure
    scatter(setB(:,1), setB(:,2), 200, '.b') % cloud of points
    hold on
    scatter(setA(:,1), setA(:,2), 200, '.r') % test point
    scatter(cp(:,1), cp(:,2), 250, 'g') % selected closest point
    hold off
    grid on
    
    hold on
    for i = 1:N
        plot([setA(i,1) cp(i,1)], [setA(i,2) cp(i,2)], 'm')
    end
    hold off
    
end

if(D==3)
    
    figure
    scatter3(setB(:,1), setB(:,2), setB(:,3), 200, '.b') % cloud of points
    hold on
    scatter3(setA(:,1), setA(:,2), setA(:,3), 200, '.r') % test point
    scatter3(cp(:,1), cp(:,2), cp(:,3), 250, 'g') % selected closest point
    hold off
    grid on
    axis vis3d
    
    hold on
    for i = 1:N
        plot3([setA(i,1) cp(i,1)], [setA(i,2) cp(i,2)], [setA(i,3) cp(i,3)], 'm')
    end
    hold off
end

legend({'data A', 'data B', 'match'})
title({'Problem:', 'Find closest point match between set A and set B.' 'Repeats allowed.'})

%% Test 3 - set vs set (repeats NOT allowed, bad solution, depends on order of points)
% Creates two sets of random points (red and blue sets).
% Tries to match each point from set A to its closest neighbour from set B.
% Repeats are NOT allowed.
%
% WARNING:
% Note that solution is dependent on the data order and this is usually not
% desirable !

% EDIT
N = 10; % number of points
D = 3; % number of dimensions

setA = randn(N,D);
setB = randn(N,D);

clear cp cp_idx
setB_copy = setB;
for i = 1:N
    [cp(i,:), cp_idx(i)] = findClosestPoint(setA(i,:), setB_copy)
    setB_copy(cp_idx(i), :) = [];
end
if(D==2)
    
    figure
    scatter(setB(:,1), setB(:,2), 200, '.b') % cloud of points
    hold on
    scatter(setA(:,1), setA(:,2), 200, '.r') % test point
    scatter(cp(:,1), cp(:,2), 250, 'g') % selected closest point
    hold off
    grid on
    
    hold on
    for i = 1:N
        plot([setA(i,1) cp(i,1)], [setA(i,2) cp(i,2)], 'm')
    end
    hold off
    
end

if(D==3)
    
    figure
    scatter3(setB(:,1), setB(:,2), setB(:,3), 200, '.b') % cloud of points
    hold on
    scatter3(setA(:,1), setA(:,2), setA(:,3), 200, '.r') % test point
    scatter3(cp(:,1), cp(:,2), cp(:,3), 250, 'g') % selected closest point
    hold off
    grid on
    axis vis3d
    
    hold on
    for i = 1:N
        plot3([setA(i,1) cp(i,1)], [setA(i,2) cp(i,2)], [setA(i,3) cp(i,3)], 'm')
    end
    hold off
end

legend({'data A', 'data B', 'match'})
title({'Problem:', 'Find closest point match between set A and set B.' 'Repeats NOT allowed.'})
