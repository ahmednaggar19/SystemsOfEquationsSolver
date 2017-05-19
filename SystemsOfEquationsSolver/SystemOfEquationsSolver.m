function varargout = SystemOfEquationsSolver(varargin)
% SYSTEMOFEQUATIONSSOLVER M-file for SystemOfEquationsSolver.fig
%      SYSTEMOFEQUATIONSSOLVER, by itself, creates a new SYSTEMOFEQUATIONSSOLVER or raises the existing
%      singleton*.
%
%      H = SYSTEMOFEQUATIONSSOLVER returns the handle to a new SYSTEMOFEQUATIONSSOLVER or the handle to
%      the existing singleton*.
%
%      SYSTEMOFEQUATIONSSOLVER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SYSTEMOFEQUATIONSSOLVER.M with the given input arguments.
%
%      SYSTEMOFEQUATIONSSOLVER('Property','Value',...) creates a new SYSTEMOFEQUATIONSSOLVER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SystemOfEquationsSolver_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SystemOfEquationsSolver_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SystemOfEquationsSolver

% Last Modified by GUIDE v2.5 13-May-2017 12:01:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SystemOfEquationsSolver_OpeningFcn, ...
                   'gui_OutputFcn',  @SystemOfEquationsSolver_OutputFcn, ...
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


% --- Executes just before SystemOfEquationsSolver is made visible.
function SystemOfEquationsSolver_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SystemOfEquationsSolver (see VARARGIN)

% Choose default command line output for SystemOfEquationsSolver
handles.output = hObject;

% Clear the table data
set(handles.solution, 'Data', cell(size(0)));

% Update handles structure
guidata(hObject, handles);
setHandlesStructure(handles, hObject);

function setHandlesStructure(handles, hObject)
handles.numberOfEquations = 0;
handles.equations = zeros(1,20);
handles.results = zeros(1,20);
handles.equalSigns = zeros(1,20);
handles.initialValues = zeros(1,20);
guidata(hObject, handles);

% UIWAIT makes SystemOfEquationsSolver wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SystemOfEquationsSolver_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in addEquation.
function addEquation_Callback(hObject, eventdata, handles)
% hObject    handle to addEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%guidata(hObject, handles);
handles.numberOfEquations = handles.numberOfEquations + 1;
index = handles.numberOfEquations;
contents = get(handles.methods,'String'); 
method = contents{get(handles.methods,'Value')};
checkGaussSeidel = strcmp(method, 'Gauss Seidel');
checkAll = strcmp(method, 'All');
state = 'off';
if (checkGaussSeidel || checkAll)
    state = 'on';
end
handles.equations(index) = uicontrol('Style', 'Edit', 'Position', [50 ,320 - 50*(index - 1),162, 22], 'BackgroundColor','white');
handles.equalSign(index) = uicontrol('Style', 'Text', 'Position', [224 ,320 - 50*(index - 1),52, 15], 'string', '=');
handles.results(index) = uicontrol('Style', 'Edit', 'Position', [300 ,320 - 50*(index - 1),51, 22], 'BackgroundColor','white');
handles.initialValues(index) = uicontrol('Style', 'Edit', 'Position', [360 ,320 - 50*(index - 1),51, 22], 'BackgroundColor','white', 'Visible', state, 'string', '0');
guidata(hObject, handles);

% --- Executes on selection change in methods.
function methods_Callback(hObject, eventdata, handles)
% hObject    handle to methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = get(handles.methods,'String'); 
method = contents{get(handles.methods,'Value')};
checkGaussSeidel = strcmp(method, 'Gauss Seidel');
checkAll = strcmp(method, 'All');
if (checkGaussSeidel || checkAll)
    setGaussSeidelParametersVisibility(handles, 'on');
else
    setGaussSeidelParametersVisibility(handles, 'off');
end;
% Hints: contents = cellstr(get(hObject,'String')) returns methods contents as cell array
%        contents{get(hObject,'Value')} returns selected item from methods

function setGaussSeidelParametersVisibility(handles, state)
set(handles.maxIterationsTag,'Visible',state);
set(handles.maxIterationsValue,'Visible',state);
set(handles.epsilonTag,'Visible',state);
set(handles.epsilonValue,'Visible',state);
equationsSize = handles.numberOfEquations;
for i = 1:equationsSize
    set(handles.initialValues(i), 'Visible', state);
end;

% --- Executes during object creation, after setting all properties.
function methods_CreateFcn(hObject, eventdata, handles)
% hObject    handle to methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in solve.
function solve_Callback(hObject, eventdata, handles)
% hObject    handle to solve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
equationsSize = handles.numberOfEquations;
maxSymVar = Parsers.InputParser.getMaxSymVar(handles, equationsSize);
[A, b] = Parsers.InputParser.getEquationsMatrices(handles, maxSymVar, equationsSize);
chooseProperMethod(handles, A, b, maxSymVar);

function initial = fillInitialValues(handles, A)
     initial = zeros(length(A), 1);
     noOfVariables = handles.numberOfEquations;
     for i = 1:noOfVariables
        initialValueString = get(handles.initialValues(i), 'string');
        initialValue = str2double(initialValueString);
        initial(i) = initialValue;
     end;

function [maxIt,eps] = getGaussSeidelParameters(handles)
    maxItString = get(handles.maxIterationsValue, 'string');
    status = strcmp(maxItString, '');
    if (status)
        maxIt = str2double(maxItString);
    else
        maxIt = 100;
    end
    epsString = get(handles.epsilonValue, 'string');
    [num, status] = str2num(epsString);
    if (status)
        eps = num;
    else
        eps = 0.001;
    end    
    
