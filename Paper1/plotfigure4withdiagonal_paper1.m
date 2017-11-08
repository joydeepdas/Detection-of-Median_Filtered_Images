clear all;
fyori=importdata('fig4withdiagonal/foriwithdia1338.mat');
fymf3 =importdata('fig4withdiagonal/w3withdiagonalmf1338.mat');
fymf5 =importdata('fig4withdiagonal/w5withdiagonalmf1338.mat');
fymf7 =importdata('fig4withdiagonal/w7withdiagonalmf1338.mat');
fymf9 =importdata('fig4withdiagonal/w9withdiagonalmf1338.mat');
fybsc06=importdata('fig4withdiagonal/fmfbsc061338.mat');
fybsc2=importdata('fig4withdiagonal/fmfbsc21338.mat');
fygauss05=importdata('fig4withdiagonal/fmfgauss05withdia.mat');
fygauss15=importdata('fig4withdiagonal/fmfgauss15withdia.mat');
fymfavg3=importdata('fig4withdiagonal/fmfavg3withdia.mat');
fymfavg5=importdata('fig4withdiagonal/fmf5avg1338.mat');
fymf55jpeg=importdata('fig4withdiagonal/fmfjpeg55withdia.mat');
fymf75jpeg=importdata('fig4withdiagonal/fmfjpeg75withdia.mat');
fymf95jpeg=importdata('fig4withdiagonal/fmfjpeg95withdia.mat');

% fymfsc06=importdata('featuremfbsc061338.mat');
% fymfsc2=importdata('featuremf2bsc1338.mat');
% fymfgauss05=importdata('featuremf05gauss1338.mat');
% fymfgauss15=importdata('featuremf15gauss1338.mat');
% fymfavg3=importdata('featuremf3avg1338.mat');
% fymfavg5=importdata('featuremf5avg1338.mat');
% fymf55jpeg=importdata('featuremf55jpeg1338.mat');
% fymf75jpeg=importdata('featuremf75jpeg1338.mat');
% fymf95jpeg=importdata('featuremf95jpeg1338.mat');

for i=1:14
    for j=1:1338
        fx(i,j)=1338*(i-1)+j;
    end
end


plot(fx(1,:),fyori,'k.',fx(2,:),fymf3,'r+',fx(3,:),fymf5,'g+',fx(4,:),fymf7,'b+',fx(5,:),...
    fymf9,'m+',fx(6,:),fybsc06,'c+',fx(7,:),fybsc2,'m+',fx(8,:),fygauss05,'y+',fx(9,:),fygauss15,'r+',...
    fx(10,:),fymfavg3,'g+',fx(11,:),fymfavg3,'b+',fx(12,:),fymf55jpeg,'m+',fx(13,:),fymf75jpeg,'c+',...
    fx(14,:),fymf95jpeg,'b+');


 