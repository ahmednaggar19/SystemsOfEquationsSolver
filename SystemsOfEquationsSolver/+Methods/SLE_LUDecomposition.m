function [X] = SLE_LUDecomposition (A, b, handles, symbols)
  
    if nargin ~= 4
       error 'Only four parameters are expected'
    end

    if ~(isnumeric(A)&&isnumeric(b))
        error 'Input matrix and vector must be numeric'
    end

    [nRow,nCol]=size(b);
    if nRow>1 && nCol>1
        error '2nd parameter must be a vector'
    end

    [nRow,nCol]=size(A);
    if nRow ~= nCol
        error 'Input matrix must be a square matrix' 
    end
    
    if length(b) ~= nRow
       error 'Input vector length does not match input matrix dimensions'        
    end
    
    %change the input vector b from being a vector to a matrix of 
    %3 rows and one column so no errors occur on multiplication with 
    %permutation matrix P obtained from LU decomposition.
    b=b(:); 
    [L,U,P] = Methods.LUdecomposition_PIV(A)
    [~,Y] = Methods.Gauss_Elimination.forwardElimination(L, P*b)
    X = Methods.Gauss_Elimination.backwardSubstitution(U, Y)
    OutputHandler.outputData(handles,X,symbols, 'LU Decomposition');
end
