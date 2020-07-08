function varargout = demoProgram(varargin)
% DEMOPROGRAM MATLAB code for demoProgram.fig
%      DEMOPROGRAM, by itself, creates a new DEMOPROGRAM or raises the existing
%      singleton*.
%
%      H = DEMOPROGRAM returns the handle to a new DEMOPROGRAM or the handle to
%      the existing singleton*.
%
%      DEMOPROGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMOPROGRAM.M with the given input arguments.
%
%      DEMOPROGRAM('Property','Value',...) creates a new DEMOPROGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before demoProgram_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to demoProgram_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help demoProgram

% Last Modified by GUIDE v2.5 08-Jul-2020 21:21:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @demoProgram_OpeningFcn, ...
                   'gui_OutputFcn',  @demoProgram_OutputFcn, ...
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


% --- Executes just before demoProgram is made visible.
function demoProgram_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to demoProgram (see VARARGIN)

% Choose default command line output for demoProgram
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes demoProgram wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = demoProgram_OutputFcn(hObject, eventdata, handles) 
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
[file,path] = uigetfile({'*.jpg';'*.jpeg';'*.png';'*.gif'}, 'File Selector');
image_file = strjoin({path,file}, '');
x = imread(image_file);
x = rgb2gray(x);
handles.x = x;
guidata(hObject, handles);
axes(handles.axes1)
imshow(x);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value_tran = get(handles.popupmenu4, 'value');
value_ptype = get(handles.popupmenu1, 'value');
value_wtype = get(handles.popupmenu5, 'value');
y = ones(256,256)*255;
if value_tran == 2
    switch value_ptype
        case 2 %am ban
            y = am_ban(handles.x);
        case 3 %bien doi su dung ham log
            value_c = get(handles.edit1, 'string');
            value_c = str2double(value_c);
            y = log_change(handles.x,value_c);
        case 4 %bien doi su dung luy thua
            value_c = str2double(get(handles.edit1, 'string'));
            value_epsilon = str2double(get(handles.edit2, 'string'));
            value_gammar = str2double(get(handles.edit3, 'string'));
            y = exp_change(handles.x, value_c , value_epsilon, value_gammar);
        case 5 %bien doi su dung tuyen tinh tung khuc
            value_slow = uint8(str2double(get(handles.edit5, 'string')));
            value_shigh = uint8(str2double(get(handles.edit6, 'string')));
            value_rlow = uint8(str2double(get(handles.edit7, 'string')));
            value_rhigh = uint8(str2double(get(handles.edit8, 'string')));
            y = tuyen_tinh_tung_khuc(handles.x, value_rlow, value_slow, value_rhigh, value_shigh);
        case 6 %bien doi su dung can bang histogram
            y = histeq(handles.x);
        case 7 %bien doi dua vao cap xam
            value_background = get(handles.popupmenu3, 'value');
            if value_background == 2
                type_background = 'no_background';
            else
                type_background = 'background';
            end
            value_slow = str2double(get(handles.edit5, 'string'));
            value_shigh = str2double(get(handles.edit6, 'string'));
            value_rlow = str2double(get(handles.edit7, 'string'));
            value_rhigh = str2double(get(handles.edit8, 'string'));
            y = level_change(handles.x,type_background,value_slow, value_shigh, value_rlow, value_rhigh);
        case 8
            value_plane = (get(handles.popupmenu6, 'value')) -2
            y = bit_plane(handles.x, value_plane);
        otherwise
            y = ones(256,256)*255;
    end
