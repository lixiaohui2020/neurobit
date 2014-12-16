function [] = ColourFrontiersExperimentCentre()

%% initialisation

% cleaning the workspace
clearvars;
close all;
clc;

% creating the colour frontiers
FrontierTable = GreyFrontiers();

% invoque the list of nameable colours from the literature
[CartFocals, ~] = FocalColours();

%% CRS setup

% setting the monitor up
crsStartup;
% crsSet24bitColourMode ;
crsSetColourSpace(CRS.CS_RGB);
% Gammacorrect should be turned on for this experiment.
% I turn it off here because it causes the black screen to look too bright
% I will tun it on just before the begining of the experiment...
crsSetVideoMode(CRS.EIGHTBITPALETTEMODE + CRS.NOGAMMACORRECT);

%% experiment parameters

ExperimentParameters = CreateExperimentParameters(CRS, 'Centre');

AngleMargin = 0.1;

minradius = 0;
maxradius = 20;
ini_radialstep = 0.1;

%% preparing the experiment

% TODO: should I remove grey level mondrian
if ExperimentParameters.BackgroundType == -1
  blacknwhite = 1;
  BackgroundTitle = 'Coloured mondrians background';
elseif ExperimentParameters.BackgroundType == -2
  blacknwhite = 2;
  BackgroundTitle = 'Greylevel mondrians background';
elseif ExperimentParameters.BackgroundType >= 0
  blacknwhite = 2;
  BackgroundTitle = 'Plain grey background';
end

% TODO: should I add this 'binomials'?
[FrontierTable, conditions] = GetExperimentConditions(FrontierTable, ExperimentParameters);

totnumruns = length(conditions);

% the parameters that we save in excel
expjunk.angles = zeros(totnumruns, 1);
expjunk.radii = zeros(totnumruns, 1);
expjunk.luminances = zeros(totnumruns, 1);
expjunk.times = zeros(totnumruns, 1);
expjunk.conditions = conditions;

expjunk.startangles = zeros(totnumruns, 1);
expjunk.startradius = zeros(totnumruns, 1);
expjunk.radialstep = ini_radialstep;
expjunk.mybackground = ExperimentParameters.BackgroundType;

%% start of experiment

SubjectName = StartExperiment(ExperimentParameters);

if ExperimentParameters.plotresults
  FigurePlanes = unique(FrontierTable(:, 1));
  FigurePlanes{1, 2} = [];
  for i = 1:size(FigurePlanes, 1)
    AvailablePosition = AvailableFigurePosition(cell2mat(FigurePlanes(:, 2)));
    FigurePlanes{i, 2} = figure;
    set(FigurePlanes{i, 2}, 'Name', ['Plane L= ', FigurePlanes{i, 1}], 'NumberTitle', 'off', 'position', AvailablePosition);
    hold on;
    title(['Subject: ', SubjectName, '; Background: ', BackgroundTitle]);
    % plotting all the borders at the start
    PlaneIndex = ~cellfun('isempty', strfind(FrontierTable(:, 1), FigurePlanes{i, 1}));
    PlaneTable = FrontierTable(PlaneIndex, :);
    for j = 1:size(PlaneTable, 1)
      PlotGrey(PlaneTable(j, :), blacknwhite, maxradius, CartFocals);
    end
  end
end

crsSetVideoMode(CRS.EIGHTBITPALETTEMODE + CRS.GAMMACORRECT); %CRS.HYPERCOLOURMODE );
crsResetTimer();

