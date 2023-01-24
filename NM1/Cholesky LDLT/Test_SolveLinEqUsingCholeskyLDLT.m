%% NOTIFYING START OF TEST
disp(" ========================================================================================== ")
disp(" ========================================================================================== ")
disp(" ==================================== START OF TESTS ======================================")
disp(" ========================================================================================== ")
disp(" ========================================================================================== ")
disp(newline)
disp(newline)
disp(newline)
%% [3x3] Testing Tutorial List C, Problem 3:
disp(" ======================================================================================== ")
disp("||       FOR 3x3 S.P.D. MATRIX 'A' and 'b' solved on Tutorial (List C, problem 3)       ||")
disp(" ======================================================================================== ")
disp(newline)
disp(">Given Matrix:");
A=[1 1 0; 1 5 2; 0 2 10]

%%% For b from the tutorial questions:
disp("====== For the following b: ======")
b= [ 1; -7; -4]
disp(">Known solution (calculated by-hand on tutorials):")
knownSolution=[3;-2;0];
x=knownSolution
disp(">Using my implementation:")
x=SolveLinEqUsingCholeskyLDLT(A,b)
disp(">Using MATLAB Linsolve:")
x=linsolve(A,b)

%%% For b= sum of columns of each rows of the Matrix.
disp("====== (not from tutorial) For the b: ======")
b=sum(A,2)
disp(">Known solution (Since b is the sum of elements of each row):")
knownSolution=[1;1;1];
x=knownSolution
disp(">Using my implementation:")
x=SolveLinEqUsingCholeskyLDLT(A,b)
disp(">Using MATLAB Linsolve:")
x=linsolve(A,b)

%%% For b= 0 0 0.
disp("====== (not from tutorial) For the 'b' with only 0s ======")
b=zeros(3,1)
disp(">Known solution (Since b contains 0s only):")
knownSolution=[0;0;0];
x=knownSolution
disp(">Using my implementation:")
x=SolveLinEqUsingCholeskyLDLT(A,b)
disp(">Timing (in seconds):")
f=@()SolveLinEqUsingCholeskyLDLT(A,b);
Time_Taken_In_Seconds=timeit(f)
disp(">Using MATLAB Linsolve:")
x=linsolve(A,b)




%% [2x2] Using S.P.D. Matrix derived by hand for various B:
disp(" ===================================================================== ")
disp("||       FOR S.P.D. 2x2 MATRIX DERIVED BY HAND for various 'b'       ||")
disp(" ===================================================================== ")
disp(newline)
disp(">Given Matrix:");
A=[ 5.2,-1.6;
   -1.6, 2.8 ]

%%% For b= sum of columns of each rows of the Matrix.
disp("====== For the b: ======")
b=sum(A,2)
disp(">Known solution (Since b is the sum of elements of each row):")
knownSolution=[1;1];
x=knownSolution
disp(">Using my implementation:")
x=SolveLinEqUsingCholeskyLDLT(A,b)
disp(">Using MATLAB Linsolve:")
x=linsolve(A,b)

%%% For b= 0 0
disp("====== For the b: ======")
b=zeros(2,1)
disp(">Known solution (Since b contains 0s only):")
knownSolution=[0;0];
x=knownSolution
disp(">Using my implementation:")
x=SolveLinEqUsingCholeskyLDLT(A,b)
disp(">Timing (in seconds):")
f=@()SolveLinEqUsingCholeskyLDLT(A,b);
Time_Taken_In_Seconds=timeit(f)
disp(">Using MATLAB Linsolve:")
x=linsolve(A,b)



%% [10x10] Testing on a generated S.P.D. matrix for various B:
disp(" ========================================================================== ")
disp("||        FOR S.P.D. 10x10 MATLAB GENERATED MATRIX for various 'b'        ||")
disp(" ========================================================================== ")
disp(newline)

