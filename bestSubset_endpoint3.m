close all
clear all
clc

%% Import dati
opts=detectImportOptions('./MiniProjectEFSA.xlsx');
dati=readtable('./MiniProjectEFSA.xlsx', opts);

%% Subset Selection - endpoint 3
data_endpoint_3=dati(dati.endpoint==3,:);
x_1 = data_endpoint_3.sex_0_M_1_F_;
x_2 = data_endpoint_3.dose;
x_3 = data_endpoint_3.numberOfAnimals;
y=data_endpoint_3.response;
n=length(y);
TSS=sum((y-mean(y)'*(y-mean(y))));

%K=1
phi_1=[ones(n,1) x_1];
phi_2=[ones(n,1) x_2];
phi_3=[ones(n,1) x_3];

[theta_1,std_theta_1, SSR_1] = identificator(phi_1,y);
[theta_2,std_theta_2, SSR_2] = identificator(phi_2,y);
[theta_3,std_theta_3, SSR_3] = identificator(phi_3,y);

%K=2
phi_4=[ones(n,1) x_1 x_2]; 
phi_5=[ones(n,1) x_1 x_3];
phi_6=[ones(n,1) x_2 x_3];

[theta_4,std_theta_4, SSR_4] = identificator(phi_4,y);
[theta_5,std_theta_5, SSR_5] = identificator(phi_5,y);
[theta_6,std_theta_6, SSR_6] = identificator(phi_6,y);

%K=3
phi_7=[ones(n,1) x_1 x_2 x_3];
[theta_7,std_theta_7, SSR_7] = identificator(phi_7,y);

%BEST MODEL
[FPE_1,AIC_1,MDL_1,SQUARED_R_1,Cp_1,BIC_1] = objectiveTest(n, length(theta_1), SSR_1, TSS);
[FPE_4,AIC_4,MDL_4,SQUARED_R_4,Cp_4,BIC_4] = objectiveTest(n, length(theta_4), SSR_4, TSS); %WINNER (is possible a negative value of AIC and MDL ?)
[FPE_7,AIC_7,MDL_7,SQUARED_R_7,Cp_7,BIC_7] = objectiveTest(n, length(theta_7), SSR_7, TSS); 

%Miglioramenti: il prof dice di usare una least square pesata (heteroscedasticity). Plottare risultati


