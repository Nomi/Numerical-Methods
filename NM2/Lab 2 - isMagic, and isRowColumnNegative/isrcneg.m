function w = isrcneg(A)

%In the following line of code, any(A<0) returns a single-rowed array containing
%a logical 1s in all corresponding columns where A<0, and 0 in other
%corresponding columns. Meanwhile, the encompassing all(...) returns true(logical 1) if
%all the elements of any(A<0) are logical 1s.
w = all(any(A<0)); 
if(w == true)   %Because we only need further checks if not false already.
    w=all(any(A.'<0));  %Does the same as above, but this time for rows as it's applied on transpose of A this time.
    %Could've used any(A,2) to operate on rows! %Just FYI, all(A,2) exists as well!
end

end