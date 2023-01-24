function [result] = SolveLinEqUsingCholeskyLDLT(A,b) %,B) %,X,B)
%% Description:
% Solves a system of equations [A]{x}={b} using the Cholsky LDL^T (LDL')
% decomposition as the method of factorization for that. The factor
% matrices are then used in a series of "equations" to get the solution to
% the given equation.
%
% The code assumes that A is symmetric and postive definite, which is
% given/guaranteed in project/task decription already.
%% Arguments Explanation:
% A is a nxn Symmetric Positive Definite Matrix and b is a vertical vector 
% of length n such that Ax=B (where x is a vertical vector of length n 
% whose members are the solutions we need to find).
%% Pre-requisites:
% As per the instructions recieved on labs, A must be symmetric positive
% definite and all of its members must be real.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Performing Cholesky LDL' Decomposition/Factorization of A %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[L,D_vec]=CholeskyLDLT(A);
[L,D_vec]=CholeskyLDLT_FasterAlternative(A); %Note: L^T <==> L'




%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Solving the Equation %%
%%%%%%%%%%%%%%%%%%%%%%%%%%
% So far, we want to solve: LDL'x=B <=> x=(L^-1(D^-1(L^-1(B))))
% In order to avoid relying on inverses for performance reasons, we'll use
% the factorized matrices to our advantage.
%
% Initially: Ax=B 
% After Cholesky LDL^T Decomposition, we have: Ax=LDL'x=B (as stated above)
% So, let y=L'x
% and let z=Dy.
% Then,

% First we solve Lz=b as:
z=LowTri_linsolve(L,b);
% Then we solve Dy=z as:
y=DiagVec_linsolve(D_vec,z);
% Finally, we solve L'x=y, as:
x=UpTri_linsolve(L',y);
% hence, we have the required x vector {stores values of x_sub(i) (for
% from the interval [1,n]) for the given equation to be true};




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Finished computation, setting result to return. %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
result=x;
%result = L'\(diag(D_vec)\(L\b));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Nested Function Definition:: Cholesky LDL' decomposition %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% The square-root and summation based approach:
    function [L,D_vec]=CholeskyLDLT_FasterAlternative(A)
        %Almost 80% of it is just the programmatic implementation of the
        %formulae given here: 
        %https://en.wikipedia.org/wiki/Cholesky_decomposition#LDL_decomposition_2
        %
        %However,some things implicitly understood in the equation or
        %not needed for a hand-written/typed solution were added by
        %me. And some other modifications that I might not recall at the
        %moment.
        n=size(A,1);
        tempVec=ones(1,n);
        L=diag(tempVec);
        D_vec=zeros(n,1);
        for i=1:n
            D_vec(i)=A(i,i)-(L(i,1:i-1).^2)*D_vec(1:i-1);%The semicolons (':') in the indices act as a series just like how we specify vectors or iterations of loop.
            for j=i+1:n
                L(j,i)=(A(j,i)-L(j,1:i-1).*L(i,1:i-1)*D_vec(1:i-1))/D_vec(i);%The semicolons (':') in the indices act as a series just like how we specify vectors or iterations of loop.
            end
        end
    end

    %%% Main algorithm based approach. Slower/inefficient.
    function [L,D_vec]=CholeskyLDLT(A) %Depreccated in favor of: CholeskyLDLT_FasterAlternative(A)
    % This implementation is based on theory from the book "Matrix 
    % Computations" (2nd Edition) by Golub and Van Loan(refer to pages 137 to 139)
    %
    % This function returns L and D where A=LDL' using the LDL variant of
    % Cholesky method. (L is a lower triangular matrix with ones 
    % on the diagonal, and D is a diagonal matrix). However, to save memory
    % I used a vector that contains only the diagonal elements as it is
    % more useful.
    %
    % The code assumes that A is symmetric and postive definite, which is
    % given/guaranteed in project/task decription already.
    
        n=size(A,1); %n stores the size of A
        L=zeros(n,n);
        vec=zeros([n 1]);
        d=zeros([n 1]); %vector storing Diagonal matrices' diagonal values only
        
        
        
        vec(1)=A(1,1);
        d(1)=vec(1);
        L(2:n,1)=A(2:n,1)/vec(1);  
        for i=2:n-1
            vec(1:i-1)=L(i,1:i-1).*d(1:i-1);
            vec(i)=A(i,i)-L(i,1:i-1)*vec(1:i-1)';
            d(i)=vec(i);
            L(i+1:n,i)=(A(i+1:n,i)-L(i+1:n,1:i-1)*vec(1:i-1)')/vec(i);
        end
        vec(1:n-1)=L(n,1:n-1).*d(1:n-1);
        vec(n)=A(n,n)-L(n,1:n-1)*vec(1:n-1)';
        d(n)=vec(n);
        
        D_vec=d;
        %D=diag(d);  % Putting d into a diagonal matrix (form?) to return as D.
        L=L+eye(n); % Puting ones on the diagonal of L (as expected of L)
        %Side note: Because A is positive definite, 
        %           the diagonal of D is all positive:
    % End of the nested Cholesky LDL' Decomposition Function/
    end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Nested Function Definition:: Self-Implemented LinSolve Alternatives %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%These functions were made from the algorithms I have used in solving
%tutorial problems, but in a programattic form. I don't know if there's
%something more efficient, but this is the only way I've seen it be
%solved on our course.
    
    %%% Lower Triangular Linsolve:
    function z=LowTri_linsolve(LowTri,B) %lower triangular linsolve
        n=size(LowTri,1);
        z=zeros([n 1]);
        
        z(1)=B(1); %/LowTri(1,1); %commented out /LowTri(1,1) because it's always 1.
        for r=2:n
            currRowZSum=0;
            for c=1:r-1
                currRowZSum=currRowZSum+(LowTri(r,c)*z(c));
            end
            z(r)=(B(r)-currRowZSum)/LowTri(r,r);
        end
    end

    %%% Diagonal Linsolve:
    function y=DiagVec_linsolve(D_vec,z) %diagonal matrix linsolve
        n=size(D_vec);%earlier: n=size(D,1);
        y=zeros([n 1]);
        
        for rc=1:n
            y(rc)=z(rc)/D_vec(rc);%D(rc,rc);
        end
    end

    %%% Upper Triangular Linsolve:
    function x=UpTri_linsolve(UpTri,y) %upper triangular linsolve
        n=size(UpTri,1);
        x=zeros([n 1]);
        x(n)=y(n);%/UpTri(n,n); %commented out /UpTri(n,n) because it's always 1.
        for r=n-1:-1:1
            currRowZSum=0;
            for c=n-(n-r)+1:1:n%Just realized I could've just done "i=r+1:n" (:P), but since I was trying to do it as if I was solving a problem on paper, I ended up like this, which looks weird.
                currRowZSum=currRowZSum+UpTri(r,c)*x(c);
            end
            x(r)=(y(r)-currRowZSum)/UpTri(r,r);
        end
    end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% End of the main function %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end