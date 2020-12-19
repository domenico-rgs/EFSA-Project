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
phi_1=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5]; %best
[theta_1,std_theta_1, RSS_1] = identificator(phi_1,y, weights);

%% K=2
phi_2=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2];
phi_3=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2.*x_4.*x_5];
phi_4=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5];
phi_5=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_1.*x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5];
phi_6=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5];
phi_7=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5];
phi_8=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5];
phi_9=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5]; 
phi_10=[ones(n,1) x_1 x_4 x_1.*x_4 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5];
phi_11=[ones(n,1) x_1 x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5];
phi_12=[ones(n,1) x_1 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5];
phi_13=[ones(n,1) x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2 x_1.*x_2.*x_4.*x_5];

[theta_2,std_theta_2, RSS_2] = identificator(phi_2,y, weights); %best
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
[theta_13,std_theta_13, RSS_13] = identificator(phi_13,y, weights); 

%% K=3
phi_14=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5];
phi_15=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2];
phi_16=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_1.*x_2.*x_5 x_1.*x_2];
phi_17=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2];
phi_18=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2];
phi_19=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2];
phi_20=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2];
phi_21=[ones(n,1) x_1 x_4 x_1.*x_4 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2];
phi_22=[ones(n,1) x_1 x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2];
phi_23=[ones(n,1) x_1 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2];
phi_24=[ones(n,1) x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5 x_1.*x_2];

[theta_14,std_theta_14, RSS_14] = identificator(phi_14,y, weights); %best
[theta_15,std_theta_15, RSS_15] = identificator(phi_15,y, weights); 
[theta_16,std_theta_16, RSS_16] = identificator(phi_16,y, weights); 
[theta_17,std_theta_17, RSS_17] = identificator(phi_17,y, weights); 
[theta_18,std_theta_18, RSS_18] = identificator(phi_18,y, weights); 
[theta_19,std_theta_19, RSS_19] = identificator(phi_19,y, weights); 
[theta_20,std_theta_20, RSS_20] = identificator(phi_20,y, weights); 
[theta_21,std_theta_21, RSS_21] = identificator(phi_21,y, weights);
[theta_22,std_theta_22, RSS_22] = identificator(phi_22,y, weights);
[theta_23,std_theta_23, RSS_23] = identificator(phi_23,y, weights);
[theta_24,std_theta_24, RSS_24] = identificator(phi_24,y, weights);

%% K=4
phi_25=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5];
phi_26=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_1.*x_2.*x_5];
phi_27=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_2.*x_5 x_1.*x_2.*x_5];
phi_28=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5];
phi_29=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5];
phi_30=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5];
phi_31=[ones(n,1) x_1 x_4 x_1.*x_4 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5];
phi_32=[ones(n,1) x_1 x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5];
phi_33=[ones(n,1) x_1 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5];
phi_34=[ones(n,1) x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5 x_1.*x_2.*x_5];

[theta_25,std_theta_25, RSS_25] = identificator(phi_25,y, weights); %best
[theta_26,std_theta_26, RSS_26] = identificator(phi_26,y, weights);
[theta_27,std_theta_27, RSS_27] = identificator(phi_27,y, weights);
[theta_28,std_theta_28, RSS_28] = identificator(phi_28,y, weights);
[theta_29,std_theta_29, RSS_29] = identificator(phi_29,y, weights);
[theta_30,std_theta_30, RSS_30] = identificator(phi_30,y, weights);
[theta_31,std_theta_31, RSS_31] = identificator(phi_31,y, weights);
[theta_32,std_theta_32, RSS_32] = identificator(phi_32,y, weights);
[theta_33,std_theta_33, RSS_33] = identificator(phi_33,y, weights);
[theta_34,std_theta_34, RSS_34] = identificator(phi_34,y, weights);

%% K=5
phi_35=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5];
phi_36=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_2.*x_5];
phi_37=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_1.*x_5 x_2.*x_5];
phi_38=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5];
phi_39=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5];
phi_40=[ones(n,1) x_1 x_4 x_1.*x_4 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5];
phi_41=[ones(n,1) x_1 x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5];
phi_42=[ones(n,1) x_1 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5];
phi_43=[ones(n,1) x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5 x_2.*x_5];

[theta_35,std_theta_35, RSS_35] = identificator(phi_35,y, weights); %best
[theta_36,std_theta_36, RSS_36] = identificator(phi_36,y, weights);
[theta_37,std_theta_37, RSS_37] = identificator(phi_37,y, weights);
[theta_38,std_theta_38, RSS_38] = identificator(phi_38,y, weights);
[theta_39,std_theta_39, RSS_39] = identificator(phi_39,y, weights);
[theta_40,std_theta_40, RSS_40] = identificator(phi_40,y, weights);
[theta_41,std_theta_41, RSS_41] = identificator(phi_41,y, weights);
[theta_42,std_theta_42, RSS_42] = identificator(phi_42,y, weights);
[theta_43,std_theta_43, RSS_43] = identificator(phi_43,y, weights);

