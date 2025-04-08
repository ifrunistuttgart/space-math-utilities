function [vertices_rot, centroids_rot, normals_rot] = rotateBody(vertices, ...
                                                                 centroids, ...
                                                                 normals, ...
                                                                 rotation_angle__rad, ...
                                                                 rotation_direction, ...
                                                                 rotation_hinge_point)
% rotateBody - Rotate the vertices, centroids, and normals of a body around a hinge point
%
%  [vertices_rot, centroids_rot, normals_rot] = rotateBody(vertices, ...
%                                                          centroids, ...
%                                                          normals, ...
%                                                          rotation_angle__rad, ...
%                                                          rotation_direction, ...
%                                                          rotation_hinge_point)
% 
%  Inputs:
%   vertices: 3x3xN array of the vertices of the faces
%   centroids: 3xN array of the centroids of the faces
%   normals: 3xN array of the normals of the faces
%   rotation_angle__rad: scalar, the angle of rotation in radians
%   rotation_direction: 3x1 vector, the direction of rotation
%   rotation_hinge_point: 3x1 vector, the point around which the body is rotated
%
%  Outputs:
%   vertices_rot: 3x3xN array of the rotated vertices of the faces
%   centroids_rot: 3xN array of the rotated centroids of the faces
%   normals_rot: 3xN array of the rotated normals of the faces
%

%% Vertices
% Reshape 3x3xN vertices array into a 3x(3*N) matrix
vertices_list = reshape(vertices, 3, []);
% Rotate vertices
vertices_list = smu.rotateAroundPoint(vertices_list, rotation_angle__rad, rotation_direction, rotation_hinge_point);
% Reshape vertices matrix back into 3x3xN array
vertices_rot = reshape(vertices_list, 3, 3, []);

%% Centroids
centroids_rot = smu.rotateAroundPoint(centroids, rotation_angle__rad, rotation_direction, rotation_hinge_point);

%% Normals
normals_rot = smu.rotateAroundOrigin(normals, rotation_angle__rad, rotation_direction);
end