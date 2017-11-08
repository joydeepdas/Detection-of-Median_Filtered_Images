I=double(rgb2gray(imread('ucid.v2/ucid01000.tif')));
img=I;
img=medfilt2(img,[3 3]);
[m,n]=size(img);
%img=double(uint8(imfilter(img,ones(3)/9)));
for i=1:m
    for j=1:n-1
        d(i,j)=img(i,j)-img(i,j+1);
    end
end
% bcoz -ve index is not allowed
d1=d+256;
P11=zeros(255*2+1,255*2+1);
for i=1:m
    for j=1:n-2
        P11(d1(i,j),d1(i,j+1))=P11(d1(i,j),d1(i,j+1))+1;
    end
end

P11=P11./(255*255);
P11=P11.^0.05;
P11=imrotate(P11,-90,'bilinear','crop');

imshow(P11);


%% computation
k=1;
count_f=zeros(1,16);
%F1
for j=256:511
    count_f(k)= count_f(k)+abs((j-256))*P11(256,j);
    
end
k=k+1;
%F2
for i=1:255
    for j=513-i:511
        count_f(k)= count_f(k)+P11(i,j)*abs((i-256))*abs((j-256));
    end
end
k=k+1;
%F3
for i=1:255
    count_f(k)= count_f(k)+abs((i-256))*P11(i,512-i)*abs((i-256));
end
k=k+1;
%F4
for i=1:255
    for j=255:511-i
        count_f(k)= count_f(k)+P11(i,j)*abs((j-256))*abs((i-256));
        
    end
end
k=k+1;
%F5
for i=1:256
    count_f(k)= count_f(k)+abs((i-256))*P11(i,256);
    
end
k=k+1;
%F6
for i=1:255
    for  j=i:254
        count_f(k)= count_f(k)+P11(i,j)*abs((i-256))*abs((j-256));
        
    end
end
k=k+1;
%F7
for i=1:254
    count_f(k)= count_f(k)+P11(i,i)*abs((i-256))*abs((i-256));
    
end
k=k+1;
%F8
for i=1:254
    for j=1:i
        count_f(k)= count_f(k)+P11(i,j)*abs((i-256))*abs((j-256));
        
    end
end
k=k+1;
%F9
for j=1:255
    count_f(k)= count_f(k)+P11(256,j)*abs((j-256));
    
    
end

k=k+1;
%F10
for i=257:511
    for j=1:511-i
        count_f(k)= count_f(k)+abs((i-256))*abs((j-256))*P11(i,j);
        
    end
end
k=k+1;
%F11
for i=256:509
    count_f(k)= count_f(k)+P11(i,510-i)*abs((i-256))*abs((i-256));  
end
k=k+1;
%F12
for i=256:510
    for j=511-i:254
        count_f(k)= count_f(k)+P11(i,j)*abs((i-256))*abs((j-256));
        
    end
end
k=k+1;
%F13
for i=255:511
    count_f(k)= count_f(k)+P11(i,256)*abs((i-256));
    
end
k=k+1;
%F14
for i=257:511
    for j=257:i
        count_f(k)= count_f(k)+P11(i,j)*abs((i-256))*abs((j-256));
        
    end
end
k=k+1;
%F15
for i=256:511
    count_f(k)= count_f(k)+P11(i,i)*abs((i-256))*abs((i-256));
    
end
k=k+1;
%F16
for i=257:511
    for j=i+1:511
        count_f(k)= count_f(k)+P11(i,j)*abs((i-256))*abs((j-256));
        
    end
end
k=k+1;




