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

[theta_1,std_theta_1, RSS_1] = identificator(phi_1,y, weights); %better
[theta_2,std_theta_2, RSS_2] = identificator(phi_2,y, weights);
[theta_3,std_theta_3, RSS_3] = identificator(phi_3,y, weights);

%% K=2
phi_4=[ones(n,1) x_1 x_2]; 
phi_5=[ones(n,1) x_1 x_3];

[theta_4,std_theta_4, RSS_4] = identificator(phi_4,y, weights); %better
[theta_5,std_theta_5, RSS_5] = identificator(phi_5,y, weights);

%% K=3
phi_7=[ones(n,1) x_1 x_2 x_3];
[theta_7,std_theta_7, RSS_7] = identificator(phi_7,y, weights);


%% BEST MODEL
[FPE_1,AIC_1,MDL_1,SQUARED_R_1,Cp_1,BIC_1] = objectiveTest(n, length(theta_1), RSS_1, TSS);
[FPE_4,AIC_4,MDL_4,SQUARED_R_4,Cp_4,BIC_4] = objectiveTest(n, length(theta_4), RSS_4, TSS); %winner
[FPE_7,AIC_7,MDL_7,SQUARED_R_7,Cp_7,BIC_7] = objectiveTest(n, length(theta_7), RSS_7, TSS);

%% Result plot
figure
sgtitle("RSS at each subset selection iteration")
subplot(1,3,1)
bar([RSS_1 RSS_2 RSS_3])
ylabel("RSS")
subplot(1,3,2)
bar([RSS_4 RSS_5])
set(gca,'XTickLabel',[4 5]);
xlabel("models")
subplot(1,3,3)
bar([RSS_7])
set(gca,'XTickLabel',[7]);