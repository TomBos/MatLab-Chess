function checkEnPassant(Board, piece, new_r, old_r, c)
    if piece.type ~= 'P'
        return;
    end    

    % --- +1 for white, -1 for black ---
    direction = sign(new_r - old_r);  

    if abs(new_r - old_r) == 2
        piece.doubleMove = true;
        Board.enPassantSquare = [old_r + direction, c];
    else
        piece.doubleMove = false;
        Board.enPassantSquare = [];
    end
end
