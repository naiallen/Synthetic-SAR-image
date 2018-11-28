function varargout = SARsimulator(varargin)
% SARSIMULATOR MATLAB code for SARsimulator.fig
%      SARSIMULATOR, by itself, creates a new SARSIMULATOR or raises the existing
%      singleton*.
%
%      H = SARSIMULATOR returns the handle to a new SARSIMULATOR or the handle to
%      the existing singleton*.
%
%      SARSIMULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SARSIMULATOR.M with the given input arguments.
%
%      SARSIMULATOR('Property','Value',...) creates a new SARSIMULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SARsimulator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SARsimulator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SARsimulator

% Last Modified by GUIDE v2.5 21-Oct-2018 15:16:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SARsimulator_OpeningFcn, ...
                   'gui_OutputFcn',  @SARsimulator_OutputFcn, ...
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


% --- Executes just before SARsimulator is made visible.
function SARsimulator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SARsimulator (see VARARGIN)

% Choose default command line output for SARsimulator
handles.output = hObject;
% axis(handles.imageHH, 'off');
% axis(handles.imageHV, 'off');
% axis(handles.imageVV, 'off');

% Update handles structure
guidata(hObject, handles);

common



% UIWAIT makes SARsimulator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SARsimulator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function sliderAzi_Callback(hObject, eventdata, handles)
% hObject    handle to sliderAzi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
common


% --- Executes during object creation, after setting all properties.
function sliderAzi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderAzi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbuttonSimulate.
function pushbuttonSimulate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSimulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
common
simular


function editNumRange_Callback(hObject, eventdata, handles)
% hObject    handle to editNumRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNumRange as text
%        str2double(get(hObject,'String')) returns contents of editNumRange as a double


% --- Executes during object creation, after setting all properties.
function editNumRange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNumRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editNumAzi_Callback(hObject, eventdata, handles)
% hObject    handle to editNumAzi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNumAzi as text
%        str2double(get(hObject,'String')) returns contents of editNumAzi as a double
common


% --- Executes during object creation, after setting all properties.
function editNumAzi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNumAzi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editHplat_Callback(hObject, eventdata, handles)
% hObject    handle to editHplat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editHplat as text
%        str2double(get(hObject,'String')) returns contents of editHplat as a double
common


% --- Executes during object creation, after setting all properties.
function editHplat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editHplat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAngIncid_Callback(hObject, eventdata, handles)
% hObject    handle to editAngIncid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAngIncid as text
%        str2double(get(hObject,'String')) returns contents of editAngIncid as a double
common

% --- Executes during object creation, after setting all properties.
function editAngIncid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAngIncid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editLantenna_Callback(hObject, eventdata, handles)
% hObject    handle to editLantenna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLantenna as text
%        str2double(get(hObject,'String')) returns contents of editLantenna as a double
common


% --- Executes during object creation, after setting all properties.
function editLantenna_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLantenna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFcarrier_Callback(hObject, eventdata, handles)
% hObject    handle to editFcarrier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFcarrier as text
%        str2double(get(hObject,'String')) returns contents of editFcarrier as a double
common


% --- Executes during object creation, after setting all properties.
function editFcarrier_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFcarrier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBW_Callback(hObject, eventdata, handles)
% hObject    handle to editBW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBW as text
%        str2double(get(hObject,'String')) returns contents of editBW as a double
common


% --- Executes during object creation, after setting all properties.
function editBW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVplat_Callback(hObject, eventdata, handles)
% hObject    handle to editVplat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVplat as text
%        str2double(get(hObject,'String')) returns contents of editVplat as a double
common

% --- Executes during object creation, after setting all properties.
function editVplat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVplat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkboxRCSmuitoalto.
function checkboxRCSmuitoalto_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxRCSmuitoalto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxRCSmuitoalto


% --- Executes on button press in checkboxAreaUrbana.
function checkboxAreaUrbana_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxAreaUrbana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxAreaUrbana


% --- Executes on button press in checkboxLago.
function checkboxLago_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxLago (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxLago


% --- Executes on button press in checkboxRSCalto.
function checkboxRSCalto_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxRSCalto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxRSCalto


% --- Executes on button press in checkboxRSCmoderado.
function checkboxRSCmoderado_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxRSCmoderado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxRSCmoderado


% --- Executes on button press in checkboxRSCbaixo.
function checkboxRSCbaixo_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxRSCbaixo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxRSCbaixo


% --- Executes on button press in pushbuttonGerarImg.
function pushbuttonGerarImg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonGerarImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
common
