function [] = P3R1()


frecRef = 2; % FRefe
frecM = 20; % FmRefe
A = 5; % Amplitud
t = 1; % Ttm
D = 0; % Defasamiento

% Generacion de señal senoidal
[vecSeno,fm] = funGeSe(frecM,t,A,frecRef,D);    

% Gráfica senoidal
funGraOnda(vecSeno, fm, "Gráfica senoidal", 100, [2,1,1])

% Gráfica del espectro
[magE,vectorE] = funGeMagFre(frecM, fm);
funGraMagFre(magE, vectorE, [2,1,2]); 


figure
subplot (2,1,1)
    stem(fm, vecSeno)
subplot(2,1,2)
    funGraMagFre(magE, vectorE, [2,1,2]);
    
pamso = vecSeno + 5;

figure
stem(fm, pamso)

L = 256; % L = niveles
pcmsof = (pamso ./ (2 * A)) * (L - 1);
pcmsoc = round(pcmsof);

figure
    subplot(2,1,1)
    stem(fm, pcmsof)

    subplot(2,1,2)
    stem(fm, pcmsoc)
    
  potMed=sqrt(snr(vecSeno))
  potMedMues=sqrt(snr(pcmsoc))
  
  Q=(max(pamso)-min(pamso))/L
 
  ErrorQ=pcmsof-pcmsoc;
  SQNR=10*log10(vecSeno./ErrorQ)
  %figure
  %stem(fm,SQNR);
  
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
  stairs(tren);
  
  valores=pamso./pcmsof;
  figure
  stem(fm,valores)

end

