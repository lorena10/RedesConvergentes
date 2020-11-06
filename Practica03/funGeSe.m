function [fsmm,vxtm]=funGeSe(Fm,Ttm,A,F,D)
% Genera una funcion se�al senoidal y su vector de tiempos (eje x).

% Fm: Frecuencia de muestreo (Hz)
% Ttm: Tiempo total de muestreo (segs)
% A: Amplitud maxima de la onda
% F: Frecuencia de la se�al (Hz)
% D: Defasamiento

vxtm=geVcxTiem(Ttm,Fm);    % Genera vector de momentos de muestreo (eje x)
fsmm=funSe(A,F,D,vxtm);    % Vector de valores de la funcion se�al

%fprintf('Terminando funGeSe\n\n');
return;