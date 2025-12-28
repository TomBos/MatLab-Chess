function inCheck = kingInCheck(board, color)
    inCheck = false;
    [kr, kc] = utils.findKing(board, color);
    kingPos = [kr kc];
    attackerColor = utils.tern(color == 'w', 'b', 'w');

    for r = 1:8
        for c = 1:8
            piece = board.pieces{r,c};
            if isempty(piece) || piece.color ~= attackerColor
                continue;
            end
            
            % --- Allow "capturing" king ---
            moves = utils.getMoves(board, r, c, true); 
            
            if any(all(moves == kingPos, 2))
                inCheck = true;
                return;
            end
        end
    end
end