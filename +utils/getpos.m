function pos = getpos()
    ax = gca;
    f = ancestor(ax, 'figure');
    pos = [];
    
    function clickCallback(~, ~)
        if ~isgraphics(ax) 
            return;
        end
        
        cp = get(ax, 'CurrentPoint');
        r = floor(cp(1,2)) + 1;
        c = floor(cp(1,1)) + 1;
        
        % --- Only resume if click is inside the 8x8 board ---
        if r >= 1 && r <= 8 && c >= 1 && c <= 8
            pos = [r, c];
            uiresume(f);
        end
    end

    % --- Set the callback ---
    set(f, 'WindowButtonDownFcn', @clickCallback);
    uiwait(f);
    
    if isgraphics(f)
        set(f, 'WindowButtonDownFcn', '');
    end
    
    % --- Prevent game crash ---
    if isempty(pos)
        error('Game window closed by user.');
    end
end