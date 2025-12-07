function pos = getValidMove(validMoves)
    while true
        pos = utils.getpos();
        % Check if clicked pos is in any validMoves
        if any(validMoves(:,1) == pos(1) & validMoves(:,2) == pos(2))
            break;
        end
    end
end
