function validMoves = moveHorse(board, piece, color)
    % --- Max possible horse moves ---
    validMoves = zeros(8,2);
    moveCount = 0;

    r = piece.row;
    c = piece.col;
    enemy = utils.tern(color == 'w', 'b', 'w');

    % --- Horse offsets ---
    offsets = [
         2  1;
         2 -1;
        -2  1;
        -2 -1;
         1  2;
         1 -2;
        -1  2;
        -1 -2
    ];

    for i = 1:8
        nextRow = r + offsets(i,1);
        nextCol = c + offsets(i,2);

        % --- Check board ---
        if ~utils.inBounds(nextRow, nextCol)
            continue;
        end

        nextPiece = board.pieces{nextRow, nextCol};

        % --- Dont capture king ---
        if ~isempty(nextPiece) && strcmp(nextPiece.type, 'K')
            continue;
        end

        % --- Empty or enemy ---
        if isempty(nextPiece) || strcmp(nextPiece.color, enemy)
            moveCount = moveCount + 1;
            validMoves(moveCount,:) = [nextRow, nextCol];
        end
    end

    validMoves = validMoves(1:moveCount,:);
end