elseif value_tran == 3
    switch value_wtype
        case 2
            windown_type = 'laplacian';
        case 3
            windown_type = 'average';
        case 4
            windown_type = 'gaussian';
        case 5
            windown_type = 'log';
        case 6
            windown_type = 'median';
        case 7
            windown_type = 'sobelx';
        case 8
            windown_type = 'sobely';
        otherwise
            windown_type = 'laplacian';
    end
    layer_size = str2double(get(handles.edit9, 'string'));
    sigma = str2double(get(handles.edit10, 'string'));
    alpha = str2double(get(handles.edit11, 'string'));
    [y, filter] = space_processing(handles.x, layer_size, windown_type, sigma, alpha);  
    if value_wtype ~= 6 & value_wtype ~= 1
        set(handles.uitable1, 'data', filter);
        set(handles.uipanel4, 'visible', 'on');
        set(handles.uitable1, 'visible', 'on');
    else
        set(handles.uipanel4, 'visible', 'off');
        set(handles.uitable1, 'visible', 'off');
    end
end
if value_tran ~= 3
    set(handles.uipanel4, 'visible', 'off');
    set(handles.uitable1, 'visible', 'off');
end
axes(handles.axes2)
imshow(y);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
value = get(hObject, 'value');
if value==4
    set(handles.uipanel6, 'visible', 'on');
    set(handles.text6, 'visible', 'on');
    set(handles.text8, 'visible', 'on');
    set(handles.text7, 'visible', 'on');
    set(handles.edit1, 'visible', 'on');
    set(handles.edit2, 'visible', 'on');
    set(handles.edit3, 'visible', 'on');
    set(handles.text18, 'visible', 'off');
    set(handles.popupmenu6, 'visible', 'off');
else
    set(handles.uipanel6, 'visible', 'off');
    set(handles.text6, 'visible', 'off');
    set(handles.text8, 'visible', 'off');
    set(handles.text7, 'visible', 'off');
    set(handles.edit1, 'visible', 'off');
    set(handles.edit2, 'visible', 'off');
    set(handles.edit3, 'visible', 'off');
    if value == 8
        set(handles.uipanel6, 'visible', 'on');
        set(handles.text18, 'visible', 'on');
        set(handles.popupmenu6, 'visible', 'on');
    else
        if value == 3
            set(handles.uipanel6, 'visible', 'on');
            set(handles.text6, 'visible', 'on');
            set(handles.edit1, 'visible', 'on');
        else
            set(handles.uipanel6, 'visible', 'off');
            set(handles.text18, 'visible', 'off');
            set(handles.popupmenu6, 'visible', 'off');
            set(handles.text6, 'visible', 'off');
            set(handles.edit1, 'visible', 'off');
        end
    end
end
if value == 5
    set(handles.uipanel7, 'visible', 'on');
    set(handles.text9, 'visible', 'off');
    set(handles.popupmenu3, 'visible', 'off');
    set(handles.text10, 'visible', 'on');
    set(handles.text11, 'visible', 'on');
    set(handles.text12, 'visible', 'on');
    set(handles.text13, 'visible', 'on');
    set(handles.edit5, 'visible', 'on');
    set(handles.edit6, 'visible', 'on');
    set(handles.edit7, 'visible', 'on');
    set(handles.edit8, 'visible', 'on');
elseif value == 7
    set(handles.uipanel7, 'visible', 'on');
    set(handles.text9, 'visible', 'on');
    set(handles.popupmenu3, 'visible', 'on');
    set(handles.text10, 'visible', 'on');
    set(handles.text11, 'visible', 'on');
    set(handles.text12, 'visible', 'on');
    set(handles.text13, 'visible', 'on');
    set(handles.edit5, 'visible', 'on');
    set(handles.edit6, 'visible', 'on');
    set(handles.edit7, 'visible', 'on');
    set(handles.edit8, 'visible', 'on');
else
    set(handles.uipanel7, 'visible', 'off');
    set(handles.text9, 'visible', 'off');
    set(handles.popupmenu3, 'visible', 'off');
    set(handles.text10, 'visible', 'off');
    set(handles.text11, 'visible', 'off');
    set(handles.text12, 'visible', 'off');
    set(handles.text13, 'visible', 'off');
    set(handles.edit5, 'visible', 'off');
    set(handles.edit6, 'visible', 'off');
    set(handles.edit7, 'visible', 'off');
    set(handles.edit8, 'visible', 'off');
