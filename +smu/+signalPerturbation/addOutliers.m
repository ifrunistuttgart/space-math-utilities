function u_out = addOutliers(u_in,outlierProbability,outlierStd)
%% addOutliers - Adds time-random outliers to the output signal
%   u_out = addOutliers(u_in,outlierProbability,outlierStd)
%   Adds an outlier or impulse spike to the signal with the outlierProbability
%   in each step. The added outlier is sampled from a normal distribution 
%   with the given standard deviation.
%
% Inputs:
%   u_in: numeric input signal of any size or dimension
%   outlierProbability: numeric positive scalar below one, a probability
%   outlierStd: numeric positive scalar
%
% Outputs:
%   u_out: numeric output signal of any size or dimension
%

arguments
    u_in {mustBeNumeric, mustBeReal, mustBeFinite}
    outlierProbability (1,1) {mustBeNumeric, mustBeReal, mustBeFinite, mustBePositive, mustBeLessThan(outlierProbability,1)}
    outlierStd (1,1) {mustBeNumeric, mustBeReal, mustBeFinite, mustBePositive}
end

u_dim = size(u_in);
u_vec = reshape(u_in, [], u_dim(end));

for i=1:numel(u_vec)
    u_vec(i) = u_vec(i) + (rand < outlierProbability) * (randn * outlierStd); % Large random spikes
end

u_out = reshape(u_vec, u_dim);

end