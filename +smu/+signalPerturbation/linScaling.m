function u_out = linScaling(u_in,scale)
%% linScaling - Scales the input signal by a constant
%   u_out = linScaling(u_in,scale)
%   Linear scaling of every element of the input signal u_in by multiplying 
%   the scale factor
%
% Inputs:
%   u_in: numeric input signal of any size or dimension
%   scale: numeric scalar
%
% Outputs:
%   u_out: numeric output signal of any size or dimension
%

arguments
    u_in {mustBeNumeric, mustBeReal, mustBeFinite}
    scale (1,1) {mustBeNumeric, mustBeReal, mustBeFinite, mustBePositive}
end

u_out = scale*u_in;

end