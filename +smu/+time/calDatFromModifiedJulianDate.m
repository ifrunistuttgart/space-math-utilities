function [year, month, fractional_day] = calDatFromModifiedJulianDate(modified_julian_date)
% calDatFromModifiedJulianDate - Calculate the calendar date from a modified julian date.
%   [year, month, fractional_day] = calDatFromModifiedJulianDate(modified_julian_date)
%
%   Inputs:
%   modified_julian_date: Scalar value of the modified julian date
%
%   Outputs:
%   year: Scalar value of the year
%   month: Scalar value of the month
%   fractional_day: Scalar value of the day with fractional part
%
%% References
% [1] J. Meeus, “Julianischer Tag,” in Astronomische Algorithmen, 2nd ed., Leipzig; Berlin; Heidelberg: Barth, 1994, pp. 72–80.

%% Input validation
arguments
    modified_julian_date (1,1) {mustBeGreaterThanOrEqual(modified_julian_date, -2400000.5)}
end

%% Algorithm from [1]
% only valid for non-negative julian dates (i.e. mjd >= -2400000.5)
JD = smu.time.jdFromMjd(modified_julian_date);
G = JD + 0.5;

Z = floor(G);
F = G - Z;

alpha = floor((Z - 1867216.25) / 36524.25);

A = Z + 1 + alpha - floor(alpha/4);

B = A + 1524;

C = floor( (B - 122.1) / 365.25);

D = floor(365.25 * C);

E = floor( (B-D) / 30.6001);

fractional_day = B - D - floor(30.6001 * E) + F;

if E < 14
    month = E - 1;
else
    month = E - 13;
end

if month > 2
    year = C - 4716;
else
    year = C - 4715;
end


end