% The following SYMMETRIC POSITIVE DEFINITE matrix A was generated using 
% the method mentioned at 
% https://www.mathworks.com/matlabcentral/answers/424565-how-to-generate-a-symmetric-positive-definite-matrix#comment_751966
A=[2.59262579249781,2.36114722096032,2.25317391448454,2.22774099002492,2.93888085572066,1.73348244785529,2.51291595617214,2.17772379855524,2.28201925460990,2.10203610675005;2.36114722096032,3.50791712941774,1.93445428732933,2.91405327852974,3.63529567796393,2.52018469917575,2.91451944895679,3.01091761270414,2.88238602796827,2.42760029865851;2.25317391448454,1.93445428732933,3.01964049916671,2.28507763399638,2.63060978009579,1.71899329621383,2.23605958903869,2.17507446224467,2.40213324293225,1.92278846896178;2.22774099002492,2.91405327852974,2.28507763399638,3.42383005112126,3.22942589310346,2.37077779699890,2.89688591815278,2.99722462049119,2.76528068940584,2.21576546554056;2.93888085572066,3.63529567796393,2.63060978009579,3.22942589310346,4.21197098993271,2.65834901515475,3.37645346230226,3.22784600302511,3.19874206602811,2.93684255499157;1.73348244785529,2.52018469917575,1.71899329621383,2.37077779699890,2.65834901515475,2.39800969814749,1.80694164121685,2.05641005822566,2.23481450242606,1.83060080546609;2.51291595617214,2.91451944895679,2.23605958903869,2.89688591815278,3.37645346230226,1.80694164121685,3.99793738864213,3.32478608670935,2.89715695983927,2.20295501866808;2.17772379855524,3.01091761270414,2.17507446224467,2.99722462049119,3.22784600302511,2.05641005822566,3.32478608670935,3.82899872624213,3.22836556090455,2.11675831135261;2.28201925460990,2.88238602796827,2.40213324293225,2.76528068940584,3.19874206602811,2.23481450242606,2.89715695983927,3.22836556090455,3.09947276861498,2.23102122360865;2.10203610675005,2.42760029865851,1.92278846896178,2.21576546554056,2.93684255499157,1.83060080546609,2.20295501866808,2.11675831135261,2.23102122360865,2.16288506664153];
disp("(You will get the option to print the matrix A at the end of the program)");
disp(newline)
%%% For b=4.5*sum(A,2)
disp("====== For the b = 4.5*sum of elements of each row [4.5*sum(A,2)] ======")
b=4.5*sum(A,2);
disp(">Known solution (Since b = 4.5*sum(A,2)):")
disp("x=4.5,4.5,.....,4.5]");
disp(newline)
disp(">Using my implementation:")
x=SolveLinEqUsingCholeskyLDLT(A,b)
disp(">Using MATLAB Linsolve:")
x=linsolve(A,b)

%%% For b= 0,0...,0
disp(" ====== For the b = 0,0,...0 ======")
b=zeros(10,1);
disp(">Known solution (Since b contains 0s only):")
disp("x=[0,0,.....,0]");
disp(newline)
disp(">Using my implementation:")
x=SolveLinEqUsingCholeskyLDLT(A,b)
disp(">Timing (in seconds):")
f=@()SolveLinEqUsingCholeskyLDLT(A,b);
Time_Taken_In_Seconds=timeit(f)
disp(">Using MATLAB Linsolve:")
x=linsolve(A,b)
f=@()linsolve(A,b);
secondsTakenBy_MATLAB_Linsolve=timeit(f)


%%% Asking if the matrix A should be printed:
boolPrintA = input('Print whole Matrix A for the last case (10x10 S.P.D.)? -- [y/N]>>','s'); %Since N is uppercase in printing, it means "N" is the default response assumed. Therefore, only prints when "Y" or "y" is inputted.
if(upper(boolPrintA)=="Y")
    previousFormat=get(0,'Format');
    format long
    A
    %format short %reset to default matlab format
    format(previousFormat);
end

%% NOTIFYING END OF TEST
disp(newline)
disp(newline)
disp(newline)
disp(" ========================================================================================== ")
disp(" ========================================================================================== ")
disp(" ===================================== END OF TESTS =======================================")
disp(" ========================================================================================== ")
disp(" ========================================================================================== ")
disp(newline)