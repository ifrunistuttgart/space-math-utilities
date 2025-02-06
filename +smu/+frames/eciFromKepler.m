function [pos_eci__m, vel_eci__m_s] = eciFromKepler(mu_m3_s2, semi_major_axis__m, eccentricity, ...
                        inclination__rad, RAAN__rad, ...
                        argument_of_periapsis__rad, true_anomaly__rad)
% eciFromKepler - Translates the orbital elements of a spacecraft to the cartesian position 
% and velocity vectors relative to the Earth centered inertial reference frame.
% Only for elliptic orbits.
%
%   Inputs:
%       mu_m3_s2:           gravitational parameter of Earth
%       semi_major_axis__m: semi major axis of the orbit
%       eccentricity:       eccentricity ranging, 0 to 1
%       inclination__rad:   inclination, 0 to pi
%       RAAN__rad:          right ascension of the ascending node, 0 to 2pi
%       argument_of_periapsis__rad: argument of periapsis, 0 to 2pi
%       true_anomaly__rad:          true anomaly of current position, 0 to 2pi
%   
%   Outputs:
%       pos_BI_I__m:   position - vector from center of ECI to spacecraft in
%                      inertial coordinates
%       vel_BI_I__m_s: velocity of the spacecraft relative to ECI in
%                      inertial coordinates

arguments
    mu_m3_s2            {mustBeNumeric, mustBeReal}
    semi_major_axis__m  {mustBeNumeric, mustBeReal, mustBePositive}
    eccentricity        {mustBeNumeric, mustBeReal, mustBeInRange(eccentricity,0,0.999)}
    inclination__rad    {mustBeNumeric, mustBeReal, mustBeInRange(inclination__rad,0,3.1415926536)}
    RAAN__rad           {mustBeNumeric, mustBeReal, mustBeInRange(RAAN__rad,0,6.2831853072)}
    argument_of_periapsis__rad  {mustBeNumeric, mustBeReal, mustBeInRange(argument_of_periapsis__rad,0,6.2831853072)}
    true_anomaly__rad   {mustBeNumeric, mustBeReal, mustBeInRange(true_anomaly__rad,0,6.2831853072)}
end

mu = mu_m3_s2;
sma = semi_major_axis__m;
ecc = eccentricity;
inc = inclination__rad;
nu = true_anomaly__rad;
w = argument_of_periapsis__rad;
theta__rad = w + nu;

pos_eci__m = zeros(3, 1);
vel_eci__m_s = zeros(3, 1);

% Calculate the semi-latus rectum and radius
l = sma * (1.0 - ecc^2);
r_p = l / (1.0 + ecc * cos(nu));
h = sqrt(mu * l);

% Get position
pos_eci__m(1) = r_p * (cos(theta__rad) * cos(RAAN__rad) - cos(inc)...
                * sin(theta__rad) * sin(RAAN__rad));
pos_eci__m(2) = r_p * (cos(theta__rad) * sin(RAAN__rad) + cos(inc)...
                * sin(theta__rad) * cos(RAAN__rad));
pos_eci__m(3) = r_p * sin(theta__rad) * sin(inc);

% Get velocity
vel_eci__m_s(1) = -mu / h * (cos(RAAN__rad) * (ecc * sin(w) + sin(theta__rad)) + ...
                     cos(inc) * (ecc * cos(w) + cos(theta__rad)) * sin(RAAN__rad));
vel_eci__m_s(2) = -mu / h * (sin(RAAN__rad) * (ecc * sin(w) + sin(theta__rad)) - ...
                     cos(inc) * (ecc * cos(w) + cos(theta__rad)) * cos(RAAN__rad));
vel_eci__m_s(3) = mu / h * (ecc * cos(w) + cos(theta__rad)) * sin(inc);

