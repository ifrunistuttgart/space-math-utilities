function [day_of_year, fractional_seconds_of_day] = doySodFromCalDat(year, month, fractional_day)
% doySodFromCalDat - Calculate the day of the year and seconds of the day with fractional part from a calendar date.
%   [day_of_year, fractional_seconds_of_day] = doySodFromCalDat(year, month, fractional_day)
%
%   Inputs:
%   year: Scalar value of the year
%   month: Scalar value of the month
%   fractional_day: Scalar value of the day with fractional part
%
%   Outputs:
%   day_of_year: Scalar value of the day of the year
%   fractional_seconds_of_day: Scalar value of the seconds of the day with fractional part
%
%% References
% [1] J. Meeus, “Julianischer Tag,” in Astronomische Algorithmen, 2nd ed., Leipzig; Berlin; Heidelberg: Barth, 1994, pp. 72–80.

%% Input validation
arguments
    year (1,1) {mustBeInteger, mustBeGreaterThan(year, 1582)}
    month (1,1) {mustBeInteger, mustBeInRange(month, 1, 12)}
    fractional_day (1,1) {mustBeNumeric, smu.argumentValidation.mustBeValidDate(year, month, fractional_day), smu.argumentValidation.mustBeGregorianDate(year, month, fractional_day)}
end

%% Determine if year is leap year
is_leap_year = smu.time.determineLeapYear(year);

%% Algorithm from [1]
% only valid after the adoption of the Gregorian calendar and the adoption
% of the accompanying new leap year rule (i.e. from 15th October 1582
% according to the Gregorian calendar)
if is_leap_year
    K = 1;
else
    K = 2;
end

day = floor(fractional_day);

day_of_year = floor(275 * month / 9) - K * floor( (month + 9) / 12 ) + floor(fractional_day) - 30;

%% Calculate fractional seconds of day
% assumes that a day always has 86400 seconds
% thus, leap seconds are ignored
fractional_seconds_of_day = (fractional_day - day) * 86400;

end