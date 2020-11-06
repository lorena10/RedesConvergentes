function [] = P3R1()


frecRef = 2; % FRefe
frecM = 20; % FmRefe
A = 5; % Amplitud
t = 1; % Ttm
D = 0; % Defasamiento

% Generacion de se�al senoidal
[pam,fm] = funGeSe(frecM,t,A,frecRef,D);    

% Gr�fica senoidal 
funGraOnda(pam, fm, "Gr�fica senoidal", 100, [2,1,1])

% Gr�fica del espectro
[magE,vectorE] = funGeMagFre(frecM, fm);
funGraMagFre(magE, vectorE, [2,1,2]); 

% Muestreo
figure
subplot (2,1,1)
    stem(fm, pam, 'color', [0.4660, 0.6740, 0.1880])
    title("Se�al muestreada")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
    
subplot(2,1,2)
    funGraMagFre(magE, vectorE, [2,1,2]);
    
% Cuantizaci�n
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
    title("PCMSOF: Cuantizaci�n con 256 niveles")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")

    subplot(2,1,2)
    stem(fm, pcmsoc, 'color', [0.6, 0.2, 0.6])
    title("PCMSOC: Cuantizaci�n redondeada con 256 niveles")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
    
% C�lculos

% Potencia media
potMedMues = sqrt(snr(pamso))
potMedCuan = sqrt(snr(pcmsoc))

% Cuantizador
Q = (max(pamso) - min(pamso)) / L
 
% Error de cuantizaci�n
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
 
%Convertimos los valores de PCMSOC a un tren de impulsos
binFun=dec2bin(pcmsoc);
  tren(1)=0;
  x=1;
  for i=1:20
    for j=1:8
        tren(x)=str2num(binFun(i,j));
        x=x+1;
    end
    
  end
  
 figure 
stairs(tren, 'color', [0.4660, 0.6740, 0.1880]);
title("Tren de pulsos")
axis([0, 160, -0.3, 1.3])
 
%se reconvierte el tren de impulsos a PCM
  x=1;
   Aux(1)=0
  for i=1:20
        for j=1:8
        Aux(i,j)=tren(x);     
        x=x+1;
        end  
  end
  convTren=bi2de(Aux,'left-msb');
 convTren= convTren'
 potIni=sqrt(snr(pam));
%convertimos PCM a PAM
 pam = (convTren.*(2*A))./(L-1)
 pam=pam-5
 
 figure
  subplot(3,1,1)
  stem(fm,convTren,'color', [0.6, 0.2, 0.6]);
    title("PCM:Reconstrucci�n de la se�al")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
 subplot(3,1,2)
     stem(fm,pam,'color', [0.6, 0.2, 0.6]);
    title("PAM:Reconstrucci�n de la se�al")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")

    subplot(3,1,3,'color', [0.6, 0.2, 0.6])
    plot(fm, pam)
    title("Reconstrucci�n de la se�al")
    xlabel("--> Tiempo")
    ylabel("--> Magnitud")
    
    potRec=sqrt(snr(pam)) - potIni
end

