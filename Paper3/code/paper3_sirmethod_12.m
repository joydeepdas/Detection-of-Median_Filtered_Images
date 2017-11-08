clear all;
data_location = 'ucid.v2/';
imagefiles = dir([data_location '*.tif']);
for i = 1:length(imagefiles)
    filename = [data_location imagefiles(i).name];
    images{i}= (imread(filename));
end
count_f=zeros(1338,16);
tif=images;
[~,lengthtif]=size(tif);
for sss=1:lengthtif
I=double(rgb2gray(cell2mat(tif(sss))));
img=I;
img=medfilt2(img,[3 3]);
img=medfilt2(img,[3 3]);
% img=img(176:175+32,176:175+32);
%img=img(184:183+16,184:183+16);
%img=double(uint8(imfilter(img,ones(5)/25)));
%img=double(uint8(imgaussfilt(img,0.5)));
%img=double(uint8(imresize(img,2)));
% img=jpeg(img,70);
% img=img.*255;
% img=double(uint8(img));
[m,n]=size(img);

for i=1:m
    for j=1:n-1
        d(i,j)=img(i,j)-img(i,j+1);
    end
end
% bcoz -ve index is not allowed
d1=d+256;
P11=zeros(255*2+1,255*2+1);
for i=1:m
    for j=1:n-3
        P11(d1(i,j),d1(i,j+2))=P11(d1(i,j),d1(i,j+2))+1;
    end
end

P11=P11./sum(sum(P11));

%% computation
k=1;

%F1
for j=256:511
    count_f(sss,k)= count_f(sss,k)+abs(j-256)*P11(256,j);    
end
k=k+1;
%F2
for i=1:255
    for j=513-i:511
        count_f(sss,k)= count_f(sss,k)+P11(i,j)*abs((i-256))*abs((j-256));
    end
end
k=k+1;
%F3
for i=1:256
    count_f(sss,k)= count_f(sss,k)+abs((i-256))*P11(i,512-i)*abs((i-256));
end
k=k+1;
%F4
for i=1:255
    for j=257:511-i
       count_f(sss,k)= count_f(sss,k)+P11(i,j)*abs((j-256))*abs((i-256));    
    end
end
k=k+1;
%F5
for i=1:256
    count_f(sss,k)= count_f(sss,k)+abs((i-256))*P11(i,256);
    
end
k=k+1;
%F6
for i=1:255
    for  j=i+1:255
        count_f(sss,k)= count_f(sss,k)+P11(i,j)*abs((i-256))*abs((j-256));        
    end
end
k=k+1;
%F7
for i=1:255
   count_f(sss,k)= count_f(sss,k)+P11(i,i)*abs((i-256))*abs((i-256));
    
end
k=k+1;
%F8
for i=1:255
    for j=1:i-1
        count_f(sss,k)=count_f(sss,k)+P11(i,j)*abs((i-256))*abs((j-256));        
    end
end
k=k+1;
%F9
for j=1:255
    count_f(sss,k)= count_f(sss,k)+P11(256,j)*abs((j-256));
end
k=k+1;

%F10
for i=257:511
    for j=1:511-i
       count_f(sss,k)= count_f(sss,k)+abs((i-256))*abs((j-256))*P11(i,j);       
    end
end
k=k+1;
%F11
for i=256:511
    count_f(sss,k)= count_f(sss,k)+P11(i,512-i)*abs((i-256))*abs((i-256));  
end
k=k+1;
%F12
for i=257:511
    for j=513-i:255
        count_f(sss,k)= count_f(sss,k)+P11(i,j)*abs((i-256))*abs((j-256));      
    end
end
k=k+1;
%F13
for i=256:511
    count_f(sss,k)= count_f(sss,k)+P11(i,256)*abs((i-256));   
end
k=k+1;
%F14
for i=257:511
    for j=257:i-1
        count_f(sss,k)= count_f(sss,k)+P11(i,j)*abs((i-256))*abs((j-256));       
    end
end
k=k+1;
%F15
for i=256:511
    count_f(sss,k)= count_f(sss,k)+P11(i,i)*abs((i-256))*abs((i-256));
    
end
k=k+1;
%F16
for i=257:511
    for j=i+1:511
        count_f(sss,k)= count_f(sss,k)+P11(i,j)*abs((i-256))*abs((j-256));        
    end
end
k=k+1;

end


