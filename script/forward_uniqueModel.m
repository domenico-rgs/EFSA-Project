%% Unique model (forward)
close all
clear all
clc

%% Data import
opts=detectImportOptions('../data/MiniProjectEFSA.xlsx');
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
data=readtable('../data/MiniProjectEFSA.xlsx', opts);
data.Properties.VariableNames={'response','numberOfAnimals','SD','dose','sex','endpoint'};

x_1 = data.sex;
x_2 = data.dose;

DUMMY = dummyvar(data.endpoint);
x_4 = DUMMY(:,1); %dummy variable for endpoint 1
x_5 = DUMMY(:,2); %dummy variable for endpoint 2

y=data.response;

n=length(y);
TSS=sum(((y-mean(y))'*((y-mean(y)))));

weights= 1./((data.SD./sqrt(data.numberOfAnimals)).^2);

%% K=1
phi_1=[ones(n,1) x_1];
phi_2=[ones(n,1) x_2];
phi_3=[ones(n,1) x_1.*x_2];
phi_4=[ones(n,1) x_4];
phi_5=[ones(n,1) x_5];
phi_6=[ones(n,1) x_1.*x_4]; %best
phi_7=[ones(n,1) x_1.*x_5];
phi_8=[ones(n,1) x_2.*x_4];
phi_9=[ones(n,1) x_2.*x_5];
phi_10=[ones(n,1) x_1.*x_2.*x_4];
phi_11=[ones(n,1) x_1.*x_2.*x_5];

[theta_1,std_theta_1, RSS_1] = identificator(phi_1,y, weights);
[theta_2,std_theta_2, RSS_2] = identificator(phi_2,y, weights);
[theta_3,std_theta_3, RSS_3] = identificator(phi_3,y, weights); 
[theta_4,std_theta_4, RSS_4] = identificator(phi_4,y, weights); 
[theta_5,std_theta_5, RSS_5] = identificator(phi_5,y, weights); 
[theta_6,std_theta_6, RSS_6] = identificator(phi_6,y, weights);
[theta_7,std_theta_7, RSS_7] = identificator(phi_7,y, weights); 
[theta_8,std_theta_8, RSS_8] = identificator(phi_8,y, weights); %best
[theta_9,std_theta_9, RSS_9] = identificator(phi_9,y, weights);
[theta_10,std_theta_10, RSS_10] = identificator(phi_10,y, weights); 
[theta_11,std_theta_11, RSS_11] = identificator(phi_11,y, weights); 

%% K=2
phi_12=[ones(n,1) x_2 x_4 x_2.*x_4 x_1];
phi_13=[ones(n,1) x_2 x_4 x_2.*x_4 x_1.*x_2];
phi_14=[ones(n,1) x_2 x_4 x_2.*x_4 x_5];
phi_15=[ones(n,1) x_2 x_4 x_2.*x_4 x_1.*x_4];
phi_16=[ones(n,1) x_2 x_4 x_2.*x_4 x_1.*x_5];
phi_17=[ones(n,1) x_2 x_4 x_2.*x_4 x_2.*x_5];
phi_18=[ones(n,1) x_2 x_4 x_2.*x_4 x_1.*x_2.*x_4];
phi_19=[ones(n,1) x_2 x_4 x_2.*x_4 x_1.*x_2.*x_5];

[theta_12,std_theta_12, RSS_12] = identificator(phi_12,y, weights); 
[theta_13,std_theta_13, RSS_13] = identificator(phi_13,y, weights); 
[theta_14,std_theta_14, RSS_14] = identificator(phi_14,y, weights);
[theta_15,std_theta_15, RSS_15] = identificator(phi_15,y, weights); %best
[theta_16,std_theta_16, RSS_16] = identificator(phi_16,y, weights); 
[theta_17,std_theta_17, RSS_17] = identificator(phi_17,y, weights); 
[theta_18,std_theta_18, RSS_18] = identificator(phi_18,y, weights); 
[theta_19,std_theta_19, RSS_19] = identificator(phi_19,y, weights); 

%% K=3
phi_20=[ones(n,1) x_1 x_2 x_4 x_2.*x_4 x_1.*x_4 x_1.*x_2];
phi_21=[ones(n,1) x_1 x_2 x_4 x_2.*x_4 x_1.*x_4 x_5];
phi_22=[ones(n,1) x_1 x_2 x_4 x_2.*x_4 x_1.*x_4 x_1.*x_5];
phi_23=[ones(n,1) x_1 x_2 x_4 x_2.*x_4 x_1.*x_4 x_2.*x_5];
phi_24=[ones(n,1) x_1 x_2 x_4 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4];
phi_25=[ones(n,1) x_1 x_2 x_4 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_5];

[theta_20,std_theta_20, RSS_20] = identificator(phi_20,y, weights);
[theta_21,std_theta_21, RSS_21] = identificator(phi_21,y, weights); %best
[theta_22,std_theta_22, RSS_22] = identificator(phi_22,y, weights);
[theta_23,std_theta_23, RSS_23] = identificator(phi_23,y, weights);
[theta_24,std_theta_24, RSS_24] = identificator(phi_24,y, weights);
[theta_25,std_theta_25, RSS_25] = identificator(phi_25,y, weights);

%% K=4
phi_26=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2];
phi_27=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_5];
phi_28=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_2.*x_5];
phi_29=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4];
phi_30=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_5];

