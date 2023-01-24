function w = ismagic(A)
    Osize  = size(A,1) %gets the length of rows (same as columns because matrix is square)
    prevVal=-1
    IsMagic = TRURE
    for i = 1:(2*Osize) %loops over each row
        if(IsMagic==FALSE)
            break
        for j = 1: Osize
            newVal=sum
            if((i~=1)&&(j~=1))
                if(prevVal~=newVal)
                    IsMagic=FALSE
                    break
                end
            end
        end
                
        
    
    