% wave speed
% v = f*\lambda
% examining wave speed as a function of lambda and f

% cd D:\science\swap\matlab_tests

% y(t,x) = ym*sin(kx-wt)


clear; close all; clc;

% time dimension
t0 = 0;
tf = 10;
t = t0:0.05:tf;

% spatial dimension
x0 = 0;
xf = 10;
x = x0:0.05:xf;

ym = 1;

% wave 1
f = 1; % frequency
w = 2*pi*f; % angular frequency
L = 10;  % wavelength
k = 2*pi/L; % wave number

% wave 2
f2 = 2; % frequency
w2 = 2*pi*f2; % angular frequency
L2 = 1;  % wavelength
k2 = 2*pi/L2; % wave number


% equation for prop. waves
for i = 1:length(t)
    for j = 1:length(x)
        y(i,j) = ym*sin(k*x(j)-w*t(i));
        y2(i,j) = ym*sin(k2*x(j)-w2*t(i));
    end
end


% oscillation speed visualization
if 1
    for i = 1:length(t)
        subplot(2,1,1)
        plot(x,y(i,:))
        hold on
        jb = 1;
        scatter(x(jb),y(i,jb),30,'b','filled') % propagating maximum
        hold off
        xlabel('x')
        ylabel('amplitude')
        subplot(2,1,2)
        plot(x,y2(i,:))
        hold on
        jr = 1;
        scatter(x(jr),y2(i,jr),30,'r','filled') % propagating maximum
        hold off
        xlabel('x')
        ylabel('amplitude')
        drawnow
        %pause(0.5)
    end
end

