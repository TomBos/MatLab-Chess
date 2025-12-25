classdef piece < handle
    properties
        imgSrc
        row
        col
        handle
        color
        type
        size = 0.9
        firstMove = true
        doubleMove
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

            % --- Get 'w' or 'b' ---
            imgChar = char(imgSrc);
            obj.color = imgChar(1);
            
            % --- Get piece type from src example: (w/P) ---
            obj.type = imgChar(3);

            obj.draw();
        end

        function draw(obj)
            img = imread(obj.imgSrc);
            img = im2double(img);

            % --- Remove BG ---
            alpha = utils.removeBG(img);

            x = obj.col - 1 + (1 - obj.size)/2;
            y = obj.row - 1 + (1 - obj.size)/2;

            % --- Draw image with transparency ---
            obj.handle = image( ...
                'XData', [x x+obj.size], ...
                'YData', [y y+obj.size], ...
                'CData', img, ...
                'AlphaData', alpha ...
            );

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
