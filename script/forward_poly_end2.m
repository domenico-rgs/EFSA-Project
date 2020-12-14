close all
clear all
clc

%% Import dati
opts=detectImportOptions('../data/MiniProjectEFSA.xlsx');
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
data=readtable('../data/MiniProjectEFSA.xlsx', opts);
data.Properties.VariableNames={'response','numberOfAnimals','SD','dose','sex','endpoint'};

%% Subset Selection - endpoint 1
data_endpoint_2=data(data.endpoint==2,:);
x_1 = data_endpoint_2.sex;
x_2 = data_endpoint_2.dose;
x_3= data_endpoint_2.numberOfAnimals;
y=data_endpoint_2.response;

n=length(y);

TSS=sum(((y-mean(y))'*((y-mean(y)))));
weights= 1./(data_endpoint_2.SD.^2);

%% K=1
phi_1=[ones(n,1) x_1];
phi_2=[ones(n,1) x_2];
phi_3=[ones(n,1) x_3];
phi_4=[ones(n,1) x_1.^2];
phi_5=[ones(n,1) x_2.^2];
phi_6=[ones(n,1) x_3.^2];
phi_7=[ones(n,1) x_1.*x_2];
phi_8=[ones(n,1) x_2.*x_3];
phi_9=[ones(n,1) x_3.*x_1];

[theta_1,std_theta_1, RSS_1] = identificator(phi_1,y, weights);
[theta_2,std_theta_2, RSS_2] = identificator(phi_2,y, weights);
[theta_3,std_theta_3, RSS_3] = identificator(phi_3,y, weights);
[theta_4,std_theta_4, RSS_4] = identificator(phi_4,y, weights);
[theta_5,std_theta_5, RSS_5] = identificator(phi_5,y, weights);
[theta_6,std_theta_6, RSS_6] = identificator(phi_6,y, weights);
[theta_7,std_theta_7, RSS_7] = identificator(phi_7,y, weights);
[theta_8,std_theta_8, RSS_8] = identificator(phi_8,y, weights); %best
[theta_9,std_theta_9, RSS_9] = identificator(phi_9,y, weights);

%% K=4
phi_10=[ones(n,1) x_2 x_3 x_2.*x_3 x_1];
phi_11=[ones(n,1) x_2 x_3 x_2.*x_3 x_1.^2];
phi_12=[ones(n,1) x_2 x_3 x_2.*x_3 x_2.^2];
phi_13=[ones(n,1) x_2 x_3 x_2.*x_3 x_3.^2];
phi_14=[ones(n,1) x_2 x_3 x_2.*x_3 x_1.*x_2];
phi_15=[ones(n,1) x_2 x_3 x_2.*x_3 x_3.*x_1];

[theta_10,std_theta_10, RSS_10] = identificator(phi_10,y, weights); %best
[theta_11,std_theta_11, RSS_11] = identificator(phi_11,y, weights);
[theta_12,std_theta_12, RSS_12] = identificator(phi_12,y, weights);
[theta_13,std_theta_13, RSS_13] = identificator(phi_13,y, weights);
[theta_14,std_theta_14, RSS_14] = identificator(phi_14,y, weights);
[theta_15,std_theta_15, RSS_15] = identificator(phi_15,y, weights);

%% K=5
phi_16=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.^2];
phi_17=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_2.^2];
phi_18=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_3.^2];
phi_19=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.*x_2];
phi_20=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_3.*x_1];

[theta_16,std_theta_16, RSS_16] = identificator(phi_16,y, weights);
[theta_17,std_theta_17, RSS_17] = identificator(phi_17,y, weights); %best
[theta_18,std_theta_18, RSS_18] = identificator(phi_18,y, weights);
[theta_19,std_theta_19, RSS_19] = identificator(phi_19,y, weights);
[theta_20,std_theta_20, RSS_20] = identificator(phi_20,y, weights);

%% K=6
phi_21=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_2.^2 x_1.^2];
phi_22=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_2.^2 x_3.^2];
phi_23=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_2.^2 x_1.*x_2];
phi_24=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_2.^2 x_3.*x_1];

