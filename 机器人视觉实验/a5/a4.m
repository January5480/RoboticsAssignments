figure('Position', [100, 100, 1200, 800]);
load('Minist_LeNet5');
correct_count = 0;
for i = 0:19
    image_path = ['./test/', num2str(i), '.png'];
    test_image = imread(image_path);
    shape = size(test_image);
    dimension = numel(shape);
    if dimension > 2
        test_image = rgb2gray(test_image); % 灰度化
    end
    test_image = imresize(test_image, [28, 28]); % 调整大小为28×28
    test_image = imbinarize(test_image, 0.5); % 二值化
    test_image = imcomplement(test_image); % 反转，确保背景为黑色，数字为白色
    result = classify(trainNet, test_image)
    subplot(4, 5, i+1);
    imshow(test_image);
    [~, file_name, ~] = fileparts(image_path);
    num = str2double(file_name);
    if num < 10
        true_label = num;
    else
        true_label = num - 10;
    end
    predicted_value = str2double(char(result));
    is_correct = (predicted_value == true_label);
    if is_correct
        correct_count = correct_count + 1;
        title_str = sprintf('预测: %d (✓)', predicted_value);
    else
        title_str = sprintf('预测: %d (✗, 真实: %d)', predicted_value, true_label);
    end
    
    title(title_str, 'FontSize', 10);
    axis off;
end
accuracy = correct_count / 20 * 100;
sgtitle(sprintf('模型准确率: %.2f%%', accuracy), 'FontSize', 16);