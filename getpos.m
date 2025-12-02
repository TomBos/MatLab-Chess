function pos = getpos()
    [x, y] = ginput(1);
    pos = [floor(y) + 1, floor(x) + 1];
end
