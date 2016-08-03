function varargout = OLAOFlickerConfig(varargin)
% OLAOFLICKERCONFIG MATLAB code for OLAOFlickerConfig.fig
%      OLAOFLICKERCONFIG, by itself, creates a new OLAOFLICKERCONFIG or raises the existing
%      singleton*.
%
%      H = OLAOFLICKERCONFIG returns the handle to a new OLAOFLICKERCONFIG or the handle to
%      the existing singleton*.
%
%      OLAOFLICKERCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OLAOFLICKERCONFIG.M with the given input arguments.
%
%      OLAOFLICKERCONFIG('Property','Value',...) creates a new OLAOFLICKERCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OLAOFlickerConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OLAOFlickerConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OLAOFlickerConfig

% Last Modified by GUIDE v2.5 18-Mar-2016 10:55:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OLAOFlickerConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @OLAOFlickerConfig_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before OLAOFlickerConfig is made visible.
function OLAOFlickerConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OLAOFlickerConfig (see VARARGIN)

% Choose default command line output for OLAOFlickerConfig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OLAOFlickerConfig wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%load last values script here
if exist('lastERGCFG.mat','file')==2
    loadLastValues(handles,1);
else
    loadLastValues(handles,0);
end

%disable some non-functioning options for now
% set(handles.LconeButton, 'Enable', 'off');
% set(handles.MconeButton, 'Enable', 'off');
set(handles.ttlInputButton, 'Enable', 'off');



% --- Outputs from this function are returned to the command line.
function varargout = OLAOFlickerConfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function numSweeps_Callback(hObject, eventdata, handles)
% hObject    handle to numSweeps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numSweeps as text
%        str2double(get(hObject,'String')) returns contents of numSweeps as a double


% --- Executes during object creation, after setting all properties.
function numSweeps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numSweeps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweepDuration_Callback(hObject, eventdata, handles)
% hObject    handle to sweepDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweepDuration as text
%        str2double(get(hObject,'String')) returns contents of sweepDuration as a double


% --- Executes during object creation, after setting all properties.
function sweepDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweepDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweepDelay_Callback(hObject, eventdata, handles)
% hObject    handle to sweepDelay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweepDelay as text
%        str2double(get(hObject,'String')) returns contents of sweepDelay as a double


% --- Executes during object creation, after setting all properties.
function sweepDelay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweepDelay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intersweepDelay_Callback(hObject, eventdata, handles)
% hObject    handle to intersweepDelay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intersweepDelay as text
%        str2double(get(hObject,'String')) returns contents of intersweepDelay as a double


% --- Executes during object creation, after setting all properties.
function intersweepDelay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intersweepDelay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function flickerRate_Callback(hObject, eventdata, handles)
% hObject    handle to flickerRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flickerRate as text
%        str2double(get(hObject,'String')) returns contents of flickerRate as a double


