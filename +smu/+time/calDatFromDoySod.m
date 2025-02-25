function [month, fractional_day] = calDatFromDoySod(year, day_of_year, fractional_seconds_of_day)
% calDatFromDoySod - Calculate the month and fractional day from the day of the year and seconds of the day with fractional part.
%   [month, fractional_day] = calDatFromDoySod(year, day_of_year, fractional_seconds_of_day)
%
%   Inputs:
%   year: Scalar value of the year
%   day_of_year: Scalar value of the day of the year
%   fractional_seconds_of_day: Scalar value of the seconds of the day with fractional part
%
%   Outputs:
%   month: Scalar value of the month
%   fractional_day: Scalar value of the day with fractional part
%
%% References
% [1] J. Meeus, “Julianischer Tag,” in Astronomische Algorithmen, 2nd ed., Leipzig; Berlin; Heidelberg: Barth, 1994, pp. 72–80.

arguments
    year (1,1) {mustBeInteger}
    day_of_year (1,1) {mustBeInteger, mustBeInRange(day_of_year, 1, 366), mustBeGregorianDoySod(year, day_of_year)} = 1
    fractional_seconds_of_day (1,1) {mustBeNumeric, mustBeInRange(fractional_seconds_of_day, 0, 86400, "exclude-upper")} = 0
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

if day_of_year < 32
    month = 1;
else
    month = floor((9 * (K + day_of_year) / 275) + 0.98);
end

day = day_of_year - floor(275 * month / 9) + K * floor((month + 9) / 12) + 30;

%% Calculate fractional day
% assumes that a day always has 86400 seconds
% thus, leap seconds are ignored
fractional_day = day + fractional_seconds_of_day / 86400;

end

%% Custom Argument Validation Function
function mustBeGregorianDoySod(year, day_of_year)
    if year  > 1582
        return;
    end
    
    if (year == 1582)        
        if day_of_year >= 288
            return;
        end
    end

    error('Date:NonGregorian','The date must be 15th October 1582 or later.');

end