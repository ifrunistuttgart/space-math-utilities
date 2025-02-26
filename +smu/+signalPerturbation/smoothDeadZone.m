function u_out = smoothDeadZone(u_in, deadZoneParameter)
%% smoothDeadZone - Creates a smooth zone around zero where the output stays zero
%   u_out = smoothDeadZone(u_in, deadZoneParameter)
%   Mimicks the behaviour of a device that has no output for arbitrarily 
%   small inputs. The deadzone parameter is the first value after which the 
%   output is non-zero.
%
% Inputs:
%   u_in: numeric input signal of any size or dimension
%   deadZoneParameter: numeric scalar
%
% Outputs:
%   u_out: numeric output signal of any size or dimension
%
%% References
%  [1] C. A. Pérez-Gómez, “Hard Dead Zone and Friction Modeling and 
%  Identification of a Permanent Magnet DC Motor Non-Linear Model,” 
%  WSEAS TRANSACTIONS ON SYSTEMS AND CONTROL, vol. 15, pp. 527–536, Oct. 2020
%  doi: https://doi.org/10.37394/23203.2020.15.51.

arguments
    u_in {mustBeNumeric, mustBeReal}
    deadZoneParameter (1,1) {mustBeNumeric, mustBeReal, mustBeFinite, mustBePositive}
end

u_out = nan(size(u_in));
for i = 1:numel(u_out)
    if abs(u_in(i)) < deadZoneParameter
        u_out(i)=0;
    else
        u_out(i) = u_in(i) - sign(u_in(i)) * deadZoneParameter;
    end
end

end