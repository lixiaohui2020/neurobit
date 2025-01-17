function MetamerDiffs = MetamerTestFosterHyperspectralImages()

FunctionPath = mfilename('fullpath');
DataSetFolder = 'data/dataset/ColourConstancyDataset/hyperspectral/';
DataSetMatPath = [DataSetFolder, 'HyperspectralImageList.mat'];
FunctionRelativePath = 'src/algorithms/colouranalysis/MetamerTestFosterHyperspectralImages';
MatFilePath = strrep(FunctionPath, ['matlab/', FunctionRelativePath], DataSetMatPath);
DataSetPath = strrep(FunctionPath, ['matlab/', FunctionRelativePath], DataSetFolder);
HyperspectralImageListMat = load(MatFilePath);

IlluminantstPath = strrep(FunctionPath, FunctionRelativePath, 'data/mats/hsi/illuminants.mat');
illuminants = load(IlluminantstPath);

% 400 - 720 nm
inds = find(illuminants.wavelength == 400):10:find(illuminants.wavelength == 720);

HyperspectralImageNames = HyperspectralImageListMat.HyperspectralImageNames;
nimages = numel(HyperspectralImageNames);

MetamerDiffs = cell(nimages, 1);

FundamentalsPath = strrep(FunctionPath, FunctionRelativePath, 'data/mats/hsi/');
ColourReceptorsMat = load([FundamentalsPath, 'Xyz1931SpectralSensitivity.mat']);
% spectral sensitivities of 1931 observers
ColourReceptors = ColourReceptorsMat.Xyz1931SpectralSensitivity;

IlluminantsMat = load([FundamentalsPath, 'illuminants.mat']);
illuminant = IlluminantsMat.d65;
illuminant = illuminant(inds);

wp = whitepoint('d65');
plotme = true;

nPixels = 2000;

for i = 1:nimages
  DebugImagePath = [DataSetPath, HyperspectralImageNames{i}(1:end-3), 'mat'];
  CurrentMat = load(DebugImagePath);
  
  hsi = CurrentMat.hsi;
  
  hsi = reshape(hsi, size(hsi, 1) * size(hsi, 2), 1, size(hsi, 3));
  InputSignal = hsi(randi(size(hsi, 1), [nPixels, 1]), :, :);
  lab = hsi2lab(InputSignal, illuminant, ColourReceptors, wp);
  MetamerDiffs{i} = MetamerAnalysisColourDifferences(lab);
  if plotme
    SignalLength = size(InputSignal, 3);
    MetamerPlot = MetamerDiffs{i};
    MetamerPlot.SgnlDiffs = 1 ./ MetamerPlot.CompMat2000;
    nSignals = size(lab, 1);
    PlotTopMetamers(MetamerPlot, reshape(InputSignal, nSignals, SignalLength)', 25);
  end
end

end