% --- Executes during object creation, after setting all properties.
function flickerRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flickerRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function contrast_Callback(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of contrast as text
%        str2double(get(hObject,'String')) returns contents of contrast as a double
global ConfigParams
ConfigParams.contrast = str2double(get(handles.contrast, 'String'));


% --- Executes during object creation, after setting all properties.
function contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function backgroundLevel_Callback(hObject, eventdata, handles)
% hObject    handle to backgroundLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of backgroundLevel as text
%        str2double(get(hObject,'String')) returns contents of backgroundLevel as a double
global CFG;
CFG.backgroundLevel = str2double(get(handles.backgroundLevel, 'String'));


% --- Executes during object creation, after setting all properties.
function backgroundLevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to backgroundLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function refreshRate_Callback(hObject, eventdata, handles)
% hObject    handle to refreshRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of refreshRate as text
%        str2double(get(hObject,'String')) returns contents of refreshRate as a double


% --- Executes during object creation, after setting all properties.
function refreshRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to refreshRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function calibrationPopUp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calibrationPopUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in calibrationPopUp.
function calibrationPopUp_Callback(hObject, eventdata, handles)
% hObject    handle to calibrationPopUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns calibrationPopUp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from calibrationPopUp
global CFG ConfigParams
calNames = cellstr(get(hObject,'String')); 
calIndex = get(hObject, 'Value');
CFG.calName = calNames(calIndex);
CFG.calIndex = calIndex;

%if you change the calibration type, obtain the dates for the new one
[calDates] = OLGetCalibrationDateGUI;
ConfigParams.calDates = calDates;
set(handles.calDatePopUp, 'Value', 1, 'String', calDates);

% --- Executes on selection change in calDatePopUp.
function calDatePopUp_Callback(hObject, eventdata, handles)
% hObject    handle to calDatePopUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns calDatePopUp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from calDatePopUp
global CFG ConfigParams
dateNames = cellstr(get(hObject,'String')); 
dateIndex = get(hObject, 'Value');
CFG.dateName = dateNames(dateIndex);
CFG.dateIndex = dateIndex;
CFG.cal = ConfigParams.cals{CFG.dateIndex};

% --- Executes during object creation, after setting all properties.
function calDatePopUp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calDatePopUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in cancelPushButton.
function cancelPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CFG
CFG.ok = 0;
setappdata(0, 'CFG', CFG);
close;

% --- Executes on button press in loadLastPushButton.
function loadLastPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadLastPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CFG ConfigParams; %#ok<*NUSED>
loadLastValues(handles, ConfigParams.loadlast);

function subjectID_Callback(hObject, eventdata, handles)
% hObject    handle to subjectID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subjectID as text
%        str2double(get(hObject,'String')) returns contents of subjectID as a double


% --- Executes during object creation, after setting all properties.
function subjectID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subjectID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when selected object is changed in stimFormPanel.
function stimFormPanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in stimFormPanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global CFG;
if get(handles.squareWaveButton, 'Value')==1
    set(handles.backgroundLevel, 'String', 0);
    set(handles.contrastText, 'String', 'Step Height (%)')
else
    set(handles.backgroundLevel, 'String', CFG.backgroundLevel);
    set(handles.contrastText, 'String', 'Contrast (%)')
end

% --- Executes on button press in okPushButton.
function okPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to okPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CFG
CFG.ok = 1;
CFG.flickerRate = str2double(get(handles.flickerRate, 'String'));
CFG.contrast = str2double(get(handles.contrast, 'String'));
CFG.backgroundLevel = str2double(get(handles.backgroundLevel, 'String'));
CFG.refreshRate = str2double(get(handles.refreshRate, 'String'));
CFG.sineWaveButton = get(handles.sineWaveButton, 'Value');
CFG.squareWaveButton = get(handles.squareWaveButton, 'Value');
CFG.luminanceButton = get(handles.luminanceButton, 'Value');
CFG.LconeButton = get(handles.LconeButton, 'Value');
CFG.MconeButton = get(handles.MconeButton, 'Value');
CFG.subjectID = get(handles.subjectID,'String');
CFG.numSweeps = str2double(get(handles.numSweeps, 'String'));
CFG.sweepDuration = str2double(get(handles.sweepDuration, 'String'));
CFG.sweepDelay = str2double(get(handles.sweepDelay, 'String'));
CFG.intersweepDelay = str2double(get(handles.intersweepDelay, 'String'));
CFG.ttlOutputButton = get(handles.ttlOutputButton, 'Value');
CFG.ttlInputButton = get(handles.ttlInputButton, 'Value');
CFG.maxCheck = get(handles.maxCheck, 'Value');
CFG.fieldSizeDeg = str2double(get(handles.fieldSizeDeg, 'String'));
CFG.subjectAge = str2double(get(handles.subjectAge, 'String'));
CFG.pupilSizeMM = str2double(get(handles.pupilSizeMM, 'String'));


save('lastERGCFG.mat', 'CFG');
setappdata(0, 'CFG', CFG);
close;

function loadLastValues (handles,last)

global CFG ConfigParams; %#ok<*NUSED>

if last==1
    load('lastERGCFG.mat');
    ConfigParams.contrast = CFG.contrast;
    %list available calibrations
    [calFolder, calPopUpList, availableCalTypes] = OLGetCalibrationStructureGUI;
    ConfigParams.availableCalTypes = availableCalTypes;
    ConfigParams.calFolder = calFolder;
    set(handles.calibrationPopUp, 'String', calPopUpList);
    %go through them to see if the previous calibration type is still there
    keepGoing = true;
    while keepGoing == true;
        for i = 1:length(calPopUpList);
            if strcmp(char(calPopUpList{i}),char(CFG.calName))==1;
                CFG.calIndex = i; %reset the index in case more calibrations have been added
                keepGoing = false;
            end
        end
        %if no match found, remind user to select a calibration type in the GUI
        if keepGoing == true;
            errordlg('Previous calibration type not found; please re-select', 'Select calibration type in GUI');
            keepGoing = false;
        end
    end
    set(handles.calDatePopUp, 'Value', CFG.calIndex);
    %re-check available calibration dates;
    [calDates] = OLGetCalibrationDateGUI;    
    ConfigParams.calDates = calDates;
    set(handles.calDatePopUp, 'String', ConfigParams.calDates);
    %go through them to see if the previous calibration date is still there
    keepGoing = true;
    while keepGoing == true;
        for i = 1:length(calDates);
            if strcmp(char(calDates{i}),char(CFG.dateName))==1;
                CFG.dateIndex = i;
                keepGoing = false;
            end
        end
        %if no match found, remind user to select a date in the GUI
        if keepGoing == true;
            errordlg('Calibration date not found; please re-select', 'Select calibration date in GUI');
            keepGoing = false;
        end
    end
    set(handles.calDatePopUp, 'Value', CFG.dateIndex);
    ConfigParams.loadlast = 0;
    set(handles.loadLastPushButton, 'String', 'Reset')
else %Set default values here
    CFG.flickerRate = 30;
    CFG.contrast = 100;
    CFG.backgroundLevel = 0.5;
    CFG.refreshRate = 120;
    CFG.sineWaveButton = 1;
    CFG.squareWaveButton = 0;
    CFG.luminanceButton = 1;
    CFG.LconeButton = 0;
    CFG.MconeButton = 0;
    CFG.subjectID = '11046';
    CFG.numSweeps = 20;
    CFG.sweepDuration = 0.200;
    CFG.sweepDelay = 10;
    CFG.intersweepDelay = 1;
    CFG.ttlOutputButton = 1;
    CFG.ttlInputButton = 0;
    CFG.maxCheck = 0;
    CFG.fieldSizeDeg = 27.2;
    CFG.subjectAge = 32;
    CFG.pupilSizeMM = 4.7;
    
    ConfigParams.contrast = CFG.contrast;
    
    %Calibration pop-up menu here -- load available files
    [calFolder, calPopUpList, availableCalTypes] = OLGetCalibrationStructureGUI;
    set(handles.calibrationPopUp, 'String', calPopUpList);
    ConfigParams.loadlast = 1;
    ConfigParams.availableCalTypes = availableCalTypes;
    ConfigParams.calFolder = calFolder;
    calNames = cellstr(get(handles.calibrationPopUp,'String'));
    calIndex = get(handles.calibrationPopUp, 'Value');
    CFG.calName = calNames(calIndex);
    CFG.calIndex = calIndex;
    %Calibration date pop-up menu here -- load dates for first files prior
    %to user selection
    [calDates] = OLGetCalibrationDateGUI;
    ConfigParams.calDates = calDates;
    set(handles.calDatePopUp, 'String', ConfigParams.calDates);
    dateNames = cellstr(get(handles.calDatePopUp,'String'));
    dateIndex = get(handles.calDatePopUp, 'Value');
    CFG.dateName = dateNames(dateIndex);
    CFG.dateIndex = dateIndex;    
    set(handles.loadLastPushButton, 'String', 'Load Last');
end

set(handles.flickerRate, 'String', CFG.flickerRate);
set(handles.contrast, 'String', CFG.contrast);
set(handles.backgroundLevel, 'String', CFG.backgroundLevel);
set(handles.refreshRate, 'String', CFG.refreshRate);
set(handles.sineWaveButton, 'Value', CFG.sineWaveButton);
set(handles.squareWaveButton, 'Value', CFG.squareWaveButton);
set(handles.luminanceButton, 'Value', CFG.luminanceButton);
if get(handles.luminanceButton, 'Value')==1	 %turn off maxCheck
    set(handles.maxCheck, 'Value', 0, 'Enable','off');
    set(handles.maxText, 'Visible', 'off');
else
    set(handles.maxCheck, 'Value', CFG.maxCheck, 'Enable', 'on');
    set(handles.maxText, 'Visible', 'on');
end

set(handles.LconeButton, 'Value', CFG.LconeButton);
set(handles.MconeButton, 'Value', CFG.MconeButton);
set(handles.subjectID, 'String', CFG.subjectID);
set(handles.numSweeps, 'String', CFG.numSweeps);
set(handles.sweepDuration, 'String', CFG.sweepDuration);
set(handles.sweepDelay, 'String', CFG.sweepDelay);
set(handles.intersweepDelay, 'String', CFG.intersweepDelay);
set(handles.ttlOutputButton, 'Value', CFG.ttlOutputButton);
set(handles.ttlInputButton, 'Value', CFG.ttlInputButton);
set(handles.fieldSizeDeg, 'String', CFG.fieldSizeDeg);
set(handles.subjectAge, 'String', CFG.subjectAge);
set(handles.pupilSizeMM, 'String', CFG.pupilSizeMM);



function [calFolder, calPopUpList, availableCalTypes] = OLGetCalibrationStructureGUI
% cal = OLGetCalibrationStructureGUI
%
% Interact with user to get the desired one light
% calibration structure.
%
% 4/4/13  dhb, ms  Pulled out of a calling program as separate function.
% 3/3/16  wst      Adapted code in OneLightToolbox for use in this GUI  
global ConfigParams CFG
% First, set the paths in which the calibration files live.
calFolderInfo = what(fullfile(CalDataFolder, 'OneLight'));
calFolder = calFolderInfo.path;

% Get a list of possible calibration types.
calTypes = enumeration('OLCalibrationTypes');

% Figure out the available calibration types.
numAvailCalTypes = 0;
for i = 1:length(calTypes)
    fName = [calFolder, filesep, calTypes(i).CalFileName, '.mat'];
    
    % If the calibration file associated with the calibration type,
    % store it as an available calibration type.
    if exist(fName, 'file')
        numAvailCalTypes = numAvailCalTypes + 1;
        availableCalTypes(numAvailCalTypes) = calTypes(i); %#ok<AGROW>
    end
end

% Throw an error if there are no calibration types
assert(numAvailCalTypes >= 1, 'OLAnalyzeCal:NoAvailableCalTypes', ...
    'No available calibration types.');

% Make a list of the available calibration types.
for i = 1:length(availableCalTypes)
    if i == 1;
        calPopUpList = {availableCalTypes(i).char};
    else
        calPopUpList = [calPopUpList, {availableCalTypes(i).char}]; %#ok<AGROW>
    end
end

function [calDates] = OLGetCalibrationDateGUI
%this subroutine gets the date(s) of the selected Calibration type 

% 4/4/13  dhb, ms  Pulled out of a calling program as separate function.
% 3/3/16  wst      Adapted code in OneLightToolbox for use in this GUI 

global CFG ConfigParams
% If we only have the name of the calibration file, prompt for the version of the calibration data we want.
cal = ConfigParams.availableCalTypes(CFG.calIndex).CalFileName;
if ischar(cal)
    % Get all the calibration data.
    [~, cals] = LoadCalFile(cal);
    
    if length(cals) > 1
        % create list of calibration dates
            for i = 1:length(cals)
                if i == 1;
                    calDates = {cals{i}.describe.date};
                else
                    calDates = [calDates, {cals{i}.describe.date}]; %#ok<AGROW>
                end
            end
    else
        calDates = {cals{1}.describe.date};
    end
    ConfigParams.cals = cals;
end


% --- Executes on button press in maxCheck.
function maxCheck_Callback(hObject, eventdata, handles)
% hObject    handle to maxCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of maxCheck
global CFG ConfigParams
if get(handles.maxCheck, 'Value')==1 && strcmp(get(handles.maxCheck, 'Enable'),'on')==1;
    set(handles.contrast, 'String', 'max');
elseif get(handles.maxCheck, 'Value')==0 && strcmp(get(handles.maxCheck, 'Enable'), 'on')==1;
    set(handles.contrast, 'String', ConfigParams.contrast);
end


function subjectAge_Callback(hObject, eventdata, handles)
% hObject    handle to subjectAge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subjectAge as text
%        str2double(get(hObject,'String')) returns contents of subjectAge as a double


% --- Executes during object creation, after setting all properties.
function subjectAge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subjectAge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fieldSizeDeg_Callback(hObject, eventdata, handles)
% hObject    handle to fieldSizeDeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fieldSizeDeg as text
%        str2double(get(hObject,'String')) returns contents of fieldSizeDeg as a double


% --- Executes during object creation, after setting all properties.
function fieldSizeDeg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fieldSizeDeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pupilSizeMM_Callback(hObject, eventdata, handles)
% hObject    handle to pupilSizeMM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pupilSizeMM as text
%        str2double(get(hObject,'String')) returns contents of pupilSizeMM as a double


% --- Executes during object creation, after setting all properties.
function pupilSizeMM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pupilSizeMM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in spectralModulationPanel.
function spectralModulationPanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in spectralModulationPanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if get(handles.luminanceButton, 'Value')==1
    set(handles.maxCheck, 'Enable', 'off');
    set(handles.maxText, 'Visible', 'off');
else
    set(handles.maxCheck, 'Enable', 'on');
    set(handles.maxText, 'Visible', 'on');
end
