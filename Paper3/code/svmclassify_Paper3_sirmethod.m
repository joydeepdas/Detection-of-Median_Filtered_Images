clear all;
fyavg_1=importdata('paper3_features/11/countzero_avg_3w_sirmethod_11.mat');
fyavg_2=importdata('paper3_features/12/countzero_avg3_sirmethod_12.mat');
fyavg_3=importdata('paper3_features/21/countzero_avg_3w_sirmethod_21.mat');
fymed_1=importdata('paper3_features/11/countzero_med_3w_sirmethod_11.mat');
fymed_2=importdata('paper3_features/12/countzero_med_3w_sirmethod_12.mat');
fymed_3=importdata('paper3_features/21/countzero_med_3w_sirmethod_21.mat');
%% randomly take 80% sample
random_gen = randperm(1338,1338);

%
% fyavg_1=fyavg_1';
% fyavg_2=fyavg_2';
% fyavg_3=fyavg_3';
% fymed_1=fymed_1';
% fymed_2=fymed_2';
% fymed_3=fymed_3';


fyori=[fyavg_1   ] ;
fymf=[ fymed_1  ];


trainvector=[fyori ;fymf];


for i=1:1338
    fyoriShuffle(i,:)=fyori(random_gen(i),:);
    fymfShuffle(i,:)=fymf(random_gen(i),:);
end
%% train
trainfyori=fyoriShuffle(1:1070,:);
trainfymf=fymfShuffle(1:1070,:);

trainvector=[trainfyori ;trainfymf];
for i=1:1070
    label(i)=0;
end

for i=1071:2140
    label(i)=1;
end
label=label';
SVMStruct = svmtrain(trainvector,label);


%% classify
testfyori=fyoriShuffle(1071:1338,:);
testfymf=fymfShuffle(1071:1338,:);
testvector=[testfyori ;testfymf];
Group = svmclassify(SVMStruct,testvector);

originalforged=0;
forgeddetected=0;
for i=1:268
    if Group(i)==1
        originalforged=originalforged+1;
    end
end

for i=269:536
    if Group(i)==1
        forgeddetected=forgeddetected+1;
    end
end


T_FP=originalforged/268;
T_TP=forgeddetected/268;
T_TN=(268-forgeddetected)/268;
Pe=((T_FP+T_TN)/2)*100;


