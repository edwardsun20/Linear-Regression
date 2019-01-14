function [rmse] = my_taylor_approx(p, a, n)

v = zeros(100, 1);
v_approx = zeros(100, 1);
sum_errors = 0;

z = 0:(1/99):1;
%Creates a vector of 100 equally-spaced values of z from [0, 1]

for i = 1:100
    v(i) = p(1)*(z(i)^3) + p(2)*(z(i)^2) + p(3)*(z(i)) + p(4);
    %Calculates values of V delivered by battery at each of z point
    v_approx(i) = my_calculate_taylor(p, a, z(i), n);
    %Calculates approximated values of V using Taylor series
end

for j = 1:100
    sum_errors = sum_errors + (v(j) - v_approx(j))^2;
end
%Calculates the sigma part of Equation 14 for m = 100

rmse = sqrt(0.01 * sum_errors);
%Calculates the root mean squared error for m = 100 (Equation 14)
end

function [taylor_part] = my_calculate_taylor(p, a, x, k)
%Calculates Taylor series for 4 terms (hardcode lol)

taylor(1) = p(1)*(a^3) + p(2)*(a^2) + p(3)*(a) + p(4);
taylor(2) = (3*p(1)*(a^2) + 2*p(2)*a + p(3)) * (x - a);
taylor(3) = (3*p(1)*a) + p(2) * ((x - a)^2);
taylor(4) = (p(1)) * ((x - a)^3);
%taylor(4) doesn't get used lol

if k == 0
    taylor_part = taylor(1);
elseif k == 1
    taylor_part = taylor(1) + taylor(2);
elseif k == 2
    taylor_part = taylor(1) + taylor(2) + taylor(3);
end
end