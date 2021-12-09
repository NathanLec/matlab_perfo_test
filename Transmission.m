%%Burst Data
clear all
clc
clearvars
%Packet Lengts par efficiency suivant plusieurs F et plusieurs D
TRTT=2.5;
figure()
p=10^(-4);
q=1-p;
D=0.45;
c=1500;
H=16;
PH=(1-p)^H;
F=10000;%length of all data
R=[13900 1300 976]; %data rate bps
L=[1:1:800]; %Length of data payload in one packet
M=10; %Number of packets in a train
%F<LM
for a=(1:3)
effi=[];
 N=floor(F./L); %Nombre de packets pour la data
for b=(1:length(L))

    Pt=(1-p)^(2*H+M);
    Pd=(1-p)^(H+L(b));
    somme=0;
    for k=(1:N(b))
        somme=somme+(-1)^k*(factorial(N(b))/(factorial(k)*factorial(N(b)-k)))*((1-Pd)^k)/(1-(1-Pd)^k);
    end
    Netoile=1-somme;
    Nd=N(b)/Pd;
    Nack=Netoile/Pt;
    y=(2*H+M)./R(a);
    Tdisco=H./R(a);
    Thand=1/PH^2*(TRTT+Tdisco);
    Tdata=(Nack-Netoile).*(y+TRTT)+Netoile.*(y+2*D/c)+Nd*(H+L(b))./R(a);
    Ttotal=Tdisco+Thand+Tdata;
    
    effi=[effi (F./R(a))./Ttotal];
  end  


plot (L,effi);
xlabel('L (bits)')
ylabel('efficiency')
hold on
legend('R=13900 bps','R=1300 bps','R=976 bps')
end

%% 

% Instant messages
%R max = 976 bps
TRTT=2.5;
% figure()
p=10^(-3);
q=1-p;
D=0.45;
c=1500;
H=16;
% % 
Rins=976;
effim=[];
Fins=512;
Lins=[1:10:256];
Nins=floor(Fins./Lins);
for b=(1:length(Lins))
    
    Pim=q^(2*H+Lins(b)); %The probability that both the packet and the packet’s acknowledgement are successfully received 
    Nim=Nins(b)/Pim; %The mean number of packets that need to be sent for a reliable delivery of N packets
    Nimack=Nim-Nins(b);
    Tim=Nim*((2*H+Lins(b))/Rins+2*D/c)+Nimack*(2*H/Rins+TRTT);
    effim =[effim (Fins/Rins)/(Tim)];
end
plot(Lins,effim);
xlabel('Lins (bits)')
ylabel('efficiency')
legend('instant message')



