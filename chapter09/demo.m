% TODO: 
%   1) beta for em regress
%   2) refine kmeansRnd and mixGaussRnd

%% demo: EM linear regression
% close all; clear;
% d = 5;
% n = 200;
% [x,t] = linRnd(d,n);
% [model,llh] = linRegEm(x,t);
% plot(llh);
%%
d = 512; % signal length
k = 20;  % number of spikes
n = 100; % number of measurements
%
% random +/- 1 signal
x = zeros(d,1);
q = randperm(d);
x(q(1:k)) = sign(randn(k,1)); 

% projection matrix
A = unitize(randn(d,n),1);
% noisy observations
sigma = 0.005;
e = sigma*randn(1,n);
y = x'*A + e;
[model,llh] = rvmRegEm(A,y);
plot(llh);


% [model,llh] = rvmRegEbFp(A,y);
% plot(llh);
m = zeros(d,1);
m(model.index) = model.w;

h = max(abs(x))+0.2;
x_range = [1,d];
y_range = [-h,+h];
figure;
subplot(2,1,1);plot(x); axis([x_range,y_range]); title('Original Signal');
subplot(2,1,2);plot(m); axis([x_range,y_range]); title('Recovery Signal');


%% demo: kmeans 
% close all; clear;
% d = 2;
% k = 3;
% n = 500;
% [X,label] = kmeansRnd(d,k,n);
% y = kmeans(X,k);
% plotClass(X,label);
% figure;
% plotClass(X,y);

%% demo: Em for Gauss Mixture 
% close all; clear;
% d = 2;
% k = 3;
% n = 1000;
% [X,label] = mixGaussRnd(d,k,n);
% plotClass(X,label);
% 
% m = floor(n/2);
% X1 = X(:,1:m);
% X2 = X(:,(m+1):end);
% % train
% [z1,model,llh] = mixGaussEm(X1,k);
% figure;
% plot(llh);
% figure;
% plotClass(X1,z1);
% % predict
% z2 = mixGaussPred(X2,model);
% figure;
% plotClass(X2,z2);
%% demo: Em for Gauss mixture initialized with kmeans;
% close all; clear;
% d = 2;
% k = 3;
% n = 500;
% [X,label] = mixGaussRnd(d,k,n);
% init = kmeans(X,k);
% [z,model,llh] = mixGaussEm(X,init);
% plotClass(X,label);
% figure;
% plotClass(X,init);
% figure;
% plotClass(X,z);
% figure;
% plot(llh);
