function is_leap_year = determineLeapYear(year)
    is_leap_year = (mod(year, 4) == 0 && mod(year, 100) ~= 0) || (mod(year, 400) == 0);
end