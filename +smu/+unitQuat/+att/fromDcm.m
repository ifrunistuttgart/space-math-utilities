function att_quat_BA = fromDcm(dcm_BA)
%% Calculate the Attitude Quaternion from a Direction Cosine Matrix
%   att_quat_BA = fromDcm(dcm_BA)
%
%   This function calculates the attitude quaternion from a direction cosine
%   matrix.
%
%   Inputs:
%   - dcm_BA: Direction cosine matrix from frame B to frame A
%
%   Outputs:
%   - att_quat_BA: Attitude quaternion from frame B to frame A
%

arguments
    dcm_BA (3,3) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeSpecialOrthogonalMatrix}
end

% Calculate rotation matrix from A to B
rotm_BA_A = dcm_BA';

% Use function to calculate quaternion from rotation matrix
att_quat_BA = smu.unitQuat.fromRotm(rotm_BA_A);

end