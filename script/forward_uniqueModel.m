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
x_3= data.numberOfAnimals;

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
phi_3=[ones(n,1) x_3];
phi_4=[ones(n,1) x_4];
phi_5=[ones(n,1) x_5];

[theta_1,std_theta_1, RSS_1] = identificator(phi_1,y, weights);
[theta_2,std_theta_2, RSS_2] = identificator(phi_2,y, weights);
[theta_3,std_theta_3, RSS_3] = identificator(phi_3,y, weights); 
[theta_4,std_theta_4, RSS_4] = identificator(phi_4,y, weights); %better
[theta_5,std_theta_5, RSS_5] = identificator(phi_5,y, weights); 


%% K=2
phi_6=[ones(n,1) x_3 x_1]; 
phi_7=[ones(n,1) x_3 x_2];
phi_8=[ones(n,1) x_3 x_4];
phi_9=[ones(n,1) x_3 x_5];

[theta_6,std_theta_6, RSS_6] = identificator(phi_6,y, weights);
[theta_7,std_theta_7, RSS_7] = identificator(phi_7,y, weights); 
[theta_8,std_theta_8, RSS_8] = identificator(phi_8,y, weights); %better
[theta_9,std_theta_9, RSS_9] = identificator(phi_9,y, weights);

%% K=3
phi_10=[ones(n,1) x_3 x_2 x_1];
phi_11=[ones(n,1) x_3 x_2 x_4];
phi_12=[ones(n,1) x_3 x_2 x_5];

[theta_10,std_theta_10, RSS_10] = identificator(phi_10,y, weights); 
[theta_11,std_theta_11, RSS_11] = identificator(phi_11,y, weights); %better
[theta_12,std_theta_12, RSS_12] = identificator(phi_12,y, weights);

%% K=4
phi_13=[ones(n,1) x_3 x_2 x_1 x_4];
phi_14=[ones(n,1) x_3 x_2 x_1 x_5];

[theta_13,std_theta_13, RSS_13] = identificator(phi_13,y, weights); %better
[theta_14,std_theta_14, RSS_14] = identificator(phi_14,y, weights); 

%% K=5
phi_15=[ones(n,1) x_3 x_2 x_1 x_5 x_4];

[theta_15,std_theta_15, RSS_15] = identificator(phi_15,y, weights);

%% BEST MODEL
[FPE_4,AIC_4,MDL_4,SQUARED_R_4,Cp_4,BIC_4] = objectiveTest(n, length(theta_4), RSS_4, TSS); %Winner
[FPE_8,AIC_8,MDL_8,SQUARED_R_8,Cp_8,BIC_8] = objectiveTest(n, length(theta_8), RSS_8, TSS);
[FPE_11,AIC_11,MDL_11,SQUARED_R_11,Cp_11,BIC_11] = objectiveTest(n, length(theta_11), RSS_11, TSS);
[FPE_13,AIC_13,MDL_13,SQUARED_R_13,Cp_13,BIC_13] = objectiveTest(n, length(theta_13), RSS_13, TSS);
[FPE_15,AIC_15,MDL_15,SQUARED_R_15,Cp_15,BIC_15] = objectiveTest(n, length(theta_15), RSS_15, TSS); 

%% Results plot
%RSS
figure
sgtitle("RSS at each subset selection iteration")
subplot(2,3,1)
bar([RSS_1 RSS_2 RSS_3 RSS_4 RSS_5])
grid on
ylabel("RSS")
subplot(2,3,2)
bar([RSS_6 RSS_7 RSS_8 RSS_9])
grid on
set(gca,'XTickLabel',[6 7 8 9]);
subplot(2,3,3)
bar([RSS_10 RSS_11 RSS_12])
grid on
set(gca,'XTickLabel',[10 11 12]);
subplot(2,3,4)
bar([RSS_13 RSS_14])
grid on
set(gca,'XTickLabel',[13 14]);
subplot(2,3,5)
bar(RSS_15)
grid on
set(gca,'XTickLabel',15);

