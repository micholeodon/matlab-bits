% Mini-example from the paper titled: Partial Least Squares
% (PLS) Methods for Neuroimaging: A Tutorial and Review, Krishnan et al. 2011
% Here we do PLSR.
clear; close all; clc;

% PET results: 9 subjects (three groups: AD, PD, NC) x 12 brain voxels
X =  [ 2     5     6     1     9     1     7     6     2     1     7     3 ;...   AD1
       4     1     5     8     8     7     2     8     6     4     8     2 ;...   AD2
       5     8     7     3     7     1     7     4     5     1     4     3 ;...   AD3

       3     3     7     6     1     1    10     2     2     1     7     4 ;...   PD1
       2     3     8     7     1     6     9     1     8     8     1     6 ;...   PD2
       1     7     3     1     1     3     1     8     1     3     9     5 ;...   PD3
       
       9     0     7     1     8     7     4     2     3     6     2     7 ;...   NC1
       8     0     6     5     9     7     4     4     2    10     3     8 ;...   NC2
       7     7     4     5     7     6     7     6     5     4     8     8]; %   NC3
X

% behavioral data: [words recalled (WR), RT], 9 subjects x 2 measures
Y =   [15   600 ; ... AD1  
       19   520 ; ... AD2 
       18   545 ; ... AD3 
       
       22   426 ; ... PD1 
       21   404 ; ... PD2 
       23   411 ; ... PD3 
       
       29   326 ; ... NC1 
       30   309 ; ... NC2 
       30   303]; %   NC3

whos

%% centering & normalization (each condition separately)

X = zscore(X);
Y = zscore(Y);

%% iterative process of getting latent variables

%% First iteration (to get first latent variable out of rank(X) possible)
X0 = X;
Y0 = Y;

R1 = X0' * Y0;

[W1, D1, C1] = svd(R1, 'econ')

% weights
w1 = W1(:,1)

% latent variable of X
t1 = X0*w1;
t1 = t1/norm(t1)

% loadings of X0 on t1
p1 = X0'*t1

% least square estimate of X from the first latent variable
X1_hat = t1*p1'

% latent variable of Y
c1 = C1(:,1)
u1 = Y0*c1

