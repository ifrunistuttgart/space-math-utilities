% testPerturbations - script to show what the signalPerturbation functions do to
% a linear input signal

clc
clear 
close all

%% Reference signal
t = -10:0.1:10;
u = -10:0.1:10;


%% Disturb signal
u_biased = smu.signalPerturbation.addBias(u,1);
u_noisen = smu.signalPerturbation.addRandn(u,1);
u_linscale = smu.signalPerturbation.linScaling(u,1.5);
u_nlscale = smu.signalPerturbation.expScaling(u,0.7);
u_smoothdeadzone = smu.signalPerturbation.smoothDeadZone(u,2);
u_harddeadzone = smu.signalPerturbation.hardDeadZone(u,2);
u_saturated = smu.signalPerturbation.saturation(u,-6,6);
u_discretised = smu.signalPerturbation.discreteSteps(u,2);
u_outliers = smu.signalPerturbation.addOutliers(u,0.2,4);

%% Plotting
figure
subplot(3,3,1)
plot(t,u,'k--')
hold on
plot(t,u_biased)
title('addBias()')
grid on
xlabel('t')
ylabel('u')

subplot(3,3,2)
plot(t,u,'k--')
hold on
plot(t,u_noisen)
title('addRandn()')
grid on
xlabel('t')
ylabel('u')

subplot(3,3,3)
plot(t,u,'k--')
hold on
plot(t,u_linscale)
title('linScaling()')
grid on
xlabel('t')
ylabel('u')

subplot(3,3,4)
plot(t,u,'k--')
hold on
plot(t,u_nlscale)
title('expScaling()')
grid on
xlabel('t')
ylabel('u')

subplot(3,3,5)
plot(t,u,'k--')
hold on
plot(t,u_smoothdeadzone)
title('smoothDeadZone()')
grid on
xlabel('t')
ylabel('u')

subplot(3,3,6)
plot(t,u,'k--')
hold on
plot(t,u_harddeadzone)
title('hardDeadZone()')
grid on
xlabel('t')
ylabel('u')

subplot(3,3,7)
plot(t,u,'k--')
hold on
plot(t,u_saturated)
title('saturation()')
grid on
xlabel('t')
ylabel('u')

subplot(3,3,8)
plot(t,u,'k--')
hold on
plot(t,u_discretised)
title('discreteSteps()')
grid on
xlabel('t')
ylabel('u')

subplot(3,3,9)
plot(t,u,'k--')
hold on
plot(t,u_outliers)
title('addOutliers()')
grid on
xlabel('t')
ylabel('u')
