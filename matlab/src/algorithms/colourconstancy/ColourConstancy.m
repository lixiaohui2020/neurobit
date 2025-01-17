function ColourConstantImage = ColourConstancy(InputImage, algorithm, plotme, varargin)
%ColourConstancy  wrapper for all the existing colour constancy algorithms.
%
% Inputs
%   InputImage  the input image.
%   algorithm   the name of the algorithm.
%   plotme      if you want the results be plotted.
%   varargin    the specific parameters for each algorithm.
%
% Outputs
%   ColourConstantImage  the colour constant image in range of [0, 1].
%
% See also: ColourConstancyACE, ColourConstancyGreyWorld,
%           ColourConstancyHisteq, ColourConstancyHistWhitePatch,
%           ColourConstancyMSRCR, ColourConstancyMultiScaleRetinex,
%           ColourConstancyProgressive, ColourConstancySingleScaleRetinex,
%           ColourConstancyWhitePatch
%

InputImage = im2double(InputImage);

algorithm = lower(algorithm);

switch algorithm
  case 'histeq'
    ColourConstantImage = ColourConstancyHisteq(InputImage);
  case 'grey world'
    ColourConstantImage = ColourConstancyGreyWorld(InputImage);
  case 'white patch'
    ColourConstantImage = ColourConstancyWhitePatch(InputImage);
  case 'hist white patch'
    ColourConstantImage = ColourConstancyHistWhitePatch(InputImage);
  case 'progressive'
    if length(varargin) > 1
      h1 = varargin{1};
      h2 = varargin{2};
      ColourConstantImage = ColourConstancyProgressive(InputImage, h1, h2);
    else
      ColourConstantImage = InputImage;
      disp('Progressive algorithm must have two parameters.');
    end
  case 'single scale retinex'
    ColourConstantImage = ColourConstancySingleScaleRetinex(InputImage);
  case 'multi scale retinex'
    ColourConstantImage = ColourConstancyMultiScaleRetinex(InputImage);
  case 'msrcr'
    ColourConstantImage = ColourConstancyMSRCR(InputImage);
  case 'ace'
    ColourConstantImage = ColourConstancyACE(InputImage);
  otherwise
    ColourConstantImage = InputImage;
    disp('Unknown alogrithm, please check name.');
end

ColourConstantImage = uint8(ColourConstantImage .* 255);

if plotme
  figure('NumberTitle', 'Off', 'Name', 'Colour Constancy');
  subplot(1, 2, 1);
  imshow(InputImage);
  title('Original image');
  subplot(1, 2, 2);
  imshow(ColourConstantImage);
  title(['Algorithm ', algorithm]);
end

end
