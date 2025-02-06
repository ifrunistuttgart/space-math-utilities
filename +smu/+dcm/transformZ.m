function dcm_z_alpha = transformZ(alpha__rad)
%% Create DCM for transformation around Z axis
%   dcm_z_alpha = transformZ(alpha__rad)
%
%   This function returns the direction cosine matrix of the transformation
%   that describes a rotation about the Z axis with angle alpha.
%
%   Inputs:
%   - alpha__rad: Angle of rotation in radian
%
%   Outputs:
%   - dcm_z_alpha: DCM of rotation around Z axis 
%

arguments
    alpha__rad (1,1) {mustBeNumeric, mustBeReal}
end

cA = cos(alpha__rad);
sA = sin(alpha__rad);

dcm_z_alpha = zeros(3,3);

dcm_z_alpha(1,1,:) = cA;
dcm_z_alpha(1,2,:) = sA;
dcm_z_alpha(2,1,:) = -sA;
dcm_z_alpha(2,2,:) = cA;
dcm_z_alpha(3,3,:) = 1;

end
