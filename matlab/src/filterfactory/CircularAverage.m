function ch = CircularAverage(radius)
%CircularAverage  creates a circual average filter
%
% inputs
%   radius  the length of the radius in pixels.
%
% outputs
%   ch  the circle average filter
%

x = radius * 2;
if mod(x, 2) == 0
  x = x + 1;
end
[rr, cc] = meshgrid(1:x);
centre = ceil(x / 2);
ch = sqrt((rr - centre) .^ 2 + (cc - centre) .^ 2) <= radius;

ch = ch ./ sum(ch(:));

end
