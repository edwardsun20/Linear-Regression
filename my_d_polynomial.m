function [coefficients_d] = my_d_polynomial(coefficients, k)

if k == 0
    coefficients_d = coefficients;
else
    n = numel(coefficients) - 1; %n is the degree of the leading coefficient
    
    derivative = zeros(1, n + 1);
    derivatives = zeros(1, n + 1);
    for i = 0:n - 1
        derivative(i + 1) = (n - i)*coefficients(i + 1);
    end
    for i = 0:n - 1
        derivatives(end - i) = derivative(end - i - 1);
    end
    coefficients_d = my_d_polynomial(derivatives, k - 1);

end

end