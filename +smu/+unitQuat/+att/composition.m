function att_quat_CA = composition(att_quat_CB, att_quat_BA)
%% Composition of Attitude Quaternions
%   att_quat_CA = composition(att_quat_CB, att_quat_BA)
%
%   This function calculates the composition of two attitude quaternions.
%   Given the attitude quaternion of frame C with respect to frame B, and the
%   attitude quaternion of frame B with respect to frame A, this function
%   calculates the attitude quaternion of frame C with respect to frame A.
%
%   Inputs:
%   - att_quat_CB: Attitude quaternion of frame C with respect to frame B
%   - att_quat_BA: Attitude quaternion of frame B with respect to frame A
%
%   Outputs:
%   - att_quat_CA: Attitude quaternion of frame C with respect to frame A
%

arguments
    att_quat_CB (4,1) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
    att_quat_BA (4,:) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
end

% Use composition of rotation quaternions but in reverse order
att_quat_CA = smu.unitQuat.rot.composition(att_quat_BA, att_quat_CB);

end