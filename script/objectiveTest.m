function [FPE,AIC,MDL,SQUARED_R,Cp,BIC] = objectiveTest(n, q, SSR, TSS)
FPE = ((n+q)/(n-q))*SSR;
AIC = 2*q/n + log(SSR);
MDL = log(n)*q/n + log(SSR);
SQUARED_R=1-((SSR/(n-q-1))/(TSS/(n-1)));
Cp=(1/n)*(SSR+2*q*(SSR/(n-q)));
BIC=(1/n)*(SSR+log(n)*q*(SSR/(n-q)));
end

