classdef FileReader
    properties
    end
    
    methods (Static)
        function handles = readInputFile(handles, fileName, hObject, eventdata)
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
            SystemOfEquationsSolver.addEquation_Callback(hObject, eventdata, handles);
            handles = guidata(hObject);
            if (checkGaussSeidel || checkAll)
                format = '%s';
                initialValue = fscanf(fileID, format, [1,1]);
                set(handles.initialValues(i), 'string', initialValue);
            end;
            set(handles.equations(i), 'string', equation);
            set(handles.results(i), 'string',result);
            fprintf('%s %d %s\n', equation, result);
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
        end
end
end