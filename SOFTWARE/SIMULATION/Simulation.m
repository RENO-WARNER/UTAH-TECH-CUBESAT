clear();
clc();
close();



animation = Animation();
%observer = Observer();
controller = Controller();
dynamics = Dynamics();

time = 0:0.1:15;

% Initialize state as 0
x = zeros(7,1);
% Rip
x(1) = 1;
r = [1;0;0;0]; 

for i = 1:length(time)

	if mod(time(i),5) == 0
		r = zeros(7,1);

		r(1:4) = rand(4,1);

		r(1:4) = r(1:4) ./ norm(r(1:4));
	end

	%x_hat = observer.update();

	u = controller.update(x,r);

	x = dynamics.update(x,u,0.1)

	y = x(1:4);

	animation.update(y);

	drawnow;

	pause(0.1);

	    
end