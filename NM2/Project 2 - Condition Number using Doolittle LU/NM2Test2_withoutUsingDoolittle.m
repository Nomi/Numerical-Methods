function result = NM2Test2(A)
%% Some basic values
nA = size(A,1); %only need that as matrix is square.
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
u=ones(nA,1);
m1=1;
v=A*u; 
m2=max(abs(v));
err=abs(m1-m2);
while err>eps  %Calculating biggest eigenvalue and the corresponding eigenvector.
    v=A*u; 
    m2=max(abs(v));
    u=v/m2;
    err=abs(m1-m2);
    m1=m2;
end
lambda_max = m1;

%% Doolittle Method (for getting A=LU decomposition for using Inverse Power Method)
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
%% Finish
result=lambda_max/lambda_min;
end