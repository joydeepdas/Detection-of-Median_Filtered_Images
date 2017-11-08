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
img=cell2mat(tif(sss));
img=double(rgb2gray(img));
img=medfilt2(img,[3 3]);
img=jpeg(img,70);
img=img.*255;
img=double(uint8(img));
[m,n]=size(img);
%% 1st difference image
%Pk1
for i=2:m-1
    for j=2:n-1
        pk1d101(i,j)=abs(img(i,j)-img(i,j+1));
        pk1d10_1(i,j)=abs(img(i,j)-img(i,j-1));
        pk1d110(i,j)=abs(img(i,j)-img(i+1,j));
        pk1d1_10(i,j)=abs(img(i,j)-img(i-1,j));
    end
end
%Pk2
for i=2:m-1
    for j=2:n-1
        pk2d111(i,j)=abs(img(i,j)-img(i+1,j+1));
        pk2d11_1(i,j)=abs(img(i,j)-img(i+1,j-1));
        pk2d1_11(i,j)=abs(img(i,j)-img(i-1,j+1));
        pk2d1_1_1(i,j)=abs(img(i,j)-img(i-1,j-1));
    end
end

%% 2nd difference image
%Pk1
for i=3:m-2
    for j=3:n-2
        pk1d201(i,j)=abs(pk1d101(i,j)-pk1d101(i,j+1));
        pk1d20_1(i,j)=abs(pk1d10_1(i,j)-pk1d10_1(i,j-1));
        pk1d210(i,j)=abs( pk1d110(i,j)- pk1d110(i+1,j));
        pk1d2_10(i,j)=abs(pk1d1_10(i,j)-pk1d1_10(i-1,j));
    end
end
%Pk2
for i=3:m-2
    for j=3:n-2
        pk2d211(i,j)=abs(pk2d111(i,j)-pk2d111(i+1,j+1));
        pk2d21_1(i,j)=abs(pk2d11_1(i,j)-pk2d11_1(i+1,j-1));
        pk2d2_11(i,j)=abs(pk2d1_11(i,j)-pk2d1_11(i-1,j+1));
        pk2d2_1_1(i,j)=abs(pk2d1_1_1(i,j)-pk2d1_1_1(i-1,j-1));
    end
end


%% local feature
[m,n]=size(pk1d101);
B=3;
Y1=zeros(B,ceil(m*n/3));k=1;
Y2=zeros(B,ceil(m*n/3));
Y3=zeros(B,ceil(m*n/3));
Y4=zeros(B,ceil(m*n/3));
for i=1:m
    for j=1:B:n-B
        Y1(:,k)=pk1d101(i,j:j+B-1);
        Y2(:,k)=pk1d10_1(i,j:j+B-1);
        Y3(:,k)=pk1d110(i,j:j+B-1);
        Y4(:,k)=pk1d1_10(i,j:j+B-1);
        k=k+1;
    end
end
Y=[Y1 Y2 Y3 Y4];
Y( :, all( ~any( Y ), 1 ) ) = [];
Y=Y';
%covariance
kk=1;
for i=2:B
    for j=1:i-1
        NCC_feature(kk)=corr(Y(:,i),Y(:,j));
        kk=kk+1;
    end
end
%% local feature
[m,n]=size(pk2d111);
B=3;
Y1=zeros(B,ceil(m*n/3));k=1;
Y2=zeros(B,ceil(m*n/3));
Y3=zeros(B,ceil(m*n/3));
Y4=zeros(B,ceil(m*n/3));
for i=1:m
    for j=1:B:n-B
        Y1(:,k)=pk2d111(i,j:j+B-1);
        Y2(:,k)=pk2d11_1(i,j:j+B-1);
        Y3(:,k)=pk2d1_11(i,j:j+B-1);
        Y4(:,k)=pk2d1_1_1(i,j:j+B-1);
        k=k+1;
    end
end
Y=[Y1 Y2 Y3 Y4];
Y( :, all( ~any( Y ), 1 ) ) = [];
Y=Y';
%covariance
for i=2:B
    for j=1:i-1
        NCC_feature(kk)=corr(Y(:,i),Y(:,j));
        kk=kk+1;
    end
end
%% local feature
[m,n]=size(pk1d201);
B=3;
Y1=zeros(B,ceil(m*n/3));k=1;
Y2=zeros(B,ceil(m*n/3));
Y3=zeros(B,ceil(m*n/3));
Y4=zeros(B,ceil(m*n/3));
for i=1:m
    for j=1:B:n-B
        Y1(:,k)=pk1d201(i,j:j+B-1);
        Y2(:,k)=pk1d20_1(i,j:j+B-1);
        Y3(:,k)=pk1d210(i,j:j+B-1);
        Y4(:,k)=pk1d2_10(i,j:j+B-1);
        k=k+1;
    end
end
Y=[Y1 Y2 Y3 Y4];
Y( :, all( ~any( Y ), 1 ) ) = [];
Y=Y';
%covariance

i=1;
for i=2:B
    for j=1:i-1
        NCC_feature(kk)=corr(Y(:,i),Y(:,j));
        kk=kk+1;
    end
end
%% local feature
[m,n]=size(pk2d211);
B=3;
Y1=zeros(B,ceil(m*n/3));k=1;
Y2=zeros(B,ceil(m*n/3));
Y3=zeros(B,ceil(m*n/3));
Y4=zeros(B,ceil(m*n/3));
for i=1:m
    for j=1:B:n-B
        Y1(:,k)=pk2d211(i,j:j+B-1);
        Y2(:,k)=pk2d21_1(i,j:j+B-1);
        Y3(:,k)=pk2d2_11(i,j:j+B-1);
        Y4(:,k)=pk2d2_1_1(i,j:j+B-1);
        k=k+1;
    end
end
Y=[Y1 Y2 Y3 Y4];
Y( :, all( ~any( Y ), 1 ) ) = [];
Y=Y';
%covariance

i=1;
for i=2:B
    for j=1:i-1
        NCC_feature(kk)=corr(Y(:,i),Y(:,j));
        kk=kk+1;
    end
end
feature_local(sss,:)=NCC_feature;  
end
    
           

    
        