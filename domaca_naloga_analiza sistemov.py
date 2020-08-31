# -*- coding: utf-8 -*-

import numpy as np
from scipy import linalg
from scipy import integrate
from matplotlib import pyplot as pp

def analiticna_resitev(t):
    
    return np.array([4/3-8/3*np.exp(-3/2*t)*np.sin(np.sqrt(3)*t/2 + np.pi/6),
                     8/3-8/3*np.exp(-3/2*t)*np.cos(np.sqrt(3)*t/2)])

    
def numericna_resitev1(A, B, u, x_0, t):
    
    x = np.zeros((2, t.size))
    
    for i, t_i in enumerate(t):
        expAtx0 = np.dot(linalg.expm(A*t_i), x_0)
        
        if np.count_nonzero(u(t)) == 0:
            x[:, i] = expAtx0
        else:
            f1 = lambda tau: np.dot(np.dot(linalg.expm(A*(t_i-tau)), B), u(tau))[0]
            f2 = lambda tau: np.dot(np.dot(linalg.expm(A*(t_i-tau)), B), u(tau))[1]
            
            conv1 = integrate.quad(f1, 0, t_i)[0]
            conv2 = integrate.quad(f2, 0, t_i)[0]
            
            x[0, i] = expAtx0[0] + conv1
            x[1, i] = expAtx0[1] + conv2
        
    return x


def numericna_resitev2(A, B, u, x_0, t_konec):
    
    f = lambda t, x: np.dot(A,x) + np.dot(B,u(t))
    
    solver = integrate.solve_ivp(f, (0, t_konec), x_0, max_step=0.01)
        
    return solver.t, solver.y


def izris_potek(t, x):
    
    pp.figure()
    pp.plot(t, x[0,:], 'b--', label="i_L")
    pp.plot(t, x[1,:], 'g--', label="u_C")
    pp.xlabel("Čas [s]")
    pp.ylabel("Spremenljivke stanj")
    pp.title("Potek spremenljivk stanj sistema")
    pp.legend()
    pp.show()


def izris_tirnica(x):
    
    pp.figure()
    pp.plot( x[0,:],  x[1,:], 'r--')
    pp.xlabel("i_L[A]")
    pp.ylabel("u_C[V]")
    pp.title("Tirnica v prostoru stanj")
    pp.show()


def izris_fazni_portret(x_list):
    
    pp.figure()
    for x in x_list:
        pp.plot(x[0,:], x[1,:], 'k-')
    
    pp.xlabel("i_L[A]")
    pp.ylabel("u_C[V]")
    pp.title("Fazni portret")
    pp.show()

if __name__ == '__main__':
    
    # PODATKI, KI JIH DOBITE Z REŠEVANJEM NALOGE
    A = np.array([[-2, 1],[-1, -1]])
    B = np.array([0, 1]) # B = np.array(([0, 1], [1, 1])) # 2x2 matrika B
    x_0 = np.array([0, 0]) # x_0 = np.array([2, 3])
    u = lambda t: 4 # u = lambda t: np.array([4, 8])  # u = lambda t: np.sin(t)
    
    # ČASOVNE TOČKE
    t_0 = 0
    t_konec = 5
    t = np.linspace(t_0, t_konec, 500)
    
    # ANALITIČNA REŠITEV
    x = analiticna_resitev(t)
    izris_potek(t, x)
    izris_tirnica(x)

    # NUMERIČNA REŠITEV 1
    x = numericna_resitev1(A, B, u, x_0, t)
    izris_potek(t, x)
    izris_tirnica(x)
    
    # FAZNI PORTRET 1
    x_0_ = np.array([[-2,-2],[0,-2],[0,2],[-2,0],[2,0],[-2,2],[2,-2],[2,2]])
    u0 = lambda t: 0  # u = lambda t: np.array([0, 0]) # za 2x2 matriko B
    x_list = []
    for x0_i in x_0_:
        x_list.append(numericna_resitev1(A, B, u0, x0_i, t))
    izris_fazni_portret(x_list)

    # NUMERIČNA REŠITEV 2
    t, x = numericna_resitev2(A, B, u, x_0, t_konec)
    izris_potek(t, x)
    izris_tirnica(x)
    
    # FAZNI PORTRET 2
    x_0_ = np.array([[-2,-2],[0,-2],[0,2],[-2,0],[2,0],[-2,2],[2,-2],[2,2]])
    u0 = lambda t: 0 # u = lambda t: np.array([0, 0]) # za 2x2 matriko B
    x_list = []
    for x0_i in x_0_:
        t, x = numericna_resitev2(A, B, u0, x0_i, t_konec)
        x_list.append(x)
    izris_fazni_portret(x_list)
    

    