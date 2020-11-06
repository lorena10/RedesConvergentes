function [] = P1s4p3R3()
% Matriz [funVoz, Fm]
[audio1, frec1] = audioread("porky.wav");
[audio2, frec2] = audioread("luke.wav");
[audio3, frec3] = audioread("spidey.wav");

whos;

potMedia1 = funPoMe(audio1);
potMedia2 = funPoMe(audio2);
potMedia3 = funPoMe(audio3);

fprintf("La potencia media del primer audio es: " + potMedia1 + "\n");
fprintf("La potencia media del segundo audio es: " + potMedia2 + "\n");
fprintf("La potencia media del tercer audio es: " + potMedia3 + "\n");


end

