function validMoves = getMoves(board, r, c, checkControl)
    piece = board.pieces{r,c};
    if isempty(piece)
        validMoves = [];
        return;
    end

    type = piece.type;
    color = piece.color;

    if nargin < 4
        checkControl = false;
    end

    switch type
        case 'K'
            validMoves = utils.moves.moveKing(board, piece, color);
        case 'B'
            validMoves = utils.moves.moveBishop(board, piece, color, checkControl);
        case 'H'
            validMoves = utils.moves.moveHorse(board, piece, color, checkControl);
        case 'P'
            validMoves = utils.moves.movePawn(board, piece, color, checkControl);
        case 'Q'
            validMoves = utils.moves.moveQueen(board, piece, color, checkControl);
        case 'R'
            validMoves = utils.moves.moveRook(board, piece, color, checkControl);
    end
end