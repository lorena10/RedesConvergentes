function dummy=funGraOnda(fsmm,vxtm,txtTitle,vista,sbplt)
% Grafica una funcion onda se�al.

% fsmm: Vector de valores de la funcion onda se�al
% vxtm: vector de momentos de muestreo (eje x)
% F: frecuencia de la se�al.
% vista: subtotal de todas las muestras a graficar (en %; p.e. 20%).
% sbplt: definicion de ventana de subplot.

lon=length(fsmm);    % Total de valores del vector.

N=vista;    % Subtotal de momentos a desplegar
if vista > lon
    N=lon;
end

txtLegend=sprintf('Muestras: total=%.f / vista=%.f',lon,N);
fprintf('%s\n',txtLegend);

subplot(sbplt(1),sbplt(2),sbplt(3)),
    plot(vxtm(1:N), fsmm(1:N), 'color', [0.4660, 0.6740, 0.1880]),    title(txtTitle),
    xlabel('-->Tiempo'),    ylabel('-->Magnitud'),    legend(txtLegend);
    
%fprintf('Terminando funGraOnda\n\n');
return;