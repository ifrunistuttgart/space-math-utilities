function mustBeValidDate(year, month, fractional_day)
    if month == 2
        if smu.time.determineLeapYear(year)
            max_day = 29;
        else
            max_day = 28;
        end
    elseif any(month == [4, 6, 9, 11])
        max_day = 30;
    else
        max_day = 31;
    end

    if fractional_day < 1 || fractional_day >= (max_day + 1)
        error('Date:Invalid','The day input is impossible for the given month and year.');
    end
end