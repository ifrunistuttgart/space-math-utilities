% testPerturbations - script to show what the signalPerturbation functions do to
% a linear input signal

%% Reference signal
u = -10:0.1:10;

%% Disturbed signals
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
tiledlayout;
nexttile
plot(u,u,'k--')
hold on
plot(u,u_biased)
title('addBias()')
grid on
xlabel('u_in')
xlabel('u_out')

nexttile
plot(u,u,'k--')
hold on
plot(u,u_noisen)
title('addRandn()')
grid on
xlabel('u_in')
xlabel('u_out')

nexttile
plot(u,u,'k--')
hold on
plot(u,u_linscale)
title('linScaling()')
grid on
xlabel('u_in')
xlabel('u_out')

nexttile
plot(u,u,'k--')
hold on
plot(u,u_nlscale)
title('expScaling()')
grid on
xlabel('u_in')
xlabel('u_out')

nexttile
plot(u,u,'k--')
hold on
plot(u,u_smoothdeadzone)
title('smoothDeadZone()')
grid on
xlabel('u_in')
xlabel('u_out')

nexttile
plot(u,u,'k--')
hold on
plot(u,u_harddeadzone)
title('hardDeadZone()')
grid on
xlabel('u_in')
xlabel('u_out')

nexttile
plot(u,u,'k--')
hold on
plot(u,u_saturated)
title('saturation()')
grid on
xlabel('u_in')
xlabel('u_out')

nexttile
plot(u,u,'k--')
hold on
plot(u,u_discretised)
title('discreteSteps()')
grid on
xlabel('u_in')
xlabel('u_out')

nexttile
plot(u,u,'k--')
hold on
plot(u,u_outliers)
title('addOutliers()')
grid on
xlabel('u_in')
xlabel('u_out')
