clear; close all; clc;

%% Artificial signal generation
srate = 1000;
t = 0:1/srate:1-1/srate;
N = length(t);
f = 4;
%x = sin(2*pi*f*t)+sin(2*pi*3*f*t);     % sine
%x = randn(1,N);                        % random
%x = 0.3*t + 0.2;                       % linear
a = exp(-5*t); x = a.*sin(2*pi*f*t);    % damped sine

%% Recurrence plot

% calculate euclidean norm between different time samples
dab = zeros(N,N);
for i = 1:N
    for j = 1:N
        a = x(:,i);
        b = x(:,j);
        dab(i,j) = norm(a-b);
    end
end

% Plotting
figure('Units', 'Normalized', 'OuterPosition', [0 0 1 1])

h1 = subplot(2,2,[1 2])
plot(t,x)
title('Signal')
xlabel 'time [s]'
grid on

h2 = subplot(2,2,3)
imagesc(dab)
set(gca,'Ydir','normal')
axis square
colormap(h2,jet)
colorbar
title('Recurrence plot') 
xlabel 'time [sample]'
ylabel 'time [sample]'

h3 = subplot(2,2,4)
th = 1e-1; % threshold
imagesc(dab<=th)
set(gca,'Ydir','normal')
axis square
colormap(h3,gray)
colorbar
title(['Thresholded at ', num2str(th)])
xlabel 'time [sample]'
ylabel 'time [sample]'