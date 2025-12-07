classdef piece < handle
    properties
        imgSrc
        row
        col
        size = 0.9
        handle
        firstMove = true
    end

    methods
        function obj = piece(imgSrc, row, col, pieceSize)
            if nargin >= 4
                obj.size = pieceSize;
            end

            if ~endsWith(imgSrc, ".png")
                imgSrc = imgSrc + ".png";
            end

            obj.imgSrc = imgSrc;
            obj.row = row;
            obj.col = col;

            obj.draw();
        end

        function draw(obj)
            img = imread(obj.imgSrc);

            x = obj.col - 1 + (1 - obj.size)/2;
            y = obj.row - 1 + (1 - obj.size)/2;

            obj.handle = image([x x+obj.size], [y y+obj.size], img);
            set(gca,'YDir','reverse');
        end

        function moveTo(obj, row, col)
            obj.row = row;
            obj.col = col;
            obj.updatePosition();
        end

        function updatePosition(obj)
            if isempty(obj.handle) || ~isvalid(obj.handle)
                return;
            end

            x = obj.col - 1 + (1 - obj.size)/2;
            y = obj.row - 1 + (1 - obj.size)/2;

            obj.handle.XData = [x x+obj.size];
            obj.handle.YData = [y y+obj.size];
        end
    end
end
