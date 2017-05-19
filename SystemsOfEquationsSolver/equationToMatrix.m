function [A,b] = equationToMatrix(eq, var)
% Converts a symbolic linear equation to vectorform.
% E.g. a1*x1 + a2*x2 + a3*x3 = c
% <=>  A = [a1 a2 a3] & b = [c]
% where A represents the left side of the =
% and b representes the right side.
%
% Author: Jon Andr Adsersen

% The used variables are made to syms
%var=symvar(eq);
for i=1:length(var)
    eval(['syms ' char(var(i))]);
end

% b is determined
eq2=eq;
for i=1:length(var)
    eq2=eval(['subs(eq2,' char(var(i)) ',0)']);
end
b=-eq2;

% A is determined

% Prealocation
A=zeros(1,length(var));

for i=1:length(var)
    eq2=eq;
    for j=1:length(var)
        if j~=i
            eq2=eval(['subs(eq2,' char(var(j)) ',0)']);
        else
            eq2=eval(['subs(eq2,' char(var(j)) ',1)']);
        end
    end
    A(i)=eq2+b;
end
end