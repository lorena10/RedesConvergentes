function [pex1fsX,px1fs0,snrx1fsXdb] = potMeSNR(x1fs0,x1fsX)

aux = zeros(1,32000);

for i = 1:1:length(x1fsX)
    aux(i) = x1fsX(i);
end   

x1fsX = aux;    
%Se�al residual o de error (ex1sfsX).
ex1fsX = x1fs0 - x1fsX;

%Potencia media de la se�al de error.
pex1fsX = (ex1fsX * ex1fsX') / length(ex1fsX); 

%Potencia media de la se�al original.
px1fs0 = (x1fs0 * x1fs0') / length(x1fs0);

%Relaci�n se�al a ruido (SNR) de la se�al submuestreada
snrx1fsX=(px1fs0 / pex1fsX); 

%SNR expresada en decibeles
snrx1fsXdb = 10 * log10(snrx1fsX); 

end

