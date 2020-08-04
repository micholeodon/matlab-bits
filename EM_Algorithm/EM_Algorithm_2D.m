%% EM algorithm - 2-D Case
% Based on: https://www.youtube.com/watch?v=TG6Bh-NFhA0&
clear; close all; clc;

addpath ./aux

% 0. Prepare 2-D data and gaussian function handle
% Suppose X = [X1 X2 ... XN] - vector of random variables \in \mathbb{R}^p. 
% Sample of variable Xi is denoted as xi,  xi \in \mathbb{R}^p.
% Density function for each Xi: f(xi). 
% Here: N=1, so X = X1; p = 2;

N = 160;
if(mod(N,2)==1)
    N=N-1
else
    N
end;

x1 = [(randn(2,N/2) + 2) , (1*randn(2,N/2) - 1)];
% p-dimensional Gaussian: G(x,\mu,\Sigma) = \frac{1}{\sqrt{(2\pi)^pdet(\Sigma)}} e^{-\frac{1}{2}(x-\mu)^T\Sigma^{-1}(x-\mu)}
G = @(mu,S,x) (1/(2*pi*sqrt(det(S))))*exp(-0.5*(x-mu)'*inv(S)*(x-mu)) 

% 1. Init parameters theta = [muA, muB, sA, sB, prA, prB] 
% mu - mean; s - std dev.; p - priors

 muA = randn(2,1);
 muB = randn(2,1);

%muA = [0;0]
%muB = [-1;-1]
SA = 10*eye(2,2)
SB = 10*eye(2,2)
prA = 0.5;
prB = 0.5;

poA_num = zeros(1,N);
poB_num = zeros(1,N);
poA = zeros(1,N);
poB = zeros(1,N);

% plot
sdrange = [0.5 1.0 1.96 3] % range of isolines for plotting in sd units
Acolor = [0 0.8 0];
Bcolor = [0.8 0 0.8];
scatter(x1(1,:),x1(2,:),'k')
axis square
xlim([-9 9])
ylim([-9 9])
hold on
for sd = sdrange
    hA = plot_gaussian_ellipsoid(muA, SA, sd);
    hA.Color = Acolor;
    hB = plot_gaussian_ellipsoid(muB, SB, sd);
    hB.Color = Bcolor;
end
hold off


% Iterative process;
% 2. Estimate posteriors ("how likely x came from A given X = x? Pr(x \in A | X=x)."
% Pr(xi \in A | Xi=xi) = \frac{Pr(Xi=xi | xi \in A) Pr(xi \in A) }{Pr(Xi=xi)},
% where for GM model Pr(Xi=xi | xi \in A) = gauss(xi; muA, sA);
% We can calculate only numerators. Why? 
% Because denominator is simply sum of calculated numerators, thanks to axiom of probability Pr(A \cap B) = Pr(A|B)Pr(B):
% Pr(Xi=xi) = Pr(Xi=xi \cap xi \in A) + Pr(Xi=xi \cap xi \in B) = 
%           = Pr(Xi=xi | xi \in A)Pr(xi \in A) + Pr(Xi=xi | xi \in B)Pr(xi \in B) = sum of numerators ;)

K = 100
for k = 1:K
    for n = 1:N
        poA_num(n) = G(muA,SA,x1(:,n))*prA;
        poB_num(n) = G(muB,SB,x1(:,n))*prB;
        poA(n) = poA_num(n)/(poA_num(n) + poB_num(n));
        poB(n) = poB_num(n)/(poA_num(n) + poB_num(n));
    end
    % 3. Recalculate parameters theta
     muA(1,1) = sum(x1(1,:).*poA)/sum(poA);
     muA(2,1) = sum(x1(2,:).*poA)/sum(poA);
     muB(1,1) = sum(x1(1,:).*poB)/sum(poB);
     muB(2,1) = sum(x1(2,:).*poB)/sum(poB);

     % CHECK !!!! WHY NOT SYMMETRIC ???!!!
     SA(1,1) = sum(poA.*(x1(1,:)-muA(1,1)).*(x1(1,:)-muA(1,1)))/sum(poA);
     SA(1,2) = sum(poA.*(x1(1,:)-muA(1,1)).*(x1(2,:)-muA(2,1)))/sum(poA);
     SA(2,1) = sum(poA.*(x1(2,:)-muA(2,1)).*(x1(1,:)-muA(1,1)))/sum(poA);
     SA(2,2) = sum(poA.*(x1(2,:)-muA(2,1)).*(x1(2,:)-muA(2,1)))/sum(poA);
     SB(1,1) = sum(poB.*(x1(1,:)-muB(1,1)).*(x1(1,:)-muB(1,1)))/sum(poB);
     SB(1,2) = sum(poB.*(x1(1,:)-muB(1,1)).*(x1(2,:)-muB(2,1)))/sum(poB);
     SB(2,1) = sum(poB.*(x1(2,:)-muB(2,1)).*(x1(1,:)-muB(1,1)))/sum(poB);
     SB(2,2) = sum(poB.*(x1(2,:)-muB(2,1)).*(x1(2,:)-muB(2,1)))/sum(poB);

     prA = sum(poA)/length(poA);
     prB = sum(poB)/length(poB);
   
    
    % 4*. Plot points and gaussians
    dim = [0.1 0.6 0.3 0.3];
    strMuA = ['muA = [' num2str(muA(1,1)) '   ' num2str(muA(2,1)) ' ]'];
    strMuB = ['muB = [' num2str(muB(1,1)) '   ' num2str(muB(2,1)) ' ]' ];
    strSA1 = ['SA = [' num2str(SA(1,1)) '   ' num2str(SA(1,2)) ' ]'];
    strSA2 = ['     [' num2str(SA(2,1)) '   ' num2str(SA(2,2)) ' ]'];
    strSB1 = ['SB = [' num2str(SB(1,1)) '   ' num2str(SB(1,2)) ' ]'];
    strSB2 = ['     [' num2str(SB(2,1)) '   ' num2str(SB(2,2)) ' ]'];
    strPrA = ['prA = ' num2str(prA)];
    strPrB = ['prB = ' num2str(prB)];
    str = {strMuA, strMuB , '', strSA1, strSA2, '', strSB1, strSB2, '', strPrA, strPrB};
    hh = annotation('textbox',dim,'String',str,'FitBoxToText','on');

    scatter(x1(1,:),x1(2,:),'k')
    axis square
    xlim([-9 9])
    ylim([-9 9])
    hold on
    for sd = sdrange
        hA = plot_gaussian_ellipsoid(muA, SA, sd);
        hA.Color = Acolor;
        hB = plot_gaussian_ellipsoid(muB, SB, sd);
        hB.Color = Bcolor;
    end
    hold off   
    
    pause(0.01)
    
    
    % 5. Check stop criterion ( dL = 10e-10 for ten successive iteration; L - log-likelihood) OR (number of iterations > K) )
    if(k >= K) 
        break;
    end;
    delete(hh)
end
