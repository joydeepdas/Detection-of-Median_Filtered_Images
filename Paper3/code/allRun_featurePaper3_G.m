%% code which can save all the features for images like Gauss ,original in
% one one run 

clear all;
data_location = 'ucid.v2/';
imagefiles = dir([data_location '*.tif']);
for i = 1:length(imagefiles)
    filename = [data_location imagefiles(i).name];
    images{i}= (imread(filename));
end
tif=images;
[~,lengthtif]=size(tif);
images=cell(1,1338);
for i=1:1
    if i==1
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            images{sss}=img;
        end
        feature=GlobalFeature_p3(images);
        filename='original_GF';
        save(filename,feature);
    end
    if i==2
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=medfilt2(img,[3 3]);
            images{sss}=img;
        end
        feature=GlobalFeature_p3(images);
        filename='med3w_GF';
        save(filename,feature);
    end
    if i==3
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=medfilt2(img,[5 5]);
            images{sss}=img;
        end
        feature=GlobalFeature_p3(images);
        filename='med5w_GF';
        save(filename,feature);
    end
    if i==4
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=medfilt2(img,[7 7]);
            images{sss}=img;
        end-
        feature=GlobalFeature_p3(images);
        filename='med7w_GF';
        save(filename,feature);
    end
    if i==5
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=double(uint8(imfilter(img,ones(3,3)./9)));
            images{sss}=img;
        end
        feature=GlobalFeature_p3(images);
        filename='avg3w_GF';
        save(filename,feature);
    end
     if i==6
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=double(uint8(imfilter(img,ones(5,5)./25)));
            images{sss}=img;
        end
        feature=GlobalFeature_p3(images);
        filename='avg5w_GF';
        save(filename,feature);
    end
    if i==7
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=double(uint8(imgaussfilt(img,0.5)));
            images{sss}=img;
        end
        feature=GlobalFeature_p3(images);
        filename='gauss05_GF';
        save(filename,feature);
    end
    if i==8
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=double(uint8(imgaussfilt(img,1.5)));
            images{sss}=img;
        end
        feature=GlobalFeature_p3(images);
        filename='gauss15_GF';
        save(filename,feature);
    end
     if i==9
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=double(uint8(imresize(img,0.6)));
            images{sss}=img;
        end
        feature=GlobalFeature_p3(images);
        filename='bsc06_GF';
        save(filename,feature);
    end
end
        