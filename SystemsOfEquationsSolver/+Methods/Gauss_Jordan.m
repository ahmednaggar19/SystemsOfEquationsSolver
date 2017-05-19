classdef Gauss_Jordan
    
    properties
    end
    
    methods(Static)
        % [A] * [X] = [B]
        function [X] = solve(A, B, handles, symbols) % Returns "X" matrix contains answer, "A" and "B" are matrices of coefficients and constants.
        size = length(B);
        X = zeros(size, 1); % Initializing the answer array with zeros.
        for i = 1 : size % Forward elemination of below rows.
            for j = i+1 : size
                multiplying_Factor = A(j, i)/A(i, i);
                for k = i : size % Computation of the rest of each row after elimination of the desired element.
                    A(j, k) = A(j, k) - multiplying_Factor*A(i, k);
                end
                B(j) = B(j) - multiplying_Factor*B(i);
            end
            for j = i-1 : -1 : 1 % Forward elemination of above rows.
                multiplying_Factor = A(j, i)/A(i, i);
                for k = i : size % Computation of the rest of each row after elimination of the desired element.
                    A(j, k) = A(j, k) - multiplying_Factor*A(i, k);
                end
                B(j) = B(j) - multiplying_Factor*B(i);
            end
        end
        
        % Assigning the value of X's.
        for i = 1 : size
            X(i) = B(i) / A(i, i);
        end
         OutputHandler.outputData(handles,X,symbols, 'Gauss Jordan');
        end % End of the function.
    end
    
end

