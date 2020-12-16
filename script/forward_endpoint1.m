%% Subset Selection - endpoint 1

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
x_3= data_endpoint_1.numberOfAnimals;
y=data_endpoint_1.response;

n=length(y);

TSS=sum(((y-mean(y))'*((y-mean(y)))));
weights= 1./((data_endpoint_1.SD./data_endpoint_1.numberOfAnimals).^2);

%% K=1
phi_1=[ones(n,1) x_1];
phi_2=[ones(n,1) x_2];
phi_3=[ones(n,1) x_3];

[theta_1,std_theta_1, RSS_1] = identificator(phi_1,y, weights); %better
[theta_2,std_theta_2, RSS_2] = identificator(phi_2,y, weights);
[theta_3,std_theta_3, RSS_3] = identificator(phi_3,y, weights);

%% K=2
phi_4=[ones(n,1) x_1 x_2]; 
phi_5=[ones(n,1) x_1 x_3];

[theta_4,std_theta_4, RSS_4] = identificator(phi_4,y, weights); %better
[theta_5,std_theta_5, RSS_5] = identificator(phi_5,y, weights);

%% K=3
phi_6=[ones(n,1) x_1 x_2 x_3];
[theta_6,std_theta_6, RSS_6] = identificator(phi_6,y, weights);


%% BEST MODEL
[FPE_1,AIC_1,MDL_1,SQUARED_R_1,Cp_1,BIC_1] = objectiveTest(n, length(theta_1), RSS_1, TSS);
[FPE_4,AIC_4,MDL_4,SQUARED_R_4,Cp_4,BIC_4] = objectiveTest(n, length(theta_4), RSS_4, TSS); %winner
[FPE_6,AIC_6,MDL_6,SQUARED_R_6,Cp_6,BIC_6] = objectiveTest(n, length(theta_6), RSS_6, TSS);

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
