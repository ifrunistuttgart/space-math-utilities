function u_out = addOutliers(u_in, outlierProbability, outlierStd)
%% addOutliers - Adds time-random outliers to the output signal
%   u_out = addOutliers(u_in, outlierProbability, outlierStd)
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
%% References
% [1] B. Cloez, “Kalman filter with impulse noised outliers : A robust 
% sequential algorithm to filter data with a large number of outliers,” 
% arXiv (Cornell University), Jan. 2022‌

arguments
    u_in {mustBeNumeric, mustBeReal}
    outlierProbability (1,1) {mustBeNumeric, mustBeReal, mustBeInRange(outlierProbability, 0, 1)}
    outlierStd (1,1) {mustBeNumeric, mustBeReal, mustBeFinite, mustBePositive}
end

u_out = u_in;
for i = 1:numel(u_in)
    if rand < outlierProbability
        u_out(i) = u_in(i) + randn * outlierStd; % Large random spikes [1]
    end
end

end