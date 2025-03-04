function visFrac = conicalShadowing(r_P,r_A,r_B,radius_A,radius_B)
%% conicalShadowing - Calculate the shadowing given two spheres and a point of interest
%   visFrac = conicalShadowing(r_P,r_A,r_B,radius_A,radius_B)
%   Calculates the remaining visible fraction of circular object A that is 
%   occulted by the circular object B as seen from point P. All positions
%   must be in the same coordinate frame. 
%
% Inputs:
%   r_P: position of point of interest P
%   r_A: position of object A (emitter) 
%   r_B: position of object B (occulter)
%   radius_A: radius of object A
%   radius_B: radius of object B 
%
% Outputs:
%   visFrac: remaining visible fraction of object A as seen from point P
%
%% References
% [1] O. Montenbruck and E. Gill, Satellite Orbits. Berlin, 
% Heidelberg: Springer Berlin Heidelberg, 2000. doi: 10.1007/978-3-642-58351-3
% p.82 ff.


arguments
    r_P (3,1) {mustBeNumeric, mustBeReal, mustBeFinite}
    r_A (3,1) {mustBeNumeric, mustBeReal, mustBeFinite}
    r_B (3,1) {mustBeNumeric, mustBeReal, mustBeFinite}
    radius_A (1,1) {mustBeNumeric, mustBeReal, mustBeFinite}
    radius_B (1,1) {mustBeNumeric, mustBeReal, mustBeFinite}
end

% relative positions
r_PA = r_A - r_P;
r_BP = r_P - r_B;

% is the point of interest inside one of the bodies?
if norm(r_PA)<radius_A || norm(r_BP)<radius_B
    visFrac = NaN;
    return
end

% is the point of interest closer to A than B?
if norm(r_PA)<norm(r_BP)
    visFrac = 1;
    return
end

% apparent size (angle) of the emitting object A as seen from P
a = asin(radius_A/norm(r_PA)); 

% apparent size (angle) of the occulting object B as seen from P
b = asin(radius_B/norm(r_BP)); 

% apparent separation (angle) of object centers A and B as seen from P
c = acos(-dot(r_BP, r_PA) / (norm(r_PA) * norm(r_BP))); 

% distinguish no, full and partial occultation cases
if (a + b) <= c % no occultation
   visFrac = 1.0;
   
elseif (b - a > c) && (a < b) % total occultation
   visFrac = 0.0;
   
elseif (a - b > c) && (a > b) % partial but maximum occultation
   visFrac = 1 - b^2/a^2;
   
else     
   % shorthand distances
   x = (c^2 + a^2 - b^2) / (2 * c);
   y = sqrt(a^2 - x^2);
   
   % occulted area of object A
   A_occ = a^2*acos(x/a) + b^2*acos((c-x)/b) - c*y;
   
   % remaining visible fraction of object A as seen from point P
   visFrac = 1 - A_occ/(pi*a^2);
end
