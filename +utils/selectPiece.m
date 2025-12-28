function [piece, old_r, old_c, new_r, new_c] = selectPiece(board)
    highlightHandles = [];
    piece = [];
    old_r = [];
    old_c = [];
    
    targetColor = utils.tern(mod(board.round,2)==0, 'w', 'b');
    
    while true
        % --- Get selection ---
        pos = utils.getpos();
        r = pos(1);
        c = pos(2);
        clickedPiece = board.pieces{r, c};
        
        % --- Ignore empty squares or enemy pieces on first click ---
        if isempty(clickedPiece) || ~strcmp(clickedPiece.color, targetColor)
            continue
        end
        
        piece = clickedPiece;
        old_r = r;
        old_c = c;
        
        % --- Get only valid moves ---
        moves = getFilteredMoves(board, old_r, old_c, targetColor);
        
        if ~isempty(highlightHandles)
            delete(highlightHandles);
        end
        highlightHandles = utils.highlightMoves(moves);
        
        % --- Wait for MOVE, SWITCH, or DESELECT ---
        while true
            dest = utils.getpos();
            new_r = dest(1);
            new_c = dest(2);
            
            % --- DESELECT ---
            if isequal([new_r, new_c], [old_r, old_c])
                if ~isempty(highlightHandles)
                    delete(highlightHandles);
                    highlightHandles = [];
                end
                piece = []; old_r = []; old_c = [];
                break 
            end
            
            % --- SWITCH ---
            newPiece = board.pieces{new_r, new_c};
            if ~isempty(newPiece) && strcmp(newPiece.color, targetColor)
                if ~isempty(highlightHandles)
                    delete(highlightHandles);
                end
                piece = newPiece;
                old_r = new_r;
                old_c = new_c;
                
                moves = getFilteredMoves(board, old_r, old_c, targetColor);
                highlightHandles = utils.highlightMoves(moves);
                continue
            end
            
            % --- MOVE ---
            if any(ismember(moves, [new_r, new_c], 'rows'))
                if ~isempty(highlightHandles)
                    delete(highlightHandles);
                    highlightHandles = [];
                end
                return
            end
        end
    end
end

% --- Filter moves that put king in check ---
function legalMoves = getFilteredMoves(board, r, c, color)
    rawMoves = utils.getMoves(board, r, c);
    legalMoves = [];
    movingPiece = board.pieces{r, c};
    
    for i = 1:size(rawMoves, 1)
        tr = rawMoves(i,1); 
        tc = rawMoves(i,2);
        
        % --- Save state ---
        capturedPiece = board.pieces{tr, tc};
        
        % --- Simulate Move ---
        board.pieces{tr, tc} = movingPiece;
        board.pieces{r, c} = [];
        
        % --- Check King ---
        if ~utils.kingInCheck(board, color)
            legalMoves = [legalMoves; tr, tc];
        end
        
        % --- Undo Move ---
        board.pieces{r, c} = movingPiece;
        board.pieces{tr, tc} = capturedPiece;
    end
end