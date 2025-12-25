clear; clc; close;

% --- Fullscreen window ---
fig = figure;
set(fig, 'WindowState', 'maximized');

% --- Colors ---
light = utils.rgb(235, 236, 208);
dark  = utils.rgb(111, 146, 78);

% --- Create labels ---
labels = labelUI(fig);

% --- Create Board ---
B = board(light, dark);

while true
    % --- Select piece ---
    [piece, old_r, old_c, new_r, new_c] = utils.selectPiece(B);

    % --- Capture enemy piece if present ---
    captured = B.pieces{new_r, new_c};
    if ~isempty(captured)
        delete(captured.handle);
    end

    % --- en passant capture ---
    if piece.type == 'P' && isequal([new_r, new_c], B.enPassantSquare)
        dir = sign(new_r - old_r);
        captured_r = new_r - dir;
        captured_c = new_c;
        captured = B.pieces{captured_r, captured_c};
        B.pieces{captured_r, captured_c} = [];
        delete(captured.handle);
    end


    % --- Update Board ---
    B.pieces{new_r, new_c} = piece;
    B.pieces{old_r, old_c} = [];

    % --- Move piece sprite ---
    piece.moveTo(new_r, new_c);
    piece.firstMove = false;

    % --- en passant ---
    utils.checkEnPassant(B, piece, new_r, old_r, old_c);
    display(B.enPassantSquare);

    % --- Handle promotion ---
    utils.promotion(B, piece);

    % --- Next turn ---
    B.round = B.round + 1;

    % --- Update UI labels ---
    labels.updateUiLabels(B.round);
    labels.updateTurn(B.round);
end
