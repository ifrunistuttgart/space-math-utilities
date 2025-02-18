function u_out = addBias(u_in,bias)
%% addBias - Adds a constant bias to a signal
%   u_out = addBias(u_in,bias)
%   Adds the constant bias to all elements of the input signal u_in
%
% Inputs:
%   u_in: numeric input signal of any size or dimension
%   bias: numeric scalar
%
% Outputs:
%   u_out: numeric output signal of any size or dimension
%

arguments
    u_in {mustBeNumeric, mustBeReal, mustBeFinite}
    bias (1,1) {mustBeNumeric, mustBeReal, mustBeFinite}
end

u_out = u_in + bias*ones(size(u_in));

end