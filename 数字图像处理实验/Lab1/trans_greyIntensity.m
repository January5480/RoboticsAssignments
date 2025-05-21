% function [ image2 ] = trans_greyIntensity( image,gray_level )
% %UNTITLED6 此处显示有关此函数的摘要
% %   此处显示详细说明
% reduce = 256/gray_level;
% image2 = fix(image/reduce*255/(gray_level-1));
% 
% end
function reducedImage = trans_greyIntensity(image, numLevels)
    % Validate numLevels as an integer power of 2
    if mod(log2(numLevels), 1) ~= 0 || numLevels < 2 || numLevels > 256
        error('numLevels must be an integer power of 2 between 2 and 256.');
    end
    
    % Normalize the image to the range [0, 1]
    image = double(image) / 255;

    % Scale the image to the range [0, numLevels - 1]
    scaledImage = floor(image * numLevels);

    % Scale back to the range [0, 255] with reduced intensity levels
    reducedImage = uint8(scaledImage * (255 / (numLevels - 1)));

    % Display the original and reduced images for comparison
    figure;
    subplot(1, 2, 1), imshow(image * 255, []), title('Original Image');
    subplot(1, 2, 2), imshow(reducedImage, []), title(['Reduced to ', num2str(numLevels), ' Levels']);
end