%Objective test
x=[4 8 11 13 15];
figure
sgtitle("Objective tests evolution")
subplot(2,3,1)
plot(x,[FPE_4 FPE_8 FPE_11 FPE_13 FPE_15],'-o')
grid on
title("FPE")
subplot(2,3,2)
plot(x,[AIC_4 AIC_8 AIC_11 AIC_13 AIC_15],'-o')
grid on
title("AIC")
subplot(2,3,3)
plot(x,[MDL_4 MDL_8 MDL_11 MDL_13 MDL_15],'-o')
grid on
title("MDL")
subplot(2,3,4)
plot(x,[SQUARED_R_4 SQUARED_R_8 SQUARED_R_11 SQUARED_R_13 SQUARED_R_15],'-o')
grid on
title("R^2")
subplot(2,3,5)
plot(x,[Cp_4 Cp_8 Cp_11 Cp_13 Cp_15],'-o')
grid on
title("C_p")
subplot(2,3,6)
plot(x,[BIC_4 BIC_8 BIC_11 BIC_13 BIC_15],'-o')
grid on
title("BIC")

%Male Model - endpoint1
dose=[0, 30, 100, 150];
male_data_end1=data(data.sex==0&data.endpoint==1,:);

y_hat_1_male = theta_1(1)+theta_1(2)*0+ones(1,4);
y_hat_2_male = theta_2(1)+theta_2(2)*dose;
y_hat_3_male = theta_3(1)+(theta_3(2)*male_data_end1.numberOfAnimals);
y_hat_4_male = theta_4(1)+theta_4(2)*1+ones(1,4);
y_hat_5_male = theta_5(1)+theta_5(2)*0+ones(1,4);
y_hat_6_male = theta_6(1)+(theta_6(2)*male_data_end1.numberOfAnimals)+theta_6(3)*0;
y_hat_7_male = theta_7(1)+(theta_7(2)*male_data_end1.numberOfAnimals)'+theta_7(3)*dose;
y_hat_8_male = theta_8(1)+(theta_8(2)*male_data_end1.numberOfAnimals)+theta_8(3)*1;
y_hat_9_male = theta_9(1)+(theta_9(2)*male_data_end1.numberOfAnimals)+theta_9(3)*0;
y_hat_10_male = theta_10(1)+(theta_10(2)*male_data_end1.numberOfAnimals)'+theta_10(3)*dose+theta_10(4)*0;
y_hat_11_male = theta_11(1)+(theta_11(2)*male_data_end1.numberOfAnimals)'+theta_11(3)*dose+theta_11(4)*1;
y_hat_12_male = theta_12(1)+(theta_12(2)*male_data_end1.numberOfAnimals)'+theta_12(3)*dose+theta_12(4)*0;
y_hat_13_male = theta_13(1)+(theta_13(2)*male_data_end1.numberOfAnimals)'+theta_13(3)*dose+theta_13(4)*0+theta_13(5)*1;
y_hat_14_male = theta_14(1)+(theta_14(2)*male_data_end1.numberOfAnimals)'+theta_14(3)*dose+theta_14(4)*0+theta_14(5)*0;
y_hat_15_male = theta_15(1)+(theta_15(2)*male_data_end1.numberOfAnimals)'+theta_15(3)*dose+theta_15(4)*0+theta_15(5)*0+theta_15(6)*1;

y_male_end1=male_data_end1.response;

figure
plot(dose,y_hat_1_male,"--b")
hold on
plot(dose,y_hat_2_male,"--b")
hold on
plot(dose,y_hat_3_male,"--b")
hold on
plot(dose,y_hat_4_male,"--b","linewidth",2)
hold on
plot(dose,y_hat_5_male,"--b")
hold on
plot(dose,y_hat_6_male,"--c")
hold on
plot(dose,y_hat_7_male,"--c")
hold on
plot(dose,y_hat_8_male,"--c")
hold on
plot(dose,y_hat_9_male,"--c")
hold on
plot(dose,y_hat_10_male,"--y")
hold on
plot(dose,y_hat_11_male,"--y")
hold on
plot(dose,y_hat_12_male,"--y")
hold on
plot(dose,y_hat_13_male,"--g")
hold on
plot(dose,y_hat_14_male,"--g")
hold on
plot(dose,y_hat_15_male,"--m")
hold on
plot(dose,y_male_end1,"*k")
grid on
title("Male - endpoint 1 - uniquemodel")
xlabel("dose")
ylabel("response")