%% K=6
phi_44=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2];
phi_45=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_1.*x_5];
phi_46=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_2 x_1.*x_5];
phi_47=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_1.*x_2.*x_4 x_2 x_1.*x_5];
phi_48=[ones(n,1) x_1 x_4 x_1.*x_4 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5];
phi_49=[ones(n,1) x_1 x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5];
phi_50=[ones(n,1) x_1 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5];
phi_51=[ones(n,1) x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2 x_1.*x_5];

[theta_44,std_theta_44, RSS_44] = identificator(phi_44,y, weights); %best
[theta_45,std_theta_45, RSS_45] = identificator(phi_45,y, weights);
[theta_46,std_theta_46, RSS_46] = identificator(phi_46,y, weights);
[theta_47,std_theta_47, RSS_47] = identificator(phi_47,y, weights);
[theta_48,std_theta_48, RSS_48] = identificator(phi_48,y, weights);
[theta_49,std_theta_49, RSS_49] = identificator(phi_49,y, weights);
[theta_50,std_theta_50, RSS_50] = identificator(phi_50,y, weights);
[theta_51,std_theta_51, RSS_51] = identificator(phi_51,y, weights);

%% K=7
phi_52=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2];
phi_53=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4];
phi_54=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_2.*x_4 x_2];
phi_55=[ones(n,1) x_1 x_4 x_1.*x_4 x_5 x_1.*x_2.*x_4 x_2];
phi_56=[ones(n,1) x_1 x_4 x_1.*x_4 x_2.*x_4 x_1.*x_2.*x_4 x_2];
phi_57=[ones(n,1) x_1 x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2];
phi_58=[ones(n,1) x_1 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2];
phi_59=[ones(n,1) x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2];

[theta_52,std_theta_52, RSS_52] = identificator(phi_52,y, weights);
[theta_53,std_theta_53, RSS_53] = identificator(phi_53,y, weights);
[theta_54,std_theta_54, RSS_54] = identificator(phi_54,y, weights);
[theta_55,std_theta_55, RSS_55] = identificator(phi_55,y, weights);
[theta_56,std_theta_56, RSS_56] = identificator(phi_56,y, weights);
[theta_57,std_theta_57, RSS_57] = identificator(phi_57,y, weights);
[theta_58,std_theta_58, RSS_58] = identificator(phi_58,y, weights);
[theta_59,std_theta_59, RSS_59] = identificator(phi_59,y, weights); %best

%% K=8
phi_60=[ones(n,1) x_4 x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4];
phi_61=[ones(n,1) x_4 x_1.*x_4 x_5 x_2.*x_4 x_2];
phi_62=[ones(n,1) x_4 x_1.*x_4 x_5 x_1.*x_2.*x_4 x_2];
phi_63=[ones(n,1) x_4 x_1.*x_4 x_2.*x_4 x_1.*x_2.*x_4 x_2];
phi_64=[ones(n,1) x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2];
phi_65=[ones(n,1) x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4 x_2];

[theta_60,std_theta_60, RSS_60] = identificator(phi_60,y, weights); %best
[theta_61,std_theta_61, RSS_61] = identificator(phi_61,y, weights);
[theta_62,std_theta_62, RSS_62] = identificator(phi_62,y, weights);
[theta_63,std_theta_63, RSS_63] = identificator(phi_63,y, weights);
[theta_64,std_theta_64, RSS_64] = identificator(phi_64,y, weights);
[theta_65,std_theta_65, RSS_65] = identificator(phi_65,y, weights);

%% K=9
phi_66=[ones(n,1) x_4 x_1.*x_4 x_5 x_2.*x_4];
phi_67=[ones(n,1) x_4 x_1.*x_4 x_5 x_1.*x_2.*x_4];
phi_68=[ones(n,1) x_4 x_1.*x_4 x_2.*x_4 x_1.*x_2.*x_4];
phi_69=[ones(n,1) x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4];
phi_70=[ones(n,1) x_1.*x_4 x_5 x_2.*x_4 x_1.*x_2.*x_4];

[theta_66,std_theta_66, RSS_66] = identificator(phi_66,y, weights); %best
[theta_67,std_theta_67, RSS_67] = identificator(phi_67,y, weights);
[theta_68,std_theta_68, RSS_68] = identificator(phi_68,y, weights);
[theta_69,std_theta_69, RSS_69] = identificator(phi_69,y, weights);
[theta_70,std_theta_70, RSS_70] = identificator(phi_70,y, weights);

%% K=10
phi_71=[ones(n,1) x_4 x_1.*x_4 x_5];
phi_72=[ones(n,1) x_4 x_1.*x_4 x_2.*x_4];
phi_73=[ones(n,1) x_4 x_5 x_2.*x_4];
phi_74=[ones(n,1) x_1.*x_4 x_5 x_2.*x_4];

