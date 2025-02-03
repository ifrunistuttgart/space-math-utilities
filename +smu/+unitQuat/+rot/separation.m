function rot_quat_CB_D = separation(rot_quat_CA_D, rot_quat_BA_D)
%% Separation of rotation quaternions
%   rot_quat_CB_D = separation(rot_quat_CA_D, rot_quat_BA_D)
%
%   This function calculates the separation of two rotation quaternions.
%   Given the rotation quaternion from frame A to frame C with a rotation axis
%   expressed in frame D, and the rotation quaternion from frame A to frame B
%   with a rotation axis expressed in frame D, this function calculates the
%   rotation quaternion from frame B to frame C with a rotation axis expressed
%   in frame D.
%
%   Inputs:
%   - rot_quat_CA_D: Rotation quaternion from frame A to frame C with a rotation
%     axis expressed in frame D
%   - rot_quat_BA_D: Rotation quaternion from frame A to frame B with a rotation
%     axis expressed in frame D
%
%   Outputs:
%   - rot_quat_CB_D: Rotation quaternion from frame B to frame C with a rotation
%     axis expressed in frame D
%

arguments
    rot_quat_CA_D (4,1) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
    rot_quat_BA_D (4,:) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
end
% Calculate the separation of two rotation quaternions
inv_rot_quat_BA_D = smu.unitQuat.invert(rot_quat_BA_D);
rot_quat_CB_D = smu.unitQuat.qpml(rot_quat_CA_D) * inv_rot_quat_BA_D;

end