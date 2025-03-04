clc
clear
close all

%% Example small
% P is the position of interest A is the light source, B is the shading object

r_A = [0,0,0]';
r_B = [50,0,0]';

radius_A = 15;
radius_B = 20;

r_P_log = [];
sunLum_log = [];
for i = 1:100000
    r_P= 100*[2*rand-0.5,rand-0.5,rand-0.5]';
    sunLum = smu.conicalShadowing(r_P,r_A,r_B,radius_A,radius_B);

    r_P_log = [r_P_log,r_P];
    sunLum_log = [sunLum_log,sunLum];
end

%% Plotting 2D
f = figure;
hold on
axis equal

twoD_idx = ismembertol(r_P_log(3,:),0,0.01);

scatter(r_P_log(1,twoD_idx==1),r_P_log(2,twoD_idx==1),25, ... ...
        sunLum_log(twoD_idx==1),"filled")


% Draw Objects
posCirc = [r_A(1:2)'-radius_A 2*radius_A 2*radius_A];
rectangle('Position',posCirc,'Curvature',[1 1]);

posCirc = [r_B(1:2)'-radius_B 2*radius_B 2*radius_B];
rectangle('Position',posCirc,'Curvature',[1 1]);


colormap jet
colorbar

%% Plotting 3D
f = figure;

% only draw occulted values
idx = ismembertol(sunLum_log,1,0.2)==0;

% Draw Objects
ax1 = axes;
ellipsoid(ax1,r_A(1,:),r_A(2,:),r_A(3,:),radius_A,radius_A,radius_A,FaceColor='none');
hold on
ellipsoid(ax1,r_B(1,:),r_B(2,:),r_B(3,:),radius_B,radius_B,radius_B,FaceColor='none');
axis equal

ax2 = axes;
sc = scatter3(ax2,r_P_log(1,idx),r_P_log(2,idx),r_P_log(3,idx),25,sunLum_log(idx),"filled");
sc.MarkerFaceAlpha = 0.1;
% hold on
axis equal

hLink = linkprop([ax1,ax2],{'XLim','YLim','ZLim','CameraUpVector','CameraPosition','CameraTarget'});
axis([-50,150,-100,100,-100,100])


% Hide the top axes
ax2.Visible = 'off';
ax2.XTick = [];
ax2.YTick = [];

colormap(ax2,jet);

cb2 = colorbar(ax2,'Position',[0.81 0.1 0.05 0.815]);
clim([0,1])

setappdata(gcf,'StoreTheLink',hLink); % store the link so that they can rotate and zoom synchronically
