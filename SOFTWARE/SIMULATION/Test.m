% Define symbolic variables
syms q1 q2 q3 q4 wx wy wz real
syms Ixx Iyy Izz mx my mz real

% Define state vector and input vector
x = [q1; q2; q3; q4; wx; wy; wz];
u = [mx; my; mz];
I = diag([Ixx, Iyy, Izz]);  % Inertia matrix

% Define quaternion
q = [q1; q2; q3; q4];

% Define quaternion dynamics (q_dot = 0.5 * q * omega)
omega = [wx; wy; wz];
Omega = [ 0, -wx, -wy, -wz;
          wx,  0,  wz, -wy;
          wy, -wz,  0,  wx;
          wz,  wy, -wx,  0];
q_dot = 0.5 * Omega * q;

% Angular dynamics (omega_dot = I^-1 * (u - omega x (I * omega)))
omega_dot = inv(I) * (u - cross(omega, I * omega));

% Define the full state dynamics f(x, u)
f = [q_dot; omega_dot];

% Compute Jacobians
A = jacobian(f, x);  % A matrix (partial derivative of f with respect to x)
B = jacobian(f, u);  % B matrix (partial derivative of f with respect to u)

% Simplify the expressions
A = simplify(A);
B = simplify(B);

% Display the result
disp('A matrix:');
disp(A);

disp('B matrix:');
disp(B);