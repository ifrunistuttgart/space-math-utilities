function u_out = expScaling(u_in,exponent)
%% expScaling - Scales the input signal by an exponent
%   u_out = expScaling(u_in,exponent)
%   Exponential scaling of every element of the input signal u_in by 
%   using the power function with the exponent
%
% Inputs:
%   u_in: numeric input signal of any size or dimension
%   exponent: numeric scalar
%
% Outputs:
%   u_out: numeric output signal of any size or dimension
%

arguments
    u_in {mustBeNumeric, mustBeReal, mustBeFinite}
    exponent (1,1) {mustBeNumeric, mustBeFinite, mustBeReal, mustBePositive}
end

u_sign = sign(u_in);
u_out = u_sign.*abs(u_in).^exponent;

end