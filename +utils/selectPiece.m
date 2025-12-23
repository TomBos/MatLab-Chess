function [piece, r, c] = selectPiece(board)
    while true
        pos = utils.getpos();
        r = pos(1);
        c = pos(2);

        targetColor = utils.tern(mod(board.round,2) == 0, 'w', 'b');
        piece = board.pieces{r, c};

        % --- Check if selected piece exists ---
        if isempty(piece)
            continue;
        end

        % --- Check if selected piece is valid ---
        if ~strcmp(piece.color, targetColor)
            continue;
        end

        break;
    end
end
