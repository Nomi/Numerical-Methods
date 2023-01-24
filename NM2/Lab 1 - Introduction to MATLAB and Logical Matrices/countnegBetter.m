function w = countnegBetter(A)
% Counts the negative elements of A
w = sum(A < 0,'all'); % or: w = sum(sum(A < 0));