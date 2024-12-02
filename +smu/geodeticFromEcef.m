function [geodetic_latitude__rad, longitude__rad, geodetic_altitude__m] = geodeticFromEcef(x_ecef__m, y_ecef__m, z_ecef__m, precision__m, initial_geodetic_latitude__rad)
% geodeticFromEcef - Convert ECEF coordinates to geodetic coordinates
%  [geodetic_latitude__rad, longitude__rad, geodetic_altitude__m] = geodeticFromEcef(x_ecef__m, y_ecef__m, z_ecef__m, precision__m, initial_geodetic_latitude__rad)
%  Convert ECEF coordinates to geodetic coordinates using an iterative
%  algorithm.
%
%  Inputs:
%   x_ecef__m: scalar, x-coordinate in ECEF frame in meters
%   y_ecef__m: scalar, y-coordinate in ECEF frame in meters
%   z_ecef__m: scalar, z-coordinate in ECEF frame in meters
%   precision__m: optional, scalar, precision of the calculation in meters
%   initial_geodetic_latitude__rad: optional, scalar, initial guess for the geodetic latitude in radians (can be used to speed up the calculation)
%
%  Outputs:
%   geodetic_latitude__rad: scalar, geodetic latitude in radians
%   longitude__rad: scalar, longitude in radians
%   geodetic_altitude__m: scalar, geodetic altitude in meters
%
%% References:
% [1] O. Montenbruck and G. Eberhard, "Geodetic Datums," in Satellite orbits: models, methods, and applications, Berlin : New York: Springer, 2000, pp. 185–189.

%% Input validation
arguments
    x_ecef__m (1,1) {mustBeNumeric, mustBeReal}
    y_ecef__m (1,1) {mustBeNumeric, mustBeReal}
    z_ecef__m (1,1) {mustBeNumeric, mustBeReal, mustBeValidInputCoordinates(x_ecef__m, y_ecef__m, z_ecef__m)}
    precision__m (1,1) {mustBeGreaterThan(precision__m, 0)} = 1e-2
    initial_geodetic_latitude__rad {mustBeScalarOrEmpty, mustBeNumeric, mustBeValidLatitude} = []
end

%% Abbreviations
e2 = 0.00669437999014; % Earth's eccentricity squared (from WGS84)
R = 6378137; % Earth radius at equator (from WGS84)

x = x_ecef__m;
y = y_ecef__m;
z = z_ecef__m;
d2 = x^2 + y^2;

%% Algorithm from [1]
% Initialization
if isempty(initial_geodetic_latitude__rad)
    % No initial value for phi provided, use initialisation from [1]
    delta_z = e2 * z;
    [N_prev, delta_z_prev] = recursion(delta_z, z, d2, R, e2);
else
    % Initial value for phi provided, use it
    sinphi = sin(initial_geodetic_latitude__rad);
    [N_prev, delta_z_prev] = computeNandDeltaZ(R, e2, sinphi);
end

% Iteration
while true
    % Recursion
    [N, delta_z] = recursion(delta_z_prev, z, d2, R, e2);

    % Stop iteration if delta_z and N changed less than precision__m
    if max([abs(N - N_prev), abs(delta_z - delta_z_prev)]) < precision__m
        break;
    else
        N_prev = N;
        delta_z_prev = delta_z;
    end
end

% Output
longitude__rad = atan2(y,x);
geodetic_latitude__rad = atan( (z + delta_z) / sqrt(d2) );
geodetic_altitude__m = sqrt(d2 + (z + delta_z)^2) - N;

end

%% Helper functions

function [N, delta_z] = computeNandDeltaZ(R, e2, sinphi)
    N = R / sqrt(1 - e2 * sinphi^2);
    delta_z = N * e2 * sinphi;
end

function [N, delta_z] = recursion(delta_z, z, d2, R, e2)
    % Update sinphi
    sinphi = (z + delta_z) / sqrt(d2 + (z + delta_z)^2);
    % Compute N and delta_z
    [N, delta_z] = computeNandDeltaZ(R, e2, sinphi);
end

%% Custom validation functions

function mustBeValidInputCoordinates(x, y, z)
    try
        mustBeNonzeroMatrix([x; y; z])
    catch ME
        if strcmp(ME.identifier, 'mustBeNonzeroMatrix:zeroMatrix')
            error('Coordinates:Invalid','Coordinates must not all be zero.')
        else
            rethrow(ME)
        end
    end
end

function mustBeValidLatitude(latitude)
    if ~isempty(latitude) && abs(latitude) > pi/2
        mustBeInRange(latitude, pi/2, pi/2)
    end
end