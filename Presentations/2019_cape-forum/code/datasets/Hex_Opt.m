function [u_opt,w_opt_SS] = Hex_Opt(par)

import casadi.*

T1 = MX.sym('T1');
T2 = MX.sym('T2');
T = MX.sym('T');
Th1e = MX.sym('Th1e'); 
Th2e = MX.sym('Th2e'); 

u = MX.sym('u');

Th1 = par.Th1; Th2 = par.Th2; T0 = par.T0;
w0 = par.w0; wh1 = par.wh1; wh2 = par.wh2;
UA1 = par.UA1; UA2 = par.UA2;

f1 = -T1 + T0 + (Th1-T0)./(1/2+u.*w0.*(1./(2*wh1)+1./UA1));
f2 = -T2 + T0 + (Th2-T0)./(1/2+(1-u).*w0.*(1./(2*wh2)+1./UA2));
f3 = -T + u.*T1 + (1-u).*T2;
f4 = -Th1e + Th1 - u.*w0./wh1.*(T1 - T0);
f5 = -Th2e + Th2 - (1-u).*w0./wh2.*(T2 - T0);

x_var = vertcat(T1,T2,T,Th1e,Th2e);
f = vertcat(f1,f2,f3,f4,f5);

%% 
lbx = 1e-3*ones(5,1);
ubx = 500*ones(5,1);
dx0 = 100.*ones(5,1);

lbu = [0];
ubu = [1];
u0 = [0.5];

w = {};
w0 = [];
lbw = [];
ubw = [];

g = {};
lbg = [];
ubg = [];

w = {w{:},x_var,u};
lbw = [lbw;lbx;lbu];
ubw = [ubw;ubx;ubu];
w0 = [w0;dx0;u0];

J = -T; % Economic objective

g = {g{:},f};
lbg = [0.*ones(5,1)];
ubg = [0.*ones(5,1)];

opts = struct('warn_initial_bounds',false, ...
    'print_time',false, ...
    'ipopt',struct('print_level',1) ...
    );

nlp = struct('x',vertcat(w{:}),'f',J,'g',vertcat(g{:}));
solver = nlpsol('solver','ipopt',nlp,opts);
sol = solver('x0',w0,'lbx',lbw,'ubx',ubw,'lbg',lbg,'ubg',ubg);
w_opt_SS = full(sol.x);
u_opt = w_opt_SS(end);


