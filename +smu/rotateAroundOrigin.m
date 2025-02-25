function output_points = rotateAroundOrigin(input_points, rotation_angle__rad, rotation_direction)
% rotateAroundOrigin - Rotate points around the origin
%   output_points = rotateAroundOrigin(input_points, rotation_angle__rad, rotation_direction)
%   Rotates the input points around the origin by the specified angle in
%   radians and around the specified direction.
%
%   Inputs:
%   input_points: 3xN matrix of points to rotate
%   rotation_angle__rad: Angle in radians to rotate the points
%   rotation_direction: 3x1 vector specifying the direction to rotate
%       around
%
%   Outputs:
%   output_points: 3xN matrix of rotated points
%
%   Example:
%   % Rotate a point around the x-axis by 90 degrees
%   input_points = [1; 2; 3];
%   rotation_angle__rad = pi/2;
%   rotation_direction = [1; 0; 0];
%   output_points = rotateAroundOrigin(input_points, rotation_angle__rad, rotation_direction);
%

arguments
    input_points (3,:) {mustBeNumeric, mustBeReal}
    rotation_angle__rad (1,1) {mustBeNumeric, mustBeReal}
    rotation_direction (3,1) {mustBeReal, smu.argumentValidation.mustBeNonzeroMatrix}
end

% Rotation quaternion
q = smu.unitQuat.rot.fromAxisAngle(rotation_direction, rotation_angle__rad);

% Perform rotation
output_points = smu.unitQuat.rot.rotateVector(q, input_points);

end