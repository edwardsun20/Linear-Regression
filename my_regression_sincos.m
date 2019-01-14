function [k, a, b] = my_regression_sincos(x_data, y_data, n)

sum = 0;

a_matrix = [];
b_matrix = [];

for(j = 1:n) %n is number of elements in x data
    for(i = 1: numel(x_data))
        a_matrix(i,j) = sin(j*x_data(i));
        b_matrix(i,j) = cos(j*x_data(i));
    end
end
m = [ones(size(x_data)), a_matrix, b_matrix];

coefficients = pinv(m) * y_data;

%disp(coefficients)

k = coefficients(1);
a = coefficients(2:n+1);
b = coefficients(n+2:2*n+1);

return

end