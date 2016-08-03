% OLAOFlickerDemo.m
%
% Derived from OLDemo.  Simpliefied and starts driving towards a
% program for initial AO reflectance response measurements.
%
% This program executes a calibrated isochromatic light pulse from the low
% background primary level to the high primarly level and back again.
% Step can be triggered by a keypress or a UDP signal, depending on
% variable TALKUDP.
%
% This requires the OneLightToolbox, SilentSubstitutionToolbox, and the matlabUDP command be on the
% path.
%
% 11/06/15  dhb et al.   Started on this.
% 11/08/15  dhb          A little cleanup
% 02/18/16  wst          Modified original code for flicker ERG testing
% 02/26/16  wst          Added TTL pulse output for acquisition triggering
% 02/29/16  wst          Added GUI for controlling ERG parameters
% 03/18/16  wst          L and M cone-isolating flicker added

%% Clear
clear; close all

%% switch to GUI approach for data input here
uiwait(OLAOFlickerConfig);
CFG = getappdata(0, 'CFG');

%% TTL Output
if CFG.ttlOutputButton == 1;
    portName = '/dev/tty.usbserial'; %hard-coded here; also can find using FindSerialPort([],1);
    hPort = IOPort('OpenSerialPort', portName, 'DTR=0'); %open the port
else
    %deal with reading TTL inputs later
    error('TTL input reading not currently enabled')
end

%% compute stimulus parameters

stimulusTimeSecs = CFG.sweepDuration+CFG.sweepDelay/1000; %include the delay here during which data is not recorded by the acquisition system

if CFG.sineWaveButton == 1;
    %sine wave parameters
    samplesPerCycle = CFG.refreshRate/CFG.flickerRate; %number of samples per sine wave cycle
    sineXValues = 0:(CFG.flickerRate^-1)/samplesPerCycle:CFG.flickerRate^-1; %one full cycle;
    sineAmplitude = CFG.contrast./200; %convert to amplitude in zero-to-one primary space
    stimPrimaryLevels = sineAmplitude.*(sin(2.*pi.*CFG.flickerRate.*sineXValues(1:end-1)))+CFG.backgroundLevel;
elseif CFG.squareWaveButton == 1;
    %square wave parameters
    CFG.refreshRate = 2*CFG.flickerRate;
    samplesPerCycle = CFG.refreshRate/CFG.flickerRate;
    stimPrimaryLevels = [CFG.backgroundLevel CFG.contrast/100];
end
numCyclesPerSweep = stimulusTimeSecs*CFG.flickerRate; %number of stimulus cylces in each recording sweep

%% Get calibration
% waveform.cal = OLGetCalibrationStructure;
waveform.cal = CFG.cal;
S = waveform.cal.describe.S;
nPrimaries = waveform.cal.describe.numWavelengthBands;

%% Get the background primary settings
backgroundPrimary = CFG.backgroundLevel*ones(nPrimaries,1);
backgroundSettings = OLPrimaryToSettings(waveform.cal,backgroundPrimary);
[backgroundStarts,backgroundStops] = OLSettingsToStartsStops(waveform.cal, backgroundSettings);

%% Get the stepped up primary settings (flicker sequence)
stepupPrimary = zeros(nPrimaries, length(stimPrimaryLevels)); %pre-allocate then loop through;
for n = 1:length(stimPrimaryLevels)
    stepupPrimary(:,n) = stimPrimaryLevels(n)*ones(nPrimaries,1);
    stepupSpd(:,n) = OLPrimaryToSpd(waveform.cal,stepupPrimary(:,n));
    stepupSettings(:,n) = OLPrimaryToSettings(waveform.cal,stepupPrimary(:,n));
    [stepupStarts(n,:),stepupStops(n,:)] = OLSettingsToStartsStops(waveform.cal, stepupSettings(:,n));
end

% %% Get the spectra in real units
% load T_xyz1931
% T_xyz = SplineCmf(S_xyz1931,683*T_xyz1931,S);
backgroundSpd = OLPrimaryToSpd(waveform.cal,backgroundPrimary);
% stepupSpd = OLPrimaryToSpd(waveform.cal,stepupPrimary);
% luminanceBackground = T_xyz(2,:)*backgroundSpd;
% luminanceStepup = T_xyz(2,:)*stepupSpd;
% fprintf('Luminances: background %0.1f, step %0.1f\n',luminanceBackground,luminanceStepup);

%% Show how to go from spectra back to primaries and settings
backgroundPrimaryCheck = OLSpdToPrimary(waveform.cal,backgroundSpd);
size(backgroundPrimary)
size(backgroundPrimaryCheck)
% backgroundSettingsCheck = OLPrimaryToSettings(waveform.cal,backgroundPrimaryCheck);
% backgroundSettingsCheck = OLSpdToSettings(waveform.cal,backgroundSpd,0.1);
size(backgroundSettings)
% size(backgroundSettingsCheck)

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
%     if (TALKUDP)
%         while (~matlabUDP('check')) end;
%         message = '';
%         while (isempty(message))
%             message = matlabUDP('receive');
%         end
%     else
        message = input('Hit "s" to begin sequence','s');
%     end
    
    % Exit gracefully on a string that begins with 'q'
    if (message(1) == 'q')
        break;
    end
    
    for sweepNum = 1:CFG.numSweeps;
        %generate one TTL pulse per recording sweep (5 Volts; 2 msec; positive polarity)
        if CFG.ttlOutputButton == 1;            
            IOPort('ConfigureSerialPort', hPort, 'DTR=1'); WaitSecs(0.002); IOPort('ConfigureSerialPort', hPort, 'DTR=0')
        end
%         tic
        for cycleNum = 1:numCyclesPerSweep
            for sampleNum = 1:samplesPerCycle
                ol.setMirrors(stepupStarts(sampleNum,:),stepupStops(sampleNum,:));
                WaitSecs(1/CFG.refreshRate);
            end
        end
        ol.setMirrors(backgroundStarts,backgroundStops);
%         toc
%         tic
        WaitSecs(CFG.intersweepDelay);
%         toc
    end
    break;
end

%% Close IOPort
if CFG.ttlOutputButton == 1
    IOPort('CloseAll');
end

%% save the configuration file
dataRootFolder = '/Users/Shared/Matlab/Experiments/OneLight/AdaptiveOpticsExperiments/OneLightMacintosh/Testing';
t = char(datetime('now', 'TimeZone', 'local', 'Format', 'yyyy-MM-dd-HH-mm-ss'));
[r,c] = find(t=='-');
t(c) = '_';
if isdir([dataRootFolder '/' CFG.subjectID '/'])==0;
    mkdir([dataRootFolder '/' CFG.subjectID '/']);
end
%make folder for the day
if isdir([dataRootFolder '/' CFG.subjectID '/' t(1:10) '/'])==0;
    mkdir([dataRootFolder '/' CFG.subjectID '/' t(1:10) '/']);
end

CFGfname = [CFG.subjectID '_' t(end-7:end) '.mat'];
save([dataRootFolder '/' CFG.subjectID '/' t(1:10) '/' CFGfname], 'CFG');

%% Close OneLight
% ol.shutdown;


