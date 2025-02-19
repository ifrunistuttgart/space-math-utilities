function u_out = hardDeadZone(u_in,deadZoneParameter)
%% hardDeadZone - Creates a hard zone around zero where the output stays zero
%   u_out = hardDeadZone(u_in,deadZoneParameter)
%   Mimicks the behaviour of a device that has no output for arbitrarily 
%   small inputs. The deadzone parameter is the first value of u_out that is
%   equal to u_in.
%
%% References
%  [1] C. A. Pérez-Gómez, “Hard Dead Zone and Friction Modeling and 
%  Identification of a Permanent Magnet DC Motor Non-Linear Model,” 
%  WSEAS TRANSACTIONS ON SYSTEMS AND CONTROL, vol. 15, pp. 527–536, Oct. 2020
%  doi: https://doi.org/10.37394/23203.2020.15.51.
%‌
%
% Inputs:
%   u_in: numeric input signal of any size or dimension
%   deadZoneParameter: numeric scalar
%
% Outputs:
%   u_out: numeric output signal of any size or dimension
%

arguments
    u_in {mustBeNumeric, mustBeReal, mustBeFinite}
    deadZoneParameter (1,1) {mustBeNumeric, mustBeReal, mustBeFinite, mustBePositive}
end

u_dim = size(u_in);
u_vec = reshape(u_in, [], u_dim(end));

for i=1:numel(u_vec)
    if abs(u_vec(i))<deadZoneParameter
        u_vec(i)=0;
    end
end

u_out = reshape(u_vec, u_dim);

end