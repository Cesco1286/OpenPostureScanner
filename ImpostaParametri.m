function varargout = ImpostaParametri(varargin)
% IMPOSTAPARAMETRI MATLAB code for ImpostaParametri.fig
%      IMPOSTAPARAMETRI, by itself, creates a new IMPOSTAPARAMETRI or raises the existing
%      singleton*.
%
%      H = IMPOSTAPARAMETRI returns the handle to a new IMPOSTAPARAMETRI or the handle to
%      the existing singleton*.
%
%      IMPOSTAPARAMETRI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPOSTAPARAMETRI.M with the given input arguments.
%
%      IMPOSTAPARAMETRI('Property','Value',...) creates a new IMPOSTAPARAMETRI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImpostaParametri_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImpostaParametri_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImpostaParametri

% Last Modified by GUIDE v2.5 13-Jul-2016 22:50:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImpostaParametri_OpeningFcn, ...
                   'gui_OutputFcn',  @ImpostaParametri_OutputFcn, ...
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

% --- Executes just before ImpostaParametri is made visible.
function ImpostaParametri_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImpostaParametri (see VARARGIN)

% Choose default command line output for ImpostaParametri
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes ImpostaParametri wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImpostaParametri_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function SchienaSp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SchienaSp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SchienaSp_Callback(hObject, eventdata, handles)
% hObject    handle to SchienaSp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SchienaSp as text
%        str2double(get(hObject,'String')) returns contents of SchienaSp as a double
SchiSpa = str2double(get(hObject, 'String'));
if isnan(SchiSpa)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new SchienaSp value
handles.metricdata.SchiSpa = SchiSpa;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of volume as text
%        str2double(get(hObject,'String')) returns contents of volume as a double
volume = str2double(get(hObject, 'String'));
if isnan(volume)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.metricdata.volume = volume;
guidata(hObject,handles)

% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mass = handles.metricdata.density * handles.metricdata.volume;
set(handles.mass, 'String', mass);

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

initialize_gui(gcbf, handles, true);

% --- Executes when selected object changed in unitgroup.
function unitgroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in unitgroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (hObject == handles.english)
    set(handles.text4, 'String', 'lb/cu.in');
    set(handles.text5, 'String', 'cu.in');
    set(handles.text6, 'String', 'lb');
else
    set(handles.text4, 'String', 'kg/cu.m');
    set(handles.text5, 'String', 'cu.m');
    set(handles.text6, 'String', 'kg');
end

% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end

handles.metricdata.SchiSpa = 0;
handles.metricdata.Schi = 0;
handles.metricdata.BacSchi = 0;
handles.metricdata.DiffFia = 0;
handles.metricdata.DiffGin = 0;

set(handles.SchienaSp, 'String', handles.metricdata.SchiSpa);
set(handles.SchienaText, 'String', handles.metricdata.Schi);
set(handles.BacSchText, 'String', handles.metricdata.BacSchi);
set(handles.JointFianchiText, 'String', handles.metricdata.DiffFia);
set(handles.JointGinocchiaText, 'String', handles.metricdata.DiffGin);






% Update handles structure
guidata(handles.figure1, handles);



function SchienaText_Callback(hObject, eventdata, handles)
% hObject    handle to SchienaText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SchienaText as text
%        str2double(get(hObject,'String')) returns contents of SchienaText as a double
Schi = str2double(get(hObject, 'String'));
if isnan(Schi)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new Schi value
handles.metricdata.Schi = Schi;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function SchienaText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SchienaText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BacSchText_Callback(hObject, eventdata, handles)
% hObject    handle to BacSchText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BacSchText as text
%        str2double(get(hObject,'String')) returns contents of BacSchText as a double
BacSchi = str2double(get(hObject, 'String'));
if isnan(BacSchi)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new BacSchi value
handles.metricdata.BacSchi = BacSchi;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function BacSchText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BacSchText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function JointFianchiText_Callback(hObject, eventdata, handles)
% hObject    handle to JointFianchiText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of JointFianchiText as text
%        str2double(get(hObject,'String')) returns contents of JointFianchiText as a double
DiffFia = str2double(get(hObject, 'String'));
if isnan(DiffFia)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new diffFia value
handles.metricdata.DiffFia = DiffFia;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function JointFianchiText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to JointFianchiText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function JointGinocchiaText_Callback(hObject, eventdata, handles)
% hObject    handle to JointGinocchiaText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of JointGinocchiaText as text
%        str2double(get(hObject,'String')) returns contents of JointGinocchiaText as a double
DiffGin = str2double(get(hObject, 'String'));
if isnan(DiffGin)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new DiffGin value
handles.metricdata.DiffGin = DiffGin;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function JointGinocchiaText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to JointGinocchiaText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonConfirm.
function pushbuttonConfirm_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonConfirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
parametri(1) = handles.metricdata.SchiSpa;
parametri(2) = handles.metricdata.Schi;
parametri(3) = handles.metricdata.BacSchi;
parametri(4) = handles.metricdata.DiffFia;
parametri(5)  = handles.metricdata.DiffGin;
params = ParametriUtente(parametri);
controller = Controller.getInstance();
controller.setParametriUtente(params);

