function [coordinateStruct] = createCoordinates()
    % CREATECOORDINATES - Generate a structure containing the coordinates of the letters.
    % This function generates a structure containing the coordinates of the
    % letters used. Each letter is represented by a set of coordinates,
    % which are calculated using various trace functions.
    %
    % Output: coordinateStruct - Structure containing coordinates of each letter.
    
    % Define constants
    zOffset = 0.08; 
    numPointsCircle = 32;
    numPointsSegment = 16;

    % Define coordinates for each letter
    
    % Letter 'P'
    pCircle = trace_circumference(numPointsCircle,[0.45 0 0],0.15, 360, 180);
    pSegment = trace_segment(numPointsSegment, [0 0 0], [0.59 0 0]);
    pCoordinates = [pSegment(1,1) pSegment(1,2) zOffset; pSegment; pCircle; pCircle(end,1) pCircle(end,2) zOffset];

    % Letter 'O'
    oCircle = trace_circumference(numPointsCircle*2,[0.15 -0.15 0], 0.15, 0, 360);
    oCoordinates = [oCircle(1,1) oCircle(1,2) zOffset; oCircle; oCircle(end,1) oCircle(end,2) zOffset];

    % Letter 'L'
    lSegment = trace_segment(numPointsSegment, [0.5 0 0], [0 0 0]);
    lCoordinates = [lSegment(1,1) lSegment(1,2) zOffset; lSegment; lSegment(end,1) lSegment(end,2) zOffset];

    % Letter 'I'
    iSegment = trace_segment(numPointsSegment, [0 0 0], [0.3 0 0]);
    iCoordinates = [iSegment(1,1) iSegment(1,2) zOffset; iSegment; iSegment(end,1) iSegment(end,2) zOffset; 0.4 0 zOffset; 0.4 0 0; 0.4 0 zOffset];

    % Letter 'B'
    bCircle = trace_circumference(numPointsCircle,[0.15 0 0],0.15, 180, 360);
    bSegment = trace_segment(numPointsSegment, [0.5 0 0], [0.01 0 0]);
    bCoordinates = [bSegment(1,1) bSegment(1,2) zOffset; bSegment; bCircle; bCircle(end,1) bCircle(end,2) zOffset];

    % Letter 'A'
    aCircle1 = trace_circumference(numPointsCircle,[0.25 -0.125 0],0.125, 90, -90);
    aCircle2 = trace_circumference(numPointsCircle,[0.1 -0.1 0],0.1, 180, 0);
    aSegment1 = trace_segment(numPointsSegment, [0.24 -0.25 0], [0 -0.25 0]);
    aSegment2 = trace_segment(numPointsSegment, [0 -0.24 0], [0 -0.099 0]);
    aSegment3 = trace_segment(numPointsSegment, [0.2 -0.11 0], [0.2 -0.25 0]);
    aCoordinates = [aCircle1(1,1) aCircle1(1,2) zOffset; aCircle1; aSegment1; aSegment2; aCircle2; aSegment3];

    % Organize coordinates into a cell array
    coordinateCell = {
        pCoordinates;
        oCoordinates;
        lCoordinates;
        iCoordinates;
        bCoordinates;
        aCoordinates
    };

    % Create the structure
    coordinateStruct.pCoordinates = coordinateCell{1};
    coordinateStruct.oCoordinates = coordinateCell{2};
    coordinateStruct.lCoordinates = coordinateCell{3};
    coordinateStruct.iCoordinates = coordinateCell{4};
    coordinateStruct.bCoordinates = coordinateCell{5};
    coordinateStruct.aCoordinates = coordinateCell{6};
end
