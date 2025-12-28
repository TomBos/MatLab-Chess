function [isMate, isStalemate] = endOfLine(board, color)
    % "End of line man"
    % - Clu 
    isMate = false;
    isStalemate = false;
    
    inCheck = utils.kingInCheck(board, color);
    
    for r = 1:8
        for c = 1:8
            piece = board.pieces{r,c};
            if isempty(piece) || piece.color ~= color
                continue;
            end
            
            moves = utils.getMoves(board, r, c, false);
            for i = 1:size(moves,1)
                target_r = moves(i,1);
                target_c = moves(i,2);
                
                % --- save board state ---
                original_start_node = board.pieces{r, c};
                original_end_node   = board.pieces{target_r, target_c};
                
                % --- simulate move ---
                board.pieces{target_r, target_c} = original_start_node;
                board.pieces{r, c} = [];
                
                % --- Check if king is still in check ---
                stillInCheck = utils.kingInCheck(board, color);
                
                % --- undo move ---
                board.pieces{r, c} = original_start_node;
                board.pieces{target_r, target_c} = original_end_node;
                
                % --- if king is safe in one move its not mate ---
                if ~stillInCheck
                    return; 
                end
            end
        end
    end
    
    % --- No valid moves exist ---
    if inCheck
        isMate = true;
    else
        isStalemate = true;
    end
end