condition_elapsedtime = 0;
ExperimentCounter = 1;
for borderNr = conditions
  % selecting the figure for this condition
  if ExperimentParameters.plotresults
    FigureIndex = ~cellfun('isempty', strfind(FigurePlanes(:, 1), FrontierTable{borderNr, 1}));
    h = FigurePlanes{FigureIndex, 2};
    figure(h);
  end
  
  % selection the borders of this condition
  if round(rand)
    startcolourname = FrontierTable{borderNr, 2};
    endcolourname = 'Grey';
  else
    endcolourname = FrontierTable{borderNr, 2};
    startcolourname = 'Grey';
  end
  
  % choose distance to centre
  ColourRad = FrontierTable{borderNr, blacknwhite + 2};
  %   BorderIndices1 = ~cellfun('isempty', strfind(FrontierTable(:, 1), FrontierTable{borderNr, 1}));
  %   BorderIndices2 = ~cellfun('isempty', strfind(FrontierTable(:, 2), FrontierTable{borderNr, 5}));
  %   BorderColour = FrontierTable(BorderIndices1 & BorderIndices2, :);
  %   BorderRad = BorderColour{blacknwhite + 2};
  %   if ColourRad < BorderRad
  %     ColourRad = ColourRad + 2 * pi;
  %   end
  %   current_angle = (BorderRad - ColourRad) .* rand + ColourRad;
  current_angle = (-2 * AngleMargin * rand + 1 + AngleMargin) * ColourRad;
  theplane = str2double(FrontierTable{borderNr, 1});
  
  current_radius = minradius + (maxradius - minradius) * rand;
  
  expjunk.startangles(ExperimentCounter) = current_angle;
  expjunk.startradius(ExperimentCounter) = current_radius;
  
  % generating mondrian
  [~, ~, ~, palette] = GenerateMondrian(ExperimentParameters, current_angle, current_radius, theplane, startcolourname, endcolourname);
  
  audioplayer(ExperimentParameters.y_DingDong , ExperimentParameters.Fs_DingDong); %#ok
  condition_starttime = crsGetTimer();
  
  % displaying experiment information
  disp('===================================');
  disp(['Current colour zone: ', FrontierTable{borderNr, 2}]);
  if ~strcmpi(startcolourname, 'Grey')
    disp([startcolourname, ' Lab colour:  ', num2str(pol2cart3([current_angle, current_radius, theplane], 1))]);
    disp([endcolourname, ' Lab colour:  0 0 ', num2str(theplane)]);
  else
    disp([startcolourname, ' Lab colour:  0 0 ', num2str(theplane)]);
    disp([endcolourname, ' Lab colour:  ', num2str(pol2cart3([current_angle, current_radius, theplane], 1))]);
  end
  disp(['Luminance Plane: ', num2str(theplane)]);
  disp(['Start up radius: ', num2str(current_radius), ' Lab units']);
  disp(['Test angle: ', num2str(current_angle), ' rad']);
  disp(['There are still ', num2str(totnumruns - ExperimentCounter - 1), ' runs to go (', num2str(round((ExperimentCounter - 1) / totnumruns * 100)), '% completed).']);
  
  % joystick loop quit condition variable
  QuitButtonPressed = 0;
  % activate joystick
  joystick on;
  
  all_buttons = [7, 8, 5, 6, 9];
  radialstep = ini_radialstep;
  
  while QuitButtonPressed == 0
    %   Get the joystick response.
    new_buttons = joystick( 'get' , all_buttons ) ;
    Shift = 0 ;
    if new_buttons(1)
      % left correction
      Shift = Shift - radialstep;
    end
    if new_buttons(2)
      % right correction
      Shift = Shift + radialstep;
    end
    if new_buttons(3)
      % left correction
      Shift = Shift - ExperimentParameters.fastsampling * radialstep;
    end
    if new_buttons(4)
      % right correction
      Shift = Shift + ExperimentParameters.fastsampling * radialstep;
    end
    if new_buttons(5)
      % indicates last run
      QuitButtonPressed = 1;
      condition_elapsedtime = crsGetTimer() - condition_starttime;
      wavplay(ExperimentParameters.y_ding, ExperimentParameters.Fs_ding); %#ok
      UpdatePlotCurrentBorder(current_angle, current_radius, ExperimentParameters.plotresults, 'or');
      Shift = 0;
    end
    if Shift ~= 0
      % this pause is necessary due to behaviour of the joystick in order
      % to slow the adquisition process.
      pause(ExperimentParameters.joystickdelay);
      
      UpdatePlotCurrentBorder(current_angle, current_radius, ExperimentParameters.plotresults, '.b');
      
      % update current radius
      current_radius = current_radius + Shift;
      if current_radius > maxradius
        current_radius = maxradius;
        radialstep = -radialstep;
      end
      if current_radius < minradius
        current_radius = minradius;
        radialstep = -radialstep;
      end
      
      % update the CRT
      palette(ExperimentParameters.Central_patch_name, :) = Lab2CRSRGB(ExperimentParameters.CRS, pol2cart3([current_angle, current_radius, theplane], 1), ExperimentParameters.refillum);
      crsPaletteSet(palette');
      UpdatePlotCurrentBorder(current_angle, current_radius, ExperimentParameters.plotresults, '.r');
    end
  end
  
  % deactivate joystick
  joystick off;
  
  crsPaletteSet(ExperimentParameters.junkpalette);
  crsSetDisplayPage(3);
  
  % displaying the final selected border
  disp(['Selected radius: ', num2str(current_radius), ' Lab units']);
  disp(['Final Lab colour: ', num2str(pol2cart3([current_angle, current_radius, theplane], 1))]);
  disp(['Time elapsed: ', num2str(condition_elapsedtime / 1000000), ' secs']);
  
  % collect results and other junk
  expjunk.angles(ExperimentCounter) = current_angle;
  expjunk.radii(ExperimentCounter) = current_radius;
  expjunk.luminances(ExperimentCounter) = theplane;
  expjunk.times(ExperimentCounter) = condition_elapsedtime / 1000000;
  
  ExperimentCounter = ExperimentCounter + 1;
end

%% cleaning and saving

CleanAndSave(ExperimentParameters, SubjectName, expjunk);

end

%% PlotGrey

function [] = PlotGrey(FrontierTable, blacknwhite, maxradius, CartFocals)

% TODO: should we change it based on the colour?
x = 2;

labplane = str2double(FrontierTable{1});

% there is +2, because angles start from column 2
pp = pol2cart3([FrontierTable{blacknwhite + 2}, maxradius + 10]);
plot([pp(1), 0], [pp(2), 0], 'r');

ColourName = lower(FrontierTable{2});
colour = CartFocals.(ColourName)((CartFocals.(ColourName)(:, 1) == labplane), :);
text(colour(2) ./ x, colour(3) ./ x, ColourName, 'color', 'r');

end
