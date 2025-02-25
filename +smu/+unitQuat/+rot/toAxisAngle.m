function [axis_D, angle] = toAxisAngle(rot_quat_BA_D)
%% toAxisAngle - Extract the axis and angle from a rotation quaternion
%   [axis_D, angle] = toAxisAngle(rot_quat_BA_D)
%   Extracts the axis and angle from a rotation quaternion.
%
% Inputs:
%   rot_quat_BA_D: 4xN array of rotation quaternions from frame B to frame A with a rotation
%     axis expressed in frame D
%
% Outputs:
%   axis_D: 3xN array of unit vectors specifying the axis of rotation expressed in frame D
%   angle: 1xN array of angles in radians to rotate around the axis
%

arguments
    rot_quat_BA_D (4,:) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
end

% Extract the axis and angle
angle = 2 * acos(rot_quat_BA_D(1,:));
axis_D = rot_quat_BA_D(2:4,:) ./ sin(angle / 2);

end