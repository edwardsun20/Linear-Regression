function [e2, r2] = my_regression_metrics(y_data, y_predicted)

load('lab09_sample_data.mat');
e2 = 0;
y_mean = mean(y_data);
mean_diff = 0; %denominator of r^2

for(i = 1:length(y_data))
    e2 = e2 + (y_predicted(i) - y_data(i))^2;
    mean_diff = mean_diff + (y_data(i) - y_mean)^2;
end

r2 = 1 - e2/mean_diff;

return

end

