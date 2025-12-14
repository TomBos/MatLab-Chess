function validMoves = moveQueen(board, piece, color)
    % --- Max possible bishop moves ---
    % --- TODO: EDIT MAX MOVES ---
    validMoves = zeros(13,2);
    moveCount = 0;

    r = piece.row;
    c = piece.col;
    enemy = utils.tern(color == 'w', 'b', 'w');


    validMoves = validMoves(1:moveCount,:);
end
