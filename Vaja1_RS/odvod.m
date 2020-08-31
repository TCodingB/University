function dx = odvod(t, x)
ro = 1000;
S1 = 0.01;
S2 = 0.01;
kv1 = 0.10;
kv2 = 0.05;
CH1 = ro * S1;
CH2 = ro * S2;
fi = 0.02;
h1 = x(1);
h2 = x(2);

fi1 = kv1 * sign(h1-h2)*sqrt(abs(h1-h2));
fi2 = kv2 * sign(h2) *sqrt(abs(h2));

dh1 = (fi - fi1)/(ro*S1);
dh2 = (fi1 - fi2)/(ro*S2);

dx = [dh1 dh2]';
end
