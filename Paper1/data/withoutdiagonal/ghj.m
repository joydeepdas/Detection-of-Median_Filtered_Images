clear all;
fyori=importdata('featureoriginal1338.mat');
fymf3 =importdata('featuremf3w1338.mat');
fymf5 =importdata('featuremf5w1338.mat');
fymf7 =importdata('featuremf7w1338.mat');
fymf9 =importdata('featuremf9w1338.mat');
fymfavg3=importdata('featuremf3avg1338.mat');
fymfavg5=importdata('featuremf5avg1338.mat');


for i=1:7
    for j=1:1338
        fx(i,j)=1338*(i-1)+j;
    end
end


plot(fx(1,:),fyori,'k.',fx(2,:),fymf3,'r+',fx(3,:),fymf5,'g+',fx(4,:),fymf7,'b+',fx(5,:),...
    fymf9,'m+',fx(6,:),fymfavg3,'g+',fx(7,:),fymfavg5,'b+');
legend('original','w = 3x3','w = 5x5','w = 7x7','w = 9x9','avg = 3x3','avg = 5x5');