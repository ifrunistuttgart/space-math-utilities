function ind_shadowed = determineShadowedTriangles(vertices, centroids, normals, dir)
% determineShadowedTriangles - Determine which triangles are shadowed by others
%
%   ind_shadowed = determineShadowedTriangles(vertices, centroids, normals, dir)
%   calculates which triangles are shadowed by at least one of the other triangles
%   along a given a direction dir.
%   A triangle is marked as shadowed if its centroid lies behind another triangle
%   when looked at from the direction dir.
%
%   Inputs:
%   vertices: 3x3xN array of vertices of N triangles, each 3x3 matrix represents on triangle
%             of which each column represents the x, y, z coordinates of one of the 
%             triangle's vertices
%   centroids: 3xN array of surface centroids of N triangles
%   normals: 3xN array of surface normals of N triangles
%   dir: 3x1 array representing the a direction along which the shadowing is determined
%
%   Outputs:
%   ind_shadowed: 1xN logical array indicating which triangles are shadowed
%
%% References
% [1] D. Mostaza-Prieto, “CHARACTERISATION AND APPLICATIONS OF AERODYNAMIC TORQUES ON SATELLITES,” University of Manchester, 2017.
% [2] L. A. Sinpetru, N. H. Crisp, D. Mostaza-Prieto, S. Livadiotti, and P. C. E. Roberts, “ADBSat: Methodology of a novel panel method tool for aerodynamic analysis of satellites,” Computer Physics Communications, vol. 275, p. 108326, 2022, doi: https://doi.org/10.1016/j.cpc.2022.108326.
% [3] N. H. Crisp, L. A. Sinpetru, and S. Livadiotti, ADBSat (Aerodynamic Database for Satellites). (Mar. 17, 2021). MATLAB.

%% Principle
% The algorithm is adapted from the method described in [1], [2] and implemented in [3].
% First a number of necessary conditions for shadowing are used to reduce the number of triangles to be considered.
% Then, for each shadowable triangle, the triangles that could potentially shadow it are checked using the barycentric coordinates method. 

%% 1st Reduction of Triangles to Be Considered:
% Necessary condition: triangle A is shadowed by triangle B => triangle A is flow-facing and triangle B is rear-facing
% -> Shadowing triangles: only consider rear-facing triangles
% -> Shadowable triangles: only consider flow-facing triangles

