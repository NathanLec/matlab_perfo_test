publish(D:\documents\PFE\PER_calcul)
clc
clear all
clearvars
W=16000;
RSSI=mean([-20 -85]);
Noise=RSSI+6;
SNR=RSSI/Noise;
R=976;
G=10*log10(W./R);
x=floor((sqrt(2*10^((G+SNR)/10))));
fun=@(t) 1/(2.*pi).*exp(-t.^2./2);
q= integral(fun,x,Inf);
BER=2.*q*(1-0.5.*q);

Ld=64;
PER=1-(1-BER)^Ld;