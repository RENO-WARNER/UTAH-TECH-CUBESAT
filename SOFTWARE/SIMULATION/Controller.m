classdef Controller < handle
	properties
		R
		Q
	end
	methods
		function self = Controller()

			self.R = diag(ones(3,1)) .* 1;

			self.Q = diag(ones(6,1)) .* 1;
		end
		function u = update(self,x,r)
			error = x - r;

			q1 = x(1);
			q2 = x(2);
			q3 = x(3);
			q4 = x(4);

			wx = x(5);
			wy = x(6);
			wz = x(7);

			Ixx = 1/6;
			Iyy = 1/6;
			Izz = 1/6;

			% Calculate A
			% Non Linearized

			

		A = [...
			0, -wx/2, -wy/2, -wz/2,                 -q2/2,                -q3/2,                 -q4/2;
wx/2,     0,  wz/2, -wy/2,                  q1/2,                -q4/2,                  q3/2;
wy/2, -wz/2,     0,  wx/2,                  q4/2,                 q1/2,                 -q2/2;
wz/2,  wy/2, -wx/2,     0,                 -q3/2,                 q2/2,                  q1/2;
   0,     0,     0,     0,                     0, (wz*(Iyy - Izz))/Ixx,  (wy*(Iyy - Izz))/Ixx;
   0,     0,     0,     0, -(wz*(Ixx - Izz))/Iyy,                    0, -(wx*(Ixx - Izz))/Iyy;
   0,     0,     0,     0,  (wy*(Ixx - Iyy))/Izz, (wx*(Ixx - Iyy))/Izz,                     0;
   ];

			% Calculate B
			B = [
	0,     0,     0;
    0,     0,     0;
    0,     0,     0;
    0,     0,     0;
1/Ixx,     0,     0;
    0, 1/Iyy,     0;
    0,     0, 1/Izz;
	];

	
	A_reduced = [A(2:4,2:4), A(2:4,5:7);
             A(5:7,2:4), A(5:7,5:7)];
	B_reduced = [B(2:4,:); B(5:7,:)];
			%LQR
			[K_reduced,S,P] = lqr(A_reduced,B_reduced,self.Q,self.R,0);

			if error(1) < 0
				error(1:4) = -error(1:4);
			end

			q_reduced = error(2:4) / error(1);

			omega = x(5:7);

			u = -K_reduced * [q_reduced; omega];

		end
	end
end

% qtorp full -> reduced
% rptorq reduced -> ful
% L(q) = [q(1), -v]
% function H = hat(v)
% 	H = [
% 		0 -v(3) v(2);
% 		v(3) 0 -v(1);
% 		-v(2) v(1) 0;
% 	]
% end
% function L = L(q)
% 	s = q(1);
% 	v = q(2:4);
% 	L = [s, -v';
% 		 v, s * I * hat(v)]
% 	return L;
% end
% function error()
% 	q0 = x0(4:7);
% 	q = x(4:7);
% 	error = toReduced(L(q0)' * q)
% end
% G(q) = L(q) * H
			% State
% 			x = [
% 				q1
% 				q2
% 				q3
% 				q4
% 				wx
% 				wy
% 				wz
% 			];
% 
% 			iI = inv(I)

			% State ODE
% 			x_dot = [
% 				 0.5 .* [0, -omega(1),  -omega(2),  -omega(3)] * [q1;q2;q3;q4],
% 				 0.5 .* [omega(1),         0, omega(3),  -omega(2)] * [q1;q2;q3;q4],
% 				 0.5 .* [omega(2),  omega(3),         0, omega(1)] * [q1;q2;q3;q4],
% 				 0.5 .* [omega(3), omega(2),  -omega(1),         0] * [q1;q2;q3;q4],
% 				 iI(1,:) * tau
% 				 iI(2,:) * tau
% 				 iI(3,:) * tau
% 			]

			
% 			% Inputs
% 			u = [
% 				tuax
% 				tuay
% 				tuaz
% 			]
% 
% 			% Non Linearized

% 
% 			% We want it 
% 			oemga = 0
% 
% 			C = [
% 				1, 0, 0, 0, 0, 0, 0;
% 				0, 1, 0, 0, 0, 0, 0;
% 				0, 0, 1, 0, 0, 0, 0;	
% 				0, 0, 0, 1, 0, 0, 0;
% 			];
% 
% 			D = [
% 					0, 0, 0, 0, 0, 0, 0;
% 					0, 0, 0, 0, 0, 0, 0;
% 					0, 0, 0, 0, 0, 0, 0;
% 			];