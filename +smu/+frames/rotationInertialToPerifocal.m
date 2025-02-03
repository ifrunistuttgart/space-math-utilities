function att_quat_PI = rotationInertialToPerifocal(position_I__m, velocity_I__m_per_s, gravitational_parameter__m3_per_s2)
%% rotationInertialToPerifocal - Calculate the rotation quaternion from inertial to perifocal frame
%   att_quat_PI = rotationInertialToPerifocal(position_I__m, velocity_I__m_per_s, gravitational_parameter__m3_per_s2)
%   Calculates the rotation quaternion from the inertial frame to the
%   perifocal frame given the position and velocity vectors in the inertial
%   frame and the gravitational parameter.
%
%   Inputs:
%   position_I__m: 3x1 vector of the position in the inertial frame
%   velocity_I__m_per_s: 3x1 vector of the velocity in the inertial frame
%   gravitational_parameter__m3_per_s2: Gravitational parameter of the
%       central body
%
%   Outputs:
%   att_quat_PI: 4x1 quaternion representing the rotation from the
%       inertial frame to the perifocal frame
%

arguments
    position_I__m (3,1) {mustBeNumeric, mustBeReal}
    velocity_I__m_per_s (3,1) {mustBeNumeric, mustBeReal}
    gravitational_parameter__m3_per_s2 (1,1) {mustBeNumeric, mustBeReal}
end

angular_momentum = cross(position_I__m, velocity_I__m_per_s);

perigee_vector = cross(velocity_I__m_per_s, angular_momentum) / gravitational_parameter__m3_per_s2 - position_I__m / norm(position_I__m);

P = perigee_vector / norm(perigee_vector);
W = angular_momentum / norm(angular_momentum);
Q = cross(W, P);

dcm_PI = [P, Q, W]';

att_quat_PI = smu.unitQuat.att.fromDcm(dcm_PI);

end