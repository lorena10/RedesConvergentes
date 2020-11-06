function [] = leyMiu()

t = 0:0.005:2;
f = 2;
fm = 400;

% Señal
z = 4*sin(2*pi*f*t)+3*cos(3*pi*f*t)+2*sin(4*pi*f*t)+1*cos(5*pi*f*t);
figure
subplot(2,1,1)
    plot(t, z, 'color', [0.4660, 0.6740, 0.1880])
    title("Suma de senoidales")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")

% FFT de la señal
fftz = abs(fft(z));
subplot(2,1,2)
    plot(t, fftz,'color', [0.6, 0.2, 0.6])
    title("FFT de la suma de señales senoidales")
    xlabel("--> Frecuencia")
    ylabel("--> Magnitud")

% Normalización de la señal
ls = 1;
li = -1;
vse = max(z);
vie = min(z);

d = (ls - li) / (vse - vie);
comp = d .* vie;
zNorm = (d * z) - comp - 1;

figure
subplot(2,1,1)
    plot(t,z, 'color', [0.4660, 0.6740, 0.1880])
    title("Suma de señales senoidales s(t)")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
subplot(2,1,2)
    plot(t, zNorm, 'color', [0.6, 0.2, 0.6])
    title("Suma de señales senoidales normalizada z(t)")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")


% Función compresión
miu = 255; % 8 bits
funComp = sign(zNorm) .* (log(1 + miu .* abs(zNorm)) ./ log(1 + miu));

% Comparación 
figure 
plot(z, funComp, 'color', [0.4660, 0.6740, 0.1880])
title("Comparación F(z) vs z")
xlabel("--> Tiempo")
ylabel("--> Magnitud")

% Practica pasada 
% Muestreo
figure
subplot(2,1,1)
    stem(t, z, 'color', [0.4660, 0.6740, 0.1880])
    title("Señal senoidal")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")

% FFT de la señal
fftz = abs(fft(z));
subplot(2,1,2)
    plot(t, fftz, 'color', [0.6, 0.2, 0.6])
    title("FFT de la señal senoidal")
    xlabel("--> Frecuencia")
    ylabel("--> Magnitud")
    
% Encoder PCM
funComp1 = funComp + 1;
 
A = 1;
L = 256; % L = niveles
pcmsof = (funComp1 ./ (2 * A)) * (L - 1);
pcmsoc = round(pcmsof);

figure
  subplot(2,1,1)
    stem(t,pcmsoc,'color', [0.4660, 0.6740, 0.1880]);
    title("Cuantización de la señal")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
  subplot(2,1,2)
    stem(t,funComp,'color', [0.6, 0.2, 0.6]);
    title("Cuantización de la señal")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
     
% Tren de impulsos
binFun = dec2bin(pcmsoc);
  tren(1) = 0;
  x = 1;
  
  for i = 1 : fm
    for j = 1 : 8
        tren(x) = str2num(binFun(i,j));
        x = x + 1;
    end
    
  end
  
figure
stairs(tren, 'color', [0.4660, 0.6740, 0.1880]);
title("Tren de pulsos")
xlabel("--> Tiempo")
ylabel("--> Niveles")
axis([0, 400, -0.3, 1.3])
 
% Se reconvierte el tren de impulsos a PCM
x = 1;
Aux(1) = 0;
for i = 1 : fm
    for j = 1 : 8
    Aux(i,j) = tren(x);     
    x = x + 1;
    end  
end

convTren = bi2de(Aux,'left-msb');
convTren = convTren';
potIni = sqrt(snr(funComp));

% Convertimos PCM a PAM
funComp = (convTren .* (2 * A)) ./ (L - 1);
funComp = funComp - 1;
fftFunComp = abs(fft(funComp));
    
figure
  subplot(3,1,1)
    stem(t(1:400),funComp,'color', [0.4660, 0.6740, 0.1880]);
    title("Decodificación de la señal")
    xlabel("--> Tiempo")
    ylabel("--> Amplitud")
  subplot(3,1,2)
    plot(t(1:400),funComp,'color', [0.6, 0.2, 0.6]);
    title("Reconstrucción de la señal")
    xlabel("--> Frecuencia")
    ylabel("--> Magnitud")
  subplot(3,1,3)
    plot(t(1:400), fftFunComp,'color', [0.4660, 0.6740, 0.1880])
    title("FFT de la señal reconstruida")
    xlabel("--> Frecuencia")
    ylabel("--> Magnitud")
    
% Descompresión
funDes = sign(funComp).*( (1 / miu) * ((1 + miu).^(abs(funComp)) - 1));

figure
subplot(2,1,1)
    plot(t(1:400), funDes, 'color', [0.4660, 0.6740, 0.1880])
    title("Señal expandida")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
subplot(2,1,2)
    plot(funComp, funDes, 'color', [0.6, 0.2, 0.6])
    title("Comparación F(w) y w")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
    
fun = funDes./d  + comp + 1;
fftFun = abs(fft(fun));
figure
subplot(2,1,1)
    plot (t(1:400),fun, 'color', [0.4660, 0.6740, 0.1880]);
    title("Señal expandida")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
    axis([0, 2, -10, 10])
subplot(2,1,2)
    plot (t(1:400),fftFun, 'color', [0.6, 0.2, 0.6]);
    title("Señal expandida")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")

figure
subplot(2,1,1)
    plot(t, z, 'color', [0.4660, 0.6740, 0.1880])
    title("Suma de senoidales IN")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
subplot(2,1,2)
    plot(fun, z(1:400), 'color', [0.6, 0.2, 0.6])
    title("Suma de senoidales OUT")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
end

