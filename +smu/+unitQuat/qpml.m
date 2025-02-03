function q_qpml = qpml(q)
%% qpml - Left Quaternion Product Matrix
%   q_qpml = qpml(q)
%   The quaternion product of vectors with 4 elements can be written in
%   matrix form as follows:
%   q1 * q2 = L(q1) * q2
%   where q1 and q2 are 4-element vectors representing quaternions and
%   L(q1) is the left quaternion product matrix. This function calculates
%   the left quaternion product matrix for a given quaternion.
%
%   Inputs:
%   q: 4x1 vector representing a quaternion
%
%   Outputs:
%   q_qpml: 4x4 matrix representing the left quaternion product matrix
%

arguments
    q (4,1) {mustBeNumeric, mustBeReal}
end

w = q(1);
v = q(2:4);

q_qpml = [w, -v'; ...
            v, w*eye(3) + smu.cpm(v)];

end