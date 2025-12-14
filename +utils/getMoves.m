function validMoves = getMoves(board, r, c)
    piece = board.pieces{r,c};
    if isempty(piece)
        validMoves = [];
        return;
    end

    type = piece.type;
    color = piece.color;

    switch type
        case 'B'
            validMoves = utils.moves.moveBishop(board, piece, color);
        case 'H'
            validMoves = utils.moves.moveHorse(board, piece, color);
        case 'K'
            validMoves = utils.moves.moveKing(board, piece, color);
        case 'P'
            validMoves = utils.moves.movePawn(board, piece, color);
        case 'Q'
            validMoves = utils.moves.moveQueen(board, piece, color);
        case 'R'
            validMoves = utils.moves.moveRook(board, piece, color);
    end
end