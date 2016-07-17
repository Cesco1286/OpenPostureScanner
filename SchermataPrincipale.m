function varargout = SchermataPrincipale(varargin)
% SCHERMATAPRINCIPALE MATLAB code for SchermataPrincipale.fig
%      SCHERMATAPRINCIPALE, by itself, creates a new SCHERMATAPRINCIPALE or raises the existing
%      singleton*.
%
%      H = SCHERMATAPRINCIPALE returns the handle to a new SCHERMATAPRINCIPALE or the handle to
%      the existing singleton*.
%
%      SCHERMATAPRINCIPALE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCHERMATAPRINCIPALE.M with the given input arguments.
%
%      SCHERMATAPRINCIPALE('Property','Value',...) creates a new SCHERMATAPRINCIPALE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SchermataPrincipale_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SchermataPrincipale_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SchermataPrincipale

% Last Modified by GUIDE v2.5 12-Jul-2016 22:53:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SchermataPrincipale_OpeningFcn, ...
                   'gui_OutputFcn',  @SchermataPrincipale_OutputFcn, ...
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


% --- Executes just before SchermataPrincipale is made visible.
function SchermataPrincipale_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SchermataPrincipale (see VARARGIN)

% Choose default command line output for SchermataPrincipale
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SchermataPrincipale wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SchermataPrincipale_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushb
function ImpostaParametri_Callback(hObject, eventdata, handles)
% hObject    handle to ImpostaParametri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImpostaParametri();



% --- Executes on button press in ImpostaKinect.
function ImpostaKinect_Callback(hObject, eventdata, handles)
% hObject    handle to ImpostaKinect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
KinectConfigUi();


% --- Executes on button press in ImpostaBB.
function ImpostaBB_Callback(hObject, eventdata, handles)
% hObject    handle to ImpostaBB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%controller acquisisci
controller = Controller.getInstance;
I = controller.acquisisci();
%I = imread('prova.jpg');
axes(handles.axes2);
imshow(I);

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% in questa funzione ci sarà il comando 'imshow' che dovrà mostrare
% l'immagine di output
% Hint: place code in OpeningFcn to populate axes2