%Male Model - endpoint2
dose=[0, 30, 100, 150];
male_data_end2=data(data.sex==0&data.endpoint==2,:);

y_hat_1_male = theta_1(1)+theta_1(2)*0+ones(1,4);
y_hat_2_male = theta_2(1)+theta_2(2)*dose;
y_hat_3_male = theta_3(1)+(theta_3(2)*male_data_end2.numberOfAnimals);
y_hat_4_male = theta_4(1)+theta_4(2)*0+ones(1,4);
y_hat_5_male = theta_5(1)+theta_5(2)*1+ones(1,4);
y_hat_6_male = theta_6(1)+(theta_6(2)*male_data_end2.numberOfAnimals)+theta_6(3)*0;
y_hat_7_male = theta_7(1)+(theta_7(2)*male_data_end2.numberOfAnimals)'+theta_7(3)*dose;
y_hat_8_male = theta_8(1)+(theta_8(2)*male_data_end2.numberOfAnimals)+theta_8(3)*0;
y_hat_9_male = theta_9(1)+(theta_9(2)*male_data_end2.numberOfAnimals)+theta_9(3)*1;
y_hat_10_male = theta_10(1)+(theta_10(2)*male_data_end2.numberOfAnimals)'+theta_10(3)*dose+theta_10(4)*0;
y_hat_11_male = theta_11(1)+(theta_11(2)*male_data_end2.numberOfAnimals)'+theta_11(3)*dose+theta_11(4)*0;
y_hat_12_male = theta_12(1)+(theta_12(2)*male_data_end2.numberOfAnimals)'+theta_12(3)*dose+theta_12(4)*1;
y_hat_13_male = theta_13(1)+(theta_13(2)*male_data_end2.numberOfAnimals)'+theta_13(3)*dose+theta_13(4)*0+theta_13(5)*0;
y_hat_14_male = theta_14(1)+(theta_14(2)*male_data_end2.numberOfAnimals)'+theta_14(3)*dose+theta_14(4)*0+theta_14(5)*1;
y_hat_15_male = theta_15(1)+(theta_15(2)*male_data_end2.numberOfAnimals)'+theta_15(3)*dose+theta_15(4)*0+theta_15(5)*1+theta_15(6)*0;

y_male_end2=male_data_end2.response;

figure
plot(dose,y_hat_1_male,"--b")
hold on
plot(dose,y_hat_2_male,"--b")
hold on
plot(dose,y_hat_3_male,"--b")
hold on
plot(dose,y_hat_4_male,"--b","linewidth",2)
hold on
plot(dose,y_hat_5_male,"--b")
hold on
plot(dose,y_hat_6_male,"--c")
hold on
plot(dose,y_hat_7_male,"--c")
hold on
plot(dose,y_hat_8_male,"--c")
hold on
plot(dose,y_hat_9_male,"--c")
hold on
plot(dose,y_hat_10_male,"--y")
hold on
plot(dose,y_hat_11_male,"--y")
hold on
plot(dose,y_hat_12_male,"--y")
hold on
plot(dose,y_hat_13_male,"--g")
hold on
plot(dose,y_hat_14_male,"--g")
hold on
plot(dose,y_hat_15_male,"--m")
hold on
plot(dose,y_male_end2,"*k")
grid on
title("Male - endpoint 2 - uniquemodel")
xlabel("dose")
ylabel("response")

%Male Model - endpoint3
dose=[0, 30, 100, 150];
male_data_end3=data(data.sex==0&data.endpoint==3,:);

