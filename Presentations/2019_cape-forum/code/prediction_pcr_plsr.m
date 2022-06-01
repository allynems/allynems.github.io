function Y=prediction_pcr_plsr(beta,X)
    Y = [ones(size(X,1),1), X]*beta;
end