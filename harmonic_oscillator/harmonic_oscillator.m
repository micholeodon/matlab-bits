% Harmonic Oscillator

clear; close all; clc;

T = 10; % duration
t = 0:0.05:T;

f = 0.5; % frequency
p = 0; % phase shift
xm = 1; % amplitude of oscillation

subplot(3,1,1)
w = 2*pi*f;
x = xm*cos(w*t+p);
plot(t,x)
title('Position')
xlabel t

subplot(3,1,2)
v = -w*xm*sin(w*t+p);
plot(t,v)
title('Velocity')
xlabel t

subplot(3,1,3)
a = -w*w*x;
plot(t,a)
title('Acceleration')
xlabel t

%% animation

h = figure
for i = 1:length(t)
    h1 = subplot(3,1,1)
    scatter(t(i),x(i), 20, 'filled')
    xlim([-0.1 T+0.1])    
    ylim([min(x), max(x)])
    title('x(t)')
    
    h2 = subplot(3,1,2)
    bar(v(i))
    ylim([min(v), max(v)])
    axis square
    title('v(t)')
    
    h3 = subplot(3,1,3)
    bar(a(i))
    ylim([min(a), max(a)])
    axis square
    title('a(t)')
    
    drawnow
    
end