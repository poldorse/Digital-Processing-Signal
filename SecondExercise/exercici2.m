%Ignasi Escuder ls29286
%Pol Dorse ls31283
%Julia Grifols ls31278

%Exercici2
function [Ba,Aa, Bb, Ab] = exercici2()


A1 = [0.8*exp(-1i*pi/2) 0.8*exp(1i*pi/2)];
B1 = [0.8 -0.75 0.9*exp(1i*pi/4) 0.9*exp(-1i*pi/4)] ;

figure(1)
subplot(2,3,1)
[H1, w1] = freqz(poly(A1),poly(B1),'whole');
plot(w1/pi*1000/2,abs(H1)), title('Sistema a invertir a)'), xlabel('Freq'), ylabel ('modul')
subplot(2,3,4)
plot(w1/pi*1000/2,(angle(H1))), title('Sistema a invertir a)'), xlabel('Freq'), ylabel ('phase') 



%poly (A1)
[H1, w1] = freqz(poly(B1),poly(A1),'whole');
subplot(2,3,2)
plot(w1/pi*1000/2 ,abs(H1)), title('Sistema invertido a)'), xlabel('Freq'), ylabel ('modul')
subplot(2,3,5)
plot(w1/pi*1000/2,(angle(H1))), title('Sistema invertido a)'), xlabel('Freq'), ylabel ('phase') 





Ax = conv (A1,B1);
Bx = conv (B1, A1);
[H3, w3] = freqz(poly(Ax),poly(Bx),'whole');
figure(1)
subplot(2,3,3)
plot(w3/pi*1000/2,abs(H3)), title('Sistema Concatenado a)'), xlabel('Freq'), ylabel ('modul')
subplot(2,3,6)
plot (w3/pi*1000/2,angle(H3)), title('Sistema Concatenado a)'), xlabel('Freq'), ylabel ('phase') 






figure(2)
A2 = [1.25*exp(-1i*pi/2) 1.25*exp(1i*pi/2) ];
B2 = [0.8 -0.75 0.9*exp(1i*pi/4) 0.9*exp(-1i*pi/4) ]; 



[H2, w2] = freqz(poly(A2),poly(B2),'whole');
subplot(2,3,1);
plot(w2/pi*1000/2,abs(H2)), title('Sistema a invertir b)'), xlabel('Freq'), ylabel ('modul')
subplot(2,3,4);
plot (w2/pi*1000/2,angle(H2)), title('Sistema a invertir b)'), xlabel('Freq'), ylabel ('phase')


A2iCeld = [ 0.8*exp(-1i*pi/2) 0.8*exp(1i*pi/2)];%al multiplicar i dividir por los componentes 1.25e^jpi/2 i 1.25e^-jpi/2 se tachan
B2iCeld = [0.8 -0.75 0.9*exp(1i*pi/4) 0.9*exp(-1i*pi/4)] * (0.8)^2;%al multiplicar i dividir por los componentes 1.25e^jpi/2 i 1.25e^-jpi/2 se tachan



[H21, w2] = freqz(poly(B2iCeld),poly(A2iCeld),'whole');
subplot(2,3,2)
plot(w2/pi*1000/2,abs(H21)), title('Sistema invertido b)'), xlabel('Freq'), ylabel ('modul')
subplot (2,3,5)
plot (w2/pi*1000/2,angle(H21)), title('Sistema invertido b)'), xlabel('Freq'), ylabel ('phase') 



B_op = poly([A2 B2]) * (0.8)^2;
A_op = poly([B2 A2iCeld]);

[H_op,W_op] = freqz(B_op, A_op);


subplot(2,3,3)
plot(W_op/pi*1000/2,abs(H_op))
title('Sistema Concatenado modulo b)')
subplot(2,3,6)
plot (W_op/pi*1000/2,angle(H_op))
title('Sistema Concatenado fase b)')



figure (3);
subplot(3,1,1)

%t = 0:0.001:200;
fs = 1;
ts = 1/fs;
n = 200;
t = 0:ts:(n-1)*ts;
rect = [zeros(1,50) ones(1,50) zeros(1,100)] ;
plot(t, rect), title('f(x)'), xlabel('n'), ylabel ('modul');


fn = 0:fs/n:fs-fs/n;




subplot(3,1,2)

frect=fft(rect);
plot( fn, abs(frect));


Num = poly(A1);
Den = poly(B1);

SenyalFiltrada = filter(Num,Den,rect);
SenyalFiltradaSalida = filter(Den , Num, SenyalFiltrada);
subplot(3,1,3)
plot( t, abs(SenyalFiltradaSalida))

 


figure(4)
subplot(3,1,1)
plot(t, rect), title('f(x)'), xlabel('n'), ylabel ('modul');
subplot(3,1,2)
plot( fn, abs(frect))
subplot(3,1,2)

Num2 = poly(A2);
Den2 = poly(B2);

Num21 = poly(A2iCeld);
Den21 = poly (B2iCeld);

SenyalFiltrada2 = filter(Num2,Den2,rect);
SenyalFiltradaSalida2 = filter(Den21 , Num21, SenyalFiltrada2);
subplot(3,1,3)
plot( t, abs(SenyalFiltradaSalida2))

Ba = poly(A1);
Aa = poly(B1);
Bb = B_op;
Ab = A_op;

end
