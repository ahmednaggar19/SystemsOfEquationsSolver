classdef FileWriter
    properties (Constant)
        permission = 'a';
    end
    
    methods (Static)
        function outputData(fileName, data, methodName)
            fileID = fopen(fileName, FileWriter.permission);
            fprintf(fileID,'\t%s\n', methodName);
            for i = 1:length(data)
                fprintf(fileID, '%d ', data(i));
            end
            fprintf(fileID, '\n');
            fclose(fileID);
        end
        
        function outputIterativeData(fileName, data, error)
            fileID = fopen(fileName, FileWriter.permission);
            for i = 1:length(data)
                fprintf(fileID, '%d %4.5f', data(i), error(i));
            end
            fprintf(fileID, '\n');
            fclose(fileID);
        end
    end
end