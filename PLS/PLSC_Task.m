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

% contrast data: 9 subjects x 2 contrast (values are such that contrast 1 
% predicts that the AD and PD participants will differ from NC; 
% contrast 2 will differentiate AD form PD)
Y =   [-0.24 -0.41 ; ... AD1  
       -0.24 -0.41 ; ... AD2 
       -0.24 -0.41 ; ... AD3 
       -0.24  0.41 ; ... PD1 
       -0.24  0.41 ; ... PD2 
       -0.24  0.41 ; ... PD3 
        0.47  0.00 ; ... NC1 
        0.47  0.00 ; ... NC2 
        0.47  0.00]; %   NC3

whos
%% centering & normalization (each condition separately)
% centering
X = X - mean(X);

% normalization
for iCol = 1:size(X,2)
    X_column_norms(1,iCol) = norm(X(:,iCol));
end

X = X./X_column_norms;

whos

% check
X
mean(X,1)
sum(X.^2)
Y
sum(Y.^2) % not ones -> too low precision given in paper

% fix nans
X(isnan(X)) = 0;
Y(isnan(Y)) = 0;

% % split fixed matrices
% X1 = X(1:3,:);
% X2 = X(4:6,:);
% X3 = X(7:9,:);
% Y1 = Y(1:3,:);
% Y2 = Y(4:6,:);
% Y3 = Y(7:9,:);


%% cross-product matrix

R = Y'*X

[U,D,V] = svd(R, 'econ'); % 'econ' to drop entries related to zero-singular vlaues


% U - behavioral measures saliences
% V - contrasts saliences
% D - covariance values for n-th latent variable of X and n-th latent variable
% of Y
U,D,V



%% latent variables

LX = X*V
LY = Y*U

%% plot latent variables

colors = [0.4 0.0 0.8;
          0.8 0.6 0.0;
          0.2 0.7 0.0];

colors = [0.4 0.0 0.8;
          0.8 0.6 0.0;
          0.2 0.7 0.0];

figure
hold on
% AD
scatter(LX(1:3,1),LX(1:3,2),80,colors(1,:),'filled')
% PD
scatter(LX(4:6,1),LX(4:6,2),80,colors(2,:),'filled')
% NC
scatter(LX(7:9,1),LX(7:9,2),80,colors(3,:),'filled')
hold off

title('Latent variables of X (L_X)')
xlabel '1'
ylabel '2'
set(gca,'XTickLabel','')
set(gca,'YTickLabel','')
legend({'AD', 'PD', 'NC'})
xlim([-2, 2])
ylim([-1 1])
hline(0); vline(0);


figure
hold on
% AD
scatter(LY(1:3,1),LY(1:3,2),80,colors(1,:),'filled')
% PD
scatter(LY(4:6,1),LY(4:6,2),80,colors(2,:),'filled')
% NC
scatter(LY(7:9,1),LY(7:9,2),80,colors(3,:),'filled')
hold off

title('Latent variables of Y (L_Y)')
xlabel '1'
ylabel '2'
set(gca,'XTickLabel','')
set(gca,'YTickLabel','')
legend({'AD', 'PD', 'NC'})
xlim([-1,1])
ylim([-1 1])
hline(0); vline(0);

% result is the same as in the paper up to a sign (vectors are flipped
% upside down, but their absolute values are the same)

