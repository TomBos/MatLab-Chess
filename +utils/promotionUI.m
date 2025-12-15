function promotionUI(color)
    fig = uifigure('Name','Select Your Piece','Position',[500 500 400 120]);

    pieces = {'Rook','Knight','Bishop','Queen'};
    imgs = {
        color + "/R.png",
        color + "/H.png",
        color + "/B.png",
        color + "/Q.png"
    };

    btnWidth = 80;
    btnHeight = 80;
    spacing = 10;
    xPos = spacing;

    for i = 1:length(pieces)
        % Read image
        img = imread(imgs{i});
        img = im2double(img);

        % --- Detect red for transparency ---
        R = img(:,:,1);
        G = img(:,:,2);
        B = img(:,:,3);
        alpha = ones(size(R));
        redMask = R > 0.6 & G < 0.4 & B < 0.4;
        alpha(redMask) = 0;

        % --- Create axes to hold image ---
        ax = uiaxes(fig, 'Position',[xPos 20 btnWidth btnHeight]);
        image(ax, img, 'AlphaData', alpha);
        ax.XTick = [];
        ax.YTick = [];
        ax.XColor = 'none';
        ax.YColor = 'none';
        axis(ax,'off');

        % --- Set click callback ---
        ax.ButtonDownFcn = @(src,event) pieceSelected(pieces{i});

        xPos = xPos + btnWidth + spacing;
    end
end
