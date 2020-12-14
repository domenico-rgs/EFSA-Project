close all
clear all
clc

%% Import dati
opts=detectImportOptions('../data/MiniProjectEFSA.xlsx');
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
data=readtable('../data/MiniProjectEFSA.xlsx', opts);
data.Properties.VariableNames={'response','numberOfAnimals','SD','dose','sex','endpoint'};

%% Subset Selection - endpoint 1
data_endpoint_1=data(data.endpoint==1,:);
x_1 = data_endpoint_1.sex;
x_2 = data_endpoint_1.dose;
x_3= data_endpoint_1.numberOfAnimals;
y=data_endpoint_1.response;

n=length(y);

TSS=sum((y-mean(y)'*(y-mean(y))));
weights= 1./(data_endpoint_1.SD.^2);

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

[theta_1,std_theta_1, RSS_1] = identificator(phi_1,y, weights); %best
[theta_2,std_theta_2, RSS_2] = identificator(phi_2,y, weights);
[theta_3,std_theta_3, RSS_3] = identificator(phi_3,y, weights);
[theta_4,std_theta_4, RSS_4] = identificator(phi_4,y, weights);
[theta_5,std_theta_5, RSS_5] = identificator(phi_5,y, weights);
[theta_6,std_theta_6, RSS_6] = identificator(phi_6,y, weights);
[theta_7,std_theta_7, RSS_7] = identificator(phi_7,y, weights);
[theta_8,std_theta_8, RSS_8] = identificator(phi_8,y, weights);
[theta_9,std_theta_9, RSS_9] = identificator(phi_9,y, weights);

%% K=2
phi_10=[ones(n,1) x_1 x_2];
phi_11=[ones(n,1) x_1 x_3];
phi_12=[ones(n,1) x_1 x_1.^2];
phi_13=[ones(n,1) x_1 x_2.^2];
phi_14=[ones(n,1) x_1 x_3.^2];
phi_15=[ones(n,1) x_1 x_1.*x_2];
phi_16=[ones(n,1) x_1 x_2.*x_3];
phi_17=[ones(n,1) x_1 x_1.*x_3];

[theta_10,std_theta_10, RSS_10] = identificator(phi_10,y, weights); %best
[theta_11,std_theta_11, RSS_11] = identificator(phi_11,y, weights);
[theta_12,std_theta_12, RSS_12] = identificator(phi_12,y, weights);
[theta_13,std_theta_13, RSS_13] = identificator(phi_13,y, weights);
[theta_14,std_theta_14, RSS_14] = identificator(phi_14,y, weights);
[theta_15,std_theta_15, RSS_15] = identificator(phi_15,y, weights);
[theta_16,std_theta_16, RSS_16] = identificator(phi_16,y, weights);
[theta_17,std_theta_17, RSS_17] = identificator(phi_17,y, weights);

%% K=3
phi_18=[ones(n,1) x_1 x_2 x_3];
phi_19=[ones(n,1) x_1 x_2 x_1.^2];
phi_20=[ones(n,1) x_1 x_2 x_2.^2];
phi_21=[ones(n,1) x_1 x_2 x_3.^2];
phi_22=[ones(n,1) x_1 x_2 x_1.*x_2];
phi_23=[ones(n,1) x_1 x_2 x_2.*x_3];
phi_24=[ones(n,1) x_1 x_2 x_1.*x_3];

[theta_18,std_theta_18, RSS_18] = identificator(phi_18,y, weights);
[theta_19,std_theta_19, RSS_19] = identificator(phi_19,y, weights);
[theta_20,std_theta_20, RSS_20] = identificator(phi_20,y, weights);
[theta_21,std_theta_21, RSS_21] = identificator(phi_21,y, weights);
[theta_22,std_theta_22, RSS_22] = identificator(phi_22,y, weights);
[theta_23,std_theta_23, RSS_23] = identificator(phi_23,y, weights); %best
[theta_24,std_theta_24, RSS_24] = identificator(phi_24,y, weights);

%% K=5
phi_25=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.^2];
phi_26=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_2.^2];
phi_27=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_3.^2];
phi_28=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.*x_2];
phi_29=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.*x_3];

[theta_25,std_theta_25, RSS_25] = identificator(phi_25,y, weights);
[theta_26,std_theta_26, RSS_26] = identificator(phi_26,y, weights); %best
[theta_27,std_theta_27, RSS_27] = identificator(phi_27,y, weights);
[theta_28,std_theta_28, RSS_28] = identificator(phi_28,y, weights);
[theta_29,std_theta_29, RSS_29] = identificator(phi_29,y, weights);

