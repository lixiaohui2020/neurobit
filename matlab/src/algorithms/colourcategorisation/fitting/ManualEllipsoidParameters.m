function ColourEllipsoids = ManualEllipsoidParameters(ColourSpace)
%ManualEllipsoidParameters Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1
  ColourSpace = 'lab';
end
ColourSpace = lower(ColourSpace);

if strcmpi(ColourSpace, 'lsy')
  
  ColourEllipsoids = ...
    [
    % green
    63.50,   1.00,  38.00,   4.40,   3.50,  40.00,   0.00,   0.00,   0.00,    0.00;
    
    % blue
    53.50,  44.00,  25.00,   7.00,  35.00,  55.00,   0.15,   0.05,   0.10,    0.00;
    
    % purple
    68.50,  35.00,  11.00,   7.00,  21.00,  38.00,   0.00,   3.00,   0.00,    0.00;
    
    % pink
    76.00,  13.00,  36.00,   6.00,   9.50,  40.00,   0.00,   3.03,   0.00,    0.00;
    
    % red
    82.00,   3.15,  15.00,   5.50,   5.00,  19.00,   0.00,   2.90,   0.00,    0.00;
    
    % orange
    76.00,   2.00,  40.00,   7.00,   3.25,  20.00,   0.00,   3.00,   0.00,    0.00;
    
    % yellow
    67.25,   1.70,  65.00,   2.50,   2.00,  36.00,   0.00,   3.11,   0.00,    0.00;
    
    % brown
    74.67,   1.85,   0.00,  11.00,   0.50,  19.00,   0.05,   0.00,   0.00,    0.00;
    
    % grey
    65.73,   6.46,  42.50,   2.25,   2.75,  35.00,   0.00,   0.00,   0.00,    0.00;
    
    % white
    65.73,   6.46,  95.00,   2.25,   2.75,  25.00,   0.00,   0.00,   0.00,    0.00;
    
    % black
    65.73,   6.46,   0.00,   2.25,   2.75,   5.00,   0.00,   0.00,   0.00,    0.00;
    ];
  
elseif strcmpi(ColourSpace, 'lab')
  
  ColourEllipsoids = ...
    [
    % green
    118.85,   61.76,  186.51,  150.00,   64.81,   53.11,    2.28,    0.00,    0.00,    0.00;
    
    % blue
    126.87,  124.90,   85.40,  150.00,   14.76,  150.00,    1.33,    0.79,    1.10,    0.00;
    
    % purple
    97.65,   186.87,   61.77,  150.00,   16.65,   65.50,    0.84,    0.14,    0.00,    0.00;
    
    % pink
    165.99,  204.90,   96.47,  150.00,   63.70,   29.71,    2.60,    0.04,    0.00,    0.00;
    
    % red
    103.42,  191.55,  186.23,   97.37,   21.04,   56.77,    0.00,    0.00,    0.16,    0.00;
    
    % orange
    183.09,  162.05,  183.08,   39.94,   23.57,   51.34,    2.64,    1.53,    2.20,    0.00;
    
    % yellow
    239.09,  123.57,  189.57,   66.92,   31.41,   45.96,    0.36,    0.37,    0.00,    0.00;
    
    % brown
    69.43,   144.00,  163.37,  124.42,   46.51,    7.16,    0.10,    0.40,    2.98,    0.00;
    
    % grey
    142.00,  128.00,  128.00,   95.00,    6.00,    6.00,    0.00,    0.00,    0.00,    0.00;
    
    % white
    260.00,  128.00,  128.00,   24.00,   24.00,   24.00,    2.40,    0.00,    0.00,    0.00;
    
    % black
    24.00,   128.00,  128.00,   24.00,   24.00,   24.00,    0.00,    0.00,    0.00,    0.00;
    ];
  
end

RGBTitles = {'G', 'B', 'Pp', 'Pk', 'R', 'O', 'Y', 'Br', 'Gr', 'W', 'Bl'}; %#ok
save([ColourSpace, '_ellipsoid_params_new.mat'], 'ColourEllipsoids', 'RGBTitles');

end
