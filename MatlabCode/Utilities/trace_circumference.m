function points = trace_circumference(points_number, center, radius, start_angle, end_angle)
    % TRACE_CIRCUMFERENCE - Generate points along the circumference of a circle.
    %   points = trace_circumference(points_number, center, radius, start_angle, end_angle) 
    %   generates a set of points along the circumference of a circle.
    %   points_number is the number of points to generate.
    %   center is a 3-dimensional vector defining the center of the circle.
    %   radius is the radius of the circle.
    %   start_angle and end_angle define the range of angles (in degrees) 
    %   to generate points on the circumference.

    % Check if center is a 3-dimensional vector
    if numel(center) ~= 3
        error('Center point must be a 3-dimensional vector.');
    end

    % Convert angles from degrees to radians
    start_angle = deg2rad(start_angle);
    end_angle = deg2rad(end_angle);

    % Angles to generate points on the circumference
    theta = linspace(start_angle, end_angle, points_number); 

    % Calculate the coordinates of the points
    points = [center(1) + radius*cos(theta);
              center(2) + radius*sin(theta);
              repmat(center(3), 1, points_number)]';
end