%% K=6
phi_30=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.^2 x_2.^2];
phi_31=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.^2 x_3.^2];
phi_32=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.^2 x_1.*x_2];
phi_33=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.^2 x_1.*x_3];

[theta_30,std_theta_30, RSS_30] = identificator(phi_30,y, weights); %best
[theta_31,std_theta_31, RSS_31] = identificator(phi_31,y, weights);
[theta_32,std_theta_32, RSS_32] = identificator(phi_32,y, weights);
[theta_33,std_theta_33, RSS_33] = identificator(phi_33,y, weights);

%% K=7
phi_34=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.^2 x_2.^2 x_3.^2];
phi_35=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.^2 x_2.^2 x_1.*x_2];
phi_36=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.^2 x_2.^2 x_1.*x_3];

[theta_34,std_theta_34, RSS_34] = identificator(phi_34,y, weights);
[theta_35,std_theta_35, RSS_35] = identificator(phi_35,y, weights); %best
[theta_36,std_theta_36, RSS_36] = identificator(phi_36,y, weights);

%% K=8
phi_37=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.^2 x_2.^2 x_1.*x_2 x_3.^2];
phi_38=[ones(n,1) x_1 x_2 x_3 x_2.*x_3 x_1.^2 x_2.^2 x_1.*x_2 x_1.*x_3];

[theta_37,std_theta_37, RSS_37] = identificator(phi_37,y, weights);
[theta_38,std_theta_38, RSS_38] = identificator(phi_38,y, weights); %best

%% BEST MODEL
[FPE_1,AIC_1,MDL_1,SQUARED_R_1,Cp_1,BIC_1] = objectiveTest(n, length(theta_1), RSS_1, TSS);
[FPE_10,AIC_10,MDL_10,SQUARED_R_10,Cp_10,BIC_10] = objectiveTest(n, length(theta_10), RSS_10, TSS); 
[FPE_23,AIC_23,MDL_23,SQUARED_R_23,Cp_23,BIC_23] = objectiveTest(n, length(theta_23), RSS_23, TSS);
[FPE_26,AIC_26,MDL_26,SQUARED_R_26,Cp_26,BIC_26] = objectiveTest(n, length(theta_26), RSS_26, TSS); %winner
[FPE_30,AIC_30,MDL_30,SQUARED_R_30,Cp_30,BIC_30] = objectiveTest(n, length(theta_30), RSS_30, TSS); 
[FPE_35,AIC_35,MDL_35,SQUARED_R_35,Cp_35,BIC_35] = objectiveTest(n, length(theta_35), RSS_35, TSS);
[FPE_37,AIC_37,MDL_37,SQUARED_R_37,Cp_37,BIC_37] = objectiveTest(n, length(theta_37), RSS_37, TSS);
[FPE_38,AIC_38,MDL_38,SQUARED_R_38,Cp_38,BIC_38] = objectiveTest(n, length(theta_38), RSS_38, TSS);

%% Plot
figure
plot([RSS_1 RSS_10 RSS_23 RSS_26 RSS_30 RSS_35 RSS_37 RSS_38])
grid on
set(gca,'XTickLabel',[1 2 3 5 6 7 8 9]);
title("RSS through models")
xlabel("n° of predictors")
ylabel("RSS")

%Objective test
figure
sgtitle("Objective tests evolution")
subplot(2,3,1)
plot(abs([FPE_1 FPE_10 FPE_23 FPE_26 FPE_30 FPE_35 FPE_37 FPE_38]),'-o')
grid on
title("FPE")
subplot(2,3,2)
plot(abs([AIC_1 AIC_10 AIC_23 AIC_26 AIC_30 AIC_35 AIC_37 AIC_38]),'-o')
grid on
title("AIC")
subplot(2,3,3)
plot(abs([MDL_1 MDL_10 MDL_23 MDL_26 MDL_30 MDL_35 MDL_37 MDL_38]),'-o')
grid on
title("MDL")
subplot(2,3,4)
plot(abs([SQUARED_R_1 SQUARED_R_10 SQUARED_R_23 SQUARED_R_26 SQUARED_R_30 SQUARED_R_35 SQUARED_R_37 SQUARED_R_38]),'-o')
grid on
title("R^2")
subplot(2,3,5)
plot(abs([Cp_1 Cp_10 Cp_23 Cp_26 Cp_30 Cp_35 Cp_37 Cp_38]),'-o')
grid on
title("C_p")
subplot(2,3,6)
plot(abs([BIC_1 BIC_10 BIC_23 BIC_26 BIC_30 BIC_35 BIC_37 BIC_38]),'-o')
grid on
title("BIC")

