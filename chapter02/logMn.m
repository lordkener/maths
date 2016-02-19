function z = logMn (x, p)
% Compute log pdf of a multinomial distribution.
% Input:
%   x: d x n data matrix
%   p: 1 x k probability
% Output:
%   z: probability density in logrithm scale z=log p(x)
% Written by Mo Chen (sth4nth@gmail.com).    
if numel(x) ~= numel(p)
    n = numel(x);
    x = reshape(x,1,n);
    label = zeros(1,n);
    [u,~,label(:)] = unique(x);
    x = full(sum(sparse(label,1:n,1,n,numel(u),n),2));
end
z = gammaln(sum(x)+1)-sum(gammaln(x+1))+dot(x,log(p));
