classdef board < handle
    properties
        LightColor
        DarkColor
        Figure
        Ax
        Pieces
        SquareSize = 1
    end

    methods
        function obj = board(light, dark)
            obj.LightColor = light;
            obj.DarkColor = dark;
            obj.Pieces = cell(8, 8);
            obj.initFigure();
            obj.drawBoard();
            obj.spawnPieces();
        end

        function initFigure(obj)
            obj.Figure = figure(1);
            clf(obj.Figure);

            obj.Ax = axes(obj.Figure);
            hold(obj.Ax, 'on');
            axis(obj.Ax, 'equal', 'off');

            set(obj.Ax, 'YDir', 'reverse');
            xlim(obj.Ax, [0 8]);
            ylim(obj.Ax, [0 8]);
        end

        function drawBoard(obj)
            for row = 1:8
                for col = 1:8
                    if mod(row+col,2) == 0
                        color = obj.LightColor;
                    else
                        color = obj.DarkColor;
                    end

                    rectangle(...
                        'Parent', obj.Ax,...
                        'Position', [col-1, row-1, obj.SquareSize, obj.SquareSize], ...
                        'FaceColor', color, ...
                        'EdgeColor', 'none' ...
                    );
                end
            end
        end

        function spawnPieces(obj)
            % Pawns
            for i = 1:8
                obj.addPiece("w/P", 2, i);
                obj.addPiece("b/P", 7, i);
            end

            % Rooks / Knights / Bishops / King / Queen
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
            obj.Pieces{row, col} = p;
        end
    end
end
