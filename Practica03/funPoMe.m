function [potMedia] = funPoMe(funVoz)

% Parámetro N
tam = size(funVoz);
n = tam(1,1);

potMedia = 0;
for i = 1: n
x = funVoz(i);
potMedia = potMedia + ((abs(x))^2/n);
end

end

