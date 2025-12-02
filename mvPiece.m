function handle = mvPiece(imgSrc, row, col, pieceSize)
    if nargin < 4
        pieceSize = 0.9;
    end

    % --- Add .png if not present
    if ~endsWith(imgSrc, ".png")
        imgSrc = imgSrc + ".png";
    end

    img = imread(imgSrc);

    x = col - 1 + (1 - pieceSize)/2;
    y = row - 1 + (1 - pieceSize)/2;

    handle = image([x x+pieceSize], [y y+pieceSize], img);
    set(gca,'YDir','reverse');
end
