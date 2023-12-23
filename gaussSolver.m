function X = gaussSolver(A, b)
[r,c] = size(A);
[r_b, c_b] = size(b);
if(c_b ~= 1 || r_b ~= r)
    errID = 'gaussSolver:BadInput';
    msg = 'Illegal Input Matrix.';
    baseException = MException(errID, msg);
    throw(baseException)
end
if(rank(A) < rank([A b]))
    errID = 'gaussSolver:MathErr';
    msg = 'No solution.';
    baseException = MException(errID, msg);
    throw(baseException);
end
if(rank(A) < c)
    errID = 'gaussSolver:MathErr';
    msg = 'Multiple solutions';
    baseException = MException(errID, msg);
    throw(baseException);
end

X = A\b;
end