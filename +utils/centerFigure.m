function centerFigure(fig)
        drawnow
        screenSize = get(0,'ScreenSize');

        % --- X axis ---
        % --- Give offset so the UI selection doesnt cover screen (0.1 = 10%) ---
        offsetX = -0.4 * screenSize(3);
        fig.Position(1) = ((screenSize(3) - fig.Position(3)) / 2) + offsetX;

        % --- Y axis ---
        fig.Position(2) = (screenSize(4) - fig.Position(4)) / 2;
end
