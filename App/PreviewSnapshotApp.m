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

% Last Modified by GUIDE v2.5 08-Dec-2013 00:49:38

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

%%get video cam
try CamInfo=imaqhwinfo('winvideo');
    SupFormat=CamInfo.DeviceInfo.SupportedFormats(end);
    handles.WebCamObj=videoinput('winvideo',1,SupFormat{1});
catch Mexc
    msgbox('Cant find video camera or connection is not supported','Camera connection failed', 'error');
end


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
    %%%    handles.Settings=load('Settings.mat');
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
axis(handles.LastCapture,'image');
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
set(handles.plotType,'String','Overall');


% --- Executes on button press in SyncView.
function SyncView_Callback(hObject, eventdata, handles)
% hObject    handle to SyncView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.plotType,'String','Synchronized');


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
    
    %%%make all buttons and field unavailable to push
    set(handles.SaveDir,'Enable','off');
    set(handles.BrowseBut,'Enable','off');
    set(handles.CalibBut,'Enable','off');
    %set(handles.,'Enable','off');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    load sunspot.dat %%%%used for example of data to plot
    counter=1;
    
    lag=50;
    len=length(sunspot(:,1));
    sunspotMod=rand(length(sunspot(:,1)),length(sunspot(1,:))).*sunspot;
    
    while (strcmp(get(handles.status,'String'),'running'))
        %%%run the programm for recognition and collection of data
        %%%%%output the numbers to store
        
        
        %%%%%%%%%%%show snaphot
        snapshot=getsnapshot(handles.WebCamObj);
        image(ycbcr2rgb(snapshot),'Parent',handles.LastCapture);
        axis(handles.LastCapture,'image');
        set(handles.LastCapture,'visible','off');
        
        %%%%now runs test plots
        set(handles.test,'String',int2str(counter));
        pause(1);
        counter=counter+1;
        
        %%%%print output data on graphes and make screenshot and show it in
        %%%%LastSnapshot axes
        %sunspotMod=rand(length(sunspot(:,1)),length(sunspot(1,:))).*sunspot;
        sunspotMod=[sunspotMod; rand(1,length(sunspot(1,:))).*sunspot(int8(len*rand(1)),end)];
        oon=1:length(sunspotMod(:,1)); oon=oon';
        %subplot(handles.LastPlots);
        %figure(2);%'name','Last plots');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%choose the the plotting type according to pushed button
        if (strcmp(get(handles.plotType,'String'),'Overall'))
            subp=subplot(2,2,1,'Parent',handles.axesPanel);
            plot(subp,oon,sunspotMod(:,2));
            ylabel('Wind speed, m/s')
            xlim([oon(end-lag) oon(end)]);
            subp=subplot(2,2,2,'Parent',handles.axesPanel);
            rose(subp,sunspotMod(:,2),16);
            title('Wind rose');
            subp=subplot(2,2,3:4,'Parent',handles.axesPanel);
            plot(subp,oon,sunspotMod(:,2));
            xlim([oon(end-lag) oon(end)]); ylabel('Rotational speed, rps');
        end
        if (strcmp(get(handles.plotType,'String'),'Synchronized'))
            subp=subplot(3,1,1,'Parent',handles.axesPanel);
            plot(subp,oon,sunspotMod(:,2));ylabel('Wind speed, m/s')
            xlim([oon(end-lag) oon(end)]); set(gca,'XTickLabel',[]);
            subp=subplot(3,1,2,'Parent',handles.axesPanel);
            plot(subp,oon,sunspotMod(:,2)); ylabel('Wind rose');
            xlim([oon(end-lag) oon(end)]); set(gca,'XTickLabel',[]);
            subp=subplot(3,1,3,'Parent',handles.axesPanel);
            plot(subp,oon,sunspotMod(:,1)); ylabel('Rotational speed, rps');
            xlim([oon(end-lag) oon(end)]);
        end
        
        %%%%save the data
        
    end
    
else
    if (strcmp(status,'running'))
        status='stopped';
        set(handles.status,'String',status); %%save('Settings','status','-append');
        set(handles.RunStopBut,'backgroundcolor','green','String','RUN');
        
        %%%%stop the programm run
        
        
        %%%make all buttons and field available to push
        set(handles.SaveDir,'Enable','on');
        set(handles.BrowseBut,'Enable','on');
        set(handles.CalibBut,'Enable','on');
        %set(handles.,'Enable','off');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        return;
    end
end


% --- Executes on button press in CalibBut.
function CalibBut_Callback(hObject, eventdata, handles)
% hObject    handle to CalibBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%open Calibration window
CalibrationGUIInstance = CalibrationGUI();
uiwait(CalibrationGUIInstance);



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
contents = cellstr(get(hObject,'String'));
set(handles.plotLagTime,'String',contents{get(hObject,'Value')});



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
