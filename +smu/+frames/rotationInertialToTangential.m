function att_quat_TI = rotationInertialToTangential(position_I__m, velocity_I__m_per_s)
%% rotationInertialToTangential - Calculate the rotation quaternion from inertial to tangential frame
%   att_quat_TI = rotationInertialToTangential(position_I__m, velocity_I__m_per_s)
%   Calculates the rotation quaternion from the inertial frame to the
%   tangential frame given the position and velocity vectors in the inertial
%   frame.
%
%   Inputs:
%   position_I__m: 3x1 vector of the position in the inertial frame
%   velocity_I__m_per_s: 3x1 vector of the velocity in the inertial frame
%
%   Outputs:
%   att_quat_TI: 4x1 quaternion representing the rotation from the
%       inertial frame to the tangential frame
%

arguments
    position_I__m (3,1) {mustBeNumeric, mustBeReal}
    velocity_I__m_per_s (3,1) {mustBeNumeric, mustBeReal}
end

angular_momentum = cross(position_I__m, velocity_I__m_per_s);

Y = -angular_momentum / norm(angular_momentum);
X = velocity_I__m_per_s / norm(velocity_I__m_per_s);
Z = cross(X, Y);

dcm_TI = [X, Y, Z]';

att_quat_TI = smu.unitQuat.att.fromDcm(dcm_TI);

end