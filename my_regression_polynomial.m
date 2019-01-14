function [coefficients] = my_regression_polynomial(x_data, y_data, degree_min, degree_max)
%start with degree_min
%set up polynomial of degree_min, use for loop
%do regression with that degree polynomial (do my_regression_generic)
%find square error, set to square_error1
%do regression on polynomial of degree_min + 1
%find square error, set to square_error2
%compare with original square error (if square_error2/square_error1 < 0.1,
%   stay with degree associated with square_error1

coefftotal = cell(1, degree_max);
error = zeros(1, degree_max);

for(n = degree_min:degree_max)
    
    m = [];
    
    for(i = 0: n)
        for(j = 1:numel(x_data))
            m(j,i+1) = (x_data(j)^i);
        end
    end
    coeff = pinv(m) * y_data;
    y_predicted = m * coeff;
    sq_error = 0;
    for(i = 1:length(y_data))
        sq_error = sq_error + (y_predicted(i) - y_data(i))^2;
    end
    
    coefftotal{n} = coeff;
    error(n) = sq_error;
end

for(i = degree_min: degree_max)
    if(error(i) - error(i+1) < 0.1*error(i))
        p = i;
        break
    end
end

coefficients = coefftotal{p};


% 
% for(i=degree_min + 1 :degree_max)
%     f = @(x) x.^i + f;
%     m = [];
%     for(i = 1: numel(f))
%         for(j = 1:numel(x_data))
%             m(j,i) = f{i}(x_data(j));
%         end
%     end
%     coefficients = pinv(m) * y_data;
%     y_predicted = m * coefficients;
%     sq_error2 = 0;
%     for(i = 1:length(y_data))
%         sq_error2 = sq_error2 + (y_predicted(i) - y_data(i))^2;
%     end
%     
%     
%     
% end
% 
%     
%     
%     
%     
%     
%   
end