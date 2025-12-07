function validMoves = movePawn(board, piece, color)
    % Returns array of valid coordinates [row col]
    % Max 4 moves: 1-step, 2-step and 2 takes
    validMoves = zeros(4,2);
    moveCount = 0;

    r = piece.row;
    c = piece.col;

    % Get direction
    dir = utils.tern(color == 'w', 1, -1);
    enemy = utils.tern(color == 'w', 'b', 'w');


    % Forward moves
    steps = 1 + piece.firstMove;

    for i = 1:steps
        nextR = r + (dir * i);
        if utils.inBounds(nextR, c) && isempty(board.pieces{nextR, c})
            moveCount = moveCount + 1;
            validMoves(moveCount, :) = [nextR, c];
        else
            break;
        end
    end

    % Trim unused preallocated rows
    validMoves = validMoves(1:moveCount,:);
end