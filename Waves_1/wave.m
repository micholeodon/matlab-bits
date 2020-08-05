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

f = 1; % frequency
w = 2*pi*f; % angular frequency

L = 2;  % wavelength
k = 2*pi/L; % wave number

% equation for prop. wave
for i = 1:length(t)
    for j = 1:length(x)
        y(i,j) = ym*sin(k*x(j)-w*t(i));
    end
end

% eq. for standing wave
for i = 1:length(t)
    for j = 1:length(x)
        y_st(i,j) = 2*ym*sin(k*x(j))*cos(w*t(i));
    end
end

% propagating wave
if 0 % change to 1 to see animation of a wave propagation
    for i = 1:length(t)
        plot(x,y(i,:))
         hold on
        jr = 101;
        scatter(x(jr),y(i,jr),30,'r','filled') % single position
        jb = find(y(i,:)==max(y(i,:)));
        scatter(x(jb),y(i,jb),30,'b','filled') % propagating maximum
        jg = find(y(i,:)==min(y(i,:)));
        scatter(x(jg),y(i,jg),30,'g','filled') % propagating minimum
        hold off
        xlabel('x')
        ylabel('amplitude')
        drawnow
        %pause(0.5)
    end
end

% standing wave
if 1 % change to 1 to see animation of a standing wave
    for i = 1:length(t)
        plot(x,y_st(i,:))
        hold on
        jr = 101;
        scatter(x(jr),y_st(i,jr),30,'r','filled') % single position
        jb = find(y_st(i,:)==max(y_st(i,:)));
        scatter(x(jb),y_st(i,jb),30,'b','filled') % propagating maximum
        jg = find(y_st(i,:)==min(y_st(i,:)));
        scatter(x(jg),y_st(i,jg),30,'g','filled') % propagating minimum
        hold off
        ylim([-3 3])
        xlabel('x')
        ylabel('amplitude')
        drawnow
        %pause(0.5)
    end
end