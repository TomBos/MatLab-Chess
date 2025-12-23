function promotion(Board, piece)
    if ~strcmp(piece.type,'P')
        return;
    end

    r = piece.row;
    c = piece.col;
    color = piece.color;
    promotionRow = utils.tern(color == 'w', 8, 1);

    if r == promotionRow
        % --- Promotion UI ---
        newPieceType = utils.promotionUI(color);

        % --- Remove old pawn ---
        delete(Board.pieces{r, c}.handle);

        % --- Add promoted piece ---
        newImgSrc = sprintf('%s/%s.png', color, newPieceType);
        Board.addPiece(newImgSrc, r, c);
    end
end
