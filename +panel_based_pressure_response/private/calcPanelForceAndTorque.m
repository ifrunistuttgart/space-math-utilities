function [resultingForce__N, resultingTorque__Nm] ...
                                = calcPanelForceAndTorque(areas__m2, ...
                                                            normals, ...
                                                            centroids__m, ...
                                                            reflectivities, ...                                                            
                                                            dir_B, ...
                                                            pressure__N_per_m2)
% calcAeroForceAndTorque - Calculate the aerodynamic force and torque acting on a body
%
%   [aeroForce_B__N, aerotorque_B__Nm] = calcAeroForceAndTorque(areas__m2, ...
%                                                                   normals, ...
%                                                                   centroids__m, ...
%                                                                   v_rels__m_per_s, ...
%                                                                   deltas__rad, ...
%                                                                   density__kg_per_m3, ...
%                                                                   gas_temperature__K, ...
%                                                                   surface_temperatures__K, ...
%                                                                   energy_accommodation_coefficients, ...
%                                                                   particles_mass__kg, ...
%                                                                   temperature_ratio_method)
%
%   This function calculates the aerodynamic force and torque acting on a body
%   due to the impact of particles on its surface.
%
%   Inputs:
%   areas__m2: 1xN array of the areas of N triangles
%   normals: 3xN array of surface normals of N triangles
%   centroids__m: 3xN array of surface centroids of N triangles
%   v_rels__m_per_s: 3xN array of relative velocities of N triangles
%   deltas__rad: 1xN array of angles between the flow direction and the normals of N triangles
%   density__kg_per_m3: Scalar value of the density of the gas
%   gas_temperature__K: Scalar value of the temperature of the gas
%   surface_temperatures__K: 1xN array of the N triangles' temperatures
%   energy_accommodation_coefficients: 1xN array of the energy accommodation coefficients
%                                      of N triangles
%   particles_mass__kg: Scalar value of the mass of the particles
%   temperature_ratio_method: Scalar value of the method to calculate the temperature ratio
%                             1: Exact term according to [1]
%                             2: Hyperthermal approximation according to [1]
%                             3: Hyperthermal approximation according to [2]
%
%   Outputs:
%   aeroForce__N: 3x1 array of the aerodynamic force acting on the body in the same coordinate
%                 system as the inputs normals and centroids
%   aeroTorque__Nm: 3x1 array of the aerodynamic torque acting on the body in the same
%                   coordinate system as the inputs normals and centroids and with respect to its origin 
%
%% References:
% [1] L. H. Sentman, “Free Molecule Flow Theory and Its Application to the Determination of Aerodynamic Forces,” Defense Technical Information Center, Fort Belvoir, VA, LMSC-448514, Oct. 1961.
% [2] F. Tuttas, C. Traub, M. Pfeiffer, and W. Fichter, “Generalized Treatment of Energy Accommodation in Gas-Surface Interactions for Satellite Aerodynamics Applications,” 2024, arXiv. doi: 10.48550/ARXIV.2411.11597.
% [3] G. Koppenwallner, “Energy Accomodation Coefficient and Momentum Transfer Modeling,” HTG-TN-08-11, Dec. 2009.

%% Abbreviations

%% Global forces and torques
resultingForce__N = zeros(3,1);
resultingTorque__Nm = zeros(3,1);

for i=1:numel(areas__m2)

    cosTheta = dir_B'*normals(:,i);

    % Forces
    forceIncr = zeros(3,1);

    % Panels in the same direction as pressure are not counted
    if cosTheta<0 
        forceIncr = -pressure__N_per_m2*cosTheta*areas__m2(i)...
                        *((1-reflectivities(i))*dir_B ...
                          + 2*reflectivities(i)*cosTheta*normals(:,i));    
    end
    

    
    % Torques
    torqueIncr = cross(centroids__m(:,i), forceIncr);
    
    % Output
    resultingForce__N = resultingForce__N+forceIncr;
    resultingTorque__Nm = resultingTorque__Nm+torqueIncr;
end

end