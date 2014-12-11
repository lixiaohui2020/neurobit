function [CartFocals, PolarFocals] = FocalColours()
%FocalColours Summary of this function goes here
%   Detailed explanation goes here

% TODO: add other luminances here

%% black
namblack = ...
  [
  36  -0.01   0.02;  %  Black  B&K
  36  -2.12  -3.93;  %  Black  B&O
  36  -4.60  -1.63;  %  Black  B&V
  36  -2.00   0.00;  %  Black  B&V
  36   0.00   0.00;  %  Black  B&V
  36  -0.02   0.02;  %  Black  S&W
  ];

%% blue
namblue = ...
  [
  58  -3.410  -48.08;  %  Blue  B&K
  58  -9.610  -18.44;  %  Blue  B&O
  58  -16.44  -30.00;  %  Blue  B&V
  36  -5.000  -30.00;  %  Blue  B&V
  81  -20.00  -20.00;  %  Blue  B&V
  58  -12.92  -27.22;  %  Blue  S&W
  ];

%% brown
nambrown = ...
  [
  36  18.18  30.27;  %  Brown  B&K
  36  14.81  21.60;  %  Brown  B&O
  36  20.00  40.00;  %  Brown  B&V
  36  23.33  50.00;  %  Brown  B&V
  36  25.00  45.00;  %  Brown  B&V
  36  13.07  33.61;  %  Brown  S&W
  ];

%% green
namgreen = ...
  [
  58  -52.69  9.700;  %  Green  B&K
  58  -22.60  24.65;  %  Green  B&O
  58  -21.41  14.72;  %  Green  B&V
  36  -38.09  22.89;  %  Green  B&V
  81  -20.00  20.00;  %  Green  B&V
  58  -38.09  22.89;  %  Green  S&W
  ];

%% grey
namgrey = ...
  [
  58  -0.03  0.04;  %  Grey  B&K
  58  -1.23  1.94;  %  Grey  B&O
  58  -3.95  1.42;  %  Grey  B&V
  58   2.00  2.00;  %  Grey  B&V
  58   0.00  0.00;  %  Grey  B&V
  58  -0.04  0.04;  %  Grey  S&W
  ];

%% orange
namorange = ...
  [
  58  44.69  79.79;  %  Orange  B&K
  58  33.30  43.67;  %  Orange  B&O
  58  25.00  35.00;  %  Orange  B&V
  81  33.30  45.00;  %  Orange  B&V
  81  35.00  50.00;  %  Orange  B&V
  58  31.50  57.28;  %  Orange  S&W
  ];

%% pink
nampink = ...
  [
  36  43  -7;  %  Pink  B&V
  36  45  -8;  %  Pink  B&V
  58  30  -3;  %  Pink  B&V
  58  42  -5;  %  Pink  B&V
  81  37   7;  %  Pink  B&V
  81  50  10;  %  Pink  B&V
  ];

%% purple
nampurple = ...
  [
  36  23  -40;  %  Purple  B&V
  36  20  -33;  %  Purple  B&V
  58  20  -30;  %  Purple  B&V
  58  30  -40;  %  Purple  B&V
  81  20  -25;  %  Purple  B&V
  81  25  -27;  %  Purple  B&V
  ];

%% red
namred = ...
  [
  36  59.51  30.17;  %  Red  B&K
  36  40.58  15.46;  %  Red  B&O
  36  45.00  15.00;  %  Red  B&V
  58  44.54  21.50;  %  Red  B&V
  58  49.53  22.00;  %  Red  B&V
  36  49.53  28.41;  %  Red  S&W
  ];

%% white
namwhite = ...
  [
  81  -0.05  0.060;  %  White  B&K
  81  -0.96  10.62;  %  White  B&O
  81  -3.00  4.000;  %  White  B&V
  81   3.00  0.000;  %  White  B&V
  81   0.00  1.000;  %  White  B&V
  81  -0.05  0.060;  %  White  S&W
  ];

%% yellow
namyellow = ...
  [
  81  7.28  109.12;  %  Yellow  B&K
  81  3.35  56.360;  %  Yellow  B&O
  81  2.00  50.000;  %  Yellow  B&V
  58  3.00  50.000;  %  Yellow  B&V
  81  0.00  46.000;  %  Yellow  B&V
  81  1.65  72.030;  %  Yellow  S&W
  ];

%% putting cartesian in struct
CartFocals = struct;
CartFocals.black  = [mean(namblack);               mean(namblack);  [0, 0, 0]];
CartFocals.blue   = [mean(namblue([1:4, 6], :));   mean(namblue);   mean(namblue([1:3, 5:6], :))];
CartFocals.brown  = [mean(nambrown);               mean(nambrown);  [0, 0, 0]];
CartFocals.green  = [mean(namgreen([1:4, 6], :));  mean(namgreen);  mean(namgreen([1:3, 5:6], :))];
CartFocals.grey   = [mean(namgrey);                mean(namgrey);   mean(namgrey)];
CartFocals.orange = [mean(namorange([1:3, 6], :)); mean(namorange); mean(namorange)];
CartFocals.pink   = [mean(nampink(1:4, :));        mean(nampink);   mean(nampink(3:6, :))];
CartFocals.purple = [mean(nampurple(1:4, :));      mean(nampurple); mean(nampurple(3:6, :))];
CartFocals.red    = [mean(namred([1:3, 6], :));    mean(namred);    mean(namred(4:6, :))];
CartFocals.white  = [[0, 0, 0];                    mean(namwhite);  mean(namwhite)];
CartFocals.yellow = [namyellow(4, :);              mean(namyellow); mean(namyellow)];

ColourNames = fieldnames(CartFocals);
for i = 1:numel(ColourNames)
  CartFocals.(ColourNames{i})(:, 1) = [36; 58; 81];
end

%% converting them to polar
PolarFocals = struct();
for i = 1:numel(ColourNames)
  PolarFocals.(ColourNames{i}) = cart2pol3([CartFocals.(ColourNames{i})(:, 2:3), CartFocals.(ColourNames{i})(:, 1)]);
end

end