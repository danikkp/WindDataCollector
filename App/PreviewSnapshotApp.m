function varargout = PreviewSnapshotApp(varargin)
% PREVIEWSNAPSHOTAPP MATLAB code for PreviewSnapshotApp.fig
%      PREVIEWSNAPSHOTAPP, by itself, creates a new PREVIEWSNAPSHOTAPP or raises the existing
%      singleton*.
%
%      H = PREVIEWSNAPSHOTAPP returns the handle to a new PREVIEWSNAPSHOTAPP or the handle to
%      the existing singleton*.
%
%      PREVIEWSNAPSHOTAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PREVIEWSNAPSHOTAPP.M with the given input arguments.
%
%      PREVIEWSNAPSHOTAPP('Property','Value',...) creates a new PREVIEWSNAPSHOTAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PreviewSnapshotApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PreviewSnapshotApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PreviewSnapshotApp

% Last Modified by GUIDE v2.5 01-Dec-2013 17:04:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @PreviewSnapshotApp_OpeningFcn, ...
    'gui_OutputFcn',  @PreviewSnapshotApp_OutputFcn, ...
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


% --- Executes just before PreviewSnapshotApp is made visible.
function PreviewSnapshotApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PreviewSnapshotApp (see VARARGIN)

% Choose default command line output for PreviewSnapshotApp
handles.output = hObject;

%%%get video cam
% try CamInfo=imaqhwinfo('winvideo');
%     SupFormat=CamInfo.DeviceInfo.SupportedFormats(end);
%     handles.WebCamObj=videoinput('winvideo',1,SupFormat{1});
% catch Mexc
%     msgbox('Cant find video camera or connection is not supported','Camera connection failed', 'error');
% end


%%%load Settings file
status='stopped';
set(handles.status,'String',status);

try handles.Settings=load('Settings.mat');
    if (exist(handles.Settings.SaveDir))
        set(handles.SaveDir,'String',handles.Settings.SaveDir);
    end
catch Mexc
    messageBox=msgbox(strcat('Cant find Settings file or some of its parameters. Probably it has been deleted. Now a new copy will be created. ',...
        'Matlab message: ', Mexc.message),'Initialization problem','warn');
    uiwait(messageBox);
    %%    handles.Settings=load('Settings.mat');
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PreviewSnapshotApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PreviewSnapshotApp_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in PreviewBut.
function PreviewBut_Callback(hObject, eventdata, handles)
% hObject    handle to PreviewBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
preview(handles.WebCamObj);




% --- Executes on button press in SnapshotBut.
function SnapshotBut_Callback(hObject, eventdata, handles)
% hObject    handle to SnapshotBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
snapshot=getsnapshot(handles.WebCamObj);

image(ycbcr2rgb(snapshot),'Parent',handles.LastCapture);
set(handles.LastCapture,'visible','off');
figure(2);image(ycbcr2rgb(snapshot));




function SaveDir_Callback(hObject, eventdata, handles)
% hObject    handle to SaveDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SaveDir as text
%        str2double(get(hObject,'String')) returns contents of SaveDir as a double



% --- Executes during object creation, after setting all properties.
function SaveDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SaveDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BrowseBut.
function BrowseBut_Callback(hObject, eventdata, handles)
% hObject    handle to BrowseBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SaveDir=uigetdir('','Select folder to store measurements');

if (SaveDir~=0)
    save('Settings','SaveDir','-append');
    set(handles.SaveDir,'String',SaveDir);
end


% --- Executes on button press in OverallView.
function OverallView_Callback(hObject, eventdata, handles)
% hObject    handle to OverallView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in SyncView.
function SyncView_Callback(hObject, eventdata, handles)
% hObject    handle to SyncView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RunStopBut.
function RunStopBut_Callback(hObject, eventdata, handles)
% hObject    handle to RunStopBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA

%%%%%%%%Settings=load('Settings.mat');
status=get(handles.status,'String'); %%Settings.status;


if (strcmp(status,'stopped'))
    status='running';
    set(handles.status,'String',status); %%save('Settings','status','-append');
    set(handles.RunStopBut,'backgroundcolor','red','String','STOP');
    
    counter=1;
    while (strcmp(get(handles.status,'String'),'running'))
        %%%run the programm for recognition and collection of data
        set(handles.test,'String',int2str(counter));
        pause(1);
        counter=counter+1;
    end
    
else
    if (strcmp(status,'running'))
        status='stopped';
        set(handles.status,'String',status); %%save('Settings','status','-append');
        set(handles.RunStopBut,'backgroundcolor','green','String','RUN');
        
        %%%%stop the programm run
        return;
    end
end
