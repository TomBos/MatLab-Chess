classdef board < handle
    properties
        lightColor
        darkColor
        figure
        ax
        pieces
        round = 0
        squareSize = 1
        enPassantSquare
    end

    methods
        function obj = board(light, dark)
            obj.lightColor = light;
            obj.darkColor = dark;
            obj.pieces = cell(8, 8);
            obj.initFigure();
            obj.drawBoard();
            obj.spawnPieces();
        end

        function initFigure(obj)
            obj.figure = figure(1);

            obj.ax = axes(obj.figure);
            hold(obj.ax, 'on');
            axis(obj.ax, 'equal', 'off');

            set(obj.ax, 'YDir', 'reverse');
            xlim(obj.ax, [0 8]);
            ylim(obj.ax, [0 8]);
        end

        function drawBoard(obj)
            for row = 1:8
                for col = 1:8
                    if mod(row+col,2) == 0
                        color = obj.lightColor;
                    else
                        color = obj.darkColor;
                    end

                    rectangle(...
                        'Parent', obj.ax,...
                        'Position', [col-1, row-1, obj.squareSize, obj.squareSize], ...
                        'FaceColor', color, ...
                        'EdgeColor', 'none' ...
                    );
                end
            end
        end

        function spawnPieces(obj)
            % --- Pawns --- 
            for i = 1:8
                obj.addPiece("w/P", 2, i);
                obj.addPiece("b/P", 7, i);
            end

            % --- Rooks / Knights / Bishops / King / Queen ---
            obj.addPiece("w/R", 1, 1);
            obj.addPiece("w/H", 1, 2);
            obj.addPiece("w/B", 1, 3);
            obj.addPiece("w/Q", 1, 4);
            obj.addPiece("w/K", 1, 5);
            obj.addPiece("w/B", 1, 6);
            obj.addPiece("w/H", 1, 7);
            obj.addPiece("w/R", 1, 8);

            obj.addPiece("b/R", 8, 1);
            obj.addPiece("b/H", 8, 2);
            obj.addPiece("b/B", 8, 3);
            obj.addPiece("b/Q", 8, 4);
            obj.addPiece("b/K", 8, 5);
            obj.addPiece("b/B", 8, 6);
            obj.addPiece("b/H", 8, 7);
            obj.addPiece("b/R", 8, 8);
        end

        function addPiece(obj, imgCode, row, col)
            p = piece(imgCode, row, col);
            obj.pieces{row, col} = p;
        end
    end
end
