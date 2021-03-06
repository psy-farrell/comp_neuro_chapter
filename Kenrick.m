% Code for basic example (Figure 3) of 
% Kenrick, D. T. and Li, N. P. and Butner, J. (2003).
% Dynamical evolutionary psychology: individual decision rules and emergent social norms.
% Psychological review, 110, 3--28. 

clear all; close all

gridN = 6; % number of rows and columns (assume square grid)
nReps = 15; % how many cycles to run simulation through

% each row in loc contains the grid coordinates of one of the cell grids
locs = fullfact([gridN gridN]);
locs = locs(:,[2 1]);

%----We can use any starting values we like; here are several useful ones...
% for all below, -ve is hostile, +ve is peaceful
 
% random
%oldState = sign(randn(gridN^2,1));
%oldState = oldState(randperm(gridN^2)); 

% regular pattern; if gridN is even, this gives stripes
oldState = sign(rem(1:(gridN^2),2)-0.5);

% Kenrick Figure 3 starting point
% oldState = [-1 1 -1 -1 1 -1 ...
%     -1 -1 1 1 -1 1 ...
%     1 -1 1 -1 -1 -1 ...
%     -1 1 -1 1 -1 1 ...
%     1 -1 1 1 1 1 ...
%     -1 1 -1 1 -1 1]';

for rep=1:nReps
    
    % show current state and pause until key press
    imagesc(reshape(oldState,gridN,gridN))
    text(1,1,num2str(rep));
    pause;
    
    l=1;
    for row=1:gridN
        for col=1:gridN
            % we locate neighbours based on Euclidian distance
            
            % distance of all cells from target cell (at row,col)
            locDist = sqrt(sum(bsxfun(@minus, [row col], locs).^2,2));
            
            % find the neighbours--exclude target cell
            neighbourInd = locDist>0 & locDist < 2;
            
            % consensus among neighbours
            neighbourAct = sign(sum(oldState(neighbourInd)));
            
            % work out new state based on activity of neighbours
            if (oldState(l) * neighbourAct) < 0
                newState(l) = -1*oldState(l);
            else
                newState(l) = oldState(l);
            end
            l=l+1;
        end
    end

    oldState = newState;
end