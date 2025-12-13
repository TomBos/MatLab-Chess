function validMoves = moveRook(board, piece, color)
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

            piece = board.pieces{nextRow, nextCol};

            % --- If next piece is empty or enemy, add it ---
            if isempty(piece)
                moveCount = moveCount + 1;
                validMoves(moveCount,:) = [nextRow, nextCol];
            elseif strcmp(piece.color, enemy)
                moveCount = moveCount + 1;
                validMoves(moveCount,:) = [nextRow, nextCol];
                break;
            elseif strcmp(piece.type, 'K')
                break;
            else
                break;
            end
        end
    end

    validMoves = validMoves(1:moveCount,:);
end
