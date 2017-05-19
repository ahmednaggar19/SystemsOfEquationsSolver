function [L,U,P]=LUdecomposition_PIV(A)
  % LU decomposition with partial (row) pivoting
  [m,n]=size(A);
  if n~=m
      error 'Input matrix should be a square matrix'
  end
  
  if nargin ~= 1
      error '1 parameter only is expected'
  end
  
  if ~isnumeric(A)
      error 'Input matrix must be numeric'
  end
  L=eye(n,m); %Constructs an identity matrix of dimension n * m.
  P=L; U=A;
  for k=1:n
    [~, largest_element_row_index]=max(abs(U(k:n,k))); % this returns the row index of 
    %the largest element in magnitude in kth column and
    %tilt"~" in the square brackets is used instead of unusable variable which stands for the largest element value itself. 
    largest_element_row_index=largest_element_row_index+k-1;
    if largest_element_row_index~=k
      % interchange rows m and k in U
      temp=U(k,:);
      U(k,:)=U(largest_element_row_index,:);
      U(largest_element_row_index,:)=temp;
      % interchange rows m and k in P
      temp=P(k,:);
      P(k,:)=P(largest_element_row_index,:);
      P(largest_element_row_index,:)=temp;
      if k >= 2
          temp=L(k,1:k-1);
          L(k,1:k-1)=L(largest_element_row_index,1:k-1);
          L(largest_element_row_index,1:k-1)=temp;
      end
    end
    for j=k+1:n
        L(j,k)=U(j,k)/U(k,k);
        U(j,:)=U(j,:)-L(j,k)*U(k,:);
    end
  end
end
