close all
clear all
clc

%% Import dati
opts=detectImportOptions('./MiniProjectEFSA.xlsx');
dati=readtable('./MiniProjectEFSA.xlsx', opts);

dose=[0, 30, 100, 150];

dati_male_1 = dati(dati.endpoint==1&dati.sex_0_M_1_F_==0,:);
dati_female_1 = dati(dati.endpoint==1&dati.sex_0_M_1_F_==1,:);
dati_male_2 = dati(dati.endpoint==2&dati.sex_0_M_1_F_==0,:);
dati_female_2 = dati(dati.endpoint==2&dati.sex_0_M_1_F_==1,:);
dati_male_3 = dati(dati.endpoint==3&dati.sex_0_M_1_F_==0,:);
dati_female_3 = dati(dati.endpoint==3&dati.sex_0_M_1_F_==1,:);

%% Plotting dose-responde for endpoint-gender
figure
plot(dose,dati_male_1.response);
errorbar(dose,dati_male_1.response,dati_male_1.SD)
grid on
title('Dose-Responde for male endpoint 1')
xlabel('Dose')
ylabel('Response')

figure
plot(dose,dati_female_1.response);
errorbar(dose,dati_female_1.response,dati_female_1.SD)
grid on
title('Dose-Responde for female endpoint 1')
xlabel('Dose')
ylabel('Response')

figure
plot(dose,dati_male_2.response);
errorbar(dose,dati_male_2.response,dati_male_2.SD)
grid on
title('Dose-Responde for male endpoint 2')
xlabel('Dose')
ylabel('Response')

figure
plot(dose,dati_female_2.response);
errorbar(dose,dati_female_2.response,dati_female_2.SD)
grid on
title('Dose-Responde for female endpoint 2')
xlabel('Dose')
ylabel('Response')

figure
plot(dose,dati_male_3.response);
errorbar(dose,dati_male_3.response,dati_male_3.SD)
grid on
title('Dose-Responde for male endpoint 3')
xlabel('Dose')
ylabel('Response')

figure
plot(dose,dati_female_3.response);
errorbar(dose,dati_female_3.response,dati_male_3.SD)
grid on
title('Dose-Responde for female endpoint 3')
xlabel('Dose')
ylabel('Response')