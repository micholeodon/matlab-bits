% Mini-example from the paper titled: Partial Least Squares
% (PLS) Methods for Neuroimaging: A Tutorial and Review, Krishnan et al. 2011

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
       7     7     4     5     7     6     7     6     5     4     8     8];  %   NC3
X

% behavioral data: [words recalled (WR), reaction time (RT)], 9 subjects x 2 measures
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

X1 = X(1:3,:); % subjects 1-3
X2 = X(4:6,:); % subjects 4-6
X3 = X(7:9,:); % subjects 7-9

Y1 = Y(1:3,:); % subjects 1-3
Y2 = Y(4:6,:); % subjects 4-6
Y3 = Y(7:9,:); % subjects 7-9

% centering
X1 = ( X1 - mean(X1) );
X2 = ( X2 - mean(X2) );
X3 = ( X3 - mean(X3) );

Y1 = ( Y1 - mean(Y1) );
Y2 = ( Y2 - mean(Y2) );
Y3 = ( Y3 - mean(Y3) );

% normalization
for iCol = 1:size(X1,2)
    X1_column_norms(1,iCol) = norm(X1(:,iCol));
    X2_column_norms(1,iCol) = norm(X2(:,iCol));
    X3_column_norms(1,iCol) = norm(X3(:,iCol));
end
for iCol = 1:size(Y1,2)
    Y1_column_norms(1,iCol) = norm(Y1(:,iCol));
    Y2_column_norms(1,iCol) = norm(Y2(:,iCol));
    Y3_column_norms(1,iCol) = norm(Y3(:,iCol));
end

X1 = X1./X1_column_norms;
X2 = X2./X2_column_norms;
X3 = X3./X3_column_norms;

Y1 = Y1./Y1_column_norms;
Y2 = Y2./Y2_column_norms;
Y3 = Y3./Y3_column_norms;


% join again
X = [X1; X2; X3];
Y = [Y1; Y2; Y3];

whos

% check (sum of squares of a column in one condition should be equal to 1)
disp('check')
X
Y 
disp('check X')
for iCol = 1:size(X,2)
    sum(X(1:3,iCol).^2)
    sum(X(4:6,iCol).^2)
    sum(X(7:9,iCol).^2)
end
disp('check Y')
for iCol = 1:size(Y,2)
    sum(Y(1:3,iCol).^2)
    sum(Y(4:6,iCol).^2)
    sum(Y(7:9,iCol).^2)
end

sum(X.^2)
sum(Y.^2)

% fix nans
X(isnan(X)) = 0;
Y(isnan(Y)) = 0;

% split fixed matrices
X1 = X(1:3,:);
X2 = X(4:6,:);
X3 = X(7:9,:);
Y1 = Y(1:3,:);
Y2 = Y(4:6,:);
Y3 = Y(7:9,:);


%% cross-product matrix

R = [Y1'*X1; Y2'*X2; Y3'*X3]

[U,D,V] = svd(R, 'econ'); % 'econ' to drop entries related to zero-singular vlaues
U = -U; V = -V; % need flip signs to match the paper

% U - behavioral measures saliences
% V - brain-activity saliences
% D - covariance values for n-th latent variable of X and n-th latent variable% change directions to match the paper

U,D,V

%% plot saliences
% U - behavioral saliences
% V - brain activity salienecs

colors = [0.4 0.0 0.8; % AD
          0.8 0.6 0.0; % PD
          0.2 0.7 0.0];% NC

% first behavioral salience
sal1_WR = [U(1,1), U(3,1), U(5,1)]; % element for AD, PD and NC respectively
sal1_RT = [U(2,1), U(4,1), U(6,1)];

figure('Units','Normalized', 'OuterPosition', [0 0 1 1])
subplot(2,3,1)
bar([1 2],[sal1_WR; sal1_RT]);

xlabel('Behavioral measures')
xticklabels({'Words recalled','Reaction time'})
ylabel('First behavioral salience')
set(gca,'YTickLabel','')
legend({'AD','PD','NC'}, 'Location', 'southeast')

% second behavioral salience
sal2_WR = [U(1,2), U(3,2), U(5,2)]; % element for AD, PD and NC respectively
sal2_RT = [U(2,2), U(4,2), U(6,2)];

subplot(2,3,2)
bar([1 2],[sal2_WR; sal2_RT])
xlabel('Behavioral measures')
xticklabels({'Words recalled','Reaction time'})
ylabel('Second behavioral salience')
set(gca,'YTickLabel','')
legend({'AD','PD','NC'}, 'Location', 'southeast')

% third behavioral salience
sal3_WR = [U(1,3), U(3,3), U(5,3)]; % element for AD, PD and NC respectively
sal3_RT = [U(2,3), U(4,3), U(6,3)];

subplot(2,3,3)
bar([1 2],[sal3_WR; sal3_RT])
xlabel('Behavioral measures')
xticklabels({'Words recalled','Reaction time'})
ylabel('Third behavioral salience')
set(gca,'YTickLabel','')
legend({'AD','PD','NC'}, 'Location', 'southeast')


% fourth behavioral salience
sal4_WR = [U(1,4), U(3,4), U(5,4)]; % element for AD, PD and NC respectively
sal4_RT = [U(2,4), U(4,4), U(6,4)];

subplot(2,3,4)
bar([1 2],[sal4_WR; sal4_RT])
xlabel('Behavioral measures')
xticklabels({'Words recalled','Reaction time'})
ylabel('Fourth behavioral salience')
set(gca,'YTickLabel','')
legend({'AD','PD','NC'}, 'Location', 'southeast')

% fifth behavioral salience
sal5_WR = [U(1,5), U(3,5), U(5,5)]; % element for AD, PD and NC respectively
sal5_RT = [U(2,5), U(4,5), U(6,5)];

subplot(2,3,5)
bar([1 2],[sal5_WR; sal5_RT])
xlabel('Behavioral measures')
xticklabels({'Words recalled','Reaction time'})
ylabel('Fifth behavioral salience')
set(gca,'YTickLabel','')
legend({'AD','PD','NC'}, 'Location', 'southeast')

% sixth behavioral salience
sal6_WR = [U(1,6), U(3,6), U(5,6)]; % element for AD, PD and NC respectively
sal6_RT = [U(2,6), U(4,6), U(6,6)];

subplot(2,3,6)
bar([1 2],[sal6_WR; sal6_RT])
xlabel('Behavioral measures')
xticklabels({'Words recalled','Reaction time'})
ylabel('Sixth behavioral salience')
set(gca,'YTickLabel','')
legend({'AD','PD','NC'}, 'Location', 'southeast')

%% latent variables

U1 = U(1:2,:);
U2 = U(3:4,:);
U3 = U(5:6,:);

LX = X*V
LY = [Y1*U1; Y2*U2; Y3*U3]

%% plot latent variables
subjects_names = {'AD', 'AD', 'AD', 'PD', 'PD', 'PD', 'NC', 'NC', 'NC'};
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
xlim([-2.5, 2])
ylim([-2 2])
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
xlim([-1, 1])
ylim([-1 1])
hline(0); vline(0);