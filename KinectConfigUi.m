function varargout = KinectConfigUi(varargin)
% KINECTCONFIGUI MATLAB code for KinectConfigUi.fig
%      KINECTCONFIGUI, by itself, creates a new KINECTCONFIGUI or raises the existing
%      singleton*.
%
%      H = KINECTCONFIGUI returns the handle to a new KINECTCONFIGUI or the handle to
%      the existing singleton*.
%
%      KINECTCONFIGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KINECTCONFIGUI.M with the given input arguments.
%
%      KINECTCONFIGUI('Property','Value',...) creates a new KINECTCONFIGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KinectConfigUi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KinectConfigUi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KinectConfigUi

% Last Modified by GUIDE v2.5 14-Jul-2016 19:45:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KinectConfigUi_OpeningFcn, ...
                   'gui_OutputFcn',  @KinectConfigUi_OutputFcn, ...
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


% --- Executes just before KinectConfigUi is made visible.
function KinectConfigUi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KinectConfigUi (see VARARGIN)

% Choose default command line output for KinectConfigUi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KinectConfigUi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KinectConfigUi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;






% --- Executes on button press in buttonStartPreview.
function buttonStartPreview_Callback(hObject, eventdata, handles)
% hObject    handle to buttonStartPreview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
controller= Controller.getInstance(); % prendiamo l'istanza del controller
controller.startKinectPreview(); 

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in Plusbutton.
function Plusbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Plusbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
controller = Controller.getInstance();
angle = 1;
controller.setKinectAngle(angle);


% --- Executes on button press in Minusbutton.
function Minusbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Minusbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
controller = Controller.getInstance();
angle = -1;
controller.setKinectAngle(angle);
