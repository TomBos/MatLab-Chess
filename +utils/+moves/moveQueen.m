function validMoves = moveQueen(board, piece, color, captureKing)
    % --- Max possible queen moves (rook + bishop)
    validMoves = zeros(27,2);
    moveCount = 0;

    r = piece.row;
    c = piece.col;
    enemy = utils.tern(color == 'w', 'b', 'w');

    % --- 8 directions ---
    dirs = [
        -1  0  r-1;           % UP
         1  0  8-r;           % DOWN
         0 -1  c-1;           % LEFT
         0  1  8-c;           % RIGHT
        -1 -1  min(r-1,c-1);  % UP-LEFT
        -1  1  min(r-1,8-c);  % UP-RIGHT
         1 -1  min(8-r,c-1);  % DOWN-LEFT
         1  1  min(8-r,8-c)   % DOWN-RIGHT
    ];

    for d = 1:8
        for step = 1:dirs(d,3)
            nextR = r + dirs(d,1) * step;
            nextC = c + dirs(d,2) * step;

            nextPiece = board.pieces{nextR, nextC};

            % --- Empty ---
            if isempty(nextPiece)
                moveCount = moveCount + 1;
                validMoves(moveCount,:) = [nextR, nextC];
                continue;
            end

            if strcmp(nextPiece.color, color)
                break;
            end

            % --- Enemy ---
            if strcmp(nextPiece.color, enemy)
                if ~strcmp(nextPiece.type, 'K') || captureKing
                    moveCount = moveCount + 1;
                    validMoves(moveCount,:) = [nextR, nextC];
                end
                break;
            end
        end
    end

    % --- Trim unused rows ---
    validMoves = validMoves(1:moveCount,:);
end
