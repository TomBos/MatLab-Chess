function handle = highlightMoves(validMoves)
    if isempty(validMoves)
        handle = gobjects(0,1);
        return;
    end

    x = validMoves(:,2) - 0.5;
    y = validMoves(:,1) - 0.5;
    
    markerSize = 1500;
    color = utils.rgb(85, 85, 85);
    alpha = 0.6;

    handle = scatter(gca, ...
        x, y, ...
        markerSize, ...
        color, 'filled', ...
        'MarkerFaceAlpha', alpha, ...
        'MarkerEdgeAlpha', 0 ...
    );
end
