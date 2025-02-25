function mustBeGregorianDate(year, month, day)
    if year  > 1582
        return;
    elseif (year == 1582)
        
        if month > 10
            return;
        elseif month == 10
            
            if day >= 15
                return;
            end

        end

    end

    error('Date:NonGregorian','The date must be 15th October 1582 or later.');

end