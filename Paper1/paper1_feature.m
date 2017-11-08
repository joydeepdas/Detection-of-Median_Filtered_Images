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
%This program implements count number of zeros from 1st difference image
%FORENSIC DETECTION OF MEDIAN FILTERING IN DIGITAL IMAGES
%by gang Cao

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
    img=rgb2gray(img);
    h=ones(5,5)/25;
   imgmf=jpeg(img,95);
   imgmf=imgmf.*255;
   imgmf=uint8(imgmf);
[m,n]=size(imgmf);
NHOOD=ones(9);

stdeviationori = stdfilt(img, NHOOD);
varianceori =stdeviationori .^2;

stdeviationmf = stdfilt(imgmf, NHOOD);
variancemf =stdeviationmf .^2;


varori=zeros(m-1,n-1);
for i=2:m-1
    for j=2:n-1
        if varianceori (i,j)>=100
            varori(i,j)=1;
        end
    end
end


varmf=zeros(m-1,n-1);
for i=2:m-1
    for j=2:n-1
        if variancemf (i,j)>=100
            varmf(i,j)=1;
        end
    end
end

%horizontal 1st difference
Irori=zeros(m-1,n-1);
for i=2:m-1
    for j=2:n-1
        if img(i,j+1)>img(i,j)
        if img(i,j+1)-img(i,j)==0
            Irori(i,j)=1;
        end
        else  
            if img(i,j)-img(i,j+1)==0
            Irori(i,j)=1;
            end
        end 
    end
end
Irmf=zeros(m-1,n-1);
for i=2:m-1
    for j=2:n-1
        if imgmf(i,j+1)>imgmf(i,j)
        if imgmf(i,j+1)-imgmf(i,j)==0
            Irmf(i,j)=1;
        end
        else  
            if imgmf(i,j)-imgmf(i,j+1)==0
            Irmf(i,j)=1;
            end
        end 
    end
end

%vertical 1st difference
vIrori=zeros(m-1,n-1);
for i=2:m-1
    for j=2:n-1
        if img(i+1,j)>img(i,j)
        if img(i+1,j)-img(i,j)==0
            vIrori(i,j)=1;
        end
        else  
            if img(i,j)-img(i+1,j)==0
            vIrori(i,j)=1;
            end
        end 
    end
end
vIrmf=zeros(m-1,n-1);
for i=2:m-1
    for j=2:n-1
        if imgmf(i+1,j)>imgmf(i,j)
        if imgmf(i+1,j)-imgmf(i,j)==0
            vIrmf(i,j)=1;
        end
        else  
            if imgmf(i,j)-imgmf(i+1,j)==0
            vIrmf(i,j)=1;
            end
        end 
    end
end

%diagonal-down 1st difference
Irorid2=zeros(m-1,n-1);
for i=2:m-1
    for j=2:n-1
        if img(i+1,j+1)>img(i,j)
        if img(i+1,j+1)-img(i,j)==0
            Irorid2(i,j)=1;
        end
        else  
            if img(i,j)-img(i+1,j+1)==0
            Irorid2(i,j)=1;
            end
        end 
    end
end
Irmfd2=zeros(m-1,n-1);
for i=2:m-1
    for j=2:n-1
        if imgmf(i+1,j+1)>imgmf(i,j)
        if imgmf(i+1,j+1)-imgmf(i,j)==0
            Irmfd2(i,j)=1;
        end
        else  
            if imgmf(i,j)-imgmf(i+1,j+1)==0
            Irmfd2(i,j)=1;
            end
        end 
    end
end

%diagonal-up 1st difference
Irorid1=zeros(m-1,n-1);
for i=2:m-1
    for j=2:n-1
        if img(i-1,j+1)>img(i,j)
        if img(i-1,j+1)-img(i,j)==0
            Irorid1(i,j)=1;
        end
        else  
            if img(i,j)-img(i-1,j+1)==0
            Irorid1(i,j)=1;
            end
        end 
    end
end
Irmfd1=zeros(m-1,n-1);
for i=2:m-1
    for j=2:n-1
        if imgmf(i-1,j+1)>imgmf(i,j)
        if imgmf(i-1,j+1)-imgmf(i,j)==0
           Irmfd1(i,j)=1;
        end
        else  
            if imgmf(i,j)-imgmf(i-1,j+1)==0
            Irmfd1(i,j)=1;
            end
        end 
    end
end

% feature original
fd2(sss)=sum(sum(varori.*Irorid2))/sum(sum(varori));
fd1(sss)=sum(sum(varori.*Irorid1))/sum(sum(varori));

%% feature median
fd2mf(sss)=sum(sum(varmf.*Irmfd2))/sum(sum(varmf));
fd1mf(sss)=sum(sum(varmf.*Irmfd1))/sum(sum(varmf));



% %% feature original
fr(sss)=sum(sum(varori.*Irori))/sum(sum(varori));
fc(sss)=sum(sum(varori.*vIrori))/sum(sum(varori));

%% feature median
frmf(sss)=sum(sum(varmf.*Irmf))/sum(sum(varmf));
fcmf(sss)=sum(sum(varmf.*vIrmf))/sum(sum(varmf));


f=[fr(sss) fc(sss) fd1(sss) fd2(sss)];
ff=[frmf(sss) fcmf(sss) fd1mf(sss) fd2mf(sss)];
nor=[6 6 4 4]./sqrt(104);

% 
fori(sss)=dot(f,nor);
fmf(sss)=dot(ff,nor);

end
