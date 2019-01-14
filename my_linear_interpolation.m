function [y_interp] = my_linear_interpolation(x_data, y_data, x_interp)

for i =1:size((x_interp),1) %rows
    for a = 1:size((x_interp),2) %cols   
        for j=1:numel(x_data)-1 %x_data and y_data are the same length
            if(x_interp(i,a) >= x_data(j) && x_interp(i,a) <= x_data(j+1))
                y_interp(i,a) = y_data(j) + ((y_data(j+1) - y_data(j))*(x_interp(i,a)-x_data(j)))/(x_data(j+1)-x_data(j));
            end
        end
    end
end


% if(length(y_interp) ~= length(x_interp))
%     for(a = 1:length(x_interp)-1)
%         for(j = 1:length(x_data)-1)
%             if(x_data(j) < x_interp(i) & x_data(j+1) > x_interp(i+1) & i+1 <= length(x_interp))
%                 y_interp(length(x_interp)) = 

end

