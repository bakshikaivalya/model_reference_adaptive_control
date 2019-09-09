% Global parameters
%global c bet0 bet1

%Plant Parameters
m=1; b=2;

% System and controller parameters
zeta=0.8; wn=10;
bet1=2*zeta*wn; bet0=wn*wn; gamma=1;
%m1=400; m2=0;
%tf=5;

% Adaptation gain vector computation
A=[0 1;-bet0 -bet1];
P=lyap(A',eye(size(A)));
c=gamma*[0 1]*P; c=c';
gam1=100; gam2=10;

return

%Plot the Results
figure(1)
subplot(211)
plot(tc,e(:,1));
xlabel('Time (sec)');
ylabel('Tracking Error');
title('Optimal Gains: gam1=100, gam2=10')
subplot(212)
plot(tc,par);
xlabel('Time (sec)');
ylabel('Parameters');

%Plot the Results
figure (2)
subplot(211)
plot(tc1,par1);
%xlabel('Time (sec)');
ylabel('Parameters');
title('Low Gains: gam1=10, gam2=1')
subplot(212)
plot(tc2,par2);
xlabel('Time (sec)');
ylabel('Parameters');
title('High Gains: gam1=1000, gam2=100')


