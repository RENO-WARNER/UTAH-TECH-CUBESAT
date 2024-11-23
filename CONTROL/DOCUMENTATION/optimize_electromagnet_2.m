function [optimal_design] = optimize_pcb_electromagnet_2(power, voltage, max_diameter, geometry, num_layers)
    % Physical and material constants
    cu_resistivity = 1.68e-8;  % Copper resistivity (ohm-meter)
    %permeability_free_space = 4 * pi * 1e-7;  % H/m
    
    % Input validation
    validateattributes(power, {'numeric'}, {'positive', 'scalar'});
    validateattributes(voltage, {'numeric'}, {'positive', 'scalar'});
    validateattributes(max_diameter, {'numeric'}, {'positive', 'scalar'});
    validateattributes(num_layers, {'numeric'}, {'positive', 'integer', '<=', 10});
    
    % Validate geometry
    if ~(strcmp(geometry, 'square') || strcmp(geometry, 'circular'))
        error('Geometry must be either "square" or "circular"');
    end
    
    % Calculate miniumum Resistance
	min_resistance = voltage ^ 2 / power;
    
    % Initialize optimization parameters
    best_dipole_moment = 0;
    optimal_design = struct(...
        'turns', 0, ...
        'trace_width', 0, ...
        'inner_diameter', 0, ...
        'dipole_moment', 0, ...
        'total_resistance', 0 ...
    );
    
    % Optimization search space
    turns_range = 1:1000;
    trace_width_range = linspace(0.15, 30, 20) * 10^-3;  % m
	trace_spacing = 0.20 * 10^-3; % m
    
    % Nested optimization function
    for turns = turns_range
        for trace_width = trace_width_range
            % Calculate coil dimensions
			area = 0;
			coil_length = 0;

            if strcmp(geometry, 'circular')
                % Geometric parameters calculation
                for turn = 1:turns
					diameter = max_diameter - (turn - 1) * (2 * trace_spacing + trace_width);
					area = area + diameter ^ 2 * pi / 4;
					coil_length = coil_length + pi * diameter;
				end
                
            else  % square coil
                % Square coil optimization
                for turn = 1:turns
					diameter = max_diameter - (turn - 1) * (2 * trace_spacing + trace_width);
					area = area + diameter ^ 2;
					coil_length = coil_length + 4 * diameter;
				end
			end
            
            % Resistance calculation
            trace_cross_section = trace_width * (0.035 * 10^-3);  % Assuming 35 micron thickness
            trace_length = coil_length * num_layers;
            total_resistance = (trace_length / trace_cross_section) * cu_resistivity;
            
            % NIS (Number of turns * Current * Geometry factor) calculation
            % Simplified magnetic dipole moment calculation
            if diameter > 0
                dipole_moment = min(power / voltage, 1) * area;
                
                % Maximize dipole moment while constraining power and dimensions
                if dipole_moment > best_dipole_moment
                    best_dipole_moment = dipole_moment;
                    
                    optimal_design.turns = turns;
                    optimal_design.trace_width = trace_width;
                    optimal_design.inner_diameter = diameter;
                    optimal_design.dipole_moment = dipole_moment;
                    optimal_design.total_resistance = total_resistance;
                end
            end
        end
    end
    
    % Output results with visualization
    fprintf('Optimal Electromagnet Design:\n');
    fprintf('Turns: %d\n', optimal_design.turns);
    fprintf('Trace Width: %.2f mm\n', optimal_design.trace_width);
    fprintf('Inner Diameter: %.2f mm\n', optimal_design.inner_diameter);
    fprintf('Dipole Moment: %.4e Am²\n', optimal_design.dipole_moment);
    fprintf('Total Resistance: %.2f Ω\n', optimal_design.total_resistance);
    
    % Optional: Plotting results
%     figure;
%     title('PCB Electromagnet Optimization');
%     xlabel('Number of Turns');
%     ylabel('Trace Width (mm)');
%     scatter(optimal_design.turns, optimal_design.trace_width, 'r', 'filled');
end