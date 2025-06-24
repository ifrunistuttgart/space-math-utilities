function att_quat_RI = rotationInertialToRTN(position_I__m, velocity_I__m_per_s)
%% rotationInertialToRTN - Calculate the rotation quaternion from inertial to RTN frame
%   att_quat_RI = rotationInertialToRTN(position_I__m, velocity_I__m_per_s)
%   Calculates the rotation quaternion from the inertial frame to the
%   tangential frame given the position and velocity vectors in the inertial
%   frame.
%
%   Inputs:
%   position_I__m: 3x1 vector of the position in the inertial frame
%   velocity_I__m_per_s: 3x1 vector of the velocity in the inertial frame
%
%   Outputs:
%   att_quat_RI: 4x1 quaternion representing the rotation from the
%       inertial frame to the tangential frame
%

arguments
    position_I__m (3,1) {mustBeNumeric, mustBeReal}
    velocity_I__m_per_s (3,1) {mustBeNumeric, mustBeReal}
end

angular_momentum = cross(position_I__m, velocity_I__m_per_s);

X = position_I__m / norm(position_I__m);
Z = angular_momentum/norm(angular_momentum);
Y = cross(Z,X);

dcm_RI = [X, Y, Z]';

att_quat_RI = smu.unitQuat.att.fromDcm(dcm_RI);

end