[theta_21,std_theta_21, RSS_21] = identificator(phi_21,y, weights);
[theta_22,std_theta_22, RSS_22] = identificator(phi_22,y, weights);
[theta_23,std_theta_23, RSS_23] = identificator(phi_23,y, weights); %best
[theta_24,std_theta_24, RSS_24] = identificator(phi_24,y, weights);

%% K=7
phi_25=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_2.^2 x_1.*x_2 x_1.^2];
phi_26=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_2.^2 x_1.*x_2 x_3.^2];
phi_27=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_2.^2 x_1.*x_2 x_3.*x_1];

[theta_25,std_theta_25, RSS_25] = identificator(phi_25,y, weights);
[theta_26,std_theta_26, RSS_26] = identificator(phi_26,y, weights); 
[theta_27,std_theta_27, RSS_27] = identificator(phi_27,y, weights);

%% BEST MODEL
[FPE_8,AIC_8,MDL_8,SQUARED_R_8,Cp_8,BIC_8] = objectiveTest(n, length(theta_8), RSS_8, TSS);
[FPE_10,AIC_10,MDL_10,SQUARED_R_10,Cp_10,BIC_10] = objectiveTest(n, length(theta_10), RSS_10, TSS); 
[FPE_17,AIC_17,MDL_17,SQUARED_R_17,Cp_17,BIC_17] = objectiveTest(n, length(theta_17), RSS_17, TSS);
[FPE_23,AIC_23,MDL_23,SQUARED_R_23,Cp_23,BIC_23] = objectiveTest(n, length(theta_23), RSS_23, TSS);
[FPE_25,AIC_25,MDL_25,SQUARED_R_25,Cp_25,BIC_25] = objectiveTest(n, length(theta_25), RSS_25, TSS); %winner
[FPE_26,AIC_26,MDL_26,SQUARED_R_26,Cp_26,BIC_26] = objectiveTest(n, length(theta_26), RSS_26, TSS);
[FPE_27,AIC_27,MDL_27,SQUARED_R_27,Cp_27,BIC_27] = objectiveTest(n, length(theta_27), RSS_27, TSS);

%% Plot
figure
plot([RSS_8 RSS_10 RSS_17 RSS_23 RSS_25 RSS_26 RSS_27])
grid on
set(gca,'XTickLabel',[1 4 5 6 7 7 7]);
title("RSS through models")
xlabel("n° of predictors")
ylabel("RSS")

% Objective test
figure
sgtitle("Objective tests evolution")
subplot(2,3,1)
plot([FPE_8 FPE_10 FPE_17 FPE_23 FPE_25 FPE_26 FPE_27],'-o')
set(gca,'XTickLabel',[1 4 5 6 7 7 7]);
grid on
title("FPE")
subplot(2,3,2)
plot([AIC_8 AIC_10 AIC_17 AIC_23 AIC_25 AIC_26 AIC_27],'-o')
set(gca,'XTickLabel',[1 4 5 6 7 7 7]);
grid on
title("AIC")
subplot(2,3,3)
plot([MDL_8 MDL_10 MDL_17 MDL_23 MDL_25 MDL_26 MDL_27],'-o')
set(gca,'XTickLabel',[1 4 5 6 7 7 7]);
grid on
title("MDL")
subplot(2,3,4)
plot([SQUARED_R_8 SQUARED_R_10 SQUARED_R_17 SQUARED_R_23 SQUARED_R_25 SQUARED_R_26 SQUARED_R_27],'-o')
set(gca,'XTickLabel',[1 4 5 6 7 7 7]);
grid on
title("R^2")
subplot(2,3,5)
plot([Cp_8 Cp_10 Cp_17 Cp_23 Cp_25 Cp_26 Cp_27],'-o')
set(gca,'XTickLabel',[1 4 5 6 7 7 7]);
grid on
title("C_p")
subplot(2,3,6)
plot([BIC_8 BIC_10 BIC_17 BIC_23 BIC_25 BIC_26 BIC_27],'-o')
set(gca,'XTickLabel',[1 4 5 6 7 7 7]);
grid on
title("BIC")