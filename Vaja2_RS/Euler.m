function [time, xx] = Euler(x0, par, krm)

    time = [];
    xx = [];
    x = x0;
    
    for t = 0:krm(2):krm(1)
        
        dx = deriv(t, x, par);
        
        output(t,x)
        time = [time;t];
        xx = [xx;x];
        x = x + dx*krm(2);
    end
    plot(time, xx)
    grid on 
end