end
    
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


% --- Executes on selection change in popupmenu1.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
value = get(hObject, 'value');
if value == 3
    set(handles.uipanel6, 'visible', 'off');
    set(handles.text6, 'visible', 'off');
    set(handles.text8, 'visible', 'off');
    set(handles.text7, 'visible', 'off');
    set(handles.edit1, 'visible', 'off');
    set(handles.edit2, 'visible', 'off');
    set(handles.edit3, 'visible', 'off');
    set(handles.uipanel7, 'visible', 'off');
    set(handles.text9, 'visible', 'off');
    set(handles.popupmenu3, 'visible', 'off');
    set(handles.text10, 'visible', 'off');
    set(handles.text11, 'visible', 'off');
    set(handles.text12, 'visible', 'off');
    set(handles.text13, 'visible', 'off');
    set(handles.edit5, 'visible', 'off');
    set(handles.edit6, 'visible', 'off');
    set(handles.edit7, 'visible', 'off');
    set(handles.edit8, 'visible', 'off');
    set(handles.text5, 'visible', 'off');
    set(handles.popupmenu1,'visible', 'off');
    set(handles.text17, 'visible', 'on');
    set(handles.popupmenu5,'visible', 'on');
elseif value == 2
    set(handles.text5, 'visible', 'on');
    set(handles.popupmenu1,'visible', 'on');
    set(handles.text17, 'visible', 'off');
    set(handles.popupmenu5,'visible', 'off');
else
    set(handles.uipanel6, 'visible', 'off');
    set(handles.text6, 'visible', 'off');
    set(handles.text8, 'visible', 'off');
    set(handles.text7, 'visible', 'off');
    set(handles.edit1, 'visible', 'off');
    set(handles.edit2, 'visible', 'off');
    set(handles.edit3, 'visible', 'off');
    set(handles.uipanel7, 'visible', 'off');
    set(handles.text9, 'visible', 'off');
    set(handles.popupmenu3, 'visible', 'off');
    set(handles.text10, 'visible', 'off');
    set(handles.text11, 'visible', 'off');
    set(handles.text12, 'visible', 'off');
    set(handles.text13, 'visible', 'off');
    set(handles.edit5, 'visible', 'off');
    set(handles.edit6, 'visible', 'off');
    set(handles.edit7, 'visible', 'off');
    set(handles.edit8, 'visible', 'off');
    set(handles.text5, 'visible', 'off');
    set(handles.popupmenu1,'visible', 'off');
    set(handles.text17, 'visible', 'off');
    set(handles.popupmenu5,'visible', 'off');
end

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5
value = get(hObject, 'value');

if value == 2
    set(handles.uipanel8,'visible','on');
    set(handles.text21,'visible','on');
    set(handles.edit11,'visible','on');
    set(handles.text19,'visible','off');
    set(handles.edit9,'visible','off');
    set(handles.text20,'visible','off');
    set(handles.edit10,'visible','off');
elseif value == 4 | value == 5
    set(handles.uipanel8,'visible','on');
    set(handles.text21,'visible','off');
    set(handles.edit11,'visible','off');
    set(handles.text19,'visible','on');
    set(handles.edit9,'visible','on');
    set(handles.text20,'visible','on');
    set(handles.edit10,'visible','on');
elseif value == 3 | value == 6
    set(handles.uipanel8,'visible','on');
    set(handles.text19,'visible','on');
    set(handles.edit9,'visible','on');
    set(handles.text20,'visible','off');
    set(handles.edit10,'visible','off');
    set(handles.text21,'visible','off');
    set(handles.edit11,'visible','off');
else
    set(handles.uipanel8,'visible','off');
    set(handles.text19,'visible','off');
    set(handles.edit9,'visible','off');
    set(handles.text20,'visible','off');
    set(handles.edit10,'visible','off');
    set(handles.text21,'visible','off');
    set(handles.edit11,'visible','off');
end

% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text22.
function text22_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function text16_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to text16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
