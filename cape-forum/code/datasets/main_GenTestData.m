clear
Ndata = 1000;
Noise = 0.25;
for meas_set = 1:4

    [y_test,J_test,Ju_test,uOpt_test,Jopt_test,d_test,bias] = GenerateTestData(meas_set, Ndata,Noise);
    
    TestData.y_test = y_test;
    TestData.J_test = J_test;
    TestData.Jopt_test = Jopt_test;
    TestData.Ju_test = Ju_test;
    TestData.uOpt_test = uOpt_test;
    TestData.d_test = d_test;
    TestData.bias=bias;
    
    save(['TestData' int2str(meas_set)],'TestData')
end


% %% Convert to .csv format
% 
% Feature = table2array(TestData.y_test);
% Label = TestData.uOpt_test';
% 
% data = [Feature,Label];
% csvwrite('case3_data4',data)