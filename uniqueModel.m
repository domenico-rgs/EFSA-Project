close all
clear all
clc

%% Import dati
opts=detectImportOptions('./MiniProjectEFSA.xlsx');
dati=readtable('./MiniProjectEFSA.xlsx', opts);

%% TODO