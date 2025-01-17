function lab = hsi2lab(hsi, illuminant, ColourReceptor, wp)
%HSI2LAB  converts a hyperspectral image into an LAB one.
%
% inputs
%   hsi             the hyperspectral image
%   illuminant      the illumination signal
%   ColourReceptor  the xyz sensitivity function.
%   wp              white reference.
%
% outputs
%   lab  the converted image into the CIE L*a*b* colour space.
%

FunctionPath = mfilename('fullpath');
DataFolder = ['matlab', filesep, 'data', filesep, 'mats', filesep, 'hsi', filesep];
FunctionRelativePath = ['matlab', filesep, 'src', filesep, 'transformations', filesep, 'hsi', filesep, 'hsi2lab'];
FolderPath = strrep(FunctionPath, FunctionRelativePath, DataFolder);

if nargin < 2 || isempty(illuminant)
  IlluminantsMat = load([FolderPath, 'FosterIlluminants.mat']);
  illuminant.spectra = IlluminantsMat.illum_6500;
  illuminant.wavelength = IlluminantsMat.wavelength;
end

if nargin < 3 || isempty(ColourReceptor)
  xyzmat = load([FolderPath, 'FosterXYZbar.mat']);
  ColourReceptor.spectra = xyzmat.xyzbar;
  ColourReceptor.wavelength = xyzmat.wavelength;
end

if nargin < 4 || isempty(wp)
  wp = ComputeWhitePoint(illuminant, ColourReceptor);
end

xyz = hsi2xyz(hsi, illuminant, ColourReceptor);

lab = xyz2lab(xyz, 'WhitePoint', wp);

end