% prediction of Y from the X-latent variable t1
Y1_hat = u1*(c1')

% slope of regression
b1 = t1'*u1

Y1_hat = t1*b1*(c1') 


% deflated matrices
X1 = X0-X1_hat
Y1 = Y0-Y1_hat

%% second iteration

R2 = X1' * Y1;

[W2, D2, C2] = svd(R2, 'econ')

% weights
w2 = W2(:,1)

% latent variable of X
t2 = X1*w2;
t2 = t2/norm(t2)

% loadings of X1 on t2
p2 = X1'*t2

% least square estimate of X from the second latent variable
X2_hat = t2*p2'

% latent variable of Y
c2 = C2(:,1)
u2 = Y1*c2

% prediction of Y from the X-latent variable t2
Y2_hat = u2*c2'

% slope of regression
b2 = t2'*u2

Y2_hat = t2*b2*(c2)' 


% deflated matrices
X2 = X1-X2_hat
Y2 = Y1-Y2_hat

%% third iteration

R3 = X2' * Y2;

[W3, D3, C3] = svd(R3, 'econ')

% weights
w3 = W3(:,1)

% latent variable of X
t3 = X2*w3;
t3 = t3/norm(t3)

% loadings of X2 on t3
p3 = X2'*t3

% least square estimate of X from the third latent variable
X3_hat = t3*p3'

% latent variable of Y
c3 = C3(:,1)
u3 = Y2*c3

% prediction of Y from the X-latent variable t3
Y3_hat = u3*c3'

% slope of regression
b3 = t3'*u3

Y3_hat = t3*b3*(c3)' 


% deflated matrices
X3 = X2-X3_hat
Y3 = Y2-Y3_hat

%% fourth iteration

R4 = X3' * Y3;

[W4, D4, C4] = svd(R4, 'econ')

% weights
w4 = W4(:,1)

% latent variable of X
t4 = X3*w4;
t4 = t4/norm(t4)

% loadings of X3 on t4
p4 = X3'*t4

% least square estimate of X from the fourth latent variable
X4_hat = t4*p4'

% latent variable of Y
c4 = C4(:,1)
u4 = Y3*c4

% prediction of Y from the X-latent variable t4
Y4_hat = u4*c4'

% slope of regression
b4 = t4'*u4

Y4_hat = t4*b4*(c4)' 


% deflated matrices
X4 = X3-X4_hat
Y4 = Y3-Y4_hat

%% fifth iteration

R5 = X4' * Y4;

[W5, D5, C5] = svd(R5, 'econ')

% weights
w5 = W5(:,1)

% latent variable of X
t5 = X4*w5;
t5 = t5/norm(t5)

% loadings of X4 on t5
p5 = X4'*t5

% least square estimate of X from the fifth latent variable
X5_hat = t5*p5'

% latent variable of Y
c5 = C5(:,1)
u5 = Y4*c5

% prediction of Y from the X-latent variable t5
Y5_hat = u5*c5'

% slope of regression
b5 = t5'*u5

Y5_hat = t5*b5*(c5)' 


% deflated matrices
X5 = X4-X5_hat
Y5 = Y4-Y5_hat

%% sixth iteration

R6 = X5' * Y5;

[W6, D6, C6] = svd(R6, 'econ')

% weights
w6 = W6(:,1)

% latent variable of X
t6 = X5*w6;
t6 = t6/norm(t6)

% loadings of X5 on t6
p6 = X5'*t6

% least square estimate of X from the sixth latent variable
X6_hat = t6*p6'

% latent variable of Y
c6 = C6(:,1)
u6 = Y5*c6

% prediction of Y from the X-latent variable t6
Y6_hat = u6*c6'

% slope of regression
b6 = t6'*u6

Y6_hat = t6*b6*(c6)' 


% deflated matrices
X6 = X5-X6_hat
Y6 = Y5-Y6_hat

%% seventh iteration

R7 = X6' * Y6;

[W7, D7, C7] = svd(R7, 'econ')

% weights
w7 = W7(:,1)

% latent variable of X
t7 = X6*w7;
t7 = t7/norm(t7)

% loadings of X6 on t7
p7 = X6'*t7

% least square estimate of X from the seventh latent variable
X7_hat = t7*p7'

% latent variable of Y
c7 = C7(:,1)
u7 = Y6*c7

% prediction of Y from the X-latent variable t7
Y7_hat = u7*c7'

% slope of regression
b7 = t7'*u7

Y7_hat = t7*b7*(c7)' 


% deflated matrices
X7 = X6-X7_hat
Y7 = Y6-Y7_hat

%% eighth iteration (last)

R8 = X7' * Y7;

[W8, D8, C8] = svd(R8, 'econ')

% weights
w8 = W8(:,1)

% latent variable of X
t8 = X7*w8;
t8 = t8/norm(t8)

% loadings of X7 on t8
p8 = X7'*t8

% least square estimate of X from the eight latent variable
X8_hat = t8*p8'

% latent variable of Y
c8 = C8(:,1)
u8 = Y7*c8

% prediction of Y from the X-latent variable t8
Y8_hat = u8*c8'

% slope of regression
b8 = t8'*u8

Y8_hat = t8*b8*(c8)' 


% deflated matrices
X8 = X7-X8_hat
Y8 = Y7-Y8_hat

%% ninth iteration (experiment)

R9 = X8' * Y8;

[W9, D9, C9] = svd(R9, 'econ')

% weights
w9 = W9(:,1)

% latent variable of X
t9 = X8*w9;
t9 = t9/norm(t9)

% loadings of X8 on t9
p9 = X8'*t9

% least square estimate of X from the ninth latent variable
X9_hat = t9*p9'

% latent variable of Y
c9 = C9(:,1)
u9 = Y8*c9

% prediction of Y from the X-latent variable t9
Y9_hat = u9*c9'

% slope of regression
b9 = t9'*u9

Y9_hat = t9*b9*(c9)' 


% deflated matrices
X9 = X8-X9_hat
Y9 = Y8-Y9_hat

%% SUMMARY
T = [t1, t2, t3, t4, t5, t6, t7, t8] % X latent variables
B = diag([b1, b2, b3, b4, b5, b6, b7, b8])
C = [c1, c2, c3, c4, c5, c6, c7, c8]
U = [u1, u2, u3, u4, u5, u6, u7, u8] % Y latent variables
W = [w1, w2, w3, w4, w5, w6, w7, w8]
P = [p1, p2, p3, p4, p5, p6, p7, p8]
P_tr_pinv = pinv(P')

B_PLS = P_tr_pinv*B*(C') % fixed-effect model

X_ = T*P' % should be equal to X

Y_hat = T*B*(C') 
tmp = X*B_PLS % should be equal to Y_hat


% How good is the prediction?
RESS = norm(Y-Y_hat, 'fro')

%% PLOTS

colors = [  0.8 0.0 0.8;
            0.8 0.0 0.8;
            0.8 0.0 0.8;
            0.8 0.8 0.0;
            0.8 0.8 0.0;
            0.8 0.8 0.0;
            0.0 0.8 0.0
            0.0 0.8 0.0
            0.0 0.8 0.0 ];
close all

% latent variables of X (i.e. T)
figure
idx = [1 2]; % choose two indices from 1 to 8
scatter(T(:,idx(1)), T(:,idx(2)), [], colors, 'filled')
hline(0, 'k-') ; vline(0, 'k-') ;
xlabel(['X Latent Variable ', num2str(idx(1))])
ylabel(['X Latent Variable ', num2str(idx(2))])
hold on
scatter(C(1,idx(1)), C(1,idx(1)), 80, 'b^', 'filled') % words recalled
scatter(C(2,idx(1)), C(2,idx(1)), 80, 'bs', 'filled') % reaction time
hold off


% latent variables of X (i.e. T)
figure
idx = [1 2]; % choose two indices from 1 to 8
scatter(U(:,idx(1)), U(:,idx(2)), [], colors, 'filled')
hline(0, 'k-') ; vline(0, 'k-') ;
xlabel(['Y Latent Variable ', num2str(idx(1))])
ylabel(['Y Latent Variable ', num2str(idx(2))])
hold on
scatter(C(1,idx(1)), C(1,idx(1)), 80, 'b^', 'filled') % words recalled
scatter(C(2,idx(1)), C(2,idx(1)), 80, 'bs', 'filled') % reaction time
hold off

% weights that relate each measure in Y to latent variables
% figure

