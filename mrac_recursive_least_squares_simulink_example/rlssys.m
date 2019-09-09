function [sys,x0,str,ts] = rlssys(t,x,u,flag,th0,p0,ff)
%Recursive Least Squares S-Function

n=length(th0);

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(th0,p0,n);

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=mdlDerivatives(t,x,u,n,ff);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,n);

  %%%%%%%%%%%%%%%%%%%
  % Unhandled flags %
  %%%%%%%%%%%%%%%%%%%
  case { 2, 4, 9 },
    sys = [];

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end
% end csfunc

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes(th0,p0,n)

sizes = simsizes;
sizes.NumContStates  = n+n^2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = n;
sizes.NumInputs      = n+1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);
P0=p0*eye(n);
x0  = [th0;P0(:)];
str = [];
ts  = [0 0];

% end mdlInitializeSizes
%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u,n,ff)

th=x(1:n);
y=u(1); w=u(2:n+1); 
P=x(n+1:n+n*n); P=reshape(P,n,n);
P=(P+P')/2; %make sure P stays symmetric
e=w'*th-y;
dP=ff*P-P*w*w'*P;
dth=-P*e*w;
sys = [dth;dP(:)];

% end mdlDerivatives
%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,n)

sys = x(1:n);

% end mdlOutputs