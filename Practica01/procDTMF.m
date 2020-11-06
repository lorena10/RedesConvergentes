function [] = procDTMF(Btn)
tiempo = 3;
frec = 8000;
[fBaja, fAlta] = funDTMF(Btn);

fprintf("la frecuencia baja es: " + fBaja + "\n");
fprintf("la frecuencia alta es: " + fAlta + "\n");

% Vector vxtm
vector = geVcxTiem(tiempo,frec);

% Vectores fsmm
vBaja = funSe(1,fBaja,0,vector);
vAlta = funSe(1,fAlta,0,vector);

% Vector fsmmAB
vSuma = vBaja + vAlta;

% Vectores magDFT
magBaja = absFFT(vBaja);
magAlta = absFFT(vAlta);
magSuma = absFFT(vSuma);

% Vectores vxfa
vecCoBaja = geVcxFreFun(magBaja, frec);
vecCoAlta = geVcxFreFun(magAlta, frec);
vecCoSuma = geVcxFreFun(magSuma, frec);

vRec = vector(1:100);
vBajaRec = vBaja(1:100);
vAltaRec = vAlta(1:100);
vSumaRec = vSuma(1:100);

figure
subplot(2,1,1)
    plot(vRec, vBajaRec, 'color', [0.6, 0.2, 0.6])
    title("Vector senoidal de frecuencias bajas")
    xlabel("Tiempo")
    
subplot(2,1,2)
    stem(vecCoBaja, magBaja, 'color', [0.4660, 0.6740, 0.1880])
    title("Vector mixto de frecuencias bajas")
    xlabel("Frecuencia")
    ylabel("Magnitud")
    axis ([0, 4000, 0,13000])
    
figure
subplot(2,1,1)
    plot(vRec, vAltaRec, 'color', [0.6, 0.2, 0.6])
    title("Vector senoidal de frecuencias altas")
    xlabel("Tiempo")
    
subplot(2,1,2)
    stem(vecCoAlta, magAlta, 'color', [0.4660, 0.6740, 0.1880]);
    title("Vector mixto de frecuencias altas")
    xlabel("Frecuencia")
    ylabel("Magnitud")
    axis ([0, 4000, 0,13000])



figure
subplot(2,1,1)
    plot(vRec, vSumaRec, 'color', [0.6, 0.2, 0.6])
    title("Vector senoidal de la suma de frecuencias")
    xlabel("Tiempo")
    
subplot(2,1,2)
    stem(vecCoSuma, magSuma, 'color', [0.4660, 0.6740, 0.1880]);
    title("Vector mixto de la suma de frecuencias")
    xlabel("Frecuencia")
    ylabel("Magnitud")
    axis ([0, 4000, 0,13000])
    
sound(vBaja, frec);
pause(4);
sound(vAlta, frec);
pause(4);
sound(vSuma, frec);

end

