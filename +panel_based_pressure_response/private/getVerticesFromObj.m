function vertices = getVerticesFromObj(filename)
%  getVerticesFromObj - Extracts the vertex coordinates from an OBJ file.
%
%   vertices = getVerticesFromObj(filename)
%
%   This function reads an OBJ file, extracts the vertex coordinates from it and arranges them
%   by face in a 3x3xN matrix where N is the number of faces in the OBJ file. The rows
%   represent the x, y, and z coordinates of the vertices, the columns represent the three
%   vertices of a face, and the third dimension represents the faces.
% 
%   Inputs:
%    filename: string of the path to the OBJ file
% 
%   Outputs:
%    vertices: 3x3xN array of the vertices of the faces
%

% Check the input arguments
arguments
    filename (1,:) string {mustBeFile}
end

% Open the file
fid = fopen(filename, 'r');
if fid == -1
    error('Cannot open the file: %s', filename);
end

% Initialize an empty array to store vertices
vertices_list = nan(3,0);
face_vertex_indices = vertices_list;

% Read the file line by line
while ~feof(fid)
    
    line = fgetl(fid);

    % Vertex
    if startsWith(line, 'v ')
        % Extract the vertex coordinates
        % The 'v ' will be followed by three floating point numbers separated
        % by spaces which represent the x, y, and z coordinates of the vertex.
        current_vertex_coordinates = sscanf(line, 'v %f %f %f'); % column vector

        if length(current_vertex_coordinates) ~= 3
            error('Unable to read vertex from line: %s', line);
        end

        vertices_list(:, end+1) = current_vertex_coordinates;
    end

    % Face
    if startsWith(line, 'f ')
        % Extract the face's vertex indices
        % The 'f ' will be followed by three strings separated by spaces. These
        % strings can have different formats if other data such as textures or
        % vertex normals are included in addition to the vertex indices.
        % The vertex indices are always the first integers in each of the
        % strings. Since we are only interested in these, we will use a regular
        % expression to extract only the integers after a whitespace.
        current_face_vertex_indices_cell = regexp(line, '(?<=\s)\d+', 'match'); % row cell array

        if length(current_face_vertex_indices_cell) ~= 3
            error('Unable to read face from line: %s', line);
        end

        % Convert row cell array of characters to numeric column vector
        current_face_vertex_indices = str2double(current_face_vertex_indices_cell)';

        face_vertex_indices(:, end+1) = current_face_vertex_indices;
    end
end

% Close the file
fclose(fid);

% After the file has been read, we can check if the vertex indices are valid
invalid_vertex_indices_log = (face_vertex_indices < 1) | (face_vertex_indices > size(vertices_list, 2));

if any(invalid_vertex_indices_log, 'all')
    invalid_vertex_indices = face_vertex_indices(invalid_vertex_indices_log);
    error('Invalid vertex index in the face data: %d', invalid_vertex_indices(1));
end

% Group the vertices coordinates by faces
vertices_temp = vertices_list(:,face_vertex_indices(:));

% Reshape the vertices matrix to 3x3xN
vertices = reshape(vertices_temp, 3, 3, []);

end