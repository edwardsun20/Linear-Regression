function [a, lambda] = my_regression_exp(x_data, y_data)

f = {@(x) x, @(x) ones(size(x))};

[coefficients, ~] = my_regression_generic(x_data, log(y_data), f);
lambda = -1/coefficients(1);
a = exp(coefficients(2));

end