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
            img=jpeg(img,70);
            img=img.*255;
            img=double(uint8(img));
            images{sss}=img;
        end
        feature=LocalFeature_p3(images);
        filename='original_LF_jpeg70';
        save(filename,feature);
    end
    if i==2
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=medfilt2(img,[3 3]);
            img=jpeg(img,70);
            img=img.*255;
            img=double(uint8(img));
            images{sss}=img;
        end
        feature=LocalFeature_p3(images);
        filename='med3w_LF_jpeg70';
        save(filename,feature);
    end
    if i==3
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=medfilt2(img,[5 5]);
            img=jpeg(img,70);
            img=img.*255;
            img=double(uint8(img));
            images{sss}=img;
        end
        feature=LocalFeature_p3(images);
        filename='med5w_LF_jpeg70';
        save(filename,feature);
    end
    if i==4
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=double(uint8(imfilter(img,ones(3,3)./9)));
            img=jpeg(img,70);
            img=img.*255;
            img=double(uint8(img));
            images{sss}=img;
        end
        feature=LocalFeature_p3(images);
        filename='avg3w_LF_jpeg70';
        save(filename,feature);
    end
     if i==5
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=double(uint8(imfilter(img,ones(5,5)./25)));
            img=jpeg(img,70);
            img=img.*255;
            img=double(uint8(img));
            images{sss}=img;
        end
        feature=LocalFeature_p3(images);
        filename='avg5w_LF_jpeg70';
        save(filename,feature);
    end
    if i==6
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=double(uint8(imgaussfilt(img,0.5)));
            img=jpeg(img,70);
            img=img.*255;
            img=double(uint8(img));
            images{sss}=img;
        end
        feature=LocalFeature_p3(images);
        filename='gauss05_LF_jpeg70';
        save(filename,feature);
    end
    if i==7
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=double(uint8(imgaussfilt(img,1.5)));
            img=jpeg(img,70);
            img=img.*255;
            img=double(uint8(img));
            images{sss}=img;
        end
        feature=LocalFeature_p3(images);
        filename='gauss15_LF_jpeg70';
        save(filename,feature);
    end
     if i==8
        for sss=1:lengthtif
            img=cell2mat(tif(sss));
            img=double(rgb2gray(img));
            img=double(uint8(imresize(img,0.6)));
            img=jpeg(img,70);
            img=img.*255;
            img=double(uint8(img));
            images{sss}=img;
        end
        feature=LocalFeature_p3(images);
        filename='bsc06_LF_jpeg70';
        save(filename,feature);
    end
end
        