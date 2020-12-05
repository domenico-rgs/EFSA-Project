close all
clear all
clc

%% Import dati
opts=detectImportOptions('./MiniProjectEFSA.xlsx');
dati=readtable('./MiniProjectEFSA.xlsx', opts);
dati.Properties.VariableNames={'response','numberOfAnimals','SD','dose','sex','endpoint'};

dose=[0, 30, 100, 150];

dati_male_1 = dati(dati.endpoint==1&dati.sex==0,:);
dati_female_1 = dati(dati.endpoint==1&dati.sex==1,:);
dati_male_2 = dati(dati.endpoint==2&dati.sex==0,:);
dati_female_2 = dati(dati.endpoint==2&dati.sex==1,:);
dati_male_3 = dati(dati.endpoint==3&dati.sex==0,:);
dati_female_3 = dati(dati.endpoint==3&dati.sex==1,:);

%% Plotting dose-responde for endpoint-gender

%Endpoint 1 - male
figure
subplot(2,1,1)
bar(dose,dati_male_1.response);
errorbar(dose,dati_male_1.response,dati_male_1.SD)
grid on
xlim([-10 160])
title('Dose-Response for male endpoint 1')
xlabel('Dose')
ylabel('Response')

%Endpoint 1 - female
subplot(2,1,2)
plot(dose,dati_female_1.response);
errorbar(dose,dati_female_1.response,dati_female_1.SD)
grid on
xlim([-10 160])
title('Dose-Response for female endpoint 1')
xlabel('Dose')
ylabel('Response')

%Endpoint 2 - male
figure
subplot(2,1,1)
plot(dose,dati_male_2.response);
errorbar(dose,dati_male_2.response,dati_male_2.SD)
grid on
xlim([-10 160])
title('Dose-Response for male endpoint 2')
xlabel('Dose')
ylabel('Response')

%Endpoint 2 - female
subplot(2,1,2)
plot(dose,dati_female_2.response);
errorbar(dose,dati_female_2.response,dati_female_2.SD)
grid on
xlim([-10 160])
title('Dose-Response for female endpoint 2')
xlabel('Dose')
ylabel('Response')

%Endpoint 3 - male
figure
subplot(2,1,1)
plot(dose,dati_male_3.response);
errorbar(dose,dati_male_3.response,dati_male_3.SD)
grid on
xlim([-10 160])
title('Dose-Response for male endpoint 3')
xlabel('Dose')
ylabel('Response')

%Endpoint 3 - female
subplot(2,1,2)
plot(dose,dati_female_3.response);
errorbar(dose,dati_female_3.response,dati_male_3.SD)
grid on
xlim([-10 160])
title('Dose-Response for female endpoint 3')
xlabel('Dose')
ylabel('Response')