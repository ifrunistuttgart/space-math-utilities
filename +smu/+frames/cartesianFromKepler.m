function [position__m, velocity__m_per_s] = cartesianFromKepler(semi_major_axis__m, ...
                                                        eccentricity, ...
                                                        inclination__rad, ...
                                                        right_ascension_of_ascending_node__rad, ...
                                                        argument_of_periapsis__rad, ...
                                                        true_anomaly__rad, ...
                                                        gravitational_parameter__m3_per_s2)
%% cartesianFromKepler - Translates Kepler Elements to Cartesian Position and Velocity Vectors
%
%   Inputs:
%       gravitational_parameter_m3_per_s2: Gravitational parameter of the central body
%       semi_major_axis__m: semi-major axis of the orbit
%       eccentricity: eccentricity of the orbit
%       inclination__rad: inclination of the orbit
%       right_ascension_of_ascending_node__rad: right ascension of the orbit's ascending node 
%       argument_of_periapsis__rad: argument of the orbit's periapsis
%       true_anomaly__rad: true anomaly of current position
%   
%   Outputs:
%       position__m:   position vector from the central body to spacecraft
%       velocity__m_per_s: velocity vector of the spacecraft
%
%% References:
% [1] R. R. Bate, D. D. Mueller, and J. E. White, Fundamentals of Astrodynamics, 1st ed. in Dover books on astronomy. New York: Dover Publications, 1971.


arguments
    semi_major_axis__m (1,1) {mustBeNumeric, mustBeReal, mustBeNonzero, mustBeFinite}
    eccentricity (1,1) {mustBeNumeric, mustBeReal, mustBePositive, mustBeValidEccentricity(eccentricity, semi_major_axis__m)}
    inclination__rad (1,1) {mustBeNumeric, mustBeReal}
    right_ascension_of_ascending_node__rad (1,:) {mustBeNumeric, mustBeReal}
    argument_of_periapsis__rad (1,1) {mustBeNumeric, mustBeReal}
    true_anomaly__rad (1,1) {mustBeNumeric, mustBeReal}
    gravitational_parameter__m3_per_s2 (1,1) {mustBeNumeric, mustBeReal, mustBePositive}
end

%% Abbreviations

% shape of the orbit
a = semi_major_axis__m;
ecc = eccentricity;
% orientation of the orbit
inc = inclination__rad;
RAAN = right_ascension_of_ascending_node__rad;
omega = argument_of_periapsis__rad;
% position of the spacecraft
nu = true_anomaly__rad;
% gravitational parameter
mu = gravitational_parameter__m3_per_s2;

%% Algorithm from [1]

% Calculations in perifocal frame
% Position
p = a * (1 - ecc^2);
r_mag = p / (1 + ecc * cos(nu));

pos_P__m = r_mag * [cos(nu); sin(nu); 0];

% Velocity
vel_P__m_per_s = sqrt(mu / p) * [-sin(nu); ecc + cos(nu); 0];

% Determine direction cosine matrix from inc, RAAN, and omega 
DCM = zeros(3,3);

cInc = cos(inc);
sInc = sin(inc);
cRaan = cos(RAAN);
sRaan = sin(RAAN);
cOmega = cos(omega);
sOmega = sin(omega);

DCM(1,1) = cRaan * cOmega - sRaan * sOmega * cInc;
DCM(1,2) = -cRaan * sOmega - sRaan * cOmega * cInc;
DCM(1,3) = sRaan * sInc;

DCM(2,1) = sRaan * cOmega + cRaan * sOmega * cInc;
DCM(2,2) = -sRaan * sOmega + cRaan * cOmega * cInc;
DCM(2,3) = -cRaan * sInc;

DCM(3,1) = sOmega * sInc;
DCM(3,2) = cOmega * sInc;
DCM(3,3) = cInc;

% Transformation to equatorial frame
position__m = DCM * pos_P__m;
velocity__m_per_s = DCM * vel_P__m_per_s;

end

%% Custom validation functions

function mustBeValidEccentricity(ecc, a)
    if any(ecc == 1)
        eid = "mustBeValidEccentricity:isOne";
        msg = "Eccentricity must not be equal to 1.";
        error(eid,msg)
    end

    if (a > 0) && any(ecc >= 1)
        eid = "mustBeValidEccentricity:isGreaterThanOneForEllipticalOrbit";
        msg = "Eccentricity must be less than 1 for elliptical orbits.";
        error(eid,msg)
    end

    if (a < 0) && any(ecc <= 1)
        eid = "mustBeValidEccentricity:isLessThanOneForHyperbolicOrbit";
        msg = "Eccentricity must be greater than 1 for hyperbolic orbits.";
        error(eid,msg)
    end
end