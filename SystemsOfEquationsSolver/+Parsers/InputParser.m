classdef InputParser
    properties
    end
    
    methods (Static)
        function [A,b] = getEquationsMatrices(handles, maxSymVar, equationsSize)
            A = [];
            b = [];
            for i = 1:equationsSize
                equation = get(handles.equations(i),'string');
                result = get(handles.results(i), 'string');
                symbolicEquation = sym(equation);
                resultValue = str2double(result);
                a = equationToMatrix(symbolicEquation, maxSymVar);
                A = [A;a];
                b = [b; resultValue];
            end;
        end

        function maxSymVar = getMaxSymVar(handles, equationsSize)
            maxSymVar = [];
            for i = 1:equationsSize
                equation = get(handles.equations(i),'string');
                symbolicEquation = sym(equation);
                curSymVar = symvar(symbolicEquation);
                if (length(curSymVar) > length(maxSymVar))
                    maxSymVar = curSymVar;
                end;
            end;
        end

    end
end