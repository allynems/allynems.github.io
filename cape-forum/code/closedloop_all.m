%% Closed-loop testing
clear;close all
% meas_set=3;

filepath='C:[...]';
% ite=100;
Ntest=10;

J=zeros(Ntest,1);
U= zeros(Ntest,1);
Ju=zeros(Ntest,1);
Juopt=zeros(Ntest,1);
iteractions=zeros(1,Ntest);
tol=1e-4;
Maxite=1000;
algor='SVR';
mkdir(['CL_',algor])
for meas_set=1:4
    load(['result_all' int2str(meas_set)])
    switch algor
        case 'PCR'
            trainedModel=PCRresults.model;
        case 'PLS'
            trainedModel=PLSresults.model;
        case 'SVR'
            trainedModel=SVRresults.model;
    end
    load([filepath 'TestData' int2str(meas_set) '.mat'])
    y=TestData.y_test;
    d=TestData.d_test;
    Uopt=TestData.uOpt_test';
    bias=TestData.bias;
    Jopt=TestData.Jopt_test;
    if strcmp(algor,'PCR') || strcmp(algor,'PLS')
        Xtest=y{:,:};
        ny=size(y,2);
        nl_test=[];
        nl_train=[];
        Xtrain_nl=[];
        for j=[-1,1,2]
            for r=[-1,1,2]
                if j+r>3 || j+r<-1
                    continue
                end
                for i=1:ny-1
                    nl_train=[nl_train,Xtrain(:,i).^j.*Xtrain(:,i+1:end).^r];
                    nl_test=[nl_test,Xtest(:,i).^j.*Xtest(:,i+1:end).^r];
        %             sp=Xtrain(:,i).*Xtrain(:,i+1:end);
                end
            end
        end
        y_nl=[Xtest,Xtest.^(-1),Xtest.^2,Xtest.^3,nl_test];
        Xtrain_nl=[Xtrain,Xtrain.^(-1),Xtrain.^2,Xtrain.^3,nl_train];
        y_nl=(y_nl-min(Xtrain_nl))./range(Xtrain_nl);
        y=y_nl;
    end

    switch meas_set
        case 1
            par_set={'T0','T1','Th1','T2','Th2'};
%             y(1,:)=table(60,85.714,120,158.46,220);
        case 2
            par_set={'T0','Th1','Th2','Th1e','Th2e'};
%             y(1,:)=table(60,120,220,77.143,121.54);
        case 3
            par_set={'T0','T','Th1e','Th2e','w0','wh1','wh2'};
%             y(1,:)=table(60,122.09,77.143,121.54,100,30,50);
        case 4
            par_set={'T0','T','Th1','Th2','u_span'};
%             y(1,:)=table(60,122.09,120,220,0.5);
    end
    Jimp=[];
    Uimp=[];
    Jopt_imp=[];
    Uopt_imp=[];
    Ju_imp=[];
    Ju_pred_imp=[];
    for k=1:Ntest
        %Initialization
        u=0.5;
        Y=y(k,:);
        Ju_prev=1;
        Ju_pred=0;
        p=1;
        while abs(Ju_prev-Ju_pred)>tol
            Ju_prev=Ju_pred;
            if strcmp(algor,'SVR')
                Ju_pred=prediction(trainedModel,table2array(Y));
            elseif strcmp(algor,'PCR')
                Ju_pred=prediction_pcr_plsr(trainedModel,Y);
            elseif strcmp(algor,'PLS')
                Ju_pred=prediction_pcr_plsr(trainedModel,Y);
            end
            u=u+0.0001*Ju_pred;
            if u>1
                u=1;
            elseif u<0
                u=0.0;
            end
            [~,meas]=hex_output(u,d(k,:));
            Ju_real=hex_grad(u,d(k,:));
            if meas_set==3
                Y=horzcat(meas(1,par_set(1:4)),d(k,par_set(5:7)));
            elseif meas_set==4
                Y=addvars(meas(1,par_set(1:4)),u);
            elseif meas_set==5
                Y=addvars(meas(1,par_set(1:3)),u);
            else
                Y=meas(1,par_set);
            end
            Y=table2array(Y)+bias(k,:);
            if strcmp(algor,'PCR') || strcmp(algor,'PLS')
                Xtest=Y;
