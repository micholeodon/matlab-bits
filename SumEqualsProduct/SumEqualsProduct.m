clear; clc; close all;

%%
% What x,y solves the system below for complex c?
%
% $$x + y = c$$
%
% $$xy = c$$
%
% Solutions:
%
% $$x = \frac{ c \pm \sqrt{c(c-4)} }{2}$$
%
% $$y = \frac{ c \mp \sqrt{c(c-4)} }{2}$$
%% calc

c = -7:0.1:7;
x = (c + sqrt(c.*(c-4)))./(2)
y = (c - sqrt(c.*(c-4)))./(2)



%% plot
figure

subplot(1,4,1)
plot(c, real(x),'b.', c, imag(x), 'r.')
grid on
title 'x(c)'
xlabel c
ylabel x
legend({'real(x)','imag(x)'}, 'Location', 'northwest')

subplot(1,4,2)
plot(c, real(y),'b.', c, imag(y), 'r.')
grid on
title 'y(c)'
xlabel c
ylabel y
legend({'real(y)','imag(y)'}, 'Location', 'northwest')

subplot(1,4,3)
plot(real(x),real(y),'b.',imag(x),imag(y),'r.')
grid on
title 'x vs y'
xlabel x
ylabel y
axis equal  
legend({'real part','imaginary part'}, 'Location', 'northwest')

%% check

xpy = x+y;
xty = x.*y;
[xpy', xty']

subplot(1,4,4)
plot(xpy,xty, '.')
title('x+y vs x*y')
grid on
xlabel 'x+y'
ylabel 'x*y'
axis equal  

%% plot 3d x-y-c

figure
plot3(x,y,c, 'b.')
grid on
xlabel 'real(x)'
ylabel 'real{y)'
zlabel c

%% delete

figure
plot(imag(x),imag(y),'.')
grid on
title 'x vs y'
xlabel imag(x)
ylabel imag(y)
axis equal  