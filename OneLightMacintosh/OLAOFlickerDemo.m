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
% This requires the OneLightToolbox and the matlabUDP command be on the
% path.
%
% 11/06/15  dhb et al.   Started on this.
% 11/08/15  dhb          A little cleanup
% 02/18/16  wst          Modified original code for flicker ERG testing
% 02/26/16  wst          Added TTL pulse output

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

%% TTL
TTL = true;
if (TTL)
    portName = '/dev/tty.usbserial'; %hard-coded here; also can find using FindSerialPort([],1);
    hPort = IOPort('OpenSerialPort', portName, 'DTR=0'); %open the port
end

%% Input flicker, contrast, OneLight refresh rate, and acquisition parameters
flickerRate = input('Stimulus flicker rate (in Hz) [30]:', 's'); %in Hz
if isempty(flickerRate)
    flickerRate = 30;
else
    flickerRate = str2double(flickerRate);
end

contrast = input('Stimulus contrast (%) [100]:', 's');
if isempty(contrast)
    contrast = 100; %in percent
else
    contrast = str2double(contrast);
end

refreshRateOL = input('OneLight refresh rate (in Hz) [240]:', 's');
if isempty(refreshRateOL)
    refreshRateOL = 240; %in Hz
else
    refreshRateOL = str2double(refreshRateOL);
end

bgPrimaryLevel = input('Background primary level [0.5]:', 's');
if isempty(bgPrimaryLevel)
    bgPrimaryLevel = 0.5; %midpoint around which sinusoid varies
else
    bgPrimaryLevel = str2double(bgPrimaryLevel);
end

sweepsPerResult = input('Number of sweeps to record [1]:', 's');
if isempty(sweepsPerResult)
    sweepsPerResult = 1;
else
    sweepsPerResult = str2double(sweepsPerResult);
end

sweepDuration = input('Sweep duration (in seconds) [0.200]:', 's');
if isempty(sweepDuration)
    sweepDuration = 0.200;
else
    sweepDuration = str2double(sweepDuration);
end

sweepDelay = input('First sweep delay (in milliseconds) [10]:', 's');
if isempty(sweepDelay)
    sweepDelay = 10/1000;
else
    sweepDelay = str2double(sweepDelay)/1000;
end

interSweepDelay = input('Inter sweep delay (in seconds) [1]:', 's');
if isempty(interSweepDelay)
    interSweepDelay = 1;
else
    interSweepDelay = str2double(interSweepDelay);
end

stimulusTimeSecs = sweepDuration+sweepDelay; %include the delay here in which data is not recorded by the acquisition system

samplesPerCycle = refreshRateOL/flickerRate; %number of samples per sine wave cycle
numCyclesPerSweep = stimulusTimeSecs*flickerRate; %number of sinusoidal cylces in each recording sweep

%sine wave parameters
sineXValues = 0:(flickerRate^-1)/samplesPerCycle:flickerRate^-1; %one full cycle;
sineAmplitude = contrast./200; %convert to amplitude in zero-to-one primary space
sinePrimaryLevels = sineAmplitude.*(sin(2.*pi.*flickerRate.*sineXValues(1:end-1)))+bgPrimaryLevel;

%% Get calibration
waveform.cal = OLGetCalibrationStructure;
S = waveform.cal.describe.S;
nPrimaries = waveform.cal.describe.numWavelengthBands;

%% Get the background primary settings
backgroundPrimary = bgPrimaryLevel*ones(nPrimaries,1);
backgroundSettings = OLPrimaryToSettings(waveform.cal,backgroundPrimary);
[backgroundStarts,backgroundStops] = OLSettingsToStartsStops(waveform.cal, backgroundSettings);

%% Get the stepped up primary settings (flicker sequence)
stepupPrimary = zeros(nPrimaries, length(sinePrimaryLevels)); %pre-allocate then loop through;
for n = 1:length(sinePrimaryLevels)
    stepupPrimary(:,n) = sinePrimaryLevels(n)*ones(nPrimaries,1);
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
        message = input('Hit "s" to begin sequence','s');
    end
    
    % Exit gracefully on a string that begins with 'q'
    if (message(1) == 'q')
        break;
    end
    
    for sweepNum = 1:sweepsPerResult;
        %generate one TTL pulse per recording sweep (5 Volts; 2 msec; positive polarity)
        if (TTL)            
            IOPort('ConfigureSerialPort', hPort, 'DTR=1'); WaitSecs(0.002); IOPort('ConfigureSerialPort', hPort, 'DTR=0')
        end
        tic
        for cycleNum = 1:numCyclesPerSweep
            for sampleNum = 1:samplesPerCycle
                ol.setMirrors(stepupStarts(sampleNum,:),stepupStops(sampleNum,:));
                WaitSecs(1/refreshRateOL);
            end
        end
        toc
        tic
        WaitSecs(interSweepDelay);
        toc
    end
end

%% Close UDP if open
if (TALKUDP)
    matlabUDP('close');
end

%% Close IOPort
if (TTL)
    IOPort('Close', hPort);
end

%% Close OneLight
% ol.shutdown;


