function [y, sigma2, p] = knInfer(x, model, t)
% inference for kernel model
% Written by Mo Chen (sth4nth@gmail.com).
kn = model.kn;
a = model.a;
X = model.X;
tbar = model.tbar;
y = a'*knCenterize(kn,X,x)+tbar;
if nargin == 3
    sigma2 = 1/beta+dot(X,X,1);   % 3.59
    p = exp(((t-y).^2/sigma2+log(2*pi*sigma2))/(-2));
end