[theta_71,std_theta_71, RSS_71] = identificator(phi_71,y, weights); %best
[theta_72,std_theta_72, RSS_72] = identificator(phi_72,y, weights);
[theta_73,std_theta_73, RSS_73] = identificator(phi_73,y, weights);
[theta_74,std_theta_74, RSS_74] = identificator(phi_74,y, weights);

%% K=11
phi_75=[ones(n,1) x_4 x_1.*x_4];
phi_76=[ones(n,1) x_4 x_5];
phi_77=[ones(n,1) x_1.*x_4 x_5];

[theta_75,std_theta_75, RSS_75] = identificator(phi_75,y, weights); %best
[theta_76,std_theta_76, RSS_76] = identificator(phi_76,y, weights);
[theta_77,std_theta_77, RSS_77] = identificator(phi_77,y, weights);

%% K=12
phi_78=[ones(n,1) x_4];
phi_79=[ones(n,1) x_1.*x_4];

[theta_78,std_theta_78, RSS_78] = identificator(phi_78,y, weights); %best
[theta_79,std_theta_79, RSS_79] = identificator(phi_79,y, weights);

%% BEST MODEL
[FPE_2,AIC_2,MDL_2,SQUARED_R_2,Cp_2,BIC_2] = objectiveTest(n, length(theta_2), RSS_2, TSS); 
[FPE_14,AIC_14,MDL_14,SQUARED_R_14,Cp_14,BIC_14] = objectiveTest(n, length(theta_14), RSS_14, TSS);
[FPE_25,AIC_25,MDL_25,SQUARED_R_25,Cp_25,BIC_25] = objectiveTest(n, length(theta_25), RSS_25, TSS);
[FPE_35,AIC_35,MDL_35,SQUARED_R_35,Cp_35,BIC_35] = objectiveTest(n, length(theta_35), RSS_35, TSS);
[FPE_44,AIC_44,MDL_44,SQUARED_R_44,Cp_44,BIC_44] = objectiveTest(n, length(theta_44), RSS_44, TSS);
[FPE_59,AIC_59,MDL_59,SQUARED_R_59,Cp_59,BIC_59] = objectiveTest(n, length(theta_59), RSS_59, TSS); 
[FPE_60,AIC_60,MDL_60,SQUARED_R_60,Cp_60,BIC_60] = objectiveTest(n, length(theta_60), RSS_60, TSS); %winner
[FPE_66,AIC_66,MDL_66,SQUARED_R_66,Cp_66,BIC_66] = objectiveTest(n, length(theta_66), RSS_66, TSS); 
[FPE_71,AIC_71,MDL_71,SQUARED_R_71,Cp_71,BIC_71] = objectiveTest(n, length(theta_71), RSS_71, TSS); 
[FPE_75,AIC_75,MDL_75,SQUARED_R_75,Cp_75,BIC_75] = objectiveTest(n, length(theta_75), RSS_75, TSS); 
[FPE_78,AIC_78,MDL_78,SQUARED_R_78,Cp_78,BIC_78] = objectiveTest(n, length(theta_78), RSS_78, TSS); 

%% Results plot
% RSS
figure
plot([RSS_2 RSS_14 RSS_25 RSS_35 RSS_44 RSS_59 RSS_60 RSS_66 RSS_71 RSS_75 RSS_78])


% Objective test
x=[2 14 25 35 44 59 60 66 71 75 78];
figure
sgtitle("Objective tests evolution")
subplot(2,3,1)
plot(x,[FPE_2 FPE_14 FPE_25 FPE_35 FPE_44 FPE_59 FPE_60 FPE_66 FPE_71 FPE_75 FPE_78],'-o')
grid on
title("FPE")
subplot(2,3,2)
plot(x,[AIC_2 AIC_14 AIC_25 AIC_35 AIC_44 AIC_59 AIC_60 AIC_66 AIC_71 AIC_75 AIC_78],'-o')
grid on
title("AIC")
subplot(2,3,3)
plot(x,[MDL_2 MDL_14 MDL_25 MDL_35 MDL_44 MDL_59 MDL_60 MDL_66 MDL_71 MDL_75 MDL_78],'-o')
grid on
title("MDL")
subplot(2,3,4)
plot(x,[SQUARED_R_2 SQUARED_R_14 SQUARED_R_25 SQUARED_R_35 SQUARED_R_44 SQUARED_R_59 SQUARED_R_60 SQUARED_R_66 SQUARED_R_71 SQUARED_R_75 SQUARED_R_78],'-o')
grid on
title("R^2")
subplot(2,3,5)
plot(x,[Cp_2 Cp_14 Cp_25 Cp_35 Cp_44 Cp_59 Cp_60 Cp_66 Cp_71 Cp_75 Cp_78],'-o')
grid on
title("C_p")
subplot(2,3,6)
plot(x,[BIC_2 BIC_14 BIC_25 BIC_35 BIC_44 BIC_59 BIC_60 BIC_66 BIC_71 BIC_75 BIC_78],'-o')
grid on
title("BIC")