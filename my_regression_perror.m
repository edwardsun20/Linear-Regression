function [a, p_error] = my_regression_perror(x_data, y_data, p, tolerance)

if p == 2
    a = sum(x_data.*y_data)/sum(x_data.^2);
    p_error = sum(a.*x_data - y_data).^2;
    
else
    a0 = sum(x_data.*y_data)/sum(x_data.^2);
    f = @(a) sum(p*(a*x_data-y_data).^(p-1).*(x_data))
    df = @(a) sum((p^2-p).*x_data.*x_data.*(a*x_data-y_data).^(p-2))
    [a] = my_root_newtonraphson(f,df,a0,tolerance);
    p_error = sum((a*x_data-y_data).^p);
end

    function [root] = my_root_newtonraphson(f, df, r0, tolerance)
        root = r0;
        if r0 == root;
            root = root - f(root)/df(root);
        end
        while abs(root-r0) > tolerance
            r0=root
            root = root - f(root)/df(root);
        end
    end
end

