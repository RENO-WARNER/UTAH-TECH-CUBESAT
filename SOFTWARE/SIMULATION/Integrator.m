classdef Integrator < handle
	methods(Static)
		function self = Integrator()
			if varargin 

			end
		end
		function x = integrate(fun,x,time)
			rk4(fun,x,time);
		end

		function euler()
			
		end
		function x1 = rk4(fun,x,time)
			F1 = fun(x);
            F2 = fun(x + time/2*F1);
            F3 = fun(x + time/2*F2);
            F4 = fun(x + time  *F3);
            x1 = x + time/6 * (F1 + 2*F2 + 2*F3 + F4);
		end
	end
end