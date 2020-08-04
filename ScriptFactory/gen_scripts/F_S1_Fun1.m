function [t, y] = F_S1_Fun1(x)
% NOTE: This script is intended to be modified. Final version (one of many) 
% should be released (tangled) to separate file!

% Some very often used function or too complicated part that should be
% encapsulated to help readibilty of the main script.

fs = 1000;
dt = 1/fs;
T = 1;
t = 0:dt:(T-dt);
y = x.a*sin(2*pi*t*x.f + x.p);