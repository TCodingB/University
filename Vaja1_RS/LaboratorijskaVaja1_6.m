close all
clear all
clc

ro = 1000;
S1 = 0.01;
S2 = 0.01;
R1 = 5;
R2 = 10;

kv1 = 0.1;
kv2 = 0.05;

sim('Sim_LabVaja1_6');
figure
plot(t, h1, 'b', t, h2, 'r')
%saveas(gcf,'Graph6.jpg')
%figure
%plot(t,h2, 'b')
%saveas(gcf,'Graph6.2.jpg')