classdef labelUI < handle
    properties
        fig
        digitAxes
        turnAxes
        digitImg
        digits
        alpha
        handle
        turnImg
        turnImgs
    end

    methods
        function obj = labelUI(fig)
            obj.fig = fig;
            obj.createUI();
        end

        function createUI(obj)
            % --- Preload digits ----
            obj.digits = cell(10,1);

            obj.alpha = cell(10,1);
            for i = 0:9
                % --- Read img file and prepare for bg removal ---
                img = im2double(imread(fullfile('digits', i + ".png")));
                
                obj.alpha{i+1} = utils.removeBG(img);
                obj.digits{i+1} = img;
            end

            % --- Preload turns ----
            obj.turnImgs = cell(2,1);
            for t = 1:2
                files = ["w.png","b.png"];
                img = im2double(imread(fullfile('turns', files(t))));
                alphaLayer = utils.removeBG(img);
                obj.turnImgs{t} = struct('CData', img, 'Alpha', alphaLayer);
            end

            % -- Make new axes so this is not tied to the board ---
            obj.digitAxes = axes(obj.fig, ...
                'Units','normalized', ...
                'Position',[0.75 0.85 0.1 0.05], ...
                'Visible','off');

            hold(obj.digitAxes,'on');


            % --- Draw 3-digit counter ---
            obj.handle = gobjects(3,1);
                
            digitOffset = 0;
            for i = 1:3
                obj.handle(i) = image( ...
                    'XData', [(digitOffset + 0.3) (digitOffset + 1)], ...
                    'YData', [0 1], ...
                    'CData', obj.digits{1}, ...
                    'AlphaData', obj.alpha{1} ...
                );
                digitOffset = digitOffset + 1;
            end

            xlim(obj.digitAxes,[0 5]);
            ylim(obj.digitAxes,[0 2]);
            axis(obj.digitAxes,'ij');

            % --- Draw turn image under counter ---
            obj.turnAxes = axes(obj.fig, ...
                'Units','normalized', ...
                'Position',[0.75 0.79 0.1 0.08], ...
                'Visible','off');
            hold(obj.turnAxes,'on');

            obj.turnImg = image(obj.turnAxes, ...
                'XData', [0 1], ...
                'YData', [0 1], ...
                'CData', obj.turnImgs{1}.CData, ...
                'AlphaData', obj.turnImgs{1}.Alpha);

            xlim(obj.turnAxes,[0 2]);
            ylim(obj.turnAxes,[0 2]);
            axis(obj.turnAxes,'ij');
        end

        function updateDigit(obj, digitIndex, number)
            if ~isempty(obj.handle) && isgraphics(obj.handle(digitIndex))
                obj.handle(digitIndex).CData = obj.digits{number + 1};
                obj.handle(digitIndex).AlphaData = obj.alpha{number + 1};
            end
        end

        function updateUiLabels(obj, round)
            % --- !!! This is bad, but it saves performance !!! --- 
            if round < 10
                obj.updateDigit(3, mod(round,10))
            end
            if round < 100
                obj.updateDigit(3, mod(round,10))
                obj.updateDigit(2, floor(mod(round/10, 10)));
            end
            if round < 1000
                obj.updateDigit(3, mod(round,10))
                obj.updateDigit(2, floor(mod(round/10, 10)));
                obj.updateDigit(1, floor(mod(round/100, 10)));
            end
        end

        % --- Update turn ---
        function updateTurn(obj, round)
            idx = utils.tern(mod(round,2) == 0, 1, 2);
            obj.turnImg.CData = obj.turnImgs{idx}.CData;
            obj.turnImg.AlphaData = obj.turnImgs{idx}.Alpha;
        end
    end
end
