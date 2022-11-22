clear all; clc

% Specify files to import
protofile = 'Red_CNN.prototxt';
datafile = 'Red_CNN.caffemodel';
% Import network
net = importCaffeNetwork(protofile, datafile, 'OutputLayerType', 'regression');
% Test
pfile = ['L506_QD_3_1.CT.0003.0035.2015.12.22.20.45.42.541197.358791561.IMA'];
X = dicomread(pfile);
im_input = double(X)/3000;
im_output = net.predict(im_input);
subplot(1,2,1);
imshow(im_input,[850/3000 1250/3000]);
subplot(1,2,2);
imshow(im_output,[850/3000 1250/3000]);