clear all
close all
clc

RH1= 5;
RH2 = 10;
S1 = 0.01;
S2 = 0.01;
ro = 1000;
CH1 = ro * S1;
CH2 = ro * S2;

G1 = tf([RH1*RH2*CH2 RH1+RH2], [RH1*RH2*CH1*CH2 RH1*CH1+RH2*CH1+RH2*CH2 1]);
G2 = tf([RH2], [RH1*RH2*CH1*CH2 RH1*CH1+RH2*CH1+RH2*CH2 1]);

t1 = 0:10:1600;
t2 = 0:100:1600;

[Y1, T1] = step(G1, t1);
[Y2, T2] = step(G1, t2);

[Y3, T3] = step(G2, t1);
[Y4, T4] = step(G2, t2);

figure;
plot(T1, Y1*0.02, 'r', T2, Y2*0.02, 'bx', T3,  Y3*0.02, 'c', T4, Y4*0.02, 'mx')
%saveas(gcf,'Graph1.jpg')
