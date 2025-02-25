function modified_julian_date = modifiedJulianDateFromCalDat(year, month, fractional_day, NameValueArgs)
% modifiedJulianDateFromCalDat - Calculate the modified Julian date from a calendar date.
%   modified_julian_date = modifiedJulianDateFromCalDat(year, month, fractional_day)
%
%   Inputs:
%   year: Scalar value of the year
%   month: Scalar value of the month
%   fractional_day: Scalar value of the day with fractional part
%
%   Outputs:
%   modified_julian_date: Scalar value of the modified Julian date
%
%   Optional Inputs:
%   usesGregorianCalendar: Logical value to determine if the Gregorian calendar should be used. Default is true.
%
%% References
% [1] J. Meeus, “Julianischer Tag,” in Astronomische Algorithmen, 2nd ed., Leipzig; Berlin; Heidelberg: Barth, 1994, pp. 72–80.

arguments
    year (1,1) {mustBeInteger}
    month (1,1) {mustBeInteger, mustBeInRange(month, 1, 12)}
    fractional_day (1,1) {mustBeNumeric, smu.argumentValidation.mustBeValidDate(year, month, fractional_day)}
    NameValueArgs.usesGregorianCalendar (1,1) logical = true
end

%% Algorithm from [1]
% only valid for non-negative julian dates (i.e. mjd >= -2400000.5)

if any(month == [1, 2])
    month = month + 12;
    year = year - 1;
end

if NameValueArgs.usesGregorianCalendar
A = floor(year / 100);
    B = 2 - A + floor(A / 4);
else
    B = 0;
end

JD = floor(365.25 * (year + 4716)) + floor(30.601 * (month + 1)) + fractional_day + B - 1524.5;

%% Convert to Modified Julian date
modified_julian_date = JD - 2400000.5;

end