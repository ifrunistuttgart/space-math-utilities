function mustBeNonzeroMatrix(A)
    if all(A==0)
        eidType = 'mustBeNonzeroMatrix:zeroMatrix';
        msgType = 'Input must be a matrix with at least one nonzero entry.';
        error(eidType, msgType);
    end
end