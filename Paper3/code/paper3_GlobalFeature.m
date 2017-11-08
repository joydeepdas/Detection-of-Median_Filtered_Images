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
%img=medfilt2(img,[3 3]);
img=medfilt2(img,[3 3]);
img=jpeg(img,70);
img=img.*255;
[m,n]=size(img);
PK=[];
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



for i1=0:10
    count_pk1=0;count_pk2=0;d2count_pk1=0;d2count_pk2=0;
  for i=3:m-2
    for j=3:n-2
            %d1pk1
            if pk1d101(i,j) <=i1
                count_pk1=count_pk1+1;
            end
            if pk1d10_1(i,j) <=i1
                 count_pk1=count_pk1+1;
            end
            if pk1d110(i,j) <=i1
                 count_pk1=count_pk1+1;
            end
            if pk1d1_10(i,j)  <=i1
                 count_pk1=count_pk1+1;
            end
             %d1pk2
              
            if  pk2d111(i,j)<=i1
                count_pk2=count_pk2+1;
            end
            if pk2d11_1(i,j)<=i1
                count_pk2=count_pk2+1;
            end
            if pk2d1_11(i,j)<=i1
                count_pk2=count_pk2+1;
            end
            if pk2d1_1_1(i,j)<=i1
                count_pk2=count_pk2+1;
            end  
            %d2pk1
            if pk1d201(i,j) <=i1
                d2count_pk1= d2count_pk1+1;
            end
            if pk1d20_1(i,j) <=i1
                 d2count_pk1= d2count_pk1+1;
            end
            if pk1d210(i,j) <=i1
                 d2count_pk1= d2count_pk1+1;
            end
            if pk1d2_10(i,j)  <=i1
                 d2count_pk1= d2count_pk1+1;
            end
            %d2pk2
            if  pk2d211(i,j)<=i1
                d2count_pk2=d2count_pk2+1;
            end
          
            if pk2d21_1(i,j)<=i1
                d2count_pk2=d2count_pk2+1;
            end
            if pk2d2_11(i,j)<=i1
                d2count_pk2=d2count_pk2+1;
            end
            if pk2d2_1_1(i,j)<=i1
                d2count_pk2=d2count_pk2+1;
            end    
        end
    end
    
    PKd1=[count_pk1 count_pk2]*.25;
    PKd2=[d2count_pk1 d2count_pk2]*.25;
    [m,n]=size(img);
    PK=[PK PKd1(1)/(m*n) PKd1(2)/(m*n) PKd2(1)/(m*n) PKd2(2)/(m*n)];
end

feature_paper3(sss,:)=PK;
end



