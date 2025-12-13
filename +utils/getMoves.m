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
            doSomething(color);
        case 'H'
            doSomething(color);
        case 'K'
            doSomething(color);
        case 'P'
            validMoves = utils.moves.movePawn(board, piece, color);
        case 'Q'
            doSomething(color);
        case 'R'
            validMoves = utils.moves.moveRook(board, piece, color);
    end
end