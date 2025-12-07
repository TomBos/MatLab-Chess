clear; clc;

% --- Fullscreen window ---
fig = figure;
set(fig, 'WindowState', 'maximized');

% --- Colors ---
light = utils.rgb(235, 236, 208);
dark  = utils.rgb(111, 146, 78);

% --- Create Board ---
B = board(light, dark);

while true
    % --- Select Piece ---
    [selected_piece, old_r, old_c] = utils.selectPiece(B);
    validMoves = utils.getMoves(B, old_r, old_c);
    circleHandles = utils.highlightMoves(validMoves);

    % ============================================================
    %  CLICK 2 → MOVE PIECE
    % ============================================================

    pos = utils.getValidMove(validMoves);

    if exist('circleHandles','var')
        delete(circleHandles);
    end

    new_r = pos(1);
    new_c = pos(2);

    fprintf("Move to [%d,%d]\n", new_r, new_c);

    % --- If target square has a piece, kill it ---
    if ~isempty(B.pieces{new_r, new_c})
        delete(B.pieces{new_r, new_c}.handle);
    end

    % --- Update piece position in the board matrix ---
    B.pieces{new_r, new_c} = selected_piece;
    B.pieces{old_r, old_c} = [];

    % --- Move the actual sprite ---
    selected_piece.moveTo(new_r, new_c);
    selected_piece.firstMove = false;
end