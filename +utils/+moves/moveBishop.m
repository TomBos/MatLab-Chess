function validMoves = moveBishop(board, piece, color)
    % --- Max possible bishop moves ---
    validMoves = zeros(13,2);
    moveCount = 0;

    r = piece.row;
    c = piece.col;
    enemy = utils.tern(color == 'w', 'b', 'w');

    % [ direction rows, direction columns, max steps ] 
    dirs = [
        -1 -1  min(r-1, c-1);     % UP-LEFT
        -1  1  min(r-1, 8-c);     % UP-RIGHT
         1 -1  min(8-r, c-1);     % DOWN-LEFT
         1  1  min(8-r, 8-c)      % DOWN-RIGHT
    ];

    for d = 1:4
        dr = dirs(d,1);
        dc = dirs(d,2);
        maxSteps = dirs(d,3);

        for i = 1:maxSteps
            nextRow = r + (dr*i);
            nextCol = c + (dc*i);

            nextPiece = board.pieces{nextRow, nextCol};

            % --- Stop if next piece is king ---
            if ~isempty(nextPiece) && strcmp(nextPiece.type, 'K')
                break;
            end

            % --- Capture enemy ---
            if ~isempty(nextPiece) && strcmp(nextPiece.color, enemy)
                moveCount = moveCount + 1;
                validMoves(moveCount,:) = [nextRow, nextCol];
                break;
            end

            % --- Stop on friendly piece ---
            if ~isempty(nextPiece)
                break;
            end

            % --- Empty square ---
            moveCount = moveCount + 1;
            validMoves(moveCount,:) = [nextRow, nextCol];
        end
    end

    validMoves = validMoves(1:moveCount,:);
end
