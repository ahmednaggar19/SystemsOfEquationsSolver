

classdef Gauss_Seidel

    properties
    % Equation Matrix is the input matrix 
    EquationMatrix
    %VariableOutputArray the output.
    VariableOutputArray
    %Number of max iterations
    NumIterations
    %Max Epsilon
    Epsilon
    %Relative Errors Matrix after each iteration [Output]
    MatrixOfErrors
    %Roots Matrix after each iteration [Output]
    MatrixOfRoots
    %The actual number of iterations in case of epsilon stopping condition
    ActualNumIterations
    end

    methods %performanceMetrics takes NumIter or Epsilonmax or both, in this order
      function obj = Gauss_Seidel(inputM,performanceMetrics,InitialGuess)
      obj.EquationMatrix = inputM;
      obj.VariableOutputArray = InitialGuess;
      obj.NumIterations = 50;
      obj.Epsilon = 0.00001;
      obj.MatrixOfRoots = obj.VariableOutputArray;
      obj.ActualNumIterations = 0;
      if ~isempty(performanceMetrics)
        w = size(performanceMetrics);
        if w(1,2) == 1;
          if performanceMetrics(1,1) < 1
            obj.Epsilon = performanceMetrics(1,1);
          else
            obj.NumIterations = performanceMetrics(1,1);
          end 
        else
          obj.NumIterations = performanceMetrics(1,1);
          obj.Epsilon = performanceMetrics(1,2);
        end
      end
      end  
      
%you can make a constructor that sets the EquationMatrix, NumIterations, 
%Epsilon and those that won`t be set , have a default value except the 
%EquationMatrix as it must be input.

%The function takes an input and outputs several outputs , no writing or reading from  a file is 
%done internally so you will have to read the file , send it to the function , get the outputs you 
%want and write them to a file again 

% m determines whether the iterations will stop at a max number of iterations or at
% a max epsilon
    function AllOutputArray = GaussSeidel(obj,m)
    x = size(obj.EquationMatrix);
    if x(1,1) ~= (x(1,2) - 1)
      msgID = 'Exception1';
      msg = 'Inaccurate Matrix Dimensions.';
      dimensionException = MException(msgID,msg);
      throw(dimensionException)
    end
    if m <= 0  
      for b = 1:obj.NumIterations
        u = GaussSeidelOneIter(obj);
        obj.VariableOutputArray = u.VariableOutputArray;
        obj.MatrixOfRoots = [obj.MatrixOfRoots,u.VariableOutputArray];
        CurrentColumn = size(obj.MatrixOfRoots,2);
        currentRoot = obj.MatrixOfRoots(:,CurrentColumn);
        prevRoot = obj.MatrixOfRoots(:,CurrentColumn-1);
        k = ( abs((currentRoot - prevRoot)) ./ currentRoot ) .* 100.0;
        if b == 1
          obj.MatrixOfErrors = abs(k);
        else
          obj.MatrixOfErrors = [obj.MatrixOfErrors,abs(k)];
        end
       obj.ActualNumIterations = obj.NumIterations;
     end
    else
      o = 0;
      while true
        if ~isempty(obj.MatrixOfErrors)
           if max(obj.MatrixOfErrors(:,o)) <= obj.Epsilon
              break;
           end
        end
        u = GaussSeidelOneIter(obj);
        obj.VariableOutputArray = u.VariableOutputArray;
        obj.MatrixOfRoots = [obj.MatrixOfRoots,u.VariableOutputArray];
        CurrentColumn = size(obj.MatrixOfRoots,2);
        currentRoot = obj.MatrixOfRoots(:,CurrentColumn);
        prevRoot = obj.MatrixOfRoots(:,CurrentColumn-1);
        k = ( abs(( currentRoot - prevRoot )) ./ currentRoot ) .* 100.0;
        if o == 0
          obj.MatrixOfErrors = abs(k);
        else
          obj.MatrixOfErrors = [obj.MatrixOfErrors,abs(k)];
        end
        o = o + 1;
      end
    obj.ActualNumIterations = o;
    end
    AllOutputArray = cell(1,3);
    AllOutputArray{1} = obj.MatrixOfRoots;
    AllOutputArray{2} = obj.MatrixOfErrors;
    AllOutputArray{3} = obj.VariableOutputArray;
    %AllOutputArray = obj.MatrixOfRoots;
    %AllOutputArray = [AllOutputArray,obj.MatrixOfErrors,obj.VariableOutputArray];
  end

    
    
  function obj = GaussSeidelOneIter(obj)
    x = size(obj.EquationMatrix);
    c = 1;
    for r = 1: x(1,1)
      x1 = obj.EquationMatrix(r,c);
      if x1 == 0
        msgID = 'Exception2';
        msg = 'The primary diagonal contains a zero';
        divZeroException = MException(msgID,msg);
        throw(divZeroException)
      end 
      x2 = 0;
      x3 = obj.EquationMatrix(r,x(1,2));
      for z = 1: x(1,1)
        if z ~= c
            x2 = x2 + obj.EquationMatrix(r,z)*obj.VariableOutputArray(z,1);
        end
      end  
    obj.VariableOutputArray(c,1) = (x3 - x2)/x1;
    c = c+1;
   end
  end 
  end
  
  %Testing done isa 
  
end