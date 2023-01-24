%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     VARIABLE NAMES EXPLANATION     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%funct is the function to be integrated. 

%[a,b] and nx are intervals and value of n
%respectively for when applying Composite Newton-Cotes (Simpson's) 3/8 Rule. 

%[c,d] and ny are are intervals and value of n 
%respectively for when applying Composite Trapezoidal rule.

%Example funct declaration: funct = @(x,y) (sin(x.^2) + y.^2).

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%    EXPLAINING MY USAGE OF disp()   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disp(x) prints x.
%now, if X=['string1','string2',...,'stringN']
%disp(X) = string1string2....stringN
%
%Now, if "num" is some number. disp(num)= num.
%But, disp([num,'string']=string.
%So, to fix that, we have num2str(). num2str(num)='num'.
%Therefore, disp([num2str(num),'string'])=numstring.

%So, I end up using something like the following function a lot in this
%script in order to make the Command Window output extra readable
%at the cost of making the source a bit more complicated. This is a
%voulantary choice as the source of testing functions isn't as interesting
%to most people as the source of the actual function and its results
%(output of this script):
%disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);

%It outputs the following on the command window output: 
%"Int2D [for (nx,ny)=(currentvalueof_nx,currentvalueof_ny)]:    valueof2DIntegralCalculated

%Disp is also used similarly in a few other places.


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%     Testing for f(x,y)= (x^3)y  [FOR VARIOUS nx AND ny VALUES]    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Function: %%%
funct = @(x,y) (x.^3).*y;
%%% For Simpson 3/8 rule: %%%
a=1; b=3;     %keep in mind: nx is n for simpson's 3/8 rule
%%% For Trapezoidal rule: %%%
c=1; d=2;     %keep in mind: ny is n for trapezoidal rule

disp('********************************************');
disp('::[[Testing for f(x,y)= (x^3)y ]]::');
disp(['Intervals of integration: a,b,c,d =',num2str(a),',',num2str(b),',',num2str(c),',',num2str(d)]);
disp('------------------------------------------');

%%% 
% Calculating at various nx,ny
%%%
%nx,ny=3,1
nx=3;ny=1;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=3,7
nx=3;ny=7;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=9,1
nx=9;ny=1;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=6,10
nx=6;ny=10;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%   Testing for f(x,y)= e^x - e^y  [FOR VARIOUS nx AND ny VALUES]   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Function: %%%
funct = @(x,y) exp(x)-exp(y);
%%% For Simpson 3/8 rule: %%%
a=0; b=1;   %keep in mind: nx is n for simpson's 3/8 rule
%%% For Trapezoidal rule: %%%
c=1; d=0;   %keep in mind: ny is n for trapezoidal rule

disp('********************************************');
disp('::[[Testing for f(x,y)= e^x - e^y]]::');
disp(['Intervals of integration: a,b,c,d =',num2str(a),',',num2str(b),',',num2str(c),',',num2str(d)]);
disp('------------------------------------------');

%%% 
% Calculating at various nx,ny
%%%
%nx,ny=3,10
nx=3;ny=10; 
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=3,10
nx=3;ny=10; 
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=18,30
nx=18;ny=30;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=600,500
nx=600;ny=500;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=6000,5000
nx=6000;ny=5000;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%     Testing for f(x,y)= x(y^3)  [FOR VARIOUS nx AND ny VALUES]    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Function: %%%
funct = @(x,y) x.*(y.^3);
%%% For Simpson 3/8 rule: %%%
a=1; b=2;     %keep in mind: nx is n for simpson's 3/8 rule
%%% For Trapezoidal rule: %%%
c=1; d=3;     %keep in mind: ny is n for trapezoidal rule

disp('********************************************');
disp('::[[Testing for f(x,y)= x(y^3) ]]::');
disp(['Intervals of integration: a,b,c,d =',num2str(a),',',num2str(b),',',num2str(c),',',num2str(d)]);
disp(['I2aprx = ', num2str(integral2(funct,a,b,c,d)),' {Integral CALCULATED BY "integral2" (MatLab in-built, fairly accurate)}']);
disp('------------------------------------------');



%%% 
% Calculating at various nx,ny
%%%
%nx,ny=3,10
nx=3;ny=1; 
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=3,50
nx=3;ny=50;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=3,100
nx=3;ny=100;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=3,200
nx=3;ny=200;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=3,300
nx=3;ny=300;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
%nx,ny=3,700
nx=3;ny=490;
disp(['Int2D [for (nx,ny)=(',num2str(nx),',',num2str(ny),')]:   ',num2str(Int2D(funct,a,b,nx,c,d,ny))]);
