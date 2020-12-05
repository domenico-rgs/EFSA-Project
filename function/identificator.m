function [theta,std_theta, SSR] = identificator(phi,y)
[theta, std_theta] = lscov(phi, y);
y_hat = phi * theta;
epsilon = y - y_hat; %residual
SSR = epsilon'*epsilon; 
end

