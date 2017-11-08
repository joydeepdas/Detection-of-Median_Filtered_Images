%% =========== MEDIAN FILTERING DETECTION ===========
% Median filtering detection based on characteristics of first order
% difference image and difference between original and other filtering.
% Identification
% Authors: Joydeep Das,IIT ROORKEE.
% Contact: joydeepdas994@gmail.com,sayan.uec2014@iitr.ac.in
% Supervisor: Dr. NITIN KHANNA, Asst prof
%             Dept of Electrical Engineering
%             Indian Institute of Technology, Gandhinagar
% Date: May-July 2016


%Program abstract
%This program extracts feature from distinguishing average vs median
%filtered image as a last step for decreasing false positive rates.
%Blind Detection of Median Filtering in Digital Images: A Difference Domain Based Approach
%by Chenlong chen


clear all;
data_location = 'ucid.v2/';
imagefiles = dir([data_location '*.tif']);
for i = 1:length(imagefiles)
    filename = [data_location imagefiles(i).name];
    images{i}= (imread(filename));
end
tif=images;
[~,lengthtif]=size(tif);
for sss=1:lengthtif
I=double(rgb2gray(cell2mat(tif(sss))));
img=I;
%img=medfilt2(img,[3 3]);
img=double(uint8(imfilter(img,ones(3)/9)));
[m,n]=size(img);
 for i=1:m
     for j=1:n-1
         d1(i,j)=img(i,j)-img(i,j+1);
     end
 end
 for i=1:m-1
     for j=1:n
         d2(i,j)=img(i,j)-img(i+1,j);
     end
 end
 
 
 
 

 d11=d1+256;
 d22=d2+256;
 P11=zeros(255*2+1,255*2+1);
 P22=zeros(255*2+1,255*2+1);
 total=255*2+1;
 for i=1:m
     for j=1:n-2
         P11(d11(i,j),d11(i,j+1))=P11(d11(i,j),d11(i,j+1))+1;
     end
 end
 
 for i=1:m-2
     for j=1:n
         P22(d22(i,j),d22(i+1,j))=P22(d22(i,j),d22(i+1,j))+1;
     end
 end
 
 
 
 
 
P11=P11/(256*256);   
P11=P11.^0.05;
P11=imrotate(P11,-45,'bilinear','crop');
P11(173:337,225:301)=0;
% 
P22=P22/(256*256);   
P22=P22.^0.05;
P22=imrotate(P22,-135,'bilinear','crop');
P22(173:337,225:301)=0;

figure();
imshow(P11);
% figure();
% imshow(P22);
count1=0;count2=0;
%% horizontal
%1st quadrant
for i=1:256
    for j=1:511
        if P11(i,j)~=0
            count1= count1+abs(256-i)*abs(256-j)/(256*256);
        end
    end
end

%2nd quadrant
for i=256:511
    for j=1:511
        if P11(i,j)~=0
        count2= count2+abs(256-i)*abs(256-j)/(256*256);
        end
    end
end
total_count_h=count1+count2;
%% vertical
count3=0;count4=0;
for i=1:256
    for j=1:511
        if P22(i,j)~=0
            count3= count3+abs(256-i)*abs(256-j)/(256*256);
        end
    end
end

%2nd quadrant
for i=256:511
    for j=1:511
        if P22(i,j)~=0
        count4= count4+abs(256-i)*abs(256-j)/(256*256);
        end
    end
end
total_count_v=count3+count4;

nor=[1 1];
nor=nor./sqrt(sum(nor.*nor));

total_count=[total_count_h total_count_v];
feature_avg(sss)=dot(total_count,nor);
end





