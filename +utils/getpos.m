function pos = getpos(ax)
    % Wait for a click and return [row, col]
    pos = [];

    % --- Get parent ---
    ax = gca;
    f = ancestor(ax, 'figure');
    posClick = [];
    
    function clickCallback(~, ~)
        cp = get(ax, 'CurrentPoint');
        posClick = [floor(cp(1,2)) + 1, floor(cp(1,1)) + 1];
        uiresume(f);
    end

    set(f, 'WindowButtonDownFcn', @clickCallback);
    uiwait(f);
    pos = posClick;

    set(f, 'WindowButtonDownFcn', '');
end
