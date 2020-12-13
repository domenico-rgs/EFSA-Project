close all
clear all
clc

%% Import dati
opts=detectImportOptions('./MiniProjectEFSA.xlsx');
data=readtable('./MiniProjectEFSA.xlsx', opts);

%% Unique model
x_1 = data.sex_0_M_1_F_;
x_2 = data.dose;
x_3 = data.numberOfAnimals;
x_4 = data.endpoint;
y=data.response;
n=length(y);
TSS=sum((y-mean(y)'*(y-mean(y))));

%K=1
phi_1=[ones(n,1) x_1];
phi_2=[ones(n,1) x_2];
phi_3=[ones(n,1) x_3];
phi_4=[ones(n,1) x_4];

[theta_1,std_theta_1, SSR_1] = identificator(phi_1,y);
[theta_2,std_theta_2, SSR_2] = identificator(phi_2,y);
[theta_3,std_theta_3, SSR_3] = identificator(phi_3,y);
[theta_4,std_theta_4, SSR_4] = identificator(phi_4,y); %OK

%K=2
phi_5=[ones(n,1) x_1 x_2]; 
phi_6=[ones(n,1) x_1 x_3];
phi_7=[ones(n,1) x_1 x_4];
phi_8=[ones(n,1) x_2 x_3];
phi_9=[ones(n,1) x_2 x_4];
phi_10=[ones(n,1) x_3 x_4];

[theta_5,std_theta_5, SSR_5] = identificator(phi_5,y);
[theta_6,std_theta_6, SSR_6] = identificator(phi_6,y);
[theta_7,std_theta_7, SSR_7] = identificator(phi_7,y); %OK
[theta_8,std_theta_8, SSR_8] = identificator(phi_8,y);
[theta_9,std_theta_9, SSR_9] = identificator(phi_9,y);
[theta_10,std_theta_10, SSR_10] = identificator(phi_10,y);

%K=3
phi_11=[ones(n,1) x_1 x_2 x_3];
phi_12=[ones(n,1) x_2 x_3 x_4];
phi_13=[ones(n,1) x_1 x_3 x_4];
phi_14=[ones(n,1) x_1 x_2 x_4];

[theta_11,std_theta_11, SSR_11] = identificator(phi_11,y);
[theta_12,std_theta_12, SSR_12] = identificator(phi_12,y);
[theta_13,std_theta_13, SSR_13] = identificator(phi_13,y); 
[theta_14,std_theta_14, SSR_14] = identificator(phi_14,y); %OK

%K=4
phi_15=[ones(n,1) x_1 x_2 x_3 x_4];
[theta_15,std_theta_15, SSR_15] = identificator(phi_15,y);

%BEST MODEL
[FPE_4,AIC_4,MDL_4,SQUARED_R_4,Cp_4,BIC_4] = objectiveTest(n, length(theta_4), SSR_4, TSS); %MDL 4 or 7
[FPE_7,AIC_7,MDL_7,SQUARED_R_7,Cp_7,BIC_7] = objectiveTest(n, length(theta_7), SSR_7, TSS); %WINNER
[FPE_14,AIC_14,MDL_14,SQUARED_R_14,Cp_14,BIC_14] = objectiveTest(n, length(theta_14), SSR_14, TSS);
[FPE_15,AIC_15,MDL_15,SQUARED_R_15,Cp_15,BIC_15] = objectiveTest(n, length(theta_15), SSR_15, TSS);

%Miglioramenti: il prof dice di usare una least square pesata (heteroscedasticity). Plottare risultati