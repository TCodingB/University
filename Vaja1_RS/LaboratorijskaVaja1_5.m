close all
clear all
clc
t = [0 1600];

[t, x] = ode45(@odvod, t,[0;0]);

subplot(2,1,2);
plot(t, x(:, 1), 'b');
subplot(2,1,1);
plot(t, x(:, 2), 'b');
%saveas(gcf,'Graph5.1.jpg')

figure;
plot(t,x(:, 1), 'b');
hold;
plot(t,x(:, 2), 'r');
%saveas(gcf,'Graph5.2.jpg')