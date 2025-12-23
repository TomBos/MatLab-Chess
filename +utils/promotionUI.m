function pieceType = promotionUI(color)
    % --- Give starting position negative offset ---
    % --- Than bring it to middle of screen ---
    position = [
        -400 ...
        -120 ...
        400  ...
        120  ...
    ];

    fig = uifigure('Name','Select Your Piece','Position', position);
    fig.UserData = [];
    utils.centerFigure(fig);



    pieces = {'R','K','B','Q'};
    imgs = {
        color + "/R.png";
        color + "/H.png";
        color + "/B.png";
        color + "/Q.png"
    };

    btnWidth = 80;
    btnHeight = 80;
    spacing = 10;
    xPos = spacing;

    for i = 1:length(pieces)
        % --- Read image --- 
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
        hImg = image(ax, img, 'AlphaData', alpha);
        hImg.ButtonDownFcn = @(~,~) selectPiece(pieces{i});
        hImg.PickableParts = 'all';
        hImg.HitTest = 'on';
        axis(ax,'off');
        ax.XTick = [];
        ax.YTick = [];


        % --- Set click callback ---
        ax.ButtonDownFcn = @(src,event) selectPiece(pieces{i});

        xPos = xPos + btnWidth + spacing;
    end

    % --- Wait for action --
    uiwait(fig);

    pieceType = fig.UserData;
    delete(fig);

    function selectPiece(p)
        fig.UserData = p;
        uiresume(fig);
    end
end
