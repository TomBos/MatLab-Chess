classdef piece < handle
    properties
        ImgSrc
        Row
        Col
        Size = 0.9
        Handle
    end

    methods
        function obj = piece(imgSrc, row, col, pieceSize)
            if nargin >= 4
                obj.Size = pieceSize;
            end

            if ~endsWith(imgSrc, ".png")
                imgSrc = imgSrc + ".png";
            end

            obj.ImgSrc = imgSrc;
            obj.Row = row;
            obj.Col = col;

            obj.draw();
        end

        function draw(obj)
            img = imread(obj.ImgSrc);

            x = obj.Col - 1 + (1 - obj.Size)/2;
            y = obj.Row - 1 + (1 - obj.Size)/2;

            obj.Handle = image([x x+obj.Size], [y y+obj.Size], img);
            set(gca,'YDir','reverse');
        end

        function moveTo(obj, row, col)
            obj.Row = row;
            obj.Col = col;
            obj.updatePosition();
        end

        function updatePosition(obj)
            if isempty(obj.Handle) || ~isvalid(obj.Handle)
                return;
            end

            x = obj.Col - 1 + (1 - obj.Size)/2;
            y = obj.Row - 1 + (1 - obj.Size)/2;

            obj.Handle.XData = [x x+obj.Size];
            obj.Handle.YData = [y y+obj.Size];
        end
    end
end
