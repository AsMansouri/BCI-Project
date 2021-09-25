function varargout = TrialsCombiner(varargin)
% TRIALSCOMBINER MATLAB code for TrialsCombiner.fig
%      TRIALSCOMBINER, by itself, creates a new TRIALSCOMBINER or raises the existing
%      singleton*.
%
%      H = TRIALSCOMBINER returns the handle to a new TRIALSCOMBINER or the handle to
%      the existing singleton*.
%
%      TRIALSCOMBINER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRIALSCOMBINER.M with the given input arguments.
%
%      TRIALSCOMBINER('Property','Value',...) creates a new TRIALSCOMBINER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TrialsCombiner_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TrialsCombiner_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TrialsCombiner

% Last Modified by GUIDE v2.5 08-Oct-2020 21:18:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrialsCombiner_OpeningFcn, ...
                   'gui_OutputFcn',  @TrialsCombiner_OutputFcn, ...
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


% --- Executes just before TrialsCombiner is made visible.
function TrialsCombiner_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TrialsCombiner (see VARARGIN)

% Choose default command line output for TrialsCombiner
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TrialsCombiner wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TrialsCombiner_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileNames, PathNames] = uigetfile('Multiselect', 'on','*.dat', 'Select trials');
set(handles.listbox1,'String',FileNames);
files = struct('name',strcat(PathNames,FileNames));

handles.InputFiles = files;
guidata(hObject, handles);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath('mex\')
[FileName, Folder] = uiputfile('*.dat', 'Save as');
[signal, states, parameters,total_samples] = load_bcidat(handles.InputFiles.name);
set(handles.text4,'String',num2str(total_samples));
save_bcidat(strcat(Folder,FileName), signal, states, parameters);




% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
