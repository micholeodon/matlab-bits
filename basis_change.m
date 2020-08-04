% Change of the basis
clear;
close all;
clc;

% simple animation expressed in different spaces
% space 1
% and its basis vectors expressed in screen coords.
b1=[1;0]; b2=[0;1];

% space 2
% and its basis vectors expressed in screen coords.
t1=[1;0]; t2=[-2/3;2/3];

% points to be shown (expressed in our basis)
P = [3 4 5; ...
    1 2 3]-[2;0];
% "frame" coordinates in our basis
Rx=[0 6 6 0 0];
Ry=[0 0 6 6 0];

% plot
figure
hold on
scatter(P(1,:),P(2,:),1000,'.','b')
plot(Rx,Ry, 'b')  % to plot our basis frame
axis equal
xlim([-8 8])
ylim([-4 10])

% Now imagine that he says exacly same coordinates of P but he means from his point of view.
% What points he means from our point of view?
% transform !
A = [t1 t2];
invA = inv(A);

% plot how things look in our perspective
P2 = A*P;
tmp = A*[Rx;Ry];
R2x = tmp(1,:);
R2y = tmp(2,:);
scatter(P2(1,:),P2(2,:),600,'.','r')
plot(R2x,R2y, 'r')  % to plot our basis frame
hold off
legend({'basis 1 frame', 'basis 1 points', 'basis 2 frame', 'basis 2 points'})


%% animation
rot = @(th) [cos(th) -sin(th); sin(th) cos(th)]

t = 0:0.1:4;
figure
for ti = t
    T = rot(2*pi/8*ti); % rotation matrix expressed in our coordinates
    %invT = T';
    Pi = T*P;
    
    % plot our frame
    scatter(Pi(1,:),Pi(2,:),1000,'.','b')
    hold on
    plot(Rx,Ry, 'b')  % to plot our basis frame
    
    % plot his frame
    P2i = A*T*P;  
    scatter(P2i(1,:),P2i(2,:),600,'.','r')
    plot(R2x,R2y, 'r')  % to plot our basis frame
    hold off
    axis equal
    xlim([-8 8])
    ylim([-4 10])
    drawnow
end