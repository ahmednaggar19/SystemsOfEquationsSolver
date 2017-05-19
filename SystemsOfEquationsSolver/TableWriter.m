classdef TableWriter
     properties
     end
    
     methods(Static)

         function outputData(handles, X,symbols, methodName)
            data = get(handles.solution,'data');
            columnNames = [];
            if (length(data) <= 1)
                data(end,1) = {methodName};
            else 
                data(end + 1, 1) = {methodName};
            end;
            data(end + 1,1) = {X(1)};
            columnNames = [columnNames; char(symbols(1))];
            for i = 2:length(X)
                data(end,i) = {X(i)};
                columnNames = [columnNames; char(symbols(i))];
            end
            set(handles.solution,'data',data);
            set(handles.solution,'ColumnName',columnNames);
         end

         function outputIterativeData(handles, X, error ,symbols)
            data = get(handles.solution,'data');
            columnNames = [];
            data(end + 1,1) = {X(1)};
            columnNames = [columnNames; char(symbols(1))];
            for i = 2:length(X)
                data(end,i) = {X(i)};
                columnNames = [columnNames; char(symbols(i))];
            end
            for i = 1:length(error)
                data(end,i + length(X)) = {error(i)};
                columnNames = [columnNames; char(symbols(i))];
            end
            
            set(handles.solution,'data',data);
            set(handles.solution,'ColumnName',columnNames);
         end

     end

end