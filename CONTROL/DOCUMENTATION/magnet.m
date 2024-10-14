
layers = 2;
turns = 50;
thickness = 0.1 * turns * 2; % (mm)
n = layers * turns;  % Number of turns 2 * 50
I = 0.1;  % Current (A)

B = 50e-6;  % Earth's magnetic field strength (T)
time = 2  * 60;  % Time (s)
theta = 2 * pi; % One full rotation

J = 6 * ((0.3)^2+(0.1)^2) / 12;  % Moment of inertia of rectangular prism (kg·m²)

A = 0.3 * 0.85;  % Area of the PCB (m²)
m = n * I * A;  % Magnetic dipole moment (A·m²)
    
actual_angular_torque = m * B;  % Angular velocity (rad/s)
actual_angular_acceleration = actual_angular_torque / J;

required_angular_acceleration = 4 * theta / (time ^ 2);
required_torque = J * required_angular_acceleration;

required_angular_acceleration
actual_angular_acceleration