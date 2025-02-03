function mustBeSpecialOrthogonalMatrix(M)

if ~(size(M) == [3, 3])
    eid = "mustBeSpecialOrthogonalMatrix:wrongSize";
    msg = "Input must be a 3x3 matrix.";
    error(eid, msg);
end

if M.' * M ~= eye(3)
    eid = "mustBeSpecialOrthogonalMatrix:notOrthogonal";
    msg = "Input must be an orthogonal matrix.";
    error(eid, msg);
end

if abs(det(M) - 1) > 1e-6
    eid = "mustBeSpecialOrthogonalMatrix:wrongDeterminant";
    msg = "Input does not have a determinant close enough to 1.";
    error(eid, msg);
end

end
