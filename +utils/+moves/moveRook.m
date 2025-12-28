function validMoves = moveRook(board, piece, color, captureKing)
    % --- Max possible bishop moves ---
    validMoves = zeros(14,2);
    moveCount = 0;

    r = piece.row;
    c = piece.col;
    enemy = utils.tern(color == 'w', 'b', 'w');

    % [ direction rows, direction columns, max steps ] 
    dirs = [
        -1  0  r-1; % UP
         1  0  8-r; % DOWN
         0 -1  c-1; % LEFT
         0  1  8-c  % RIGHT
    ];

    for d = 1:4
        dr = dirs(d,1);
        dc = dirs(d,2);
        maxSteps = dirs(d,3);

        for i = 1:maxSteps
            nextRow = r + (dr*i);
            nextCol = c + (dc*i);

            nextPiece = board.pieces{nextRow, nextCol};

            % --- Capture enemy piece ---
            if ~isempty(nextPiece) && strcmp(nextPiece.color, enemy)
                if ~strcmp(nextPiece.type, 'K') || captureKing
                    moveCount = moveCount + 1;
                    validMoves(moveCount,:) = [nextRow, nextCol];
                end
                break;
            end

            % --- Stop for friendly piece ---
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
