function FINALRESULT = Int2D(funct,a,b,nx,c,d,ny)   

%% :Arguments Explanation: %%
%funct is the function to be integrated. 

%[a,b] and nx are intervals and number of nodes respectively 
%for when applying Composite Newton-Cotes\Simpson's 3/8 Rule. 

%[c,d] and ny are intervals and number of nodes respectively 
%for when applying Composite Trapezoidal rule.

%Example funct definition: funct = @(x,y) (x.^2 + y.^2).



%% :Hardcoded Parameters: %%
FixnCheckNumberOfPoints=true; %enables built-in checks and fixes for invalid values of nx and ny.



%% :Setting up h and n values for each quadrature: %%
if(FixnCheckNumberOfPoints)
    if(nx<3)                %Because Simpson's 3/8 rule requires minimum nx=3;
        nx=3;                   %nx=3 applies non-composite Simpson 3/8 rule. 
    elseif(mod(nx,3)~=0)    %Checks if nx (>=3 because elseif) is not a multiple of as Simpson 3/8 quardature requires n to be a multiple of 3. 
        nx=ceil(nx/3)*3;        %sets nx to multiple of 3 that's nearby old nx. New nx> old nx (bigger so as to not be less accurate than one would expect from old nx).
    end
    if(ny<1)                %Trapezoidal rule requires n to be at least 1.
       ny=1;                    %note that ny=1 applies non-composite trapezoidal rule.
    end
end

hx = (b-a)/nx;   %hx is the value of h for Simpson's 3/8.
hy = (d-c)/ny;   %hy is the value of h for Trapzoidal rule

%% :Finding all pairs of nodes (x,y): %%

xnodes = a:hx:b; %vector containing the x nodes (xi,x_sub_i). [for Simpson rule]
ynodes = c:hy:d; %vector containing the y nodes (yi,y_sub_i). [for Trapezoidal rule]

[xnodesgrid, ynodesgrid]=ndgrid(xnodes,ynodes); %For each _=x,y; each "_nodegrid" contains the "_list" 
                                                %(horizontal vector) listed n times vertically.

%% :Calculating values of f(x,y) [for each pair of nodes (x,,y)]: %%
fxyVals= funct(xnodesgrid,ynodesgrid); %used to generate values of function for every (xi,yi) pair
                                       %where xi and yi are nodes for x and y respectively.
                                       %First Column is basically:  f(x0,y0),f(x0,y1),.... f(x0,yn), here, n=nx. 
                                       %First Row is basicall:      f(x0,y0),f(x1,y0),.... f(xn,y0), here, n=ny
                                       %Other rows and columns are similar
                                       %as in, y changes with columns (increases left to right)
                                       %and x changes with rows (increases up to down).



%% :Finding coefficients and common multiplier for COMPOSITE NEWTON-COTES/SIMPSON'S 3/8 RULE: %%
%First we find the common scalar coefficient for the Simpson's 3/8 quadrature/rule.
commonSimp=(3*hx/8);

%Then, we calculate the coefficients for each term of the Simpson's 3/8
%quadrature/rule according to the formula provided in the report (and lecture notes).
coeffsSimp=0:nx;            %Creates a vector to store the coefficients of Simpson's 3/8 rule.

%For the following 3 lines, note that index for vectors starts from 1,
%so here we add +1 to the indice we want.
coeffsSimp(0+1:end-1)=3;    %We set everything to 3. The ones that aren't supposed to be 3 will change in next lines.
coeffsSimp(0+1:3:end)=2;    %Because every 3rd element is supposed to have 2 as their coefficient.
coeffsSimp(0+1:nx:end)=1;   %End points have 1 as their coefficient.


%% :Finding coefficients and common multiplier for COMPOSITE TRAPEZOIDAL RULE: %%
%First we find the common scalar coefficient for the Trapezoidal rule.
commonTrap=hy;                %supposed to be hy/2, but we take 2 common from the sum
                              %, which cancels out with 1/2.

%Then, we calculate the coefficients for each term of the Trapezoidal rule
%according to the formula provided in the report (and lecture notes),
%and keeping in mind we already took 2 out as common scalar.
coeffsTrap=0:ny;              %Creates a vector to store the coefficients of Trapezoidal rule.

%For the following 2 lines, note that index for vectors starts from 1,
%so here we add +1 to the indice we want.
coeffsTrap(1+1:end-1)=1;      %every non-endpoint supposed to have 2 as coeffecient,
                              %but we took it common outside the sum, so we have 1.
                              
coeffsTrap(0+1:ny:end)=1/2;   %every non-endpoint supposed to have 1 as coeffecient,
                              %but we took it common outside the sum, so we have 1/2.

%% :INTEGRATING (Applying the quadratures.): %%

%As per lecture notes, I took common factors  and only multiplied them at the end 
%(after summing all the elements of the matrix resulting from Matrix multiplication)
%to reduce computation time.
%The formula for the answer (FINALRESULT) I made is inspired by the formula taught by the lecturer on
%lectures:
%i.e.[B(Q2 COEFFS/horizontalvector)][f(x,y)(m+1 x n+1 matrix)][A(Q1 COEFFS/vertical vector)]
%clutter-less: [B]*[f(x,y)]*[A].

FINALRESULT=commonTrap*commonSimp*sum(sum((coeffsTrap.*(fxyVals.*coeffsSimp.')))); 
%refer to Closing Thoughts notes for further explanation on how/why it
%works.






return

%% CLOSING THOUGHTS ABOUT THE FINAL FORMULA %%
%(Note: explained/clarified further in the report.)

%Based on the formula for 2D Integrals given in the lectures, we know that
%the result is basically: Common Scalar Coeffiecients multiplied with
%[Trapezoidal rule applied (Coeffiecient Matrix Multiplication) to 
%[Simpson's 3/8 rule applied ny+1 times (Coeffiecient Matrix Multiplication) to
%each function f(x,yi)for each i belongs to [0,n]]].
%{side note: f(x,yi)acts like single variable based function as yi is some constant}
%Then we up all the terms.

%Should be clear from the definition/formulae of each of these quadratures
%and the formula for 2D Integrals comparied to the comments/explanation 
%at the beginning of this "Integrating" section and the 
%comments/explanation at the place where we generated array fxy.
