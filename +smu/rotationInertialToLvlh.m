function quaternion_OI = rotationInertialToLvlh(position_I__m, velocity_I__m_per_s)
%% rotationInertialToLvlh - Calculate the rotation quaternion from inertial to LVLH frame
%   quaternion_OI = rotationInertialToLvlh(position_I__m, velocity_I__m_per_s)
%   Calculates the rotation quaternion from the inertial frame to the LVLH
%   frame given the position and velocity vectors in the inertial frame.
%
%   Inputs:
%   position_I__m: 3x1 vector of the position in the inertial frame
%   velocity_I__m_per_s: 3x1 vector of the velocity in the inertial frame
%
%   Outputs:
%   quaternion_OI: 4x1 quaternion representing the rotation from the
%       inertial frame to the LVLH frame
%

arguments
    position_I__m (3,1) {mustBeNumeric, mustBeReal}
    velocity_I__m_per_s (3,1) {mustBeNumeric, mustBeReal}
end

angular_momentum = cross(position_I__m, velocity_I__m_per_s);

Y = -angular_momentum / norm(angular_momentum);
Z = position_I__m / norm(position_I__m);
X = cross(Y, Z);

quaternion_OI = dcm2quat([X,Y,Z]);

end