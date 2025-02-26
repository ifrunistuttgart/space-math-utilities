function dcm_BA = x(alpha__rad)
%% Create the Direction Cosine Matrix for Frames rotated against each other about the X axis
%   dcm_BA = x(alpha__rad)
%
%   This function returns the direction cosine matrix of the transformation
%   from frame A to B where B is separated from A by a rotation about the
%   X axis with angle alpha.
%
%   Inputs:
%   - alpha__rad: Angle of rotation in radian
%
%   Outputs:
%   - dcm_BA: Direction cosine matrix transforming vector representations
%             in frame A to their equivalent in frame B
%

arguments
    alpha__rad (1,1) {mustBeNumeric, mustBeReal}
end

cA = cos(alpha__rad);
sA = sin(alpha__rad);

dcm_BA = zeros(3,3);

dcm_BA(1,1,:) = 1;
dcm_BA(2,2,:) = cA;
dcm_BA(2,3,:) = sA;
dcm_BA(3,3,:) = cA;
dcm_BA(3,2,:) = -sA;

end
