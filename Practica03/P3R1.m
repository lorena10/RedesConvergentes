function [] = P3R1()


frecRef = 2; % FRefe
frecM = 20; % FmRefe
A = 5; % Amplitud
t = 1; % Ttm
D = 0; % Defasamiento

% Generacion de señal senoidal
[pam,fm] = funGeSe(frecM,t,A,frecRef,D);    

% Gráfica senoidal 
funGraOnda(pam, fm, "Gráfica senoidal", 100, [2,1,1])

% Gráfica del espectro
[magE,vectorE] = funGeMagFre(frecM, fm);
funGraMagFre(magE, vectorE, [2,1,2]); 

% Muestreo
figure
subplot (2,1,1)
    stem(fm, pam, 'color', [0.4660, 0.6740, 0.1880])
    title("Señal muestreada")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
    
subplot(2,1,2)
    funGraMagFre(magE, vectorE, [2,1,2]);
    
% Cuantización
% PAMSO
pamso = pam + 5;

figure
stem(fm, pamso, 'color', [0.4660, 0.6740, 0.1880])
title("PAMSO")
xlabel("--> Tiempo")
ylabel("--> Magnitud")

L = 256; % L = niveles
pcmsof = (pamso ./ (2 * A)) * (L - 1);
pcmsoc = round(pcmsof);

figure
    subplot(2,1,1)
    stem(fm, pcmsof, 'color', [0.4660, 0.6740, 0.1880])
    title("PCMSOF: Cuantización con 256 niveles")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")

    subplot(2,1,2)
    stem(fm, pcmsoc, 'color', [0.6, 0.2, 0.6])
    title("PCMSOC: Cuantización redondeada con 256 niveles")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
    
% Cálculos

% Potencia media
potMedMues = sqrt(snr(pamso))
potMedCuan = sqrt(snr(pcmsoc))

% Cuantizador
Q = (max(pamso) - min(pamso)) / L
 
% Error de cuantización
errorQ = abs(pcmsoc - pcmsof)

figure
stem(errorQ)

pcmsof
pcmsoc
% Potencia media del error
potMedError = sqrt(snr(errorQ))

% SQNR
SQNR=10*log10(pam./errorQ);
figure
stem(fm,SQNR);
  
binFun=dec2bin(pcmsoc);
numBinFun=str2num(binFun);
numBinFun=numBinFun';
tren(1)=0;
for i=1:20
    for j=1:8
        tren(j*i)=str2num(binFun(i,j));
    end
end
figure 
stairs(tren, 'color', [0.4660, 0.6740, 0.1880]);
title("Tren de pulsos")
axis([0, 160, -0.3, 1.3])

valores=pamso./pcmsof;
figure
stem(fm,valores)
end

