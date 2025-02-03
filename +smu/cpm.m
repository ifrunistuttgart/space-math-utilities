function x_cpm = cpm(x)
% cpm - Calculate the cross product matrix of a vector
%   x_cpm = cpm(x)
%   The cross product of two vectors with 3 elements can be written in
%   matrix form as follows:
%   cross(x, y) = CPM(x) * y
%   where x and y are 3-element vectors and CPM(x) is the cross product
%   matrix of x. This function calculates the cross product matrix of a
%   given vector.
%
%   Inputs:
%   x: 3x1 vector
%
%   Outputs:
%   x_cpm: 3x3 cross product matrix
%
%   Example:
%   % Calculate the cross product matrix of a vector
%   x = [1; 2; 3];
%   x_cpm = cpm(x);
%

arguments
    x (3,1) {mustBeNumeric}
end

x_cpm = [0, -x(3), x(2); ...
            x(3), 0, -x(1); ...
            -x(2), x(1), 0];

end

