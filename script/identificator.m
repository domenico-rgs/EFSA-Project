function [theta,std_theta, SSR] = identificator(phi,y, weights)
[theta, std_theta] = lscov(phi, y, weights);
y_hat = phi * theta;
epsilon = y - y_hat; %residual
SSR = epsilon'*epsilon; 
end

