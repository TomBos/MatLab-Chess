function out = imageHandler(method, row, col, h)
    persistent handles;

    if isempty(handles)
        handles = cell(8,8);
    end

    switch method
        case "add"
            handles{row, col} = h;
            out = h;

        case "get"
            out = handles{row, col};

        case "delete"
            if ~isempty(handles{row, col})
                delete(handles{row, col});
                handles{row, col} = [];
            end
            out = [];

        case "reset"
            handles = cell(8,8);
            out = [];

        otherwise
            error("Unknown method: %s", method);
    end
end
