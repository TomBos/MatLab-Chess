clear; clc; close;

% --- Fullscreen window ---
fig = figure;
set(fig, 'WindowState', 'maximized');

% --- Colors ---
light = utils.rgb(235, 236, 208);
dark  = utils.rgb(111, 146, 78);

% --- Create Board ---
B = board(light, dark);

while true
    % --- Select piece ---
    [piece, old_r, old_c, new_r, new_c] = utils.selectPiece(B);

    % --- Skip deselected piece ---
    if isempty(piece)
        continue
    end

    % --- Capture enemy piece if present ---
    captured = B.pieces{new_r, new_c};
    if ~isempty(captured)
        delete(captured.handle);
    end

    % --- Update board matrix ---
    B.pieces{new_r, new_c} = piece;
    B.pieces{old_r, old_c} = [];

    % --- Move piece sprite ---
    piece.moveTo(new_r, new_c);
    piece.firstMove = false;

    % --- Handle promotion ---
    utils.promotion(B, piece);

    % --- Next turn ---
    B.round = B.round + 1;
end
