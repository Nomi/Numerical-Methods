function result = NM2Test2(A)
%% Some basic values
nA = size(A,1); %only need that as matrix is square.
initialGuess=0; %alpha smallest => min eigen val is nearest (can't be -ive here)
%hint: my notebook has something about accuracy in Lecture 6 part

%% Checking Inputs:
%Checking if it is symmetric positive definite
try chol(A);
    %This method of checking is most efficient according to: 
    %https://www.mathworks.com/help/matlab/math/determine-whether-matrix-is-positive-definite.html#:~:text=The%20most%20efficient%20method%20to%20check%20whether%20a,then%20the%20matrix%20is%20not%20symmetric%20positive%20definite.
catch
    disp('Matrix is not symmetric positive definite')
end

%% Power Method
%change this section to avoid the PLAGUE:3
%Textbook notation comparison: v=x^(k+1)=A*x^(k) and u=(x~)^(k) (m1 is lambda
%for v and m2 is lambda for u).
u=ones(nA,1); %First u is selected at random. I selected vectors full of 1s.
m1=1;         %consequently/similarly, we select m1 as 1 to normalize( max of u = ones anyway).
%First iteration is done outside of the while loop.
v=A*u; 
m2=max(abs(v));     
err=abs(m1-m2);
currEps=eps;
currEps=0.00001;
%The loop conditions follow formula  right after eqn 45 from lecture notes
while err>currEps  %Calculating biggest eigenvalue and the corresponding eigenvector.
    v=A*u; 
    m2=max(abs(v));     %largest singular value, norm of u (x^k) in next iteration %ends up just like the formula in the paragraph following Exercise 12
    u=v/m2; %Avoiding underflow/overflow according to formula 44 of lecture notes. Same goes for v above.
    err=abs(m1-m2);
    m1=m2;
end
lambda_max = m1;

%% Doolittle LU Decomposition Usage
DoolittleLU();

%% Inverse Power Method

invA=inv(A);
%invA=inv(U)*inv(L);
Vm=ones(size(invA,1),1);
meow=Vm;
for j = 1:10
    Vm = invA*Vm;%change to use LU decomp
    [maxVm, index] = max(abs(Vm(:)));
    maxVm = maxVm * sign(invA(index));
    lambda_min = abs(maxVm);%max(Vmiin,[],'ComparisonMethod','abs');%abs(max(vec));
    Vm = Vm./maxVm; %max(vec,[],'ComparisonMethod','abs'); %abs??
end
lambda_min=1/lambda_min;
%%For testing:
%lambda_min*Vm;
%A*Vm
%Both are the same!


%% Finish
result=lambda_max/lambda_min;


%% Doolittle LU decomposition (Nested Function Definition)
    function DoolittleLU()
        %change this section to avoid the PLAGUE:3
        U=zeros(nA);
        L=zeros(nA);
        U(1,:)=A(1,:);
        L(:,1)=A(:,1)/U(1,1);
        L(1,1)=1;
        for k=2:nA
            for i=2:nA
                for j=i:nA
                    U(i,j)=A(i,j)-dot(L(i,1:i-1),U(1:i-1,j));
                end
                L(i,k)=(A(i,k)-dot(L(i,1:k-1),U(1:k-1,k)))/U(k,k);
            end
        end
        %A(1,1)=A(1,1)
        %newA=L*U
        P=eye(nA);
        %the following are just for testing if these were made correctly.
        %U(nA,1)=-1
        %L(1,nA)=-1
        %Now, we have decomposed A int L and U such that A=LU 
        %where L is lower-triangle matrix and U is upper triangle.
    end
end