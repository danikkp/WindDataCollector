function varargout = CalibrationGUI(varargin)
% CALIBRATIONGUI MATLAB code for CalibrationGUI.fig
%      CALIBRATIONGUI, by itself, creates a new CALIBRATIONGUI or raises the existing
%      singleton*.
%
%      H = CALIBRATIONGUI returns the handle to a new CALIBRATIONGUI or the handle to
%      the existing singleton*.
%
%      CALIBRATIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALIBRATIONGUI.M with the given input arguments.
%
%      CALIBRATIONGUI('Property','Value',...) creates a new CALIBRATIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CalibrationGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CalibrationGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CalibrationGUI

% Last Modified by GUIDE v2.5 05-Dec-2013 12:37:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @CalibrationGUI_OpeningFcn, ...
    'gui_OutputFcn',  @CalibrationGUI_OutputFcn, ...
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


% --- Executes just before CalibrationGUI is made visible.
function CalibrationGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CalibrationGUI (see VARARGIN)

% Choose default command line output for CalibrationGUI
handles.output = hObject;

%%get video cam
try CamInfo=imaqhwinfo('winvideo');
    SupFormat=CamInfo.DeviceInfo.SupportedFormats(end);
    handles.WebCamObj=videoinput('winvideo',1,SupFormat{1});
    
    %%%%show preview by default
    vRes=handles.WebCamObj.VideoResolution;
    hImage = image(zeros(vRes(2),vRes(1), handles.WebCamObj.NumberOfBands),'Parent',handles.SnapshotPreviewAxes);
    preview(handles.WebCamObj,hImage); axis(handles.SnapshotPreviewAxes,'image');
catch Mexc
    msgbox('Cant find video camera or connection is not supported','Camera connection failed', 'error');
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CalibrationGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CalibrationGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SnapshotBut.
function SnapshotBut_Callback(hObject, eventdata, handles)
% hObject    handle to SnapshotBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


snapshot=getsnapshot(handles.WebCamObj);
image(ycbcr2rgb(snapshot),'Parent',handles.SnapshotPreviewAxes);
axis(handles.SnapshotPreviewAxes,'image');
set(handles.SnapshotPreviewAxes,'visible','off');

set(handles.rectAreaCoords,'String',num2str(zeros(1,4)));
rectArea=getrect(handles.SnapshotPreviewAxes);
set(handles.rectAreaCoords,'String',num2str(rectArea));

set(handles.SaveRectBut,'Enable','on');


% --- Executes on button press in SaveRectBut.
function SaveRectBut_Callback(hObject, eventdata, handles)
% hObject    handle to SaveRectBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rectArea=str2num(get(handles.rectAreaCoords,'String'));
save('Settings','rectArea','-append');
close(CalibrationGUI);


% --- Executes on button press in PreviewBut.
function PreviewBut_Callback(hObject, eventdata, handles)
% hObject    handle to PreviewBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vRes=handles.WebCamObj.VideoResolution;
hImage = image(zeros(vRes(2),vRes(1), handles.WebCamObj.NumberOfBands),'Parent',handles.SnapshotPreviewAxes);
preview(handles.WebCamObj,hImage); axis(handles.SnapshotPreviewAxes,'image');
