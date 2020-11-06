function [] = P1s4p2R2()

% Matriz [funVoz, Fm]
[audio1, frec1] = audioread("porky.wav");
[audio2, frec2] = audioread("luke.wav");
[audio3, frec3] = audioread("spidey.wav");

% Vectores vxtm
v1 = geVcxTiemFun(audio1,frec1);
v2 = geVcxTiemFun(audio2,frec2);
v3 = geVcxTiemFun(audio3,frec3);

% Vectores magDFT
mag1 = absFFT(audio1);
mag2 = absFFT(audio2);
mag3 = absFFT(audio3);

% Vectores vxfa
vFrec1 = geVcxFreFun(mag1, frec1);
vFrec2 = geVcxFreFun(mag2, frec2);
vFrec3 = geVcxFreFun(mag3, frec3);

figure
subplot(2,1,1)
    plot(v1, audio1, 'color', [0.4660, 0.6740, 0.1880])
    title("Audio: Eso es todo amigos")
    xlabel("Señal de audio")
    ylabel("Tiempo")
    
subplot(2,1,2)
    stem(vFrec1, mag1, 'color', [0.4660, 0.6740, 0.1880])
    title("Vector mixto de frecuencias bajas")
    xlabel("Frecuencia")
    ylabel("Magnitud")
    axis ([0, 4000, 0,120])
    
figure
subplot(2,1,1)
    plot(v2, audio2, 'color', [0.6, 0.4, 0.6])
    title("Audio: Luke, yo soy tu padre")
    xlabel("Señal de audio")
    ylabel("Tiempo")
    
subplot(2,1,2)
    stem(vFrec2, mag2, 'color', [0.6, 0.4, 0.6])
    title("Vector mixto de frecuencias bajas")
    xlabel("Frecuencia")
    ylabel("Magnitud")
    axis ([0, 4000, 0,120])
    
figure
subplot(2,1,1)
    plot(v3, audio3, 'color', [0.2, 0.6, 0.6])
    title("Audio: Un gran poder conlleva una gran responsabilidad")
    xlabel("Señal de audio")
    ylabel("Tiempo")
    
subplot(2,1,2)
    stem(vFrec3, mag3, 'color', [0.2, 0.6, 0.6])
    title("Vector mixto de frecuencias bajas")
    xlabel("Frecuencia")
    ylabel("Magnitud")
    axis ([0, 4000, 0,220])

sound(audio1);
pause(3);
sound(audio2);
pause(3);
sound(audio3);
pause(3);

whos;
end

