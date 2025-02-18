function u_out = addRandn(u_in,noiseStd)
%% addRandn - Adds a scaled normal distributed noise to the signal
%   u_out = addRandn(u_in,bias)
%   Adds the scaled noise sampled from the standard normal distribution to 
%   all elements of the input signal u_in
%
% Inputs:
%   u_in: numeric input signal of any size or dimension
%   noiseStd: numeric scalar representing the standard deviation of the noise
%
% Outputs:
%   u_out: numeric output signal of any size or dimension
%

arguments
    u_in {mustBeNumeric, mustBeReal, mustBeFinite}
    noiseStd (1,1) {mustBeNumeric, mustBeReal, mustBeFinite, mustBePositive}
end

u_out = u_in + noiseStd*randn(size(u_in));

end