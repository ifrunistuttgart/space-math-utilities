function rot_quat_BA_D = fromAxisAngle(axis_D, angle)
%% fromAxisAngle - Create a unit quaternion from an axis-angle representation
%   rot_quat_BA_D = fromAxisAngle(axis, angle)
%   Creates a unit quaternion from an axis-angle representation. The axis
%   must be a non-zero vector.
%
% Inputs:
%   axis_D: 3xN array of non-zero vectors specifying the axis of rotation expressed in frame D
%   angle: 1xN array of angles in radians to rotate around the axis
%
% Outputs:
%   rot_quat_BA_D: 4xN array of rotation quaternions from frame B to frame A with a rotation
%     axis expressed in frame D
%

arguments
    axis_D (3,:) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeNonzeroMatrix}
    angle (1,:) {mustBeNumeric, mustBeReal}
end

% Normalize the axis
axis_D = axis_D ./ vecnorm(axis_D, 2, 1);

% Calculate the quaternion
rot_quat_BA_D = [cos(angle / 2); ...
                    sin(angle / 2) .* axis_D];

end