% Angles between flow and normals
delta = real(acos(-dir' * normals));

% Determine which triangles are flow-facing and which are rear-facing
ind_shadowable = (delta <= pi/2); % flow-facing
ind_shadowing = ~ind_shadowable; % rear-facing

%% 2nd Reduction of Triangles to Be Considered:
% Shadowing triangles must be upwind of shadowable triangles
% Necessary condition: triangle A is shadowed => at least one vertex of triangle A is downwind of the most upwind vertex the shadowing triangles
% -> Shadowable triangles: only consider shadowable triangles that have at least one vertex downwind of the most upwind vertex of the shadowing triangles
% Necessary condition: triangle B shadows  => at least one vertex of triangle B is upwind of the most downwind vertex of the shadowable triangles
% -> Shadowing triangles: only consider shadowing triangles that have at least one vertex upwind of the most downwind vertex of the shadowable triangles

% Reshape 3x3xN vertices array into a 3x(3*N) matrix
vertices_list = reshape(vertices, 3, []);
% Calculate position in wind direction of all vertices
w_list = dir' * vertices_list;
% Reshape vertices matrix into 3xN array
% -> every column represents one triangle, each entry is the w coordinate of a vertex of this triangle
w = reshape(w_list, 3, []);

% w coordinates of the most downwind flow-facing vertex and the most upwind rear-facing vertex
max_w_shadowable = max(w_list(:,ind_shadowable));
min_w_shadowing = min(w_list(:,ind_shadowing));

% Decrease sets of shadowing and shadowable triangles
ind_shadowing = (ind_shadowing & any(w < max_w_shadowable));
ind_shadowable = (ind_shadowable & any(w > min_w_shadowing));

%% Loop over all triangles
num_triangles = length(delta);
ind_shadowed = false(1, num_triangles);
% Get axes perpendicular to wind direction
perp_axes = null(dir');
for i = 1:num_triangles
    if ind_shadowable(i)
        %% 3rd Reduction of Triangles to Be Considered:
        % Shadowing triangles cut space into two halves: one in the direction of the normal (H1) and one in the opposite direction (H2)
        % Necessary condition: triangle A is shadowed by triangle B => Centroid of the triangle A is in H1
        % -> for the current shadowable triangle, only consider shadowing triangles for which the projection  of the connecting vector from
        %    the shadowing triangle's centroid to the shadowable triangle's centroid onto the normal of the shadowing triangle is positive
        current_centroid = centroids(:,i);
        % reduce shadowing set to those upwind of the current triangle
        ind_current_shadowing = false(size(ind_shadowing));
        for j = 1:num_triangles
            if ind_shadowing(j)
                if normals(:,j)' * (current_centroid - centroids(:,j)) >= 0
                    ind_current_shadowing(j) = true;
                end
            end
        end
        if(any(ind_current_shadowing))
            % For the remaining potentially shadowing triangles, the problem can be reduced to 2D by projecting their vertices
            % onto a plane perpendicular to the wind direction (the origin is chosen to be the current shadowable triangle's centroid).

            % Reshape 3x3xn vertices array into a 3x(3*n) matrix
            vertices_shadowing_list = reshape(vertices(:,:,ind_current_shadowing), 3, []);

            % Project vertices of shadowing triangles onto plane
            % perpendicular to wind direction (origin is the current triangle's centroid)
            vertices_proj_list = perp_axes' * (vertices_shadowing_list - current_centroid);
            vertices_proj = reshape(vertices_proj_list, 2, 3, []);
            
            % For these projections, we have the following equivalency:
            % triangle A is shadowed by triangle B <=> the origin is within triangle B's projection  

            %% 4th Reduction of Triangles to Be Considered:
            % If the origin is within triangle B's projection, then not all three vertices of the triangle B's projection are in the same half plane.
            % If the x values of all vertices of a potentially shadowing triangle's projection have the same sign, then the triangle's projection
            % is contained within one half plan and thus cannot contain the origin. The same applies to the y values.
            % Necessary condition: the origin is within triangle B's projection => x or the y values of triangle B's projection's vertices
            % do not all have the same sign
            % -> for the current shadowable triangle, only consider shadowing triangles whose projections fulfill the following conditions: 
            %        - the sum of the signs of the x values of all vertices is neither 3 nor -3 and
            %        - the sum of the signs of the y values of all vertices is neither 3 nor -3
            ind_signchange_x = abs(squeeze(sum(sign(vertices_proj(1,:,:)), 2))) < 3;
            ind_signchange_y = abs(squeeze(sum(sign(vertices_proj(2,:,:)), 2))) < 3;

            ind_remaining = ind_signchange_x & ind_signchange_y;

            %% Dertmine if the current triangle is shadowed
            if any(ind_remaining)
                % Check if the origin is within any of the remaining shadowing triangles using the barycentric coordinates method
                ind_shadowed(i) = checkOriginInAnyTriangle(vertices_proj(:,:,ind_remaining));
            end
        end
    end
end

end

function result = checkOriginInAnyTriangle(vertices)
% Check if any of the triangles defined by the vertices contains the origin using the barycentric coordinates method
    for i = size(vertices, 3)
        
        % Coordinates of the i-th triangle's vertices a, b, and c
        a = squeeze(vertices(:,1,i));
        b = squeeze(vertices(:,2,i));
        c = squeeze(vertices(:,3,i));
    
        % Connecting vectors of vertices b and c as well as the origin with vertex a
        v0 = b - a;
        v1 = c - a;
        v2 = -a;
    
        % Calculate dot products
        d00 = v0'*v0;
        d01 = v0'*v1;
        d11 = v1'*v1;
        d20 = v2'*v0;
        d21 = v2'*v1;
    
        % Calculate barycentric coordinates
        invDenom = 1 / (d00 * d11 - d01 * d01);
        u = (d11 * d20 - d01 * d21) * invDenom;
        v = (d00 * d21 - d01 * d20) * invDenom;
    
        % Check if the origin is within the triangle
        if (u >= 0) && (v >= 0) && (u+v <= 1)
            % The origin is within the i-th triangle
            % Do not check any further triangles
            result = true;
            return;
        end
    end
    
    % The origin is not within any of the triangles
    result = false;

end