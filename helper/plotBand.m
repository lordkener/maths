function plotBand(x, y, h, color)
% plot a band with bandwidth h around y
% Written by Mo Chen (sth4nth@gmail.com).
if nargin < 4
    color = [255,228,225]/255; %pink
end
x = x(:);
y = y(:);
h = h(:); 
fill([x;flipud(x)],[y+h;flipud(y-h)],color);