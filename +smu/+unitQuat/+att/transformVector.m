function r_B = transformVector(att_quat_BA, r_A)
%% Transform Vector
%   r_B = transformVector(att_quat_BA, r_A)
%
%   This function transforms the expression of a vector in frame A to
%   frame B using the attitude quaternion of frame B with respect to frame A.
%
%   Inputs:
%   - att_quat_BA: Attitude quaternion of frame B with respect to frame A
%   - r_A: Input vector to be transformed expressed in frame A
%
%   Outputs:
%   - r_B: Transformed vector expressed in frame B
%

arguments
    att_quat_BA (4,1) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
    r_A (3,:) {mustBeNumeric, mustBeReal}
end

% Use rotation of vector but with inverted quaternion
inv_att_quat_BA = smu.unitQuat.invert(att_quat_BA);
r_B = smu.unitQuat.rot.rotateVector(inv_att_quat_BA, r_A);

end