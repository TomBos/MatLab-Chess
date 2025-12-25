function res = removeBG(imgObj)
        R = imgObj(:,:,1);
        G = imgObj(:,:,2);
        B = imgObj(:,:,3);
        alpha = ones(size(R));
        redMask = R > 0.6 & G < 0.4 & B < 0.4;
        alpha(redMask) = 0;
        
        res = alpha;
end