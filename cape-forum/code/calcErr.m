function f = calcErr( y, target )
%calcErr Calculate error using four different methods.

    % first get the raw error
    e = (y-target);

    % now get MSE
    MSE = mean(e.^2);

    % now get RMSE
    RMSE = sqrt(MSE);
    
    % now get NMSE
    NMSE = MSE./var(target);

    % now get RNMSE
    RNMSE = sqrt(NMSE);

    % NRMSE
    NRMSE = sqrt(MSE)./(max(target)-min(target));

    % SAMP
    SAMP = 100*(mean(abs(e)./((abs(y)+abs(target)))));

f.e=e;
f.MSE=MSE;
f.RMSE=RMSE;
f.NMSE=NMSE;
f.RNMSE=RNMSE;
f.NRMSE=NRMSE;
f.SAMP=SAMP;
end