[theta_26,std_theta_26, RSS_26] = identificator(phi_26,y, weights); 
[theta_27,std_theta_27, RSS_27] = identificator(phi_27,y, weights);
[theta_28,std_theta_28, RSS_28] = identificator(phi_28,y, weights);
[theta_29,std_theta_29, RSS_29] = identificator(phi_29,y, weights); %best
[theta_30,std_theta_30, RSS_30] = identificator(phi_30,y, weights);

%% K=5
phi_31=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4 x_1.*x_2.*x_5];
phi_32=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4 x_2.*x_5];
phi_33=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4 x_1.*x_5];
phi_34=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4 x_1.*x_2];

[theta_31,std_theta_31, RSS_31] = identificator(phi_31,y, weights);
[theta_32,std_theta_32, RSS_32] = identificator(phi_32,y, weights);
[theta_33,std_theta_33, RSS_33] = identificator(phi_33,y, weights); %best
[theta_34,std_theta_34, RSS_34] = identificator(phi_34,y, weights);

%% K=6
phi_35=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4 x_1.*x_5 x_1.*x_2];
phi_36=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4 x_1.*x_5 x_2.*x_5];
phi_37=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4 x_1.*x_5 x_1.*x_2.*x_5];

[theta_35,std_theta_35, RSS_35] = identificator(phi_35,y, weights);
[theta_36,std_theta_36, RSS_36] = identificator(phi_36,y, weights); %best
[theta_37,std_theta_37, RSS_37] = identificator(phi_37,y, weights);

%% K=7
phi_38=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4 x_1.*x_5 x_2.*x_5 x_1.*x_2];
phi_39=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5]; 

[theta_38,std_theta_38, RSS_38] = identificator(phi_38,y, weights);
[theta_39,std_theta_39, RSS_39] = identificator(phi_39,y, weights); %best

%% K=8
phi_40=[ones(n,1) x_1 x_2 x_4 x_5 x_2.*x_4 x_1.*x_4 x_1.*x_2.*x_4 x_1.*x_5 x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_5];

[theta_40,std_theta_40, RSS_40] = identificator(phi_40,y, weights);


%% BEST MODEL
[FPE_8,AIC_8,MDL_8,SQUARED_R_8,Cp_8,BIC_8] = objectiveTest(n, length(theta_8), RSS_8, TSS); 
[FPE_15,AIC_15,MDL_15,SQUARED_R_15,Cp_15,BIC_15] = objectiveTest(n, length(theta_15), RSS_15, TSS);
[FPE_21,AIC_21,MDL_21,SQUARED_R_21,Cp_21,BIC_21] = objectiveTest(n, length(theta_21), RSS_21, TSS);
[FPE_29,AIC_29,MDL_29,SQUARED_R_29,Cp_29,BIC_29] = objectiveTest(n, length(theta_29), RSS_29, TSS); %winner
[FPE_33,AIC_33,MDL_33,SQUARED_R_33,Cp_33,BIC_33] = objectiveTest(n, length(theta_33), RSS_33, TSS);
[FPE_36,AIC_36,MDL_36,SQUARED_R_36,Cp_36,BIC_36] = objectiveTest(n, length(theta_36), RSS_36, TSS); 
[FPE_39,AIC_39,MDL_39,SQUARED_R_39,Cp_39,BIC_39] = objectiveTest(n, length(theta_39), RSS_39, TSS);
[FPE_40,AIC_40,MDL_40,SQUARED_R_40,Cp_40,BIC_40] = objectiveTest(n, length(theta_40), RSS_40, TSS);

%% Results plot
%RSS
figure
plot([RSS_8 RSS_15 RSS_21 RSS_29 RSS_33 RSS_36 RSS_39 RSS_40])


