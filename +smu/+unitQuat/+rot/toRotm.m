function rotm_BA_D = toRotm(rot_quat_BA_D)
%% Calculate Rotation Matrix from Rotation Quaternion
%   rotm_BA_D = toRotm(rot_quat_BA_D)
%
%   This function calculates the rotation matrix from a rotation quaternion.
%
%   Inputs:
%   - rot_quat_BA_D: Rotation quaternion from frame B to frame A with a rotation
%     axis expressed in frame D
%
%   Outputs:
%   - rotm_BA_D: Rotation matrix from frame B to frame A with a rotation
%     axis expressed in frame D
%

arguments
    rot_quat_BA_D (4,1) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
end

w = rot_quat_BA_D(1);
v = rot_quat_BA_D(2:4);

% Euler-Rodrigues formula
rotm_BA_D = eye(3) + 2 * w * smu.cpm(v) + 2 * smu.cpm(v)^2;

end