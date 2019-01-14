function [coefficients] = my_splines_coefficients(x_data, y_data, condition)
 
splines = numel(x_data) - 1; 
eqs = 4*splines;
big_Matrix = zeros(eqs);

for i = 1: splines
    startRow = 2*i -1;
    endRow = startRow + 1;
    startCol = 4*i -3;
    endCol = startCol + 3;
    big_Matrix(startRow:endRow, startCol: endCol) = [x_data(i)^3, x_data(i)^2, x_data(i), 1; x_data(i+1)^3, x_data(i+1)^2, x_data(i+1), 1];
end

%1st derivative and 2nd derivative
for n = 1: splines-1
    row1 = 2* splines + n;
    row2 = 2*splines+splines-1+n;
    col1 = 4*n - 3;
    col2 = 4*n + 4;
    
    coeff1_d1 = [3*x_data(n+1)^2, 2*x_data(n+1), 1, 0];
    coeff2_d1 = -1 * coeff1_d1;
    coeff1_d2 = [6*x_data(n+1), 2, 0, 0];
    coeff2_d2 = -1*coeff1_d2;
    big_Matrix(row1,col1:col2) = [coeff1_d1, coeff2_d1];
    big_Matrix(row2, col1:col2) = [coeff1_d2, coeff2_d2];
end

%conditions
if strcmpi(condition.type,'natural')
    big_Matrix(end-1, 1:2) = [6*x_data(1),2];
    big_Matrix(end,4*splines - 3:4*splines-2) = [6*x_data(end),2];
elseif strcmpi(condition.type, 'not-a-knot')
    big_Matrix(end-1,1:5) = [1 0 0 0 -1];
    big_Matrix(end, 4*(splines-1)-3:4*(splines)-3) = [1 0 0 0 -1];
elseif strcmpi(condition.type, 'clamped')
    big_Matrix(end-1,1:4) = [3*x_data(1)^2, 2*x_data(1), 1, 0];
    big_Matrix(end,4*splines-3:4*splines) = [3*x_data(end)^2, 2*x_data(end), 1, 0];
end

y = [];
for j = 1:length(y_data)
    if j == 1 || j == length(y_data)
        y = [y, y_data(j)];
    else
        y = [y, y_data(j), y_data(j)];
    end
end
y(1, eqs) = 0;

if strcmpi(condition.type, 'clamped')
    y(end-1) = condition.left;
    y(end) = condition.right;
end
solve = pinv(big_Matrix)*y';
counter = 0;
coefficients = zeros(splines,4);

while length(solve) > 1
    counter = counter + 1;
    coefficients(counter,:) = solve(1:4);
    solve(1:4) = [];
end

end