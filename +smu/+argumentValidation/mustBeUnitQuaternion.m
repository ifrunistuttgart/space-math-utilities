function mustBeUnitQuaternion(in)

if size(in,1) ~= 4
    eidType = 'mustBeUnitQuaternion:notFourRows';
    msgType = 'Input must have four rows.';
    error(eidType, msgType);
elseif any(abs(vecnorm(in) - 1) > 1e-6)
    eidType = 'mustBeUnitQuaternion:notUnitQuaternion';
    msgType = 'Every norm along first dimension of input must be 1.';
    error(eidType, msgType);
end

end