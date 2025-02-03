function q_out = invert(q_in)
%% invert - Invert a unit quaternion
%   q_out = invert(q_in)
%   Inverts a unit quaternion by conjugation since inversion and conjugation
%   are equivalent for unit quaternions.
%
% Inputs:
%   q_in: 4x1 unit quaternion to invert
%
% Outputs:
%   q_out: 4x1 unit quaternion representing the inverse of the input
%       quaternion
%

arguments
    q_in (4,1) {mustBeNumeric, mustBeReal, smu.argumentValidation.mustBeUnitQuaternion}
end

w = q_in(1);
v = q_in(2:4);

q_out = [w; -v];

end