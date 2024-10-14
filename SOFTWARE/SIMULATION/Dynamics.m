classdef Dynamics < handle
	properties
		
	end
	methods
		function self = Dynamics()

		end
		function tau = moments(self,u)
			 tau = u;
		end
		function x_dot = kinetics(self,x,u)
			I = diag([1/6, 1/6, 1/6]) * 1^2;

			% q1
			% q2
			% q3
			% q4
			% Wx
			% Wy
			% Wz
			q = x(1:4);
			omega = x(5:7);

			q_dot = 0.5 .* quatmultiply([0;omega]',q');

			omega_dot = inv(I) * (u - cross(omega, I * omega));

			%3x3 * 3x1

			x_dot = [q_dot';omega_dot];
		end
		function x = update(self,x,u,time)
			% Saturate Inputs
			
			tau = self.moments(u);

			% Propagate Model
			x = Integrator.rk4(@(x) self.kinetics(x,tau),x,time);

			% Normalize
			x(1:4) = x(1:4) ./ norm(x(1:4));

			% Return State
		end
	end
end

function p = quatmultiply(q, r)
%QUATMULTIPLY Multiply two quaternions.
%   P = QUATMULTIPLY(Q, R) multiplies quaternions Q and R, returning their
%   product P.

if size(q, 2) ~= 4 || size(r, 2) ~= 4
  error('Expecting quaternions as rows.');
elseif size(q, 1) ~= size(r, 1)
  error('Number of quaternions don''t match.');
end

p = [q(:,1).*r(:,1) - q(:,2).*r(:,2) - q(:,3).*r(:,3) - q(:,4).*r(:,4) ...
     q(:,1).*r(:,2) + r(:,1).*q(:,2) + q(:,3).*r(:,4) - q(:,4).*r(:,3) ...
     q(:,1).*r(:,3) + r(:,1).*q(:,3) + q(:,4).*r(:,2) - q(:,2).*r(:,4) ...
     q(:,1).*r(:,4) + r(:,1).*q(:,4) + q(:,2).*r(:,3) - q(:,3).*r(:,2)];

end