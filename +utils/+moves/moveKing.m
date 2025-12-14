function validMoves = moveKing(board, piece, color)
    % --- Max possible bishop moves ---
    validMoves = zeros(8,2);
    moveCount = 0;

    r = piece.row;
    c = piece.col;
    enemy = utils.tern(color == 'w', 'b', 'w');


    validMoves = validMoves(1:moveCount,:);
end
