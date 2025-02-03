function dcm_BA = toDcm(att_quat_BA)
%% Calculate the Direction Cosine Matrix from an Attitude Quaternion
%   dcm_BA = toDcm(att_quat_BA)
%
%   This function calculates the direction cosine matrix from an attitude
%   quaternion.
%
%   Inputs:
%   - att_quat_BA: Attitude quaternion from frame B to frame A
%
%   Outputs:
%   - dcm_BA: Direction cosine matrix from frame B to frame A
%

arguments
    att_quat_BA (4,1) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
end

% Interpret attitude quaternion as rotation quaternion
rot_quat_BA_A = att_quat_BA;

% Use function to calculate rotation matrix from quaternion
rotm_BA_A = smu.unitQuat.rot.toRotm(rot_quat_BA_A);

% Calculate direction cosine matrix from A to B
dcm_BA = rotm_BA_A';

end