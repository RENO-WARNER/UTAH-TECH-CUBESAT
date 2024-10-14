classdef Observer < handle
	properties
		
	end
	methods
		function update()
			% 

			% Propogate EKF Forwared
			[x_hat,P] = Integator.integrate([x_hat_dot,P_dot],self.ts); 

			% Check if there is any new sensor data
			
			% 
		end
	end
end

%KF
% No Measurements
% P_dot = AP + PA' + GQG'
%x_hat_dot = Ax + Bu

%EKF Continous Discreet

%No Measurments
	% Recaclulate A
	% P_dot = AP + PA' + GQG
	% Propogate Dynamics
	% integrate x_hat_dot to x_hat
% New Measurement
	% Recaclulate C
	% P_k[n] = P_k[n-1] - P_k[n-1] *  (C * P_k[n-1] * C') ^ -1 * C * P_k[n-1]
	where the + in P + k indicates the auto-covariance after the measurment has been
recived and the − in P −
k indicates the auto-covariance before the measurment
has been recived.
	% Kalman Gain
		K_l = P_k[n] * C' * R^-1
	%New estimate
		x_hat = x_hat + K_l * (Y_m - Y_k)
		y_k = h();





% Recaclulate A and C
%P_dot = AP + PA' - PC'R^-1P + GQG'

