%% =========== MEDIAN FILTERING DETECTION ===========
% Median filtering detection based on characteristics of first order
% difference image and difference between original and other filtering.
% Identification
% Authors: Joydeep Das,IIT ROORKEE.
% Contact: joydeepdas994@gmail.com
% Supervisor: Dr. NITIN KHANNA, Asst prof
%             Dept of Electrical Engineering
%             Indian Institute of Technology, Gandhinagar
% Date: May-July 2016


%Program abstract
%This program implements the h0/h1 streaking artifact from paper
%ON DETECTION OF MEDIAN FILTERING IN DIGITAL IMAGES
%by Kirchnar


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
I=cell2mat(tif(sss));
I=double(rgb2gray(I));
I=medfilt2(I,[3 3]);
% I=jpeg(I,55);
% I=I.*255;
% I=double(uint8(I));
%I=double(uint8(imresize(I,2)));
%I=double(uint8(imfilter(I,ones(5)/25)));
%I=double(uint8(imgaussfilt(I,1.5)));
[m,n]=size(I);c=0;c1=0;
for i=1:m
    for j=1:n-1
        d(i,j)=I(i,j)-I(i,j+1);                                                         
        if d(i,j)==0
            c=c+1;
        end
        if d(i,j)==1
            c1=c1+1;
        end
    end
end
%feature   
m=m-1;
n=n-1;
b=64;
m1=floor(m/b);n1=floor(n/b);
kkkkk=1;
blocks=zeros(b,b,m1*n1);
for i=0:m1-1
    for j=0:n1-1
        for i1=1:b
            for j1=1:b
                if i1+i*b<=m && j1+j*b<=n
                    blocks(i1,j1,kkkkk)=d(i1+i*b,j1+j*b);
                end 
            end
        end
        kkkkk=kkkkk+1;
    end
end

for ii=1:kkkkk-1
    I=blocks(:,:,ii);zerocc=1;onecc=1;
    for i=1:64
        for j=1:64
            if I(i,j)==0
                zerocc=zerocc+1;
            end
             if I(i,j)==1
                onecc=onecc+1;
            end
        end
    end
    w=1-(zerocc/(b*b));
    p=zerocc/onecc;
    pho(ii)=p*w;
end
%p=medfilt1(pho);
med_p(sss)=median(pho);
if med_p(sss)>5
    med_p(sss)=5;
end
end

