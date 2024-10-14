function optimize_electromagnet()
    % Constants
    rho = 1.68e-8;  % Resistivity of copper (Ω·m)

    power_max = 0.5;  % Maximum power (W)
    current_max = 3;  % Maximum current (A)

    width_max = 0.080;  % Maximum width of rectangle (m)
    height_max = 0.3;  % Maximum height of rectangle (m)

    trace_spacing = 0.0001;  % Spacing between traces (m)
	trace_thickness = 1 * 35 * 10e-6; % 1 Oz Trace Thickness 
    
    % Optimization variables
    % x(1): Trace width (m)
    % x(2): Number of turns
	% x(3): Width (m)
	% x(4): Height (m)
    
    % Objective function (negative because fmincon minimizes)
    objective = @(x) -calculate_dipole_moment(x, rho, power_max, width_max, height_max, trace_spacing,trace_thickness);
    
    % Constraints
    constraint = @(x) constraint_function(x, rho, power_max, current_max, width_max, height_max, trace_spacing,trace_thickness);
    
    % Lower and upper bounds
    lower_bound = [1e-5, 1, 0.001 , 0.001];  % Minimum trace width and at least 1 turn
    upper_bound = [0.010, 1000, width_max, height_max];  % Maximum trace width and arbitrary upper limit on turns
    
    % Initial guess
    x0 = [0.001, 3,width_max / 2,height_max / 2];
    
    % Optimization options
    options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point');
    
    % Run optimization
    [x_opt, fval] = fmincon(objective, x0, [], [], [], [], lower_bound, upper_bound, constraint, options);
    
    % Display results
    trace_width = x_opt(1);
    num_turns = round(x_opt(2));
	width = x_opt(3);
	height = x_opt(4);
    [dipole_moment, current, resistance]  = calculate_dipole_moment(x_opt, rho, power_max, width_max, height_max, trace_spacing,trace_thickness);
    
    fprintf('Optimized Electromagnet Design:\n');
    fprintf('Trace width: %.6f m\n', trace_width);
    fprintf('Number of turns: %d\n', num_turns);
    fprintf('Magnetic dipole moment: %.6f A·m²\n', dipole_moment);
    fprintf('Current: %.6f A\n', current);
    fprintf('Resistance: %.6f Ω\n', resistance);
    fprintf('Total width: %.6f m\n', width);
    fprintf('Total height: %.6f m\n', height);
	min_width = width - num_turns * (trace_width + trace_spacing);
	min_height = height - num_turns * (trace_width + trace_spacing);
	fprintf('Min Height %.6f m\n', min_height);
	fprintf('Min Width %.6f m\n', min_width);
end

function [dipole_moment, current, resistance] = calculate_dipole_moment(x, rho, power_max, width_max, height_max, trace_spacing,trace_thickness)
   
	trace_width = x(1);
    num_turns = x(2);
	width = x(3);
	height = x(4);
    
	min_width = width - num_turns * (trace_width + trace_spacing);
	min_height = height - num_turns * (trace_width + trace_spacing);
    % Calculate the dimensions of the coil

    % Ensure the coil fits within the maximum dimensions
    if min_width < 0 || min_height < 0
        dipole_moment = 0;
        current = 0;
        resistance = Inf;
        return;
    end
    
    % Calculate the average area of a turn
	avg_width = (width - min_width) / 2;
	avg_height = (height - min_height) / 2;
    avg_area =  avg_height * avg_width;
    
    % Calculate the total length of the trace
    trace_length =  num_turns * (2 * avg_width + 2 * avg_height);
    
    % Calculate resistance
    resistance = rho * trace_length / (trace_width * trace_thickness);
    
    % Calculate current based on maximum power
    current = sqrt(power_max / resistance);
    
    % Calculate dipole moment
    dipole_moment = num_turns * current * avg_area;
end

function [c, ceq] = constraint_function(x, rho, power_max, current_max, width_max, height_max, trace_spacing,trace_thickness)
    
	[~, current, resistance] = calculate_dipole_moment(x, rho, power_max, width_max, height_max, trace_spacing,trace_thickness);
    
    c = [
        current - current_max;  % Current constraint
        x(4) - width_max;  % Width constraint
        x(3) - height_max;  % Height constraint
        power_max - current^2 * resistance;  % Power constraint
    ];
    ceq = [];
end

% Run the optimization
