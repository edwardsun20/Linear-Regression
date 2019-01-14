function [coefficients, e2] = my_regression_generic(x_data, y_data, f)

m = [];

for(i = 1: numel(f))
    for(j = 1:numel(x_data))
        m(j,i) = f{i}(x_data(j));
    end
end

coefficients = pinv(m) * y_data;
y_predicted = m * coefficients;
e2 = 0;

for(i = 1:length(y_data))
    e2 = e2 + (y_predicted(i) - y_data(i))^2;
end

return
end