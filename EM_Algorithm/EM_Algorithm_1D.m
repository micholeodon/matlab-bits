% EM algorithm - 1-D Case
% Based on: https://www.youtube.com/watch?v=iQoXFmbXRJA
clear; close all; clc;

addpath ./aux

% 0. Prepare 1-D data and gaussian function handle
% Suppose X = [X1 X2 ... XN] - vector of random variables \in \mathbb{R}^p. 
% Sample of variable Xi is denoted as xi,  xi \in \mathbb{R}^p.
% Density function for each Xi: f(xi). 
% Here: N=1, so X = X1; p = 1;
%x1 = [1:0.1:2.5 5:0.05:7]
N = 80;
N = 160;
if(mod(N,2)==1)
    N=N-1
else
    N
end;

x1 = [(randn(1,N/2) + 4) , (1.4*randn(1,N/2) - 1)];
G = @(mu,s,x) exp(-((x-mu).^2)/(2*s*s))/sqrt(2*pi*s*s);

plotGSum = 0; % 1 if you want to plot Gaussian Mixture; 0 - for plotting separate components

% 1. Init parameters theta = [muA, muB, sA, sB, prA, prB] 
% mu - mean; s - std dev.; p - priors

muA = randn(1,1);
muB = randn(1,1);
sA = randn(1,1);
sB = randn(1,1);
prA = 0.5;
prB = 0.5;


% Iterative process;
% 2. Estimate posteriors ("how likely x came from A given X = x? Pr(x \in A | X=x)."
% Pr(xi \in A | Xi=xi) = \frac{Pr(Xi=xi | xi \in A) Pr(xi \in A) }{Pr(Xi=xi)},
% where for GM model Pr(Xi=xi | xi \in A) = gauss(xi; muA, sA);
% We can calculate only numerators. Why? 
% Because denominator is simply sum of calculated numerators, thanks to axiom of probability Pr(A \cap B) = Pr(A|B)Pr(B):
% Pr(Xi=xi) = Pr(Xi=xi \cap xi \in A) + Pr(Xi=xi \cap xi \in B) = 
%           = Pr(Xi=xi | xi \in A)Pr(xi \in A) + Pr(Xi=xi | xi \in B)Pr(xi \in B) = sum of numerators ;)

K = 1000
for k = 1:K
    poA_num = G(muA,sA,x1)*prA;
    poB_num = G(muB,sB,x1)*prB;
    poA = poA_num./(poA_num + poB_num);
    poB = poB_num./(poA_num + poB_num);
    
    % 3. Recalculate parameters theta
    muA = sum(x1.*poA)/sum(poA);
    muB = sum(x1.*poB)/sum(poB);
    sA = sqrt(sum(poA.*((x1-muA).^2))/sum(poA));
    sB = sqrt(sum(poB.*((x1-muB).^2))/sum(poB));
    prA = sum(poA)/length(poA);
    prB = sum(poB)/length(poB);
    
    
    
    % 4*. Plot points and gaussians
    dim = [0.2 0.5 0.3 0.3];
    str = {['muA = ' num2str(muA)],['muB = ' num2str(muB)], ['sA = ' num2str(sA)], ['sB = ' num2str(sB)], ['prA = ' num2str(prA)], ['prB = ' num2str(prB)]};
    hh = annotation('textbox',dim,'String',str,'FitBoxToText','on');
    scatter(x1,0.02*ones(1,length(x1)),'k')
    ylim([0,1])
    hold on
    h = xlim;
    h = linspace(h(1),h(end),1000);
    hA = plot(h,prA*G(muA,sA,h))
    hA.Color = [0 0.8 0];
    hB = plot(h,prB*G(muB,sB,h))
    hB.Color = [0.8 0 0.8];
    if(plotGSum)
        hS = plot(h, prA*G(muA,sA,h) + prB*G(muB,sB,h))
        hS.Color = [0.8 0 0];
    end
    hold off
    pause(0.01)
    delete(hh)
    
    % 5. Check stop criterion ( dL = 10e-10 for ten successive iteration; L - log-likelihood) OR (number of iterations > K) )
    if(k >= K) 
        break;
    end;
end
