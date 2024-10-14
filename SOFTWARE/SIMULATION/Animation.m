classdef Animation < handle
	properties
		cube
	end
	methods
		function self = Animation()
			    % Draw a colored cube
    % center: center point of the cube [x, y, z]
    % side_length: length of cube sides
    % R: rotation matrix
		center = [0 0 0];
		side_length = 0.3;
		R = eye(3);

	figure(1);

    vertices = [
        -1 -1 -1;  % Vertex 1
         1 -1 -1;  % Vertex 2
         1  1 -1;  % Vertex 3
        -1  1 -1;  % Vertex 4
        -1 -1  1;  % Vertex 5
         1 -1  1;  % Vertex 6
         1  1  1;  % Vertex 7
        -1  1  1;  % Vertex 8
    ];

    % Define the faces of the cube using the vertex indices
    faces = [
        1 2 3 4;  % Face 1
        5 6 7 8;  % Face 2
        1 2 6 5;  % Face 3
        2 3 7 6;  % Face 4
        3 4 8 7;  % Face 5
        4 1 5 8;  % Face 6
    ];
        
    self.cube = patch('Faces', faces, 'Vertices', vertices, 'FaceColor', 'cyan', 'FaceAlpha', 0.5);

		    % Set view angle
    view(3);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');

	limits = [-1,1] * 5;

		xlim(limits) 
		ylim(limits)
		zlim(limits)

		end
		function update(self,y)
			  % Update cube orientation based on quaternion
    % Update cube orientation based on quaternion
	q0 = y(1);
    q1 = y(2);
    q2 = y(3);
    q3 = y(4);

    % Quaternion rotation matrix
    R = [
        1 - 2*(q2^2 + q3^2), 2*(q1*q2 - q0*q3), 2*(q1*q3 + q0*q2);
        2*(q1*q2 + q0*q3), 1 - 2*(q1^2 + q3^2), 2*(q2*q3 - q0*q1);
        2*(q1*q3 - q0*q2), 2*(q0*q1 + q2*q3), 1 - 2*(q1^2 + q2^2)
    ];

	    vertices = [
        -1 -1 -1;  % Vertex 1
         1 -1 -1;  % Vertex 2
         1  1 -1;  % Vertex 3
        -1  1 -1;  % Vertex 4
        -1 -1  1;  % Vertex 5
         1 -1  1;  % Vertex 6
         1  1  1;  % Vertex 7
        -1  1  1;  % Vertex 8
    ];

	self.cube.Vertices = (R * vertices')'; % Rotate and transpose back to original shape;
  
		end
	end
end