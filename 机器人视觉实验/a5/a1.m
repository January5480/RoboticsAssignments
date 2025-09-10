clear all, close all, clc;
%读取Mnist 数据集图像和标签
datapath = "../实验课数据/Mnist/";
filenameImagesTrain = strcat(datapath, "train-images.idx3-ubyte");
filenameLabelsTrain = strcat(datapath, "train-labels.idx1-ubyte");
filenameImagesTest = strcat(datapath, "t10k-images.idx3-ubyte");
filenameLabelsTest = strcat(datapath, "t10k-labels.idx1-ubyte");
XTrain = processMNISTimages(filenameImagesTrain);
YTrain = processMNISTlabels(filenameLabelsTrain);
XTest = processMNISTimages(filenameImagesTest);
YTest = processMNISTlabels(filenameLabelsTest);

layers = [
    imageInputLayer([28 28 1],"Name","imageinput")
    convolution2dLayer([3 3],6,"Name","conv_1","Padding","same")
    tanhLayer("Name","tanh_1")
    maxPooling2dLayer([2 2],"Name","maxpool_1","Padding","same","Stride",[2 2])
    convolution2dLayer([3 3],16,"Name","conv_2","Padding","same")
    tanhLayer("Name","tanh_2")
    maxPooling2dLayer([2 2],"Name","maxpool_2","Padding","same","Stride",[2 2])
    fullyConnectedLayer(120,"Name","fc_1")
    fullyConnectedLayer(84,"Name","fc_2")
    fullyConnectedLayer(10,"Name","fc_3")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];

options = trainingOptions('sgdm', ... %优化器
    'LearnRateSchedule','piecewise', ... %学习率
    'LearnRateDropFactor',0.2, ...
    'LearnRateDropPeriod',5, ...
    'MaxEpochs',20, ... %最大学习整个数据集的次数
    'MiniBatchSize',128, ... %每次学习样本数
    'Plots','training-progress'); %画出整个训练过程
doTraining = true; %是否训练
if doTraining
    trainNet = trainNetwork(XTrain, YTrain,layers,options);
    % 训练网络，XTrain 训练的图片，YTrain 训练的标签，layers 要训练的网
    % 络，options 训练时的参数
end
save Minist_LeNet5 trainNet %训练完后保存模型
yTest = classify(trainNet, XTest); %测试训练后的模型
accuracy = sum(yTest == YTest)/numel(YTest); %模型在测试集的准确率



% 处理MNIST 数据集图像
function X = processMNISTimages(filename)
[fileID,errmsg] = fopen(filename,'r','b');
if fileID < 0
    error(errmsg);
end
magicNum = fread(fileID,1,'int32',0,'b');
if magicNum == 2051
    fprintf('\nRead MNIST image data...\n')
end
numImages = fread(fileID,1,'int32',0,'b');
fprintf('Number of images in the dataset: %6d ...\n',numImages);
numRows = fread(fileID,1,'int32',0,'b');
numCols = fread(fileID,1,'int32',0,'b');
X = fread(fileID,inf,'unsigned char');
X = reshape(X,numCols,numRows,numImages);
X = permute(X,[2 1 3]);
X = X./255;
X = reshape(X, [28,28,1,size(X,3)]);
fclose(fileID);
end
% 处理MNIST 数据集标签
function Y = processMNISTlabels(filename)
[fileID,errmsg] = fopen(filename,'r','b');
if fileID < 0
    error(errmsg);
end
magicNum = fread(fileID,1,'int32',0,'b');
if magicNum == 2049
    fprintf('\nRead MNIST label data...\n')
end
numItems = fread(fileID,1,'int32',0,'b');
fprintf('Number of labels in the dataset: %6d ...\n',numItems);
Y = fread(fileID,inf,'unsigned char');
Y = categorical(Y);
fclose(fileID);
end