y_hat_1_male = theta_1(1)+theta_1(2)*0+ones(1,4);
y_hat_2_male = theta_2(1)+theta_2(2)*dose;
y_hat_3_male = theta_3(1)+(theta_3(2)*male_data_end3.numberOfAnimals);
y_hat_4_male = theta_4(1)+theta_4(2)*0+ones(1,4);
y_hat_5_male = theta_5(1)+theta_5(2)*0+ones(1,4);
y_hat_6_male = theta_6(1)+(theta_6(2)*male_data_end3.numberOfAnimals)+theta_6(3)*0;
y_hat_7_male = theta_7(1)+(theta_7(2)*male_data_end3.numberOfAnimals)'+theta_7(3)*dose;
y_hat_8_male = theta_8(1)+(theta_8(2)*male_data_end3.numberOfAnimals)+theta_8(3)*0;
y_hat_9_male = theta_9(1)+(theta_9(2)*male_data_end3.numberOfAnimals)+theta_9(3)*0;
y_hat_10_male = theta_10(1)+(theta_10(2)*male_data_end3.numberOfAnimals)'+theta_10(3)*dose+theta_10(4)*0;
y_hat_11_male = theta_11(1)+(theta_11(2)*male_data_end3.numberOfAnimals)'+theta_11(3)*dose+theta_11(4)*0;
y_hat_12_male = theta_12(1)+(theta_12(2)*male_data_end3.numberOfAnimals)'+theta_12(3)*dose+theta_12(4)*0;
y_hat_13_male = theta_13(1)+(theta_13(2)*male_data_end3.numberOfAnimals)'+theta_13(3)*dose+theta_13(4)*0+theta_13(5)*0;
y_hat_14_male = theta_14(1)+(theta_14(2)*male_data_end3.numberOfAnimals)'+theta_14(3)*dose+theta_14(4)*0+theta_14(5)*0;
y_hat_15_male = theta_15(1)+(theta_15(2)*male_data_end3.numberOfAnimals)'+theta_15(3)*dose+theta_15(4)*0+theta_15(5)*0+theta_15(6)*0;

y_male_end3=male_data_end3.response;

figure
plot(dose,y_hat_1_male,"--b")
hold on
plot(dose,y_hat_2_male,"--b")
hold on
plot(dose,y_hat_3_male,"--b")
hold on
plot(dose,y_hat_4_male,"--b","linewidth",2)
hold on
plot(dose,y_hat_5_male,"--b")
hold on
plot(dose,y_hat_6_male,"--c")
hold on
plot(dose,y_hat_7_male,"--c")
hold on
plot(dose,y_hat_8_male,"--c")
hold on
plot(dose,y_hat_9_male,"--c")
hold on
plot(dose,y_hat_10_male,"--y")
hold on
plot(dose,y_hat_11_male,"--y")
hold on
plot(dose,y_hat_12_male,"--y")
hold on
plot(dose,y_hat_13_male,"--g")
hold on
plot(dose,y_hat_14_male,"--g")
hold on
plot(dose,y_hat_15_male,"--m")
hold on
plot(dose,y_male_end3,"*k")
grid on
title("Male - endpoint 3 - uniquemodel")
xlabel("dose")
ylabel("response")

%Female Model - endpoint1
dose=[0, 30, 100, 150];
female_data_end1=data(data.sex==1&data.endpoint==1,:);

y_hat_1_female = theta_1(1)+theta_1(2)*1+ones(1,4);
y_hat_2_female = theta_2(1)+theta_2(2)*dose;
y_hat_3_female = theta_3(1)+(theta_3(2)*female_data_end1.numberOfAnimals);
y_hat_4_female = theta_4(1)+theta_4(2)*1+ones(1,4);
y_hat_5_female = theta_5(1)+theta_5(2)*0+ones(1,4);
y_hat_6_female = theta_6(1)+(theta_6(2)*female_data_end1.numberOfAnimals)+theta_6(3)*1;
y_hat_7_female = theta_7(1)+(theta_7(2)*female_data_end1.numberOfAnimals)'+theta_7(3)*dose;
y_hat_8_female = theta_8(1)+(theta_8(2)*female_data_end1.numberOfAnimals)+theta_8(3)*1;
y_hat_9_female = theta_9(1)+(theta_9(2)*female_data_end1.numberOfAnimals)+theta_9(3)*0;
y_hat_10_female = theta_10(1)+(theta_10(2)*female_data_end1.numberOfAnimals)'+theta_10(3)*dose+theta_10(4)*1;
y_hat_11_female = theta_11(1)+(theta_11(2)*female_data_end1.numberOfAnimals)'+theta_11(3)*dose+theta_11(4)*1;
y_hat_12_female = theta_12(1)+(theta_12(2)*female_data_end1.numberOfAnimals)'+theta_12(3)*dose+theta_12(4)*0;
y_hat_13_female = theta_13(1)+(theta_13(2)*female_data_end1.numberOfAnimals)'+theta_13(3)*dose+theta_13(4)*1+theta_13(5)*1;
y_hat_14_female = theta_14(1)+(theta_14(2)*female_data_end1.numberOfAnimals)'+theta_14(3)*dose+theta_14(4)*1+theta_14(5)*0;
y_hat_15_female = theta_15(1)+(theta_15(2)*female_data_end1.numberOfAnimals)'+theta_15(3)*dose+theta_15(4)*1+theta_15(5)*0+theta_15(6)*1;

