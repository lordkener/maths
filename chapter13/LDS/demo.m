% demo
d = 3;
k = 2;
n = 10000;

[X,model] = ldsRnd(d,k,n);
% [mu, V, llh] = kalmanFilter(X, model);
% [nu, U, Ezz, Ezy, llh] = kalmanSmoother(X, model);
[model, llh] = ldsEm(X, model);
plot(llh);

