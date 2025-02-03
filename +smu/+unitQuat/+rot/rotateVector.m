function r_out_D = rotateVector(rot_quat_BA_D, r_in_D)
%% Rotate a vector
%   r_out_D = rotateVector(rot_quat_BA_D, r_in_D)
%
%   This function rotates a vector using a rotation quaternion.
%
%   Inputs:
%   - rot_quat_BA_D: Rotation quaternion from frame B to frame A with a rotation
%     axis expressed in frame D
%   - r_in_D: Input vector to be rotated expressed in frame D
%
%   Outputs:
%   - r_out_D: Rotated vector expressed in frame D
%

arguments
    rot_quat_BA_D (4,1) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
    r_in_D (3,:) {mustBeNumeric, mustBeReal}
end

inv_rot_quat_BA_D = smu.unitQuat.invert(rot_quat_BA_D);

num_points = size(r_in_D, 2);
q = zeros(4, num_points);
q(2:4, :) = r_in_D;

q = smu.unitQuat.qpml(rot_quat_BA_D) * q;
q = smu.unitQuat.qpmr(inv_rot_quat_BA_D) * q;

r_out_D = q(2:4,:);

end