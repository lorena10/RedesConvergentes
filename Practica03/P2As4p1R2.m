function [] = P2As4p1R2()
    % Realiza: Prac2 parte A - sec4.1 - Teorema del muestreo - Reporte 1

    FmRefe = 16000;  % Frecuencia de muestreo (Hz)
    Ttm = 2; % Tiempo total de muestreo (segs)

    A=1;  % Amplitud maxima de la onda
    FRefe=1000;  % Frecuencia de la onda señal (Hz)
    D=0;  % Defasamiento

    [fsmmRefe,vxtmRefe]=funGeSe(FmRefe,Ttm,A,FRefe,D);    % Generacion de señal senoidal
    fprintf('Senoidal: [FRefe=%.2f, FmRefe=%.2f Hz],[%d filas, %d columnas]\n\n', FRefe, FmRefe, size(fsmmRefe));

    sound(fsmmRefe,FmRefe);    % Reproduccion sonora

    [magDFTRefe,vxfaRefe]=funGeMagFre(FmRefe,fsmmRefe);    % Generacion de las magnitudes del espectro de frecuencia 
    fprintf('Espectro: [FmRefe=%.2f Hz],[%d filas, %d columnas]\n\n', FmRefe, size(magDFTRefe));

    figure(1);
    txtTitle=sprintf('Senoidal: FRefe=%.2f, FmRefe=%.2f Hz', FRefe, FmRefe);
    vista=100;    % Subtotal de puntos a graficar
    funGraOnda(fsmmRefe,vxtmRefe,txtTitle,vista,[2,1,1]);    % Grafica la onda de la señal
    funGraMagFre(magDFTRefe,vxfaRefe,[2,1,2]);    % Grafica las magnitudes de frecuencia de la señal

    %fprintf('Terminando P3As4p1R1\n\n');

    [transInicio] = fsmmRefe;
    magnitud = 8000;

    for i = 1:5
        [trans, momen] = funSubMues(transInicio, magnitud*2, magnitud);
        [magn, armon] = funGeMagFre(magnitud, trans);
        figure
        txtTitle=sprintf('Senoidal: FRefe=%.2f, FmRefe=%.2f Hz', FRefe, magnitud);
        vista=100;    % Subtotal de puntos a graficar
        funGraOnda(trans,momen,txtTitle,vista,[2,1,1]);    % Grafica la onda de la señal
        funGraMagFre(magn,armon,[2,1,2]);    % Grafica las magnitudes de frecuencia de la señal
        magnitud = magnitud / 2;
        
        % Potencia media y SNR
        [potMediaE, potMediaO, snr, snrdB] = potMediaYSnr(fsmmRefe,trans);
        fprintf("La potencia media es: %4.4f \n", potMediaO);
        fprintf("El SNR es: %4.4f \n\n", snr);
        
        transInicio = trans;

    end    

end

