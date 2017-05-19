classdef Gauss_Elimination
    
    properties
    end
    
    methods(Static)
        % [A] * [X] = [B]
        function [X] = evaluate(A, B, handles,symbols) % Returns "X" matrix contains answer, "A" and "B" are matrices of coefficients and constants.
        [A, B] = Gauss_Elimination.forwardElimination(A, B);
        X = Gauss_Elimination.backwardSubstitution(A, B);
        %Gauss_Elimination.outputData(handles,X,symbols);
        OutputHandler.outputData(handles,X,symbols, 'Gauss Elimination');
        end % End of the function.
        
        function [A, B] = forwardElimination(A, B)
        size = length(B);
        for i = 1 : size-1 % Forward elemination.
            for j = i+1 : size
                multiplying_Factor = A(j, i)/A(i, i);
                for k = i : size % Computation of the rest of each row after elimination of the desired element.
                    A(j, k) = A(j, k) - multiplying_Factor*A(i, k);
                end
                B(j) = B(j) - multiplying_Factor*B(i);
            end
        end
        end
        
        function [X] = backwardSubstitution(A, B)
        size = length(B);
        X = zeros(size, 1); % Initializing the answer array with zeros.
        X(size) = B(size) / A(size, size); % Last element in answer array evaluated by backward substitution.
        for i = size-1 : -1 : 1 % Backward substitution starts here for evalutation X's.
            acc_Sum = B(i);
            for j = i+1 : size
                acc_Sum = acc_Sum - A(i, j)*X(j); % X(j) will be computed from the last step.
            end
            X(i) = acc_Sum / A(i, i);
        end
        end
    end    
end

