function [piece, r, c] = selectPiece(board)
    while true
        pos = utils.getpos();
        r = pos(1);
        c = pos(2);

        piece = board.pieces{r, c};
        if ~isempty(piece)
            break;
        end
    end
end
