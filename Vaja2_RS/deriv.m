function dx = deriv(t, x, par)
    fi = 0.02;
    fi1 = par(3) * sign(x(1)-x(2))*sqrt(abs(x(1)-x(2)));
    fi2 = par(4) * sign(x(2)) *sqrt(abs(x(2)));
    
    dh1 = (fi - fi1)/par(1);
    dh2 = (fi1 - fi2)/par(2);
    dx = [dh1 dh2];
    
end