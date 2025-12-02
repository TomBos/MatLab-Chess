clear;
clc;

% --- Fullscreen window ---
fig = figure;
set(fig, 'WindowState', 'maximized');

% --- Colors ---
light = rgb(235, 236, 208);
dark  = rgb(111, 146, 78);

% --- Draw Board ---
game_state = mkBoard(light, dark);
axis equal;

% --- Start Move ---
pos = getpos();
old_r = pos(1);
old_c = pos(2);

clicked_piece = game_state(old_r,old_c);
display(clicked_piece);

color = "";
piece = "";

chars = split(clicked_piece, "");
chars = chars(2:end-1);

if chars(1) ~= "-"
    color = chars(1);
end

if chars(2) ~= "-"
    piece = chars(2);
end

imgSrc = color + "/" + piece;
display(imgSrc);



pos = getpos();
r = pos(1);
c = pos(2);

display(c);
display(r);

% --- Delete old handle
imageHandler("delete", r, c);

handle = mvPiece(imgSrc, r, c);
imageHandler("add", r, c, handle);

% --- DEBUG -> Highlight clicked square
%{
rectangle( ...
    'Position', [ ...
        r - 1, ...
        c - 1, ...
        1, ...
        1 ...
    ],...
    'FaceColor', 'y', ...
    'EdgeColor', 'none' ...
);
%}

