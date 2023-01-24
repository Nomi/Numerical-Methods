function result = NM2Test2(A,AcceptableErrPM,AcceptableErrIPM)
%% Some basic values
nA = size(A,1); %only need size of one side (columns or rows) as matrix is square.
%% Setting acceptable error.
%According to my notes for 6th NM2 lecture, we stop iterations when we
%reach the desired accuracy. So here we set the maximum error tolerated
%according to given input.

%If for Power Method or Inverse Power method, accuracy <=0, we set it to
%the floating point accuracy (eps).
if(AcceptableErrPM<=0)
    err_PM=eps; %Floating point accuracy
else
    err_PM=AcceptableErrPM;
end

if(AcceptableErrIPM<=0)
    err_IPM=eps;    %Floating point accuracy
else
    err_IPM=AcceptableErrIPM;
end

%% Checking Symetric Positive Definiteness:
try chol(A);
    %This method of checking is recommended according to: 
    %https://www.mathworks.com/help/matlab/math/determine-whether-matrix-is-positive-definite.html#:~:text=The%20most%20efficient%20method%20to%20check%20whether%20a,then%20the%20matrix%20is%20not%20symmetric%20positive%20definite.
catch
    disp('Matrix is not symmetric positive definite.')
end

%% Power Method
%I use my own notation in this section. This is compared to the lecture
%notes in the following comments:
%Lecture notes notation comparison: v=x^(k+1)=A*x^(k) and u=(x~)^(k) (lambdaV is lambda
%for v and lambdaU is lambda for u).
u=ones(nA,1); %First u is selected at random. I selected vectors full of 1s.
lambdaV=1;         %consequently/similarly, we select lambdaV as 1 to normalize( max of u = ones anyway).
%First iteration is done outside of the while loop.
v=A*u; 
lambdaU=max(abs(v));     
currErr=abs(lambdaV-lambdaU);
%The loop conditions follow formula  right after eqn 45 from lecture notes
while (currErr>=err_PM && currErr>0)  %Calculating biggest eigenvalue and the corresponding eigenvector.
    v=A*u; 
    lambdaU=max(abs(v));     %largest singular value, norm of u (x^k) in next iteration %ends up just like the formula in the paragraph following Exercise 12
    u=v/lambdaU; %Avoiding underflow/overflow according to formula 44 of lecture notes. Same goes for v above.
    currErr=abs(lambdaV-lambdaU);
    lambdaV=lambdaU;
end
lambda_max = lambdaV;
%Note: V contains the resultant vector after each iteration while U carries
%the V from previous iteration. Also, lambdaV and lambdaU are their
%Eigenvalues respectively.

%% Doolittle LU Decomposition Usage (definied at the end)
[L, U] = DoolittleLU();

%% Inverse Power Method
%Refer to the comments of Power Method section for notes on the notation
%used here as compared to the one used on lecture script.
u=ones(nA,1); %First u is selected at random. I selected vectors full of 1s.
lambdaV=1;         %consequently/similarly, we select lambdaV as 1 to normalize( max of u = ones anyway).
%First iteration is done outside of the while loop.
%v=A*u;
y=linsolve(L,u);
v=linsolve(U,y);
lambdaU=max(abs(v));     
currErr=abs(lambdaV-lambdaU);
%The loop conditions follow formula right after eqn 45 from lecture notes
while currErr>=err_IPM  %Calculating biggest eigenvalue and the corresponding eigenvector.
    %v=A*u; 
    y=linsolve(L,u);
    v=linsolve(U,y);
    lambdaU=max(abs(v));     %largest singular value, norm of u (x^k) in next iteration %ends up just like the formula in the paragraph following Exercise 12
    u=v/lambdaU; %Avoiding underflow/overflow according to formula 44 of lecture notes. Same goes for v above.
    currErr=abs(lambdaV-lambdaU);
    lambdaV=lambdaU;
end
lambda_min = 1/lambdaV;
%Note: V contains the resultant vector after each iteration while U carries
%the V from previous iteration. Also, lambdaV and lambdaU are their
%Eigenvalues respectively.

%% Finish
result=lambda_max/lambda_min;


%% Doolittle LU decomposition (Nested Function Definition)
    function [L, U] = DoolittleLU()
        %First we create two matrices filled with zeroes as our basis for 
        %the resultant L and U matrices.
        U=zeros(nA);
        L=zeros(nA);
        U(1,:)=A(1,:); %The first row of U is the same as first row of A as required.
        L(:,1)=A(:,1)/U(1,1); %Consequently, first column of L is then set according to U.
        L(1,1)=1; %We fix this because the the code doesn't make L(1,1) be 1 as it should be (Doolittle LU makes diagonal elements of L be 1s)
        for k=2:nA
            for i=2:nA
                for j=i:nA
                    U(i,j)=A(i,j)-dot(L(i,1:i-1),U(1:i-1,j)); %This is 
                    %actually the same formula as required by Doolittle LU
                    %factorization, but here we use dot product because
                    %after some research I found out it's better/more
                    %efficient.
                end
                L(i,k)=(A(i,k)-dot(L(i,1:k-1),U(1:k-1,k)))/U(k,k); %The same comment as above applies.
            end
        end
        %Now, we have decomposed A int L and U such that A=LU 
        %where L is lower-triangle matrix and U is upper triangle.
    end
%% End of the main function
end