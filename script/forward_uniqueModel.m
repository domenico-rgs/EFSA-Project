%% Unique model
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
phi_12=[ones(n,1) x_1.*x_2.*x_4.*x_5];

[theta_1,std_theta_1, RSS_1] = identificator(phi_1,y, weights);
[theta_2,std_theta_2, RSS_2] = identificator(phi_2,y, weights);
[theta_3,std_theta_3, RSS_3] = identificator(phi_3,y, weights); 
[theta_4,std_theta_4, RSS_4] = identificator(phi_4,y, weights); 
[theta_5,std_theta_5, RSS_5] = identificator(phi_5,y, weights); 
[theta_6,std_theta_6, RSS_6] = identificator(phi_6,y, weights);
[theta_7,std_theta_7, RSS_7] = identificator(phi_7,y, weights); 
[theta_8,std_theta_8, RSS_8] = identificator(phi_8,y, weights); 
[theta_9,std_theta_9, RSS_9] = identificator(phi_9,y, weights);
[theta_10,std_theta_10, RSS_10] = identificator(phi_10,y, weights); 
[theta_11,std_theta_11, RSS_11] = identificator(phi_11,y, weights); 
[theta_12,std_theta_12, RSS_12] = identificator(phi_12,y, weights);

%% K=4
phi_13=[ones(n,1) x_1 x_4 x_1.*x_4 x_2];
phi_14=[ones(n,1) x_1 x_4 x_1.*x_4 x_5]; %best
phi_15=[ones(n,1) x_1 x_4 x_1.*x_4 x_1.*x_2];
phi_16=[ones(n,1) x_1 x_4 x_1.*x_4 x_1.*x_5];
phi_17=[ones(n,1) x_1 x_4 x_1.*x_4 x_2.*x_4];
phi_18=[ones(n,1) x_1 x_4 x_1.*x_4 x_2.*x_5];
phi_19=[ones(n,1) x_1 x_4 x_1.*x_4 x_1.*x_2.*x_4];
phi_20=[ones(n,1) x_1 x_4 x_1.*x_4 x_1.*x_2.*x_5];
phi_21=[ones(n,1) x_1 x_4 x_1.*x_4 x_1.*x_2.*x_4.*x_5];

[theta_13,std_theta_13, RSS_13] = identificator(phi_13,y, weights); 
[theta_14,std_theta_14, RSS_14] = identificator(phi_14,y, weights);
[theta_15,std_theta_15, RSS_15] = identificator(phi_15,y, weights); 
[theta_16,std_theta_16, RSS_16] = identificator(phi_16,y, weights); 
[theta_17,std_theta_17, RSS_17] = identificator(phi_17,y, weights); 
[theta_18,std_theta_18, RSS_18] = identificator(phi_18,y, weights); 
[theta_19,std_theta_19, RSS_19] = identificator(phi_19,y, weights); 
[theta_20,std_theta_20, RSS_20] = identificator(phi_20,y, weights); 
[theta_21,std_theta_21, RSS_21] = identificator(phi_21,y, weights); 

%% K=5
phi_22=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2];
phi_23=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_1.*x_2];
phi_24=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_1.*x_5];
phi_25=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4]; %best
phi_26=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_5];
phi_27=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_1.*x_2.*x_4];
phi_28=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_1.*x_2.*x_5];
phi_29=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_1.*x_2.*x_4.*x_5];

[theta_22,std_theta_22, RSS_22] = identificator(phi_22,y, weights);
[theta_23,std_theta_23, RSS_23] = identificator(phi_23,y, weights);
[theta_24,std_theta_24, RSS_24] = identificator(phi_24,y, weights);
[theta_25,std_theta_25, RSS_25] = identificator(phi_25,y, weights);
[theta_26,std_theta_26, RSS_26] = identificator(phi_26,y, weights);
[theta_27,std_theta_27, RSS_27] = identificator(phi_27,y, weights);
[theta_28,std_theta_28, RSS_28] = identificator(phi_28,y, weights);
[theta_29,std_theta_29, RSS_29] = identificator(phi_29,y, weights);

%% K=6
phi_30=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_2];
phi_31=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2];
phi_32=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_5];
phi_33=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_2.*x_4];
phi_34=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_2.*x_5];
phi_35=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4]; %best
phi_36=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_5];
phi_37=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4.*x_5];

[theta_30,std_theta_30, RSS_30] = identificator(phi_30,y, weights);
[theta_31,std_theta_31, RSS_31] = identificator(phi_31,y, weights);
[theta_32,std_theta_32, RSS_32] = identificator(phi_32,y, weights);
[theta_33,std_theta_33, RSS_33] = identificator(phi_33,y, weights);
[theta_34,std_theta_34, RSS_34] = identificator(phi_34,y, weights);
[theta_35,std_theta_35, RSS_35] = identificator(phi_35,y, weights);
[theta_36,std_theta_36, RSS_36] = identificator(phi_36,y, weights);
[theta_37,std_theta_37, RSS_37] = identificator(phi_37,y, weights);

