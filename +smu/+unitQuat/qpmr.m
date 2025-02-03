function q_qpmr = qpmr(q)
%% qpmr - Right Quaternion Product Matrix
%   q_qpmr = qpmr(q)
%   The quaternion product of vectors with 4 elements can be written in
%   matrix form as follows:
%   q1 * q2 = R(q2) * q1
%   where q1 and q2 are 4-element vectors representing quaternions and
%   R(q2) is the right quaternion product matrix. This function calculates
%   the right quaternion product matrix for a given quaternion.
%
%   Inputs:
%   q: 4x1 vector representing a quaternion
%
%   Outputs:
%   q_qpmr: 4x4 matrix representing the right quaternion product matrix
%

arguments
    q (4,1) {mustBeNumeric, mustBeReal}
end

w = q(1);
v = q(2:4);

q_qpmr = [w, -v'; ...
            v, w*eye(3) - smu.cpm(v)];

end