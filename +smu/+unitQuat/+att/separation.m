function att_quat_CB = separation(att_quat_CA, att_quat_BA)
%% Separation of Attitude Quaternions
%   att_quat_CB = separation(att_quat_CA, att_quat_BA)
%
%   This function calculates the separation of two attitude quaternions.
%   Given the attitude quaternion of frame C with respect to frame A, and the
%   attitude quaternion of frame B with respect to frame A, this function
%   calculates the attitude quaternion of frame C with respect to frame B.
%
%   Inputs:
%   - att_quat_CA: Attitude quaternion of frame C with respect to frame A
%   - att_quat_BA: Attitude quaternion of frame B with respect to frame A
%
%   Outputs:
%   - att_quat_CB: Attitude quaternion of frame C with respect to frame B
%

arguments
    att_quat_CA (4,1) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
    att_quat_BA (4,:) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
end

% Use separation of rotation quaternions but with inverted quaternions and in reverse order
inv_att_quat_CA = smu.unitQuat.invert(att_quat_CA);
inv_att_quat_BA = smu.unitQuat.invert(att_quat_BA);

att_quat_CB = smu.unitQuat.rot.separation(inv_att_quat_BA, inv_att_quat_CA);

end