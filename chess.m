clear; clc;

% --- Fullscreen window ---
fig = figure;
set(fig, 'WindowState', 'maximized');

% --- Colors ---
light = utils.rgb(235, 236, 208);
dark  = utils.rgb(111, 146, 78);

% --- Create Board ---
B = board(light, dark);

% ============================================================
%  CLICK 1 → SELECT PIECE
% ============================================================

pos = utils.getpos();
old_r = pos(1);
old_c = pos(2);

clicked_piece = B.pieces{old_r, old_c};

if isempty(clicked_piece)
    disp("No piece there.");
    return;
end

%%
validMoves = utils.getMoves(B, old_r, old_c);
display(validMoves);

circleRadius = 0.2;
circleColor = [0.5 0.5 0.5];
circleAlpha = 0.4;

for k = 1:size(validMoves,1)
    row = validMoves(k,1);
    col = validMoves(k,2);

    x = col - 0.5;
    y = row - 0.5;

    rectangle('Position',[x-circleRadius, y-circleRadius, circleRadius*2, circleRadius*2], ...
              'Curvature',[1,1], ...
              'FaceColor',[circleColor, circleAlpha], ...
              'EdgeColor','none', ...
              'Parent', B.ax);
end

%%

fprintf("Selected: %s at [%d,%d]\n", clicked_piece.imgSrc, old_r, old_c);

% ============================================================
%  CLICK 2 → MOVE PIECE
% ============================================================

pos = utils.getpos();
new_r = pos(1);
new_c = pos(2);

fprintf("Move to [%d,%d]\n", new_r, new_c);

% --- If target square has a piece, kill it
if ~isempty(B.pieces{new_r, new_c})
    delete(B.pieces{new_r, new_c}.Handle);
end

% --- Update piece position in the board matrix
B.pieces{new_r, new_c} = clicked_piece;
B.pieces{old_r, old_c} = [];

% --- Move the actual sprite
clicked_piece.moveTo(new_r, new_c);
