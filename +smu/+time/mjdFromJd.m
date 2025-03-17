function time_mjd__days = mjdFromJd(time__jd_days)
% mjdFromJd - calculate modified julian date from julian date
%   both given in days. 
%   MJD is the number of days since midnight on November 17 1858
%   JD is the number of days since noon January 1 4713 BC

%% References: [1] O. Montenbruck and E. Gill, Satellite Orbits. Berlin, 
%                  Heidelberg: Springer Berlin Heidelberg, 2000. doi: 10.1007/978-3-642-58351-3.

    time_mjd__days = time__jd_days - 2400000.5;

end

