    function w = ismagic(A)
    % Counts the negative elements of A
    s = size(A);
    w = true; %true by default so if I detect it doesnt work I can undo it.
    PrevSumR = -1;    %used in the sum calculating loops to store sum of each previous row
    sumR = -2;    %sum of current row
    PrevSumC = -1;    %used in the sum calculating loops to store sum of each previous row
    sumC = -2;    %sum of current column
    sumDL = 0;    %sum of left leaning diagonal
    sumDR = 0;    %sum of right leaning diagonal
    for i = 1:s(1)	%loop for calculating and checking equality of sumR and sumC
        PrevSumR = sumR;
        PrevSumC = sumC;  %prevSumR and prevSumC used to store values of previous sumR and sumC.
        sumR = 0;         %sumR and sumC are reset
        sumC = 0;
        for j = 1:s(2)
            if(i == j)    %Checking if the indices are at a diagonal element's location
                sumDL = sumDL+A(i,j);             %adding element of the left leaning diagonal to sumDL
                sumDR = sumDR+A(i,s(1)-(j-1));    %adding element of the right leaning diagonal to sumDR
            end
            sumR = sumR + A(i,j);    %Adding j-th element of the i-th row to sum of current row.
            sumC = sumC + A(j,i);    %Adding i-th element of the j-th row to sum of current column
        end
        if((i~=1)&&((PrevSumR~=sumR)||(PrevSumC~=sumC))) %Sets result to false and leaves loop if the new sumR and sumC values are 
            w = false;                                     %different from the previously calculated sums of rows and columns, if any.
            break
        end
    end
    %By this point we know every column and row has the same sum.
    %We also know, sumR=sumC.
    if((sumDL ~= sumDR)||(sumDR ~= sumR)) %Now we check if each diagonal has the same sum as the other 
        w = false;                      %and same sum as the rows and columns. If not, result is false.
    end