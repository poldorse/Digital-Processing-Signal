%Ignasi Escuder ls29286
%Pol Dorse ls31283
%Julia Grifols ls31278

function [fi, Bb, Bc1, Ac1, Bc2, Ac2] = exercici1()

%Apartat A
[audio,Fs] = audioread('music1.wav');
L = length(audio);
NFFT = 2^nextpow2(L);
Y = fft(audio, NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

w11= 2* pi*2200/Fs;
w12= 2* pi*(-2200)/Fs;
w21= 2* pi*(4400)/Fs;
w22= 2* pi*(-4400)/Fs;

figure(1)

subplot(1,1,1)
plot(f,20*log10(abs(Y(1:NFFT/2+1))));

title('Resposta freqüèncial Audio  ')
xlabel('Freq(Hz)')
grid on 


%ApartatB
figure(2)
subplot(2,2,1)
plot(f,20*log10(abs(Y(1:NFFT/2+1))));
title('Resposta freqüèncial Audio')
xlabel('Freq(Hz)')
grid on 

fi= [exp(w11*1i) exp(w12*1i) exp(w21*1i) exp(w22*1i)];
Bb = poly(fi);
w_max =  2* pi* 115.8/Fs; %115.8 Hz maxim pic de energia de la senyal util


[H, w] = freqz(Bb,1,1000);

valor_maxim = abs(polyval(Bb,exp(-1i*w_max)));

G = 1/valor_maxim;
B_nor = G*Bb;
Hh= G*H;

subplot(2,2,2)
plot(w/pi*Fs/2,20*log10(abs(Hh)))

title('Resposta en Frequencia del Filtre FIR ')
xlabel('freq(Hz)')
grid on 
SenyalFiltrada = filter(B_nor,1,audio);



subplot(2,2,3)
plot(SenyalFiltrada);

title('Senyal Temporal audio ')
xlabel('temps(segons)')
grid on 

SL = length(SenyalFiltrada);
NFFTS = 2^nextpow2(SL);
YS = fft(SenyalFiltrada, NFFTS)/SL;
fS = Fs/2*linspace(0,1,NFFTS/2+1);

subplot(2,2,4)
plot(fS,20*log10(abs(YS(1:NFFTS/2+1))));
title('Resposta freqüencial Senyal Filtrada ')
xlabel('Freq(Hz)')
grid on 

%normalitzarem perque la senyal es guardi correctament
SenyalFiltrada = SenyalFiltrada./(max(abs(SenyalFiltrada)));
audiowrite('music1b.wav',SenyalFiltrada,Fs);
figure(3)

[Rg,wg] = grpdelay(Hh);
plot(wg, Rg);

title('Retard de grup')
xlabel('Freq(Hz)')
grid on 

%ApartatC
 cont= 0;
 r =0;
 
 
 while(cont < 3)     
        switch(cont)
            case 0                
                r = 0.9;
            case 1
                r = 0.99;                
            case 2
                r = 1.1;                
        end        
        figure(cont+4);
        c = [r*exp(1i*((2200*2*pi)/Fs)), r*exp(-1i*((2200*2*pi)/Fs)), r*exp(1i*((4400*2*pi)/Fs)), r*exp(-1i*((4400*2*pi)/Fs))];
        A = poly(c);
        B_B = poly([exp(w11*1i) exp(w12*1i) exp(w21*1i) exp(w22*1i)]);
        [H, w] = freqz(B_B,A,1000);
        subplot(2,2,1)
        plot(w/pi*Fs/2,20*log10(abs(H)))
        title('Filtre')
        xlabel('Freq(Hz)')
        grid on 
        max_pic = 2*pi* 115.8/Fs;
        valor_max = abs(polyval(B_B,exp(-1i*max_pic)));
        Guany = 1/valor_max;
        BN = B_B*Guany;
        Hf= H*Guany;
        SenyalFiltradaa = filter(BN,A,audio);       
        subplot(2,2,2)
        plot(SenyalFiltradaa);        
        title('Senyal Temporal audio ')
        xlabel('temps(segons)')
        grid on 
        SL = length(SenyalFiltradaa);
        NFFTS = 2^nextpow2(SL);
        YS = fft(SenyalFiltradaa, NFFTS)/SL;
        fS = Fs/2*linspace(0,1,NFFTS/2+1);
        subplot(2,2,3)
        plot(fS,20*log10(abs(YS(1:NFFTS/2+1)))); 
        title('Senyal filtrada')
        xlabel('Freq(Hz)')
        grid on 
        [Rg,wg] = grpdelay(Hf);
        subplot(2,2,4)
        plot(wg, Rg);
        title('Retard de Grup')
        xlabel('Freq(Hz)')
        grid on         
        SenyalFiltradaa = SenyalFiltradaa./(max(abs(SenyalFiltradaa)));
        switch(cont)
            case 0                
                audiowrite('music1c1.wav',SenyalFiltradaa,Fs);
                Bc1=B_B;
                Ac1 = A;
            case 1
                audiowrite('music1c2.wav',SenyalFiltradaa,Fs);  
                Bc2 = B_B;
                Ac2 = A;
        end
        cont = cont +1; 
 end
end
 
 



