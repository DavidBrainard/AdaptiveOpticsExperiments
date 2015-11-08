% OLAODemo.m
%
% Derived from OLDemo.  Simpliefied and starts driving towards a
% program for initial AO reflectance response measurements.
%
% This program executes a calibrated isochromatic light pulse from the low
% background primary level to the high primarly level and back again.
% Step can be triggered by a keypress or a UDP signal, depending on
% variable TALKUDP.
%
% This requires the OneLightToolbox and the matlabUDP command be on the
% path.
%
% 11/06/15  dhb et al.   Started on this.
% 11/08/15  dhb          A little cleanup

%% Clear
clear; close all

%% UDP
%
% If you're talking with UDP, these need to match the 
% IP addresses of the two machines that are talking,
% and the port needs to be the same for the two machines.
TALKUDP = false;
macHostIP = '130.91.72.120';
winHostIP = '130.91.74.15';
udpPort = 2007;

%%  Light parameters
bgPrimaryLevel = 0.2;
highPrimaryLevel = 0.9;
stepTimeSecs = 0.5;

%% Get calibration
waveform.cal = OLGetCalibrationStructure;
S = waveform.cal.describe.S;
nPrimaries = waveform.cal.describe.numWavelengthBands;

%% Get the background primary settings
backgroundPrimary = bgPrimaryLevel*ones(nPrimaries,1);
backgroundSettings = OLPrimaryToSettings(waveform.cal,backgroundPrimary);
[backgroundStarts,backgroundStops] = OLSettingsToStartsStops(waveform.cal, backgroundSettings);

%% Get the stepped up primary settings
stepupPrimary = highPrimaryLevel*ones(nPrimaries,1);
stepupSpd = OLPrimaryToSpd(waveform.cal,stepupPrimary);
stepupSettings = OLPrimaryToSettings(waveform.cal,stepupPrimary);
[stepupStarts,stepupStops] = OLSettingsToStartsStops(waveform.cal, stepupSettings);

%% Get the spectra in real units
load T_xyz1931
T_xyz = SplineCmf(S_xyz1931,683*T_xyz1931,S);
backgroundSpd = OLPrimaryToSpd(waveform.cal,backgroundPrimary);
stepupSpd = OLPrimaryToSpd(waveform.cal,stepupPrimary);
luminanceBackground = T_xyz(2,:)*backgroundSpd;
luminanceStepup = T_xyz(2,:)*stepupSpd;
fprintf('Luminances: background %0.1f, step %0.1f\n',luminanceBackground,luminanceStepup);

%% Show how to go from spectra back to primaries and settings
backgroundPrimaryCheck = OLSpdToPrimary(waveform.cal,backgroundSpd);
size(backgroundPrimary)
size(backgroundPrimaryCheck)
% backgroundSettingsCheck = OLPrimaryToSettings(waveform.cal,backgroundPrimaryCheck);
backgroundSettingsCheck = OLSpdToSettings(waveform.cal,backgroundSpd,0.1);
size(backgroundSettings)
size(backgroundSettingsCheck)

%% Initialize UDP if desired
if (TALKUDP)
    matlabUDP('open',macHostIP,winHostIP,udpPort);
end

%% Initialize OneLight
fprintf('Initializing OneLight\n');
ol = OneLight;
fprintf('Done')

%% Loop.  
%   Set the background. 
%   Wait for signal
%   Set the step
%   Wait for duration
%
while (true)
    % Set Background
    fprintf('Setting background\n');
    ol.setMirrors(backgroundStarts,backgroundStops);
    
    % Wait for go signal
    fprintf('Waiting\n');
    if (TALKUDP)
        while (~matlabUDP('check')) end;
        message = '';
        while (isempty(message))
            message = matlabUDP('receive');
        end
    else
        message = input('Hit enter to flash','s');
    end
    
    % Exit gracefully on a string that begins with 'q'
    if (message(1) == 'q')
        break;
    end
    
    % Step up and wait
    fprintf('Stepping\n');
    ol.setMirrors(stepupStarts,stepupStops);
    WaitSecs(stepTimeSecs);
end

%% Close UDP if open
if (TALKUDP)
    matlabUDP('close');
end

%% Close OneLight
ol.shutdown;