y_female_end1=female_data_end1.response;

figure
plot(dose,y_hat_1_female,"--b")
hold on
plot(dose,y_hat_2_female,"--b")
hold on
plot(dose,y_hat_3_female,"--b")
hold on
plot(dose,y_hat_4_female,"--b","linewidth",2)
hold on
plot(dose,y_hat_5_female,"--b")
hold on
plot(dose,y_hat_6_female,"--c")
hold on
plot(dose,y_hat_7_female,"--c")
hold on
plot(dose,y_hat_8_female,"--c")
hold on
plot(dose,y_hat_9_female,"--c")
hold on
plot(dose,y_hat_10_female,"--y")
hold on
plot(dose,y_hat_11_female,"--y")
hold on
plot(dose,y_hat_12_female,"--y")
hold on
plot(dose,y_hat_13_female,"--g")
hold on
plot(dose,y_hat_14_female,"--g")
hold on
plot(dose,y_hat_15_female,"--m")
hold on
plot(dose,y_female_end1,"*k")
grid on
title("Female - endpoint 1 - uniquemodel")
xlabel("dose")
ylabel("response")

%Female Model - endpoint2
dose=[0, 30, 100, 150];
female_data_end2=data(data.sex==1&data.endpoint==2,:);

y_hat_1_female = theta_1(1)+theta_1(2)*1+ones(1,4);
y_hat_2_female = theta_2(1)+theta_2(2)*dose;
y_hat_3_female = theta_3(1)+(theta_3(2)*female_data_end2.numberOfAnimals);
y_hat_4_female = theta_4(1)+theta_4(2)*0+ones(1,4);
y_hat_5_female = theta_5(1)+theta_5(2)*1+ones(1,4);
y_hat_6_female = theta_6(1)+(theta_6(2)*female_data_end2.numberOfAnimals)+theta_6(3)*1;
y_hat_7_female = theta_7(1)+(theta_7(2)*female_data_end2.numberOfAnimals)'+theta_7(3)*dose;
y_hat_8_female = theta_8(1)+(theta_8(2)*female_data_end2.numberOfAnimals)+theta_8(3)*0;
y_hat_9_female = theta_9(1)+(theta_9(2)*female_data_end2.numberOfAnimals)+theta_9(3)*1;
y_hat_10_female = theta_10(1)+(theta_10(2)*female_data_end2.numberOfAnimals)'+theta_10(3)*dose+theta_10(4)*1;
y_hat_11_female = theta_11(1)+(theta_11(2)*female_data_end2.numberOfAnimals)'+theta_11(3)*dose+theta_11(4)*0;
y_hat_12_female = theta_12(1)+(theta_12(2)*female_data_end2.numberOfAnimals)'+theta_12(3)*dose+theta_12(4)*1;
y_hat_13_female = theta_13(1)+(theta_13(2)*female_data_end2.numberOfAnimals)'+theta_13(3)*dose+theta_13(4)*1+theta_13(5)*0;
y_hat_14_female = theta_14(1)+(theta_14(2)*female_data_end2.numberOfAnimals)'+theta_14(3)*dose+theta_14(4)*1+theta_14(5)*1;
y_hat_15_female = theta_15(1)+(theta_15(2)*female_data_end2.numberOfAnimals)'+theta_15(3)*dose+theta_15(4)*1+theta_15(5)*1+theta_15(6)*0;

y_female_end2=female_data_end2.response;

