classdef imageHandler < handle
    properties
        handles
    end

    methods
        function obj = imageHandler()
            obj.handles = cell(8,8);
        end

        function add(obj, row, col, h)
            obj.handles{row, col} = h;
        end

        function out = get(obj, row, col)
            out = obj.handles{row, col};
        end

        function deleteHandle(obj, row, col)
            if ~isempty(obj.handles{row, col})
                delete(obj.handles{row, col});
                obj.handles{row, col} = [];
            end
        end

        function reset(obj)
            obj.handles = cell(8,8);
        end
    end
end
