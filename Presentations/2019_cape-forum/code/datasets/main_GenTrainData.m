clear
Ndata = 1000;
Noise = 0.1;
for meas_set = 1:4

    [y_train,J_train,Ju_train,uOpt_train,Jopt_train,d_train,bias] = GenerateTestData(meas_set, Ndata,Noise);
    
    TrainData.y_train = table2array(y_train);
    TrainData.J_train = J_train;
    TrainData.Jopt_train = Jopt_train;
    TrainData.Ju_train = Ju_train;
    TrainData.uOpt_train = uOpt_train';
    TrainData.d_train = table2array(d_train);
    TrainData.bias=bias;
    
%     save(['TrainData' int2str(meas_set)],'TrainData')
    writetable(struct2table(TrainData),['TrainData' int2str(meas_set) '.csv']);
end


% %% Convert to .csv format
% 
% Feature = table2array(trainData.y_train);
% Label = trainData.uOpt_train';
% 
% data = [Feature,Label];
% csvwrite('case3_data4',data)