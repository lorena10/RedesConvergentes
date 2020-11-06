function [] = P2As4p1R3()
    % Audios
    % fs1 --> fsmmRefe
    [audio1, fs1] = audioread("porky.wav"); 
    [audio2, fs2] = audioread("spidey.wav");
    
    vecTiempo1 = geVcxTiemFun(audio1,fs1);
    vecTiempo2 = geVcxTiemFun(audio2,fs2);

    % Frecuencia de muestreo (Hz) --> FmRefe
    fs = 16000;  
    % Tiempo total de muestreo (segs) --> Ttm
    t = 3; 

    % Reproduccion sonora
    sound(audio1);    
    sound(audio2);
    
    % Generacion de las magnitudes del espectro de frecuencia 
    [magnFrec,vFrec]=funGeMagFre(fs,audio1);    

    figure(1);
    txtTitle=sprintf('Audio 1');
    % Subtotal de puntos a graficar
    vista=300;    
    % Grafica la onda de la señal
    funGraOnda(audio1,vecTiempo1,txtTitle,vista,[2,1,1]);    
    % Grafica las magnitudes de frecuencia de la señal
    funGraMagFre(magnFrec,vFrec,[2,1,2]);    

    [transInicio] = audio1;
    magnitud = 16000;

    for i = 1:5
        [sub, vecTiempo] = funSubMues(transInicio, magnitud*2, magnitud);
        [magn, armon] = funGeMagFre(magnitud, sub);
        figure
        txtTitle=sprintf('Audio 1: FmRefe=%.2f Hz', magnitud);
         % Subtotal de puntos a graficar
         % Grafica la onda de la señal
        funGraOnda(sub,vecTiempo,txtTitle,vista,[2,1,1]);    
        % Grafica las magnitudes de frecuencia de la señal
        funGraMagFre(magn,armon,[2,1,2]);    
        magnitud = magnitud / 2;
        transInicio = sub;

        % Potencia media y SNR
        [potMediaE, potMediaO, snr, snrdB] = potMediaYSnr(fs1,sub);
        fprintf("La potencia media es: %4.4f \n", potMediaO);
        fprintf("El SNR es: %4.4f \n\n", snr);
    end   
    [transInicio] = audio2;
    magnitud = 16000;

    for i = 1:5
        [sub, vecTiempo] = funSubMues(transInicio, magnitud*2, magnitud);
        [magn, armon] = funGeMagFre(magnitud, sub);
        figure
        txtTitle=sprintf('Audio 2 : FmRefe=%.2f Hz', magnitud);
         % Subtotal de puntos a graficar
         % Grafica la onda de la señal
        funGraOnda(sub,vecTiempo,txtTitle,vista,[2,1,1]);    
        % Grafica las magnitudes de frecuencia de la señal
        funGraMagFre(magn,armon,[2,1,2]);    
        magnitud = magnitud / 2;
        transInicio = sub;

        % Potencia media y SNR
        [potMediaE, potMediaO, snr, snrdB] = potMediaYSnr(fs1,sub);
        fprintf("La potencia media es: %4.4f \n", potMediaO);
        fprintf("El SNR es: %4.4f \n\n", snr);
    end    


end

