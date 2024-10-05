function points = trace_segment(points_number, start_point, end_point)
    % TRACE_SEGMENT - Generate points along a line segment between two 3D points.
    %   points = trace_segment(points_number, start_point, end_point) generates 
    %   a set of points along the line segment between start_point and end_point.
    %   points_number is the number of points to generate.
    %   start_point and end_point are 3-dimensional vectors defining the start 
    %   and end of the line segment, respectively.
    
    % Check if start_point and end_point are 3-dimensional vectors
    if numel(start_point) ~= 3 || numel(end_point) ~= 3
        error('Start and end points must be 3-dimensional vectors.');
    end
    
    % Calculate the direction vector from start_point to end_point
    direction_vector = (end_point - start_point) / norm(end_point - start_point);
    
    % Calculate the distance between start_point and end_point
    distance = norm(end_point - start_point);
    
    % Calculate the coordinates of the points along the segment
    points = zeros(points_number, 3);
    for i = 1:points_number
        % Calculate the position of each point along the segment
        points(i, :) = start_point + direction_vector * ((i - 1) / (points_number - 1)) * distance;
    end
end
