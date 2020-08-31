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
t = 0:10:1600

G1 = tf([RH1*RH2*CH2 RH1+RH2], [RH1*RH2*CH1*CH2 RH1*CH1+RH2*CH1+RH2*CH2 1]);
G2 = tf([RH2], [RH1*RH2*CH1*CH2 RH1*CH1+RH2*CH1+RH2*CH2 1]);

t3 = 0:14:1600;
t1 = 0:10:1600;
t2 = 0:100:1600;
t4 = 0:97:1600;


sim('Sim_LabVaja1_4_1');
sim('Sim_LabVaja1_4_2');
sim('Sim_LabVaja1_4_3');

figure(1);
plot(t3, fi1)
saveas(gcf,'Graph4.1.jpg')

figure(2);
plot(t4, h2, 'ro', t1, h22, 'bx')
%saveas(gcf,'Graph4.2.jpg')