figure
plot(dose,y_hat_1_female,"--b")
hold on
plot(dose,y_hat_2_female,"--b")
hold on
plot(dose,y_hat_3_female,"--b")
hold on
plot(dose,y_hat_4_female,"--b","linewidth",2)
hold on
plot(dose,y_hat_5_female,"--b")
hold on
plot(dose,y_hat_6_female,"--c")
hold on
plot(dose,y_hat_7_female,"--c")
hold on
plot(dose,y_hat_8_female,"--c")
hold on
plot(dose,y_hat_9_female,"--c")
hold on
plot(dose,y_hat_10_female,"--y")
hold on
plot(dose,y_hat_11_female,"--y")
hold on
plot(dose,y_hat_12_female,"--y")
hold on
plot(dose,y_hat_13_female,"--g")
hold on
plot(dose,y_hat_14_female,"--g")
hold on
plot(dose,y_hat_15_female,"--m")
hold on
plot(dose,y_female_end2,"*k")
grid on
title("Female - endpoint 2 - uniquemodel")
xlabel("dose")
ylabel("response")

%Female Model - endpoint3
dose=[0, 30, 100, 150];
female_data_end3=data(data.sex==1&data.endpoint==3,:);

y_hat_1_female = theta_1(1)+theta_1(2)*1+ones(1,4);
y_hat_2_female = theta_2(1)+theta_2(2)*dose;
y_hat_3_female = theta_3(1)+(theta_3(2)*female_data_end3.numberOfAnimals);
y_hat_4_female = theta_4(1)+theta_4(2)*0+ones(1,4);
y_hat_5_female = theta_5(1)+theta_5(2)*0+ones(1,4);
y_hat_6_female = theta_6(1)+(theta_6(2)*female_data_end3.numberOfAnimals)+theta_6(3)*1;
y_hat_7_female = theta_7(1)+(theta_7(2)*female_data_end3.numberOfAnimals)'+theta_7(3)*dose;
y_hat_8_female = theta_8(1)+(theta_8(2)*female_data_end3.numberOfAnimals)+theta_8(3)*0;
y_hat_9_female = theta_9(1)+(theta_9(2)*female_data_end3.numberOfAnimals)+theta_9(3)*0;
y_hat_10_female = theta_10(1)+(theta_10(2)*female_data_end3.numberOfAnimals)'+theta_10(3)*dose+theta_10(4)*1;
y_hat_11_female = theta_11(1)+(theta_11(2)*female_data_end3.numberOfAnimals)'+theta_11(3)*dose+theta_11(4)*0;
y_hat_12_female = theta_12(1)+(theta_12(2)*female_data_end3.numberOfAnimals)'+theta_12(3)*dose+theta_12(4)*0;
y_hat_13_female = theta_13(1)+(theta_13(2)*female_data_end3.numberOfAnimals)'+theta_13(3)*dose+theta_13(4)*1+theta_13(5)*0;
y_hat_14_female = theta_14(1)+(theta_14(2)*female_data_end3.numberOfAnimals)'+theta_14(3)*dose+theta_14(4)*1+theta_14(5)*0;
y_hat_15_female = theta_15(1)+(theta_15(2)*female_data_end3.numberOfAnimals)'+theta_15(3)*dose+theta_15(4)*1+theta_15(5)*0+theta_15(6)*0;

y_female_end3=female_data_end3.response;

figure
plot(dose,y_hat_1_female,"--b")
hold on
plot(dose,y_hat_2_female,"--b")
hold on
plot(dose,y_hat_3_female,"--b")
hold on
plot(dose,y_hat_4_female,"--b","linewidth",2)
hold on
plot(dose,y_hat_5_female,"--b")
hold on
plot(dose,y_hat_6_female,"--c")
hold on
plot(dose,y_hat_7_female,"--c")
hold on
plot(dose,y_hat_8_female,"--c")
hold on
plot(dose,y_hat_9_female,"--c")
hold on
plot(dose,y_hat_10_female,"--y")
hold on
plot(dose,y_hat_11_female,"--y")
hold on
plot(dose,y_hat_12_female,"--y")
hold on
plot(dose,y_hat_13_female,"--g")
hold on
plot(dose,y_hat_14_female,"--g")
hold on
plot(dose,y_hat_15_female,"--m")
hold on
plot(dose,y_female_end3,"*k")
grid on
title("Female - endpoint 3 - uniquemodel")
xlabel("dose")
ylabel("response")