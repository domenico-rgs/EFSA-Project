%% Subset Selection - endpoint 1 (forward)
close all
clear all
clc

%% Data import
opts=detectImportOptions('../data/MiniProjectEFSA.xlsx');
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
data=readtable('../data/MiniProjectEFSA.xlsx', opts);
data.Properties.VariableNames={'response','numberOfAnimals','SD','dose','sex','endpoint'};

data_endpoint_1=data(data.endpoint==1,:);
x_1 = data_endpoint_1.sex;
x_2 = data_endpoint_1.dose;
y=data_endpoint_1.response;

n=length(y);

TSS=sum(((y-mean(y))'*((y-mean(y)))));
weights= 1./((data_endpoint_1.SD./sqrt(data_endpoint_1.numberOfAnimals)).^2);

%% K=1
phi_1=[ones(n,1) x_1];
phi_2=[ones(n,1) x_2];
phi_3=[ones(n,1) x_2.*x_1];

[theta_1,std_theta_1, RSS_1] = identificator(phi_1,y, weights); %better
[theta_2,std_theta_2, RSS_2] = identificator(phi_2,y, weights);
[theta_3,std_theta_3, RSS_3] = identificator(phi_3,y, weights);

%% K=2
phi_4=[ones(n,1) x_1 x_2]; 
phi_5=[ones(n,1) x_1 x_2.*x_1];

[theta_4,std_theta_4, RSS_4] = identificator(phi_4,y, weights); %better
[theta_5,std_theta_5, RSS_5] = identificator(phi_5,y, weights);

%% K=3
phi_6=[ones(n,1) x_1 x_2 x_2.*x_1];
[theta_6,std_theta_6, RSS_6] = identificator(phi_6,y, weights);


%% BEST MODEL
[FPE_1,AIC_1,MDL_1,SQUARED_R_1,Cp_1,BIC_1] = objectiveTest(n, length(theta_1), RSS_1, TSS);
[FPE_4,AIC_4,MDL_4,SQUARED_R_4,Cp_4,BIC_4] = objectiveTest(n, length(theta_4), RSS_4, TSS); %but this is better because theta3>2*std.error(theta3)
[FPE_6,AIC_6,MDL_6,SQUARED_R_6,Cp_6,BIC_6] = objectiveTest(n, length(theta_6), RSS_6, TSS); %winner

%% Results plot
%RSS
figure
sgtitle("RSS for each iteration")
subplot(1,3,1)
bar([RSS_1 RSS_2 RSS_3])
grid on
ylabel("RSS")
subplot(1,3,2)
bar([RSS_4 RSS_5])
grid on
set(gca,'XTickLabel',[4 5]);
subplot(1,3,3)
bar([RSS_6])
grid on
set(gca,'XTickLabel',[6]);

%Objective test
x=[1 4 6];
figure
sgtitle("Objective tests evolution")
subplot(2,3,1)
plot(x,[FPE_1 FPE_4 FPE_6],'-o')
grid on
title("FPE")
subplot(2,3,2)
plot(x,[AIC_1 AIC_4 AIC_6],'-o')
grid on
title("AIC")
subplot(2,3,3)
plot(x,[MDL_1 MDL_4 MDL_6],'-o')
grid on
title("MDL")
subplot(2,3,4)
plot(x,[SQUARED_R_1 SQUARED_R_4 SQUARED_R_6],'-o')
grid on
title("R^2")
subplot(2,3,5)
plot(x,[Cp_1 Cp_4 Cp_6],'-o')
grid on
title("C_p")
subplot(2,3,6)
plot(x,[BIC_1 BIC_4 BIC_6],'-o')
grid on
title("BIC")

%Male Model
dose=[0, 30, 100, 150];
male_data=data(data.endpoint==1&data.sex==0,:);

y_hat_1_male = theta_1(1)+theta_1(2)*0+ones(1,4);
y_hat_4_male = theta_4(1)+theta_4(2)*0+theta_4(3)*dose;
y_hat_6_male = theta_6(1)+theta_6(2)*0+theta_6(3)*dose+theta_6(4)*0*dose;
y_male=male_data.response;

figure
plot(dose,y_hat_1_male,"--c")
hold on
plot(dose,y_hat_4_male,"g","linewidth",1)
hold on
plot(dose,y_hat_6_male,"b","linewidth",2)
hold on
plot(dose,y_male,"*k")
grid on
title("Male - endpoint 1")
xlabel("dose")
ylabel("response")
legend("1 predictor","2 predictors","3 predictors","data")

%Female Model
female_data=data(data.endpoint==1&data.sex==1,:);

y_hat_1_female = theta_1(1)+theta_1(2)*1+ones(1,4);
y_hat_4_female = theta_4(1)+theta_4(2)*1+theta_4(3)*dose;
y_hat_6_female = theta_6(1)+theta_6(2)*1+theta_6(3)*dose+theta_6(4)*1*dose;
y_female=female_data.response;

figure
plot(dose,y_hat_1_female,"--c")
hold on
plot(dose,y_hat_4_female,"g","linewidth",1)
hold on
plot(dose,y_hat_6_female,"b","linewidth",2)
hold on
plot(dose,y_female,"*k")
grid on
title("Female - endpoint 1")
xlabel("dose")
ylabel("response")
legend("1 predictor","2 predictors","3 predictors","data")