function w = countneg(A) 
%counts the negative elemtns of A INNEFFCIEIENTLY THO
s=size(A);
w=0;
for i=1:s(1)
    for j=1:s(2)
        if A(i,j) <0
            w=w+1;
        end
    end
end
