function [resulting_force_B__N, ...
            resulting_torque_B__Nm] = ...
                            panelMethod(attitude_quaternion_BI, ...
                                        incoming_direction_I_I, ...
                                        pressure__N_per_m2, ...
                                        bodies, ...                                                       
                                        bodies_rotation_angles__rad)
%% panelMethod - Calculate the resulting force and torque on a geometry from incoming uniform pressure
%
%   [resulting_force_B__N, resulting_torque_B__Nm] ...
%                           = panelMethod(attitude_quaternion_BI, ...
%                                          rotational_velocity_BI_B__rad_per_s, ...
%                                          velocity_I_I__m_per_s, ...
%                                          density__kg_per_m3, ...
%                                          bodies, ...                                                       
%                                          bodies_rotation_angles__rad
%
%   This function calculates the response forces and torques from an incoming
%   pressure of any kind using the panel method (i.e. solar radiation pressure)
%
%   This function expects the space_math_utilities namespace to be available on the MATLAB path.
%
%   Inputs:
%    attitude_quaternion_BI: 4x1 array of the attitude quaternion from the body frame to the inertial frame
%    rotational_velocity_BI_B__rad_per_s: 3x1 array of the rotational velocity of the satellite with respect
%                                         to the inertial frame expressed in the body frame
%    incoming_direction_I_I: 3x1 array of the direction of the incoming
%                                       disturbance
%    pressure__N_per_m2: Scalar value of the pressure acting on the body
%    bodies: 1xN cell array of structures containing the vertices, surface centroids, surface normals,
%            rotation direction, rotation hinge point, surface temperatures,
%            surface energy accommodation coefficients, and surface areas of the bodies
%    bodies_rotation_angles__rad: 1xN array of the rotation angles of the bodies
%
%  Outputs:
%   resulting_force_B__N: 3x1 array of the aerodynamic force acting on the satellite expressed in the body frame
%   resulting_torque_B__Nm: 3x1 array of the aerodynamic torque acting on the satellite with respect to the 
%                               center of mass (origin of body frame) expressed in the body frame
%

%% Abbreviations
q_BI = attitude_quaternion_BI;
dir_I = incoming_direction_I_I;

%% Extract data from bodies structure
% Get total number of faces of all bodies
num_bodies = length(bodies);
bodies_num_faces = zeros(1, num_bodies);
for i = 1:num_bodies
    current_body = bodies{i};
    bodies_num_faces(i) = size(current_body.vertices_B,3);
end
total_num_faces = sum(bodies_num_faces);

% Prepare variables
% Surface Areas
areas = nan(1, total_num_faces);
% Reflectivities
reflectivities = areas;
% Vertex coordinates
vertices_B = nan(3, 3, total_num_faces);
% Surface normals
normals_B = nan(3, total_num_faces);
% Surface centroids
centroids_B = normals_B;


last_face_idx = 0;
for i = 1:num_bodies
    current_body = bodies{i};

    current_indices = last_face_idx + (1:bodies_num_faces(i));

    %% Extract nondirectional data from current body
    areas(current_indices) = current_body.areas;
    reflectivities(current_indices) = current_body.reflectivities;

    %% Rotate directional data according to bodies_rotation_angles__rad  
    current_angle__rad = bodies_rotation_angles__rad(i);
    current_rotation_direction_B = current_body.rotation_direction_B;
    current_rotation_hinge_point_B = current_body.rotation_hinge_point_B;

    [vertices_B(:,:,current_indices), ...
     centroids_B(:,current_indices), ...
     normals_B(:,current_indices)] = rotateBody(current_body.vertices_B, ...
                                                current_body.centroids_B, ...
                                                current_body.normals_B, ...
                                                current_angle__rad, ...
                                                current_rotation_direction_B, ...
                                                current_rotation_hinge_point_B);

    %% Update last face index for the next iteration
    last_face_idx = current_indices(end);
end

%% Determine shadowed faces
%  To calculate the resulting response, only the faces that are not shadowed by other faces
%  are considered. The shadowing is only determined by approximation. Effects due
%  the rotational velocity of the satellite are ignored. 

% Transform wind velocity into body frame
dir_B = smu.unitQuat.att.transformVector(q_BI, dir_I);
dir_B = dir_B ./ norm(dir_B); % make sure its a unit vector

ind_not_shadowed = ~determineShadowedTriangles(vertices_B, centroids_B, normals_B, dir_B);

%% Calculate forces and torques

% Forces and Torques
[resulting_force_B__N, resulting_torque_B__Nm] ...
        = calcPanelForceAndTorque(areas(ind_not_shadowed), ...
                                    normals_B(:, ind_not_shadowed), ...
                                    centroids_B(:, ind_not_shadowed), ...
                                    reflectivities,...                                    
                                    dir_B, ...
                                    pressure__N_per_m2);

end