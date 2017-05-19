function [L,U]=LUdecomposition_NoPIV(A)
  % LU decomposition without partial pivoting
  [n,m]=size(A); %gets the dimensions of input matrix A and 
  %assigns them to n "rows" and m "columns" respectively.
  if n~=m
      error 'Input matrix should be a square matrix'
  end
  
  if nargin ~= 1
      error '1 parameter only is expected'
  end
  
  if ~isnumeric(A)
      error 'Input matrix must be numeric'
  end

  L=eye(n,m); %returns an identity matrix of dimensions n*m.
  U=A;
  
  for k=1:n
      for j=k+1:n
          L(j,k)=U(j,k)/U(k,k);
          U(j,:)=U(j,:)-L(j,k)*U(k,:);
      end
  end
  
    %removing all-zero elemets rows and colums from the 3 matrices
    L( ~any(L,2), : ) = [];  %rows
    L( :, ~any(L,1) ) = [];  %columns
    U( ~any(U,2), : ) = [];  %rows
    U( :, ~any(U,1) ) = [];  %columns
end