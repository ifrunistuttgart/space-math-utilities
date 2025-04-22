function [resultingForce__N, resultingTorque__Nm] ...
                                = calcPanelForceAndTorque(areas__m2, ...
                                                           normals, ...
                                                           centroids__m, ...
                                                           reflectivities, ...                                                            
                                                           pressure_dir_B, ...
                                                           pressure_magnitude__N_per_m2)
% calcAeroForceAndTorque - Calculate the aerodynamic force and torque acting on a body
%
%   [resultingForce__N, resultingTorque__Nm] ...
%                                 = calcPanelForceAndTorque(areas__m2, ...
%                                                            normals, ...
%                                                            centroids__m, ...
%                                                            reflectivities, ...                                                            
%                                                            pressure_dir_B, ...
%                                                            pressure__N_per_m2)
%
%   This function calculates the force and torque acting on a body
%   due to a pressure (i.e. solar radiation pressure) and its direction
%
%   Inputs:
%   areas__m2: 1xN array of the areas of N triangles
%   normals: 3xN array of surface normals of N triangles
%   centroids__m: 3xN array of surface centroids of N triangles
%   reflectivities: 1xN array of reflectivities of the surfaces
%   pressure_dir_B: 3x1 array of the direction of incoming pressure
%   pressure_magnitude__N_per_m2: magnitude of incoming pressure in N/m^2
%
%   Outputs:
%   resultingForce__N: 3x1 array of the resulting force acting on the body in the same coordinate
%                 system as the inputs normals and centroids
%   resultingTorque__Nm: 3x1 array of the resulting torque acting on the body in the same
%                   coordinate system as the inputs normals and centroids and with respect to its origin 
%
%% References:
% adapted from ifrunistuttgart/vleo-aerodynamics-core
% and
% [1] D. A. Vallado, "Solar-Radiation Pressure" in Fundamentals of 
% astrodynamics and applications in Space technology library, no. 21. 
% Torrance, CA: Microcosm Press, 2022. pp. 

%% Global forces and torques
resultingForce__N = zeros(3,1);
resultingTorque__Nm = zeros(3,1);

for i=1:numel(areas__m2)

    cosTheta = pressure_dir_B'*normals(:,i);

    % Forces
    forceIncr = zeros(3,1);

    % Panels in the same direction as pressure are not counted
    if cosTheta<0 
        forceIncr = -pressure_magnitude__N_per_m2*cosTheta*areas__m2(i)...
                        *((1-reflectivities(i))*pressure_dir_B ...
                          + 2*reflectivities(i)*cosTheta*normals(:,i));    
    end
    

    
    % Torques
    torqueIncr = cross(centroids__m(:,i), forceIncr);
    
    % Output
    resultingForce__N = resultingForce__N+forceIncr;
    resultingTorque__Nm = resultingTorque__Nm+torqueIncr;
end

end