%% K=7
phi_38=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2]; %best
phi_39=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_1.*x_2];
phi_40=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_1.*x_5];
phi_41=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2.*x_5];
phi_42=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_1.*x_2.*x_5];
phi_43=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_1.*x_2.*x_4.*x_5];

[theta_38,std_theta_38, RSS_38] = identificator(phi_38,y, weights);
[theta_39,std_theta_39, RSS_39] = identificator(phi_39,y, weights);
[theta_40,std_theta_40, RSS_40] = identificator(phi_40,y, weights);
[theta_41,std_theta_41, RSS_41] = identificator(phi_41,y, weights);
[theta_42,std_theta_42, RSS_42] = identificator(phi_42,y, weights);
[theta_43,std_theta_43, RSS_43] = identificator(phi_43,y, weights);

%% K=8
phi_44=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_2];
phi_45=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5]; %best
phi_46=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_2.*x_5];
phi_47=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_2.*x_5];
phi_48=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_2.*x_4.*x_5];

[theta_44,std_theta_44, RSS_44] = identificator(phi_44,y, weights);
[theta_45,std_theta_45, RSS_45] = identificator(phi_45,y, weights);
[theta_46,std_theta_46, RSS_46] = identificator(phi_46,y, weights);
[theta_47,std_theta_47, RSS_47] = identificator(phi_47,y, weights);
[theta_48,std_theta_48, RSS_48] = identificator(phi_48,y, weights);

%% K=9
phi_49=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_1.*x_2];
phi_50=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5]; %best
phi_51=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_1.*x_2.*x_5];
phi_52=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_1.*x_2.*x_4.*x_5];

[theta_49,std_theta_49, RSS_49] = identificator(phi_49,y, weights);
[theta_50,std_theta_50, RSS_50] = identificator(phi_50,y, weights);
[theta_51,std_theta_51, RSS_51] = identificator(phi_51,y, weights);
[theta_52,std_theta_52, RSS_52] = identificator(phi_52,y, weights);

%% K=10
phi_53=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2];
phi_54=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5]; %best
phi_55=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_4.*x_5];

[theta_53,std_theta_53, RSS_53] = identificator(phi_53,y, weights);
[theta_54,std_theta_54, RSS_54] = identificator(phi_54,y, weights);
[theta_55,std_theta_55, RSS_55] = identificator(phi_55,y, weights);

%% K=11
phi_56=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2]; %best
phi_57=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2.*x_4.*x_5];

[theta_56,std_theta_56, RSS_56] = identificator(phi_56,y, weights);
[theta_57,std_theta_57, RSS_57] = identificator(phi_57,y, weights);

%% K=12
phi_58=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5]; %best

[theta_58,std_theta_58, RSS_58] = identificator(phi_58,y, weights);

%% BEST MODEL
[FPE_6,AIC_6,MDL_6,SQUARED_R_6,Cp_6,BIC_6] = objectiveTest(n, length(theta_6), RSS_6, TSS); 
[FPE_14,AIC_14,MDL_14,SQUARED_R_14,Cp_14,BIC_14] = objectiveTest(n, length(theta_14), RSS_14, TSS);
[FPE_25,AIC_25,MDL_25,SQUARED_R_25,Cp_25,BIC_25] = objectiveTest(n, length(theta_25), RSS_25, TSS);
[FPE_35,AIC_35,MDL_35,SQUARED_R_35,Cp_35,BIC_35] = objectiveTest(n, length(theta_35), RSS_35, TSS);
[FPE_38,AIC_38,MDL_38,SQUARED_R_38,Cp_38,BIC_38] = objectiveTest(n, length(theta_38), RSS_38, TSS);
[FPE_45,AIC_45,MDL_45,SQUARED_R_45,Cp_45,BIC_45] = objectiveTest(n, length(theta_45), RSS_45, TSS); 
[FPE_50,AIC_50,MDL_50,SQUARED_R_50,Cp_50,BIC_50] = objectiveTest(n, length(theta_50), RSS_50, TSS);
[FPE_54,AIC_54,MDL_54,SQUARED_R_54,Cp_54,BIC_54] = objectiveTest(n, length(theta_54), RSS_54, TSS);
[FPE_56,AIC_56,MDL_56,SQUARED_R_56,Cp_56,BIC_56] = objectiveTest(n, length(theta_56), RSS_56, TSS);
[FPE_58,AIC_58,MDL_58,SQUARED_R_58,Cp_58,BIC_58] = objectiveTest(n, length(theta_58), RSS_58, TSS); 

%% Results plot
%RSS
figure
plot([RSS_6 RSS_14 RSS_25 RSS_35 RSS_38 RSS_45 RSS_50 RSS_54 RSS_56 RSS_58])



