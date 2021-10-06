function dT = hex_grad(u,par)

Th1 = par.Th1; Th2 = par.Th2; T0 = par.T0;
w0 = par.w0; wh1 = par.wh1; wh2 = par.wh2;
UA1 = par.UA1; UA2 = par.UA2;

meas.Th1 = Th1;
meas.Th2 = Th2;
meas.T0 = T0;

meas.T1 = T0 + (Th1-T0)./(1/2+u.*w0.*(1./(2*wh1)+1./UA1));
meas.T2 = T0 + (Th2-T0)./(1/2+(1-u).*w0.*(1./(2*wh2)+1./UA2));

% Th1out = Th1 - u*w0*(meas.T1-T0)/wh1;
% Th2out = Th2 - (1-u)*w0*(meas.T2-T0)/wh2;
% % Formulas on Jaschke paper (not consistent?)
% meas.T1 = T0 + (Th1-T0)/(1-u*w0*(1/wh1+2/UA1));
% meas.T2 = T0 + (Th2-T0)/(1-(1-u)*w0*(1/wh2+2/UA2));

dT = (meas.T1-T0).^2./(Th1-T0) - (meas.T2-T0).^2./(Th2-T0);

end