classdef OutputHandler
     properties
     end
    
     methods(Static)

         function outputData(handles, X,symbols, methodName)
            TableWriter.outputData(handles, X, symbols,methodName);
            FileWriter.outputData('output.txt',X, methodName);
         end

         function outputIterativeData(handles, X, error,symbols)
            TableWriter.outputIterativeData(handles, X, error,symbols);
            FileWriter.outputIterativeData('output.txt', X, error);
         end

     end

end