function chooseProperMethod(handles, A, b, maxSymVar)

    contents = get(handles.methods,'String'); 
    method = contents{get(handles.methods,'Value')};
    tic;
    switch(method)
        case 'Gauss Elimination'
            Methods.Gauss_EliminationPIV.evaluate(A,b,handles,maxSymVar);
        case 'Gauss Jordan'
            Methods.Gauss_Jordan.solve(A,b,handles,maxSymVar);
        case 'LU Decomposition'
            Methods.SLE_LUDecomposition(A,b,handles,maxSymVar);
        case 'Gauss Seidel'
            performGaussSeidel(handles, A, b, maxSymVar);
        case 'All'
           Methods.Gauss_EliminationPIV.evaluate(A,b,handles,maxSymVar);
           Methods.Gauss_Jordan.solve(A,b,handles,maxSymVar);
           Methods.SLE_LUDecomposition(A,b,handles,maxSymVar);
           performGaussSeidel(handles, A, b, maxSymVar);
    end
    executionTime = toc;
    computeExecutionTime(handles, executionTime);
    
function computeExecutionTime(handles, executionTime)
    executionTimeString = strcat('Execution Time : ' ,num2str(executionTime));
    set(handles.executionTime, 'string', executionTimeString); 

    
function performGaussSeidel(handles, A, b, maxSymVar)
    initial = fillInitialValues(handles, A);
    [maxIt,eps] = getGaussSeidelParameters(handles);
    GSSolver = Methods.Gauss_Seidel([A,b], [maxIt;eps], initial);
    answer = GSSolver.GaussSeidel(-10);
    OutputHandler.outputData(handles, answer{3}, maxSymVar, 'Gauss Seidel');
    viewIterationsValues(handles, answer{1}, answer{2},maxSymVar);
    figure('Name', 'Gauss Seidel Performance');
    plot(linspace(1, maxIt, length(answer{1})),answer{1});

function viewIterationsValues(handles, iterationValues, error ,maxSymVar) 
    for i = 1:length(iterationValues) - 1
         OutputHandler.outputIterativeData(handles, iterationValues(1:length(maxSymVar), i), error(1:length(maxSymVar), i),maxSymVar);
     end;

function epsilonValue_Callback(hObject, eventdata, handles)
% hObject    handle to epsilonValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epsilonValue as text
%        str2double(get(hObject,'String')) returns contents of epsilonValue as a double


% --- Executes during object creation, after setting all properties.
function epsilonValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epsilonValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function maxIterationsValue_Callback(hObject, eventdata, handles)
% hObject    handle to maxIterationsTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxIterationsTag as text
%        str2double(get(hObject,'String')) returns contents of maxIterationsTag as a double


% --- Executes during object creation, after setting all properties.
function maxIterationsTag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxIterationsTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function maxIterationsValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxIterationsValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in deleteEquation.
function deleteEquation_Callback(hObject, eventdata, handles)
% hObject    handle to deleteEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lastEquation = handles.numberOfEquations;
if (lastEquation <= 0)
    return;
end;
handles.numberOfEquations = handles.numberOfEquations - 1;
set(handles.equations(lastEquation), 'Visible', 'off');
set(handles.results(lastEquation), 'Visible', 'off');
set(handles.equalSign(lastEquation), 'Visible', 'off');
set(handles.initialValues(lastEquation), 'Visible', 'off');
guidata(hObject, handles);

% --- Executes on button press in loadFile.
function loadFile_Callback(hObject, eventdata, handles)
% hObject    handle to loadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileName = 'input2.txt';
fileID = fopen(fileName, 'r');
        format = '%s';
        methodName = fscanf(fileID, format, [1,1]);
        format = '%d';
        inputSize = fscanf(fileID, format, [1,1]);
        checkGaussSeidel = strcmp(methodName, 'Gauss_Seidel');
        checkAll = strcmp(methodName, 'All');
        for i = 1:inputSize
            format = '%s';
            equation = fscanf(fileID, format, [1,1]);
            format = '%d';
            result = fscanf(fileID, format, [1,1]);
            addEquation_Callback(hObject, eventdata, handles);
            handles = guidata(hObject);
            if (checkGaussSeidel || checkAll)
                format = '%s';
                initialValue = fscanf(fileID, format, [1,1]);
                set(handles.initialValues(i), 'string', initialValue);
            end;
            set(handles.equations(i), 'string', equation);
            set(handles.results(i), 'string',result);
        end;
        if (checkGaussSeidel || checkAll)
            format = '%s';
            epsilon = fscanf(fileID, format, [1,1]);
            maxIt = fscanf(fileID, format, [1,1]);
            set(handles.epsilonValue, 'string', epsilon);
            set(handles.maxIterationsValue, 'string', maxIt);
            setGaussSeidelParametersVisibility(handles, 'on');
        end;
        switch (methodName)
            case 'Gauss_Elimination';
            set(handles.methods, 'Value', 1);
            case 'Gauss_Jordan';
            set(handles.methods, 'Value', 2);
            case 'LU_Decomposition';
            set(handles.methods, 'Value', 3);
            case 'Gauss_Seidel';
            set(handles.methods, 'Value', 4);
            case 'All';
            set(handles.methods, 'Value', 5);
        end;
        fclose(fileID);
