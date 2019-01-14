function [coefficients] = my_lagrange(x_data, y_data)

coefficients = [];

for i = 1:numel(x_data)
    counter = x_data(i);
    d = 1;
    n = [1];
    for j = 1:numel(x_data)
        if i~= j
            d = d *(counter - x_data(j));
            n = conv(n, [1, -1 * x_data(j)]);
        end
    end
    coefficients = [coefficients; n/d];
end
coefficients = fliplr(coefficients);

last_row = zeros(1, size(coefficients,2));
for i = 1:numel(last_row)
    for j = 1:size(coefficients,1)
        last_row(i) = last_row(i) + coefficients(j,i)*y_data(j);
    end
end

coefficients = [coefficients; last_row];
end
        