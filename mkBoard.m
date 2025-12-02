function board = mkBoard(light, dark)
    fig = figure(1);
    clf(fig);
    hold on;
    axis equal off;
    squareSize = 1;

    for row = 1:8
        for col = 1:8
            if mod(row+col,2) == 0
                color = light;
            else
                color = dark;
            end
            rectangle( ...
                'Position', [ ...
                    col-1, ...
                    row-1, ...
                    squareSize, ...
                    squareSize ...
                ],...
                'FaceColor', color, ...
                'EdgeColor', 'none' ...
            );
        end
    end

    xlim([0 8]);
    ylim([0 8]);
    % --- Row 1 -> top, NOT bottom
    set(gca,'YDir','reverse');


    
    % --- Assemble starting positions ---
    % -- W/B Pawns:
    for i = 1:8
        h = mvPiece('w/P', 2, i);
        imageHandler("add", 2, 1, h);

        h = mvPiece('b/P', 7, i);
        imageHandler("add", 7, 1, h);
    end

    for row = [1 8]
        % -- W/B Rooks:
        h = mvPiece('b/R', row, 1);
        imageHandler("add", row, 1, h);
        
        h = mvPiece('w/R', row, 8);
        imageHandler("add", row, 8, h);
        
        % -- W/B Bishops:
        h = mvPiece('b/B', row, 3);
        imageHandler("add", row, 3, h);

        h = mvPiece('w/B', row, 6);
        imageHandler("add", row, 6, h);
        
        % -- W/B Horses:
        h = mvPiece('b/H', row, 2);
        imageHandler("add", row, 2, h);

        h = mvPiece('w/H', row, 7);
        imageHandler("add", row, 7, h);
    end

    % -- W/B Kings:
    h = mvPiece('w/K', 1, 5);
    imageHandler("add", 1, 5, h);

    h = mvPiece('b/K', 8, 5);
    imageHandler("add", 8, 5, h);
    
    % -- W/B Queens:
    h = mvPiece('w/Q', 1, 4);
    imageHandler("add", 1, 4, h);

    h = mvPiece('b/Q', 8, 4);
    imageHandler("add", 8, 4, h);
    
    board = [
            ["bR", "bH", "bB", "bQ", "bK", "bB", "bH", "bR"];
            ["bP", "bP", "bP", "bP", "bP", "bP", "bP", "bP"];
            ["--", "--", "--", "--", "--", "--", "--", "--"];
            ["--", "--", "--", "--", "--", "--", "--", "--"];
            ["--", "--", "--", "--", "--", "--", "--", "--"];
            ["--", "--", "--", "--", "--", "--", "--", "--"];
            ["wP", "wP", "wP", "wP", "wP", "wP", "wP", "wP"];
            ["wR", "wH", "wB", "wQ", "wK", "wB", "wH", "wR"];
     ];
end