%                 Xtrain_nl=PCRresults.Xtrain_nl;
                ny=size(Y,2);
                nl_test=[];
                nl_train=[];
                Xtrain_nl=[];
                for j=[-1,1,2]
                    for r=[-1,1,2]
                        if j+r>3 || j+r<-1
                            continue
                        end
                        for i=1:ny-1
                            nl_train=[nl_train,Xtrain(:,i).^j.*Xtrain(:,i+1:end).^r];
                            nl_test=[nl_test,Xtest(:,i).^j.*Xtest(:,i+1:end).^r];
                %             sp=Xtrain(:,i).*Xtrain(:,i+1:end);
                        end
                    end
                end
                y_nl=[Xtest,Xtest.^(-1),Xtest.^2,Xtest.^3,nl_test];
                Xtrain_nl=[Xtrain,Xtrain.^(-1),Xtrain.^2,Xtrain.^3,nl_train];
                y_nl=(y_nl-min(Xtrain_nl))./range(Xtrain_nl);
                Y=y_nl;
            else
                Y=table(Y);
            end
            p=p+1;
            if p>Maxite
                disp(['Maximum iteration reached at point ',int2str(k)])
                break
            end
            Jimp=[Jimp;meas{1,'T'}];
            Uimp= [Uimp;u];
            Uopt_imp=[Uopt_imp;Uopt(k)];
            Jopt_imp=[Jopt_imp;Jopt(k)];
            Ju_imp=[Ju_imp;Ju_real];
            Ju_pred_imp=[Ju_pred_imp;Ju_pred];
        end
        J(k)=meas{1,'T'};
        U(k)= u;
        Ju(k)=Ju_pred;
        iteractions(k)=p;
    end

    
    fig5=figure;
    stairs(Jopt_imp,'k--')
    hold on
    plot(1:length(Jimp),Jimp,'b')
    ylabel('Cost');xlabel('k');legend('Optimal','Actual','Location','best')
    saveas(fig5,[pwd '\CL_' algor '\Cost' int2str(meas_set) '.jpg'])
    saveas(fig5,[pwd '\CL_' algor '\Cost' int2str(meas_set) '.fig'])

    
    fig6=figure;
    stairs(Uopt_imp,'k--')
    hold on
    plot(1:length(Uimp),Uimp,'b')
    ylabel('Input');xlabel('k');legend('Optimal','Actual','Location','best')
    saveas(fig6,[pwd '\CL_' algor '\Input' int2str(meas_set) '.jpg'])
    saveas(fig6,[pwd '\CL_' algor '\Input' int2str(meas_set) '.fig'])

    
    fig7=figure;
    plot(1:length(Ju_imp),zeros(length(Ju_imp),1),'k--',1:length(Ju_imp),Ju_imp,'b')
    ylabel('Gradient');xlabel('k');legend('Optimal','Actual','Location','best')
    saveas(fig7,[pwd '\CL_' algor '\Gradient' int2str(meas_set) '.jpg'])
    saveas(fig7,[pwd '\CL_' algor '\Gradient' int2str(meas_set) '.fig'])
    
    fig8=figure;
    plot(1:iteractions(1)-1,Ju_pred_imp(1:iteractions(1)-1),'b',1:iteractions(1)-1,Ju_imp(1:iteractions(1)-1),'k--')
    ylabel('Gradient');xlabel('k');legend('Predicted','Actual','Location','best')
    saveas(fig8,[pwd '\CL_' algor '\Gradient_zoom' int2str(meas_set) '.jpg'])
    saveas(fig8,[pwd '\CL_' algor '\Gradient_zoom' int2str(meas_set) '.fig'])
    
end