%Objective test
x=[8 15 21 29 33 36 39 40];
figure
sgtitle("Objective tests evolution")
subplot(2,3,1)
plot(x,[FPE_8 FPE_15 FPE_21 FPE_29 FPE_33 FPE_36 FPE_39 FPE_40],'-o')
grid on
title("FPE")
subplot(2,3,2)
plot(x,[AIC_8 AIC_15 AIC_21 AIC_29 AIC_33 AIC_36 AIC_39 AIC_40],'-o')
grid on
title("AIC")
subplot(2,3,3)
plot(x,[MDL_8 MDL_15 MDL_21 MDL_29 MDL_33 MDL_36 MDL_39 MDL_40],'-o')
grid on
title("MDL")
subplot(2,3,4)
plot(x,[SQUARED_R_8 SQUARED_R_15 SQUARED_R_21 SQUARED_R_29 SQUARED_R_33 SQUARED_R_36 SQUARED_R_39 SQUARED_R_40],'-o')
grid on
title("R^2")
subplot(2,3,5)
plot(x,[Cp_8 Cp_15 Cp_21 Cp_29 Cp_33 Cp_36 Cp_39 Cp_40],'-o')
grid on
title("C_p")
subplot(2,3,6)
plot(x,[BIC_8 BIC_15 BIC_21 BIC_29 BIC_33 BIC_36 BIC_39 BIC_40],'-o')
grid on
title("BIC")

%Endpoint1
dose=[0, 30, 100, 150];
male_data_end1=data(data.sex==0&data.endpoint==1,:);

y_hat_29_male_end1 = theta_29(1)+theta_29(2)*0+theta_29(3)*dose+theta_29(4)*1+theta_29(5)*0+theta_29(6)*dose*1+theta_29(7)*0*1+theta_29(8)*dose*0*1;
y_male_end1=male_data_end1.response;

female_data_end1=data(data.sex==1&data.endpoint==1,:);

y_hat_29_female_end1 = theta_29(1)+theta_29(2)*1+theta_29(3)*dose+theta_29(4)*1+theta_29(5)*0+theta_29(6)*dose*1+theta_29(7)*1*1+theta_29(8)*dose*1*1;
y_female_end1=female_data_end1.response;

figure
plot(dose,y_hat_29_male_end1,"b","linewidth",2)
hold on
plot(dose,y_male_end1,"*r")
hold on
plot(dose,y_hat_29_female_end1,"m","linewidth",2)
hold on
plot(dose,y_female_end1,"*k")
grid on
title("Endpoint 1 - uniquemodel")
xlabel("dose")
ylabel("response")
legend("male","data male","female","data female")

%Endpoint2
male_data_end2=data(data.sex==0&data.endpoint==2,:);

y_hat_29_male_end2 = theta_29(1)+theta_29(2)*0+theta_29(3)*dose+theta_29(4)*0+theta_29(5)*1+theta_29(6)*dose*0+theta_29(7)*0*0+theta_29(8)*dose*0*0;
y_male_end2=male_data_end2.response;

female_data_end2=data(data.sex==1&data.endpoint==2,:);

y_hat_29_female_end2 = theta_29(1)+theta_29(2)*1+theta_29(3)*dose+theta_29(4)*0+theta_29(5)*1+theta_29(6)*dose*0+theta_29(7)*1*0+theta_29(8)*dose*1*0;
y_female_end2=female_data_end2.response;

figure
plot(dose,y_hat_29_male_end2,"b","linewidth",2)
hold on
plot(dose,y_male_end2,"*r")
hold on
plot(dose,y_hat_29_female_end2,"m","linewidth",2)
hold on
plot(dose,y_female_end2,"*k")
grid on
title("Endpoint 2 - uniquemodel")
xlabel("dose")
ylabel("response")
legend("male","data male","female","data female")

%Endpoint3
male_data_end3=data(data.sex==0&data.endpoint==3,:);

y_hat_29_male_end3 = theta_29(1)+theta_29(2)*0+theta_29(3)*dose+theta_29(4)*0+theta_29(5)*0+theta_29(6)*dose*0+theta_29(7)*0*0+theta_29(8)*dose*0*0;
y_male_end3=male_data_end3.response;

female_data_end3=data(data.sex==1&data.endpoint==3,:);

y_hat_29_female_end3 = theta_29(1)+theta_29(2)*1+theta_29(3)*dose+theta_29(4)*0+theta_29(5)*0+theta_29(6)*dose*0+theta_29(7)*1*0+theta_29(8)*dose*1*0;
y_female_end3=female_data_end3.response;

figure
plot(dose,y_hat_29_male_end3,"b","linewidth",2)
hold on
plot(dose,y_male_end3,"*r")
hold on
plot(dose,y_hat_29_female_end3,"m","linewidth",2)
hold on
plot(dose,y_female_end3,"*k")
grid on
title("Endpoint 3 - uniquemodel")
xlabel("dose")
ylabel("response")
legend("male","data male","female","data female")
