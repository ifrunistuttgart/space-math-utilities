function u_out = discreteSteps(u_in, discreteStepSize)
%% discreteSteps - Discretises the output signal to the given step size
%   u_out = discreteSteps(u_in, discreteStepSize)
%   Mimicks the behaviour of a device that has fixed discrete step sizes.
%
% Inputs:
%   u_in: numeric input signal of any size or dimension
%   discreteStepSize: numeric scalar representing the fixed step size
%
% Outputs:
%   u_out: numeric output signal of any size or dimension
%

arguments
    u_in {mustBeNumeric, mustBeReal, mustBeFinite}
    discreteStepSize (1,1) {mustBeNumeric, mustBeReal, mustBeFinite, mustBePositive}
end


u_out = round(u_in / discreteStepSize) * discreteStepSize;

end