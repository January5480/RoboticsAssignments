% 指定图片文件所在的目录
directory = '../实验课数据/校徽拼接乱序/';

% 获取目录下所有.png文件的信息
file_list = dir(fullfile(directory, '*.png'));

% 提取文件名（不包含路径）
image_files = {file_list.name};

% 随机排列索引
rand_indices = randperm(length(image_files));

% 打乱后的图片文件名
shuffled_image_files = image_files(rand_indices);

% 显示打乱后的顺序
disp('打乱后的图片顺序:');
for i = 1:length(shuffled_image_files)
    fprintf('%d. %s\n', i, shuffled_image_files{i});
end

% 重命名文件
for i = 1:length(image_files)
    % 构建原始文件的完整路径
    original_file = fullfile(directory, image_files{i});

    % 构建新文件的完整路径
    new_file = fullfile(directory, shuffled_image_files{i});
    % 检查是否需要移动文件
    if ~strcmp(original_file, new_file)
        % 重命名文件
        movefile(original_file, new_file);
    end
end

disp('文件重命名完成。');