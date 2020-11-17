close all
clear all
clc

%% Import dati
opts=detectImportOptions('./MiniProjectEFSA.xlsx');
dati=readtable('./MiniProjectEFSA.xlsx', opts);

%% Subset Selection - endpoint 1
data_endpoint_1=dati(dati.endpoint==1,:);
x_1 = data_endpoint_1.sex_0_M_1_F_;
x_2 = data_endpoint_1.dose;
x_3 = data_endpoint_1.numberOfAnimals;
y=data_endpoint_1.response;
n=length(y);

%K=1
phi_1=[ones(n,1) x_1];
phi_2=[ones(n,1) x_2];
phi_3=[ones(n,1) x_3];

[theta_1, std_theta_1] = lscov(phi_1, y);
[theta_2, std_theta_2] = lscov(phi_2, y);
[theta_3, std_theta_3] = lscov(phi_3, y);

y_hat_1 = phi_1 * theta_1;
y_hat_2 = phi_2 * theta_2;
y_hat_3 = phi_3 * theta_3;

epsilon_1 = y - y_hat_1; %residuo
epsilon_2 = y - y_hat_2; 
epsilon_3 = y - y_hat_3; 

SSR_1 = epsilon_1'*epsilon_1; %MIGLIORE
SSR_2 = epsilon_2'*epsilon_2;
SSR_3 = epsilon_3'*epsilon_3;

%K=2
phi_4=[ones(n,1) x_1 x_2]; 
phi_5=[ones(n,1) x_1 x_3];
phi_6=[ones(n,1) x_2 x_3];

[theta_4, std_theta_4] = lscov(phi_4, y);
[theta_5, std_theta_5] = lscov(phi_5, y);
[theta_6, std_theta_6] = lscov(phi_6, y);

y_hat_4 = phi_4 * theta_4;
y_hat_5 = phi_5 * theta_5;
y_hat_6 = phi_6 * theta_6;

epsilon_4 = y - y_hat_4;
epsilon_5 = y - y_hat_5; 
epsilon_6 = y - y_hat_6; 

SSR_4 = epsilon_4'*epsilon_4; % MIGLIORE
SSR_5 = epsilon_5'*epsilon_5;
SSR_6 = epsilon_6'*epsilon_6;

%K=3
phi_7=[ones(n,1) x_1 x_2 x_3];
[theta_7, std_theta_7] = lscov(phi_7, y);
y_hat_7 = phi_7 * theta_7;
epsilon_7 = y - y_hat_7;
SSR_7 = epsilon_7'*epsilon_7; 

%BEST MODEL
AIC_1 = 2*length(theta_1)/n + log(SSR_1);
AIC_2 = 2*length(theta_4)/n + log(SSR_4); %VINCENTE
AIC_3 = 2*length(theta_7)/n + log(SSR_7);

%Miglioramenti: vedere se possibile renderlo iterativo, il prof dice di
%usare una least square pesata (heteroscedasticity), vedere altri metodi
%per il modello migliore. Plottare risultati


