function u_out = saturation(u_in,lowerLimit,upperLimit)
%% saturation - Limits the output signal to stay within a lower and an upper limit
%   u_out = saturation(u_in,lowerLimit,upperLimit)
%   Mimicks the behaviour of a device that can saturate in its output. The
%   output signal is limited to a range between the lower and the upper limit.
%
% Inputs:
%   u_in: numeric input signal of any size or dimension
%   lowerLimit: numeric scalar representing the lower bound
%   upperLimit: numeric scalar representing the upper bound
%
% Outputs:
%   u_out: numeric output signal of any size or dimension
%

arguments
    u_in {mustBeNumeric, mustBeReal, mustBeFinite}
    lowerLimit (1,1) {mustBeNumeric, mustBeReal, mustBeFinite}
    upperLimit (1,1) {mustBeNumeric, mustBeReal, mustBeFinite}
end

u_dim = size(u_in);
u_vec = reshape(u_in, [], u_dim(end));

for i=1:numel(u_vec)
    u_vec(i) = max(lowerLimit,min(u_vec(i),upperLimit));
end

u_out = reshape(u_vec, u_dim);

end