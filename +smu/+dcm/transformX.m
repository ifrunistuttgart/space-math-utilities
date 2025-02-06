function dcm_x_alpha = transformX(alpha__rad)
%% Create DCM for transformation around Y axis
%   dcm_x_alpha = transformX(alpha__rad)
%
%   This function returns the direction cosine matrix of the transformation
%   that describes a rotation about the X axis with angle alpha.
%
%   Inputs:
%   - alpha__rad: Angle of rotation in radian
%
%   Outputs:
%   - dcm_x_alpha: DCM of rotation around X axis 
%

arguments
    alpha__rad (1,1) {mustBeNumeric, mustBeReal}
end

cA = cos(alpha__rad);
sA = sin(alpha__rad);

dcm_x_alpha = zeros(3,3);

dcm_x_alpha(1,1,:) = 1;
dcm_x_alpha(2,2,:) = cA;
dcm_x_alpha(2,3,:) = sA;
dcm_x_alpha(3,3,:) = cA;
dcm_x_alpha(3,2,:) = -sA;

end
