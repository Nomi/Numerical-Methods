function out = ismagic_alt(A)

%Step 0: Get size of given matrix
rowSize=size(A,1);
%First we check sum for each diagonal
sumDiagL = sum(diag(A));
sumDiagR = sum(diag(flip(A,1)));
%Then we check sum for each row and column,
sumRow = sum(A,1);
sumCol=sum(A,2);
sumColTransposed = sumCol.'; %We transpose so that the dimensions are comparable to sumRow ([Nx1] vs [1xN])


% Then we check if sum of row = sum of columns:
if(isequal(sumRow,sumColTransposed)==true)  %this expression can only be true if all values of the sumRow and sumColumns are some SPECIFIC CONSTANT number IN EVERY POSITION of both matrices.
    %Lastly, we check if sum of left leaning diagonal (aka DiagL) and right leaning diagonal (aka DiagR)
    %are equal in value with each other and with sum of every row and
    %column.
    for i=1:rowSize
        if(isequal(sumDiagL,sumDiagR,sumRow(1,i),sumColTransposed(1,i))==true)
            out = true;
        else
            out = false;
        end
    end
else
       out = false;
end
end
