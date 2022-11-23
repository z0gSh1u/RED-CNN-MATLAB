clear all; clc

% Specify files to import
protofile = 'Red_CNN.prototxt';
datafile = 'Red_CNN.caffemodel';
% Import network
net = importCaffeNetwork(protofile, datafile, 'OutputLayerType', 'regression');
% Test
rescale = 3000;
inDir = '../RawLow100kV';
outDir = '../LowREDCNN';
pfiles = dir(strcat(inDir, '/*.IMA'));

f = waitbar(0, 'Please wait...');
for i = 1:size(pfiles, 1)
    waitbar(i / size(pfiles, 1), f, 'Processing your data');
    X = dicomread(strcat(inDir, '/', pfiles(i).name));
    im_input = double(X) / rescale;
    im_output = net.predict(im_input) * rescale;
    fTIF = Fast_Tiff_Write(strcat(outDir, '/', num2str(i), '.tif'));
    fTIF.WriteIMG(im_output');
    fTIF.close;
end
delete(f);
