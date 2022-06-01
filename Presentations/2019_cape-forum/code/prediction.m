function Ypred=prediction(model,X)
    if isnumeric(model)
        Ypred=prediction_pcr_plsr(model,X);
    else
        Ypred=predict(model,X);
    end
end