clear all
close all
clc

t1 = 0:10:1600;
t2 = 0:100:1600;

RH1= 5;
RH2 = 10;
S1 = 0.01;
S2 = 0.01;
ro = 1000;
CH1 = ro * S1;
CH2 = ro * S2;

G1 = tf([RH1*RH2*CH2 RH1+RH2], [RH1*RH2*CH1*CH2 RH1*CH1+RH2*CH1+RH2*CH2 1]);
G2 = tf([RH2], [RH1*RH2*CH1*CH2 RH1*CH1+RH2*CH1+RH2*CH2 1]);

u1 = 0.02*ones(size(t1));
u2 = 0.02*ones(size(t2));

[Y5, T5]=lsim(G2, u1, t1);
[Y6, T6]=lsim(G2, u2, t2);

figure;
plot(T5, Y5,'r', T6, Y6, 'bx');
%saveas(gcf,'Graph2.jpg')

%%%% 3. Naloga
u3 = 0.02 + 0.01*sin(0.01*t1);
u4 = 0.02 + 0.01*sin(0.01*t2);

[Y7, T7]=lsim(G2, u3, t1);
[Y8, T8]=lsim(G2, u4, t2);
figure;
plot(T7, Y7, 'r', T8, Y8, 'bx')
%saveas(gcf,'Graph3.jpg')