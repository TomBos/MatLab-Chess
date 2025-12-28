function [r, c] = findKing(board, color)
    % --- Return row and col of king ---
    for r = 1:8
        for c = 1:8
            p = board.pieces{r,c};
            if ~isempty(p) && strcmp(p.color, color) && strcmp(p.type, 'K')
                return;
            end
        end
    end
end
