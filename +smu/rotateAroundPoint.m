function output_points = rotateAroundPoint(input_points, rotation_angle__rad, rotation_direction, rotation_hinge_point)
% rotateAroundPoint - Rotate points around a specified hinge point
%   output_points = rotateAroundPoint(input_points, rotation_angle__rad, rotation_direction, rotation_hinge_point)
%   Rotates the input points around the specified hinge point by the
%   specified angle in radians and around the specified direction.
%
%   Inputs:
%   input_points: 3xN matrix of points to rotate
%   rotation_angle__rad: Angle in radians to rotate the points
%   rotation_direction: 3x1 vector specifying the direction to rotate
%       around
%   rotation_hinge_point: 3x1 vector specifying the point to rotate around
%
%   Outputs:
%   output_points: 3xN matrix of rotated points
%
%   Example:
%   % Rotate a point around the x-axis by 90 degrees
%   input_points = [1; 2; 3];
%   rotation_angle__rad = pi/2;
%   rotation_direction = [1; 0; 0];
%   rotation_hinge_point = [4; 5; 6];
%   output_points = rotateAroundPoint(input_points, rotation_angle__rad, rotation_direction, rotation_hinge_point);
%

arguments
    input_points (3,:) {mustBeNumeric, mustBeReal}
    rotation_angle__rad (1,1) {mustBeNumeric, mustBeReal}
    rotation_direction (3,1) {mustBeNumeric, mustBeReal}
    rotation_hinge_point (3,1) {mustBeNumeric, mustBeReal}
end

% Calculate connection vectors from hinge point to input points
d = input_points - rotation_hinge_point;
% Rotate the connection vectors
d = smu.rotateAroundOrigin(d, rotation_angle__rad, rotation_direction);
% Add the rotated connection vectors to the hinge point
output_points = d + rotation_hinge_point;

end