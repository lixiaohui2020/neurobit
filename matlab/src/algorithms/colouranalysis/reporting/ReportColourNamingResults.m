function MetamerColourNameReport = ReportColourNamingResults(MetamerPairs)
%ReportColourNamingResults Summary of this function goes here
%   Detailed explanation goes here

CurrentNameMat = load('/home/arash/Documents/Software/repositories/neurobit/data/dataset/hsi/results/1931/categorisation/arash/CurrentNamesNatural.mat');
CurrentNames = CurrentNameMat.CurrentNames;

DiffColourName = CurrentNames(MetamerPairs(:, 1), :) - CurrentNames(MetamerPairs(:, 2), :);

MetamerColourNameReport = sum(abs(DiffColourName), 2) > 0;

end
