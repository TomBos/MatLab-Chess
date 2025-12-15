function [r, c] = findEnemyKing(board, enemyColor)
    % Return row and col of enemy king
    for r = 1:8
        for c = 1:8
            p = board.pieces{r,c};
            if ~isempty(p) && strcmp(p.color, enemyColor) && strcmp(p.type, 'K')
                return;
            end
        end
    end
end
