function validMoves = getMoves(board, r, c)
    piece = board.pieces{r,c};
    if isempty(piece)
        validMoves = [];
        return;
    end

    % Convert to char and get type and color
    img = char(piece.imgSrc);
    type = img(3);
    color = img(1);

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
            doSomething(color);
    end
end