function [potMediaE, potMediaO, snr, snrdB] = potMediaYSnr(original,sub)
    % x1fs0 = original
    % x1fsX = submuestreada
    
    arrSub = zeros(1,32000);
    nSub = length(sub);

    for i = 1: nSub
        arrSub(i) = sub(i);
    end   
   
    % Señal de error --> ex1sfsX 
    error = original - arrSub;
    
    % Potencia media del error --> pex1fsX
    n = length(error);
    potMediaE = (error * error') / n; 

    % Potencia media del original --> px1fs0
    n = length(original);
    potMediaO = (original * original') / n;

    % SNR
    snr = (potMediaO / potMediaE); 

    %SNR en decibeles
    snrdB = 10 * log10(snr); 
end