%Objective test
x=[6 14 25 35 38 45 50 54 56 58];
figure
sgtitle("Objective tests evolution")
subplot(2,3,1)
plot(x,[FPE_6 FPE_14 FPE_25 FPE_35 FPE_38 FPE_45 FPE_50 FPE_54 FPE_56 FPE_58],'-o')
grid on
title("FPE")
subplot(2,3,2)
plot(x,[AIC_6 AIC_14 AIC_25 AIC_35 AIC_38 AIC_45 AIC_50 AIC_54 AIC_56 AIC_58],'-o')
grid on
title("AIC")
subplot(2,3,3)
plot(x,[MDL_6 MDL_14 MDL_25 MDL_35 MDL_38 MDL_45 MDL_50 MDL_54 MDL_56 MDL_58],'-o')
grid on
title("MDL")
subplot(2,3,4)
plot(x,[SQUARED_R_6 SQUARED_R_14 SQUARED_R_25 SQUARED_R_35 SQUARED_R_38 SQUARED_R_45 SQUARED_R_50 SQUARED_R_54 SQUARED_R_56 SQUARED_R_58],'-o')
grid on
title("R^2")
subplot(2,3,5)
plot(x,[Cp_6 Cp_14 Cp_25 Cp_35 Cp_38 Cp_45 Cp_50 Cp_54 Cp_56 Cp_58],'-o')
grid on
title("C_p")
subplot(2,3,6)
plot(x,[BIC_6 BIC_14 BIC_25 BIC_35 BIC_38 BIC_45 BIC_50 BIC_54 BIC_56 BIC_58],'-o')
grid on
title("BIC")

%Male Model - endpoint1
dose=[0, 30, 100, 150];
male_data_end1=data(data.sex==0&data.endpoint==1,:);

y_hat_38_male_end1 = theta_38(1)+theta_38(2)*0+theta_38(3)*1+theta_38(4)*0*1+theta_38(5)*0+theta_38(6)*dose*1+theta_38(7)*0*dose*1+theta_38(8)*dose;
y_male_end1=male_data_end1.response;

figure
plot(dose,y_hat_38_male_end1,"b","linewidth",2)
hold on
plot(dose,y_male_end1,"*k")
grid on
title("Male - endpoint 1 - uniquemodel")
xlabel("dose")
ylabel("response")

%Female Model - endpoint1
female_data_end1=data(data.sex==1&data.endpoint==1,:);

y_hat_38_female_end1 = theta_38(1)+theta_38(2)*1+theta_38(3)*1+theta_38(4)*1*1+theta_38(5)*0+theta_38(6)*dose*1+theta_38(7)*1*dose*1+theta_38(8)*dose;
y_female_end1=female_data_end1.response;

figure
plot(dose,y_hat_38_female_end1,"b","linewidth",2)
hold on
plot(dose,y_female_end1,"*k")
grid on
title("Female - endpoint 1 - uniquemodel")
xlabel("dose")
ylabel("response")

%Male Model - endpoint2
male_data_end2=data(data.sex==0&data.endpoint==2,:);

y_hat_38_male_end2 = theta_38(1)+theta_38(2)*0+theta_38(3)*0+theta_38(4)*0*0+theta_38(5)*1+theta_38(6)*dose*0+theta_38(7)*0*dose*0+theta_38(8)*dose;
y_male_end2=male_data_end2.response;

figure
plot(dose,y_hat_38_male_end2,"b","linewidth",2)
hold on
plot(dose,y_male_end2,"*k")
grid on
title("Male - endpoint 2 - uniquemodel")
xlabel("dose")
ylabel("response")

%Female Model - endpoint2
female_data_end2=data(data.sex==1&data.endpoint==2,:);

y_hat_38_female_end2 = theta_38(1)+theta_38(2)*1+theta_38(3)*0+theta_38(4)*1*0+theta_38(5)*1+theta_38(6)*dose*0+theta_38(7)*1*dose*0+theta_38(8)*dose;
y_female_end2=female_data_end2.response;

figure
plot(dose,y_hat_38_female_end2,"b","linewidth",2)
hold on
plot(dose,y_female_end2,"*k")
grid on
title("Female - endpoint 2 - uniquemodel")
xlabel("dose")
ylabel("response")

%Male Model - endpoint3
male_data_end3=data(data.sex==0&data.endpoint==3,:);

y_hat_38_male_end3 = theta_38(1)+theta_38(2)*0+theta_38(3)*0+theta_38(4)*0*0+theta_38(5)*0+theta_38(6)*dose*0+theta_38(7)*0*dose*0+theta_38(8)*dose;
y_male_end3=male_data_end3.response;

figure
plot(dose,y_hat_38_male_end3,"b","linewidth",2)
hold on
plot(dose,y_male_end3,"*k")
grid on
title("Male - endpoint 3 - uniquemodel")
xlabel("dose")
ylabel("response")

%Female Model - endpoint3
female_data_end3=data(data.sex==1&data.endpoint==3,:);

y_hat_38_female_end3 = theta_38(1)+theta_38(2)*1+theta_38(3)*0+theta_38(4)*1*0+theta_38(5)*0+theta_38(6)*dose*0+theta_38(7)*1*dose*0+theta_38(8)*dose;
y_female_end3=female_data_end3.response;

figure
plot(dose,y_hat_38_female_end3,"b","linewidth",2)
hold on
plot(dose,y_female_end3,"*k")
grid on
title("Female - endpoint 3 - uniquemodel")
xlabel("dose")
ylabel("response")