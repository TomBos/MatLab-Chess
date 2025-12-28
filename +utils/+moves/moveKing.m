function validMoves = moveKing(board, piece, color)
    % --- Max possible king moves ---
    validMoves = zeros(8,2);
    moveCount = 0;

    r = piece.row;
    c = piece.col;

    enemy = utils.tern(color == 'w', 'b', 'w');

    % --- King directions ---
    dirs = [
        -1 -1;
        -1  0;
        -1  1;
         0 -1;
         0  1;
         1 -1;
         1  0;
         1  1
    ];

    % --- Find enemy king ---
    [ekr, ekc] = utils.findKing(board, enemy);

    for i = 1:8
        nextR = r + dirs(i,1);
        nextC = c + dirs(i,2);

        if ~utils.inBounds(nextR, nextC)
            continue;
        end

        nextPiece = board.pieces{nextR, nextC};

        if ~isempty(nextPiece) && strcmp(nextPiece.color, color)
            continue;
        end

        % --- Kings cannot touch ---
        if abs(nextR - ekr) <= 1 && abs(nextC - ekc) <= 1
            continue;
        end

        % --- Valid move ---
        moveCount = moveCount + 1;
        validMoves(moveCount,:) = [nextR, nextC];
    end

    % --- Trim ---
    validMoves = validMoves(1:moveCount,:);
end
