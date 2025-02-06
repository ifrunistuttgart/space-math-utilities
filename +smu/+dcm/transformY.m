function dcm_y_alpha = transformY(alpha__rad)
%% Create DCM for transformation around Y axis
%   dcm_y_alpha = transformY(alpha__rad)
%
%   This function returns the direction cosine matrix of the transformation
%   that describes a rotation about the Y axis with angle alpha.
%
%   Inputs:
%   - alpha__rad: Angle of rotation in radian
%
%   Outputs:
%   - dcm_y_alpha: DCM of rotation around Y axis 
%

arguments
    alpha__rad (1,1) {mustBeNumeric, mustBeReal}
end

cA = cos(alpha__rad);
sA = sin(alpha__rad);

dcm_y_alpha = zeros(3,3);

dcm_y_alpha(1,1,:) = cA;
dcm_y_alpha(1,3,:) = -sA;
dcm_y_alpha(2,2,:) = 1;
dcm_y_alpha(3,3,:) = cA;
dcm_y_alpha(3,1,:) = sA;

end
