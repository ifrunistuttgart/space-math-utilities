function mustBeEqualLength(a,b, dimA, dimB)
    % Test for equal length
    size_A = size(a);
    size_B = size(b);
    if size_A(dimA) ~= size_B(dimB)
        eid = 'Length:notEqual';
        msg = sprintf('Length of dimension %d of first input must equal length of dimension %d second input.', dimA, dimB);
        error(eid,msg)
    end
end