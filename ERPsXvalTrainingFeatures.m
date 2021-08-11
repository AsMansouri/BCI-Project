clear;
clc;

%% Reading Samples
% %---Adults
% Filenames = {'P1_Grid_Targ.mat','P1_Grid_NonTarg.mat';
%              'P1_RandLoc_Targ.mat','P1_RandLoc_NonTarg.mat';
%              'P1_Scene_Targ.mat','P1_Scene_NonTarg.mat';
%              'P2_Grid_Targ.mat','P2_Grid_NonTarg.mat';
%              'P2_RandLoc_Targ.mat','P2_RandLoc_NonTarg.mat';
%              'P2_Scene_Targ.mat','P2_Scene_NonTarg.mat';
%              'P3_Grid_Targ.mat','P3_Grid_NonTarg.mat';
%              'P3_RandLoc_Targ.mat','P3_RandLoc_NonTarg.mat';
%              'P3_Scene_Targ.mat','P3_Scene_NonTarg.mat';
%              };
%---Kids
% Filenames = {'P1C_Grid_Targ.mat','P1C_Grid_NonTarg.mat';
%              'P1C_RandLoc_Targ.mat','P1C_RandLoc_NonTarg.mat';
%              'P1C_Scene_Targ.mat','P1C_Scene_NonTarg.mat';
%              'P2C_Grid_Targ.mat','P2C_Grid_NonTarg.mat';
%              'P2C_RandLoc_Targ.mat','P2C_RandLoc_NonTarg.mat';
%              'P2C_Scene_Targ.mat','P2C_Scene_NonTarg.mat';
%              };
%  Filenames = {'..\Datasets\P1\JF_P300VSD_1_Artifact_Rejected_targets_P1.mat',...
%               '..\Datasets\P1\JF_P300VSD_1_Artifact_Rejection_nontargets_P1.mat';
%               '..\Datasets\P2\MS_P300VSD_2_Artifact_Rejection_Targets_P2.mat',...
%               '..\Datasets\P2\MS_P300VSD_2_Artifact_Rejection_NoN_targets_P2.mat'};
% DatasetFold = ['..\Datasets\Partitions\Grid\'];
% DatasetFold = ['Datasets\'];
% DatasetFold = ['Z:\BCI_learning\P300_VSD_EEG_Research\Data\Processed Data\Contextual\Adults\Segments\'];
% Filenames = {'P1_Grid_Targ.mat','P1_Grid_NonTarg.mat';
%              'P2_Grid_Targ.mat','P2_Grid_NonTarg.mat';
%              'P3_Grid_Targ.mat','P3_Grid_NonTarg.mat';
%              };


%% Initial Values...

%%----Dataset Folder Address
% DatasetFold = ['Z:\BCI_learning\P300_VSD_EEG_Research\Data\Processed Data\Contextual\Adults\Segments\'];
DatasetFold = ['J:\AAC-BCI\Dataset\Processed Data\Contextual\Adults\Segments\'];


%%----ERP features
StimulousStart = 0.1; %seconds

% ERPs.Tags = {'N170' ; 'P300' ; 'N400+' ; 'P600'};
% ERPs.Ranges = {[0.090 0.230]+StimulousStart ; [0.150 0.500]+StimulousStart ; [0.400 0.700]+StimulousStart ; [0.625 0.720]+StimulousStart};
% 
% ERPs.NominalTime = { [0.170 + StimulousStart] ; [0.300 + StimulousStart] ;[0.400 + StimulousStart] ; [0.600 + StimulousStart]};
% 
% ERPs.Regions.Chann = {{[];[12,11,13,14,15,22,19,20];[16:18]};...
%                       {[1:4,30:32];[6,7,8,9,12,11,13,14,15,19,22:25,26,20,28,29];[16:18]};...
%                       {[2,3];[7,12,11,13,14,15,19,22:23,20,29];[16:18]};...
%                       {[];[8,9,12,13,14,22:25];[]}};
%%

StimulousStart = 0.1; %seconds

ERPs(1).Tag = 'N170';
ERPs(1).Ranges = [0.090 0.230]+StimulousStart;
ERPs(1).NominalTime = [0.170 + StimulousStart];
ERPs(1).Regions = {'Frontal';'Centro-Parietal';'Occipital'};
ERPs(1).RegionsChann = {[];[12,11,13,14,15,22,19,20];[16:18]};

ERPs(2).Tag = 'P300';
ERPs(2).Ranges = [0.150 0.500]+StimulousStart;
ERPs(2).NominalTime = [0.300 + StimulousStart];
ERPs(2).Regions = {'Frontal';'Centro-Parietal';'Occipital'};
ERPs(2).RegionsChann = {[1:4,30:32];[6,7,8,9,12,11,13,14,15,19,22:25,26,20,28,29];[16:18]};

ERPs(3).Tag = 'N400+';
ERPs(3).Ranges = [0.400 0.700]+StimulousStart;
ERPs(3).NominalTime = [0.400 + StimulousStart];
ERPs(3).Regions = {'Frontal';'Centro-Parietal';'Occipital'};
ERPs(3).RegionsChann = {[2,3];[7,12,11,13,14,15,19,22:23,20,29];[16:18]};

ERPs(4).Tag = 'P600';
ERPs(4).Ranges = [0.625 0.720]+StimulousStart;
ERPs(4).NominalTime = [0.600 + StimulousStart];
ERPs(4).Regions = {'Frontal';'Centro-Parietal';'Occipital'};
ERPs(4).RegionsChann = {[];[8,9,12,13,14,22:25];[]};

%%        

Paradigms(1).Tag = 'Grid';
Paradigms(2).Tag = 'RandLoc';
Paradigms(3).Tag = 'Scene';

%%

%%----General Regions (Electrode clusters)
% Regions.Chann = {[1:9,11:17,24];[13,17:20,22:32];[1:7,27:32];[7,8,12,23:25,29];[6,8,9,11,26,28,25,22];[12:15,19,20,23];[13,16:18];[1:9,11:20,22:32]};
% Regions.Labels = {'Right';'Left';'Frontal';'Central';'Temporal';'Parietal';'Occipital';'General'};

Regions.Chann = {[1:4,30:32];[6,7,8,9,12,11,13,14,15,22:25,26,19,20,28,29];[16:18]};
Regions.Labels = {'Frontal';'Centro-Parietal';'Occipital'};
        
% 1) a frontal bin (average for the F elects), 
% 2) centro-parietal (average of the FC/C/CP/P elecs) and 
% 3) Occipital bin (average o elec).

%% Outputs 
NumHighRankedFeatures = 64;
NumIterations = 10;
FSType = 2;     % FSType: 1=fscmrmr 2=fscchi2 3=fsrftest ; 
                %         otherwise (e.g 0)=all features
    
KFoldsss = [2, 5, 10];
for FSType = 1:3
    for Kfo = 1:3
%         Kfolds = 2;     % Number of K in K-fold crossvalidation
           Kfolds = KFoldsss(Kfo);
           
% XLNameAmp = ['Results-BCI-ERPs-',datestr(now,'HH-MM-SS'),'-Amplitudes.xlsx'];
% XLNameLat = ['Results-BCI-ERPs-',datestr(now,'HH-MM-SS'),'-Latency.xlsx'];

XLOutputName = ['Results\Results_SelectedFeatures_K',num2str(Kfolds),'_FS',num2str(FSType),'_',datestr(now,'HH-MM-SS'),'.xlsx'];
%% Excel of ERPs per sheet for all electrodes

XLLine = 1;

for pt = 1:20
    if pt == 8 || pt == 9
        continue;
    end

    for o = 1:length(Paradigms)

            tmpfileAdd = [DatasetFold 'P' num2str(pt) '_Artifact_Rejection-' Paradigms(o).Tag '-Targ.mat'];
            [PtSegments{pt,1}, ChLabels, Fs, ChannInfo] = ImportingBCIData(tmpfileAdd);

            tmpfileAdd = [DatasetFold 'P' num2str(pt) '_Artifact_Rejection-' Paradigms(o).Tag '-NonTarg.mat'];
            [PtSegments{pt,2}, ChLabels, Fs, ChannInfo] = ImportingBCIData(tmpfileAdd);

    %         tmpfileAdd = [DatasetFold 'P' num2str(pt) '_Diff._Waves-' Paradigms{o} '-TvsNT.mat'];
    %         [PtSegments{pt,o}, Labels, Fs, ChannInfo] = ImportingBCIData(tmpfileAdd);

            Paradigms(o).PeakFeatures = [];
            Paradigms(o).LatencyFeatures = [];
            Paradigms(o).RawEpochFeatures = [];
            Paradigms(o).RawEpochFeatures = [reshape(PtSegments{pt,1}(:,:,StimulousStart*Fs+1:end),[size(PtSegments{pt,1},1),size(PtSegments{pt,1},2)*size(PtSegments{pt,1}(:,:,StimulousStart*Fs+1:end),3)]);...
                                             reshape(PtSegments{pt,2}(:,:,StimulousStart*Fs+1:end),[size(PtSegments{pt,2},1),size(PtSegments{pt,2},2)*size(PtSegments{pt,2}(:,:,StimulousStart*Fs+1:end),3)])];
            for E = 1:length(ERPs)
                if ERPs(E).Tag(1) =='P'
                    [Paradigms(o).TargPeaks{E},Ind] = max(PtSegments{pt,1}(:,:,ceil(ERPs(E).Ranges(1)*Fs):floor(ERPs(E).Ranges(2)*Fs)),[],3);
                    Paradigms(o).TargLatency{E} = ((Ind - 1)/ Fs) + ERPs(E).Ranges(1) - StimulousStart;
                    [Paradigms(o).NonTargPeaks{E},Ind] = max(PtSegments{pt,2}(:,:,ceil(ERPs(E).Ranges(1)*Fs):floor(ERPs(E).Ranges(2)*Fs)),[],3);
                    Paradigms(o).NonTargLatency{E} = ((Ind - 1)/ Fs) + ERPs(E).Ranges(1) - StimulousStart;
                else
                    [Paradigms(o).TargPeaks{E},Ind] = min(PtSegments{pt,1}(:,:,ceil(ERPs(E).Ranges(1)*Fs):floor(ERPs(E).Ranges(2)*Fs)),[],3);
                    Paradigms(o).TargLatency{E} = ((Ind - 1)/ Fs) + ERPs(E).Ranges(1) - StimulousStart;
                    [Paradigms(o).NonTargPeaks{E},Ind] = min(PtSegments{pt,2}(:,:,ceil(ERPs(E).Ranges(1)*Fs):floor(ERPs(E).Ranges(2)*Fs)),[],3);
                    Paradigms(o).NonTargLatency{E} = ((Ind - 1)/ Fs) + ERPs(E).Ranges(1) - StimulousStart;
                end
                Paradigms(o).PeakFeatures = [Paradigms(o).PeakFeatures , [Paradigms(o).TargPeaks{E};Paradigms(o).NonTargPeaks{E}]];
                Paradigms(o).LatencyFeatures = [Paradigms(o).LatencyFeatures , [Paradigms(o).TargLatency{E};Paradigms(o).NonTargLatency{E}]];
            end

            Paradigms(o).SegmentsLabels = [ones(size(Paradigms(o).TargPeaks{E},1),1) ; zeros(size(Paradigms(o).NonTargPeaks{E},1),1)];

            XLLine = XLLine+1; 
        
%% Selected features based on the visual investigation
 
        Paradigms(o).SelectedFeatures = [];
%         Paradigms(o).SelectedFeatures = [];
        for E = 1:length(ERPs)
            tmpSelectChann = [ERPs(E).RegionsChann{:}];
            Paradigms(o).SelectedFeatures = [Paradigms(o).SelectedFeatures, [Paradigms(o).TargPeaks{E}(:,tmpSelectChann);Paradigms(o).NonTargPeaks{E}(:,tmpSelectChann)]];     
        end

          %% Unbalanced Dataset 
        %%--Feature selection
%         clc;
%         BalancedDataset = 0;
% 
%         fprintf('UnBalanced Datasets : \n');
% 
%         %SVM
%         ACCs = [];
%         Kappas = [];
% 
%         for i = 1:NumIterations
%         [Accuracies, Kappa, CMs] = KfoldSVMFS5FoldTraining (Paradigms(o).SelectedFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
% 
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite(XLOutputName,[tmpRes,ACCs_str] , 'SVM-UnBal', ['A' num2str(XLLine)]);
% 
%         %LDA
%         ACCs = [];
%         Kappas = [];
% 
%         for i = 1:NumIterations
%         [Accuracies, Kappa, CMs] = KfoldLDAS5FoldTraining (Paradigms(o).SelectedFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
% 
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite(XLOutputName,[tmpRes,ACCs_str] , 'LDA-UnBal', ['A' num2str(XLLine)]);

        %% Balanced
        BalancedDataset = 1;

        fprintf('Balanced Datasets : \n');

        %SVM
        ACCs = [];
        Kappas = [];

        for i = 1:NumIterations
        [Accuracies, Kappa, CMs] = KfoldSVMFS5FoldTraining (Paradigms(o).SelectedFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
    %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
            ACCs = [ACCs Accuracies];
            Kappas = [Kappas Kappa];
        end
        fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(ACCs)*100);

        ACCs_str = split(cellstr(num2str(ACCs)))';
        tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
                  num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
        xlswrite(XLOutputName,[tmpRes,ACCs_str] , 'SVM-Bal', ['A' num2str(XLLine)]);

        %LDA
        ACCs = [];
        Kappas = [];

        for i = 1:NumIterations
        [Accuracies, Kappa, CMs] = KfoldLDAS5FoldTraining (Paradigms(o).SelectedFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
    %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
            ACCs = [ACCs Accuracies];
            Kappas = [Kappas Kappa];
        end
        fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(ACCs)*100);

        ACCs_str = split(cellstr(num2str(ACCs)))';
        tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
                  num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
        xlswrite(XLOutputName,[tmpRes,ACCs_str] , 'LDA-Bal', ['A' num2str(XLLine)]);

        
        
        %% Unbalanced Dataset-----RawEpoch
        %%--Feature selection
%         clc;
% 
%         NumHighRankedFeatures = 64;
%         FSType = 0;     % FSType: 1=fscmrmr 2=fscchi2 3=fsrftest ; 
%                         %         otherwise (e.g 0)=all features
%         Kfolds = 5;
%         NumIterations = 10;
%         BalancedDataset = 0;
% 
%         fprintf('UnBalanced Datasets- Raw Epochs: \n');
% 
%         %SVM
%         ACCs = [];
%         Kappas = [];
%           
%         for i = 1:NumIterations
%         [Accuracies, Kappa, CMs] = KfoldSVMFS (Paradigms(o).RawEpochFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
% 
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results_RawEpochs.xlsx',[tmpRes,ACCs_str] , 'SVM-UnBal', ['A' num2str(XLLine)]);
% 
%         %LDA
%         ACCs = [];
%         Kappas = [];
% 
%         for i = 1:NumIterations
%         [Accuracies, Kappa, CMs] = KfoldLDAFS (Paradigms(o).RawEpochFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
% 
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results_RawEpochs.xlsx',[tmpRes,ACCs_str] , 'LDA-UnBal', ['A' num2str(XLLine)]);
% 
%         %% Balanced
%         BalancedDataset = 1;
% 
%         fprintf('Balanced Datasets- Raw Epochs: \n');
% 
%         %SVM
%         ACCs = [];
%         Kappas = [];
% 
%         for i = 1:NumIterations
%         [Accuracies, Kappas, CMs] = KfoldSVMFS (Paradigms(o).RawEpochFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
% 
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results_RawEpochs.xlsx',[tmpRes,ACCs_str] , 'SVM-Bal', ['A' num2str(XLLine)]);
% 
%         %LDA
%         ACCs = [];
%         Kappas = [];
% 
%         for i = 1:NumIterations
%         [Accuracies, Kappas, CMs] = KfoldLDAFS (Paradigms(o).RawEpochFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
% 
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results_RawEpochs.xlsx',[tmpRes,ACCs_str] , 'LDA-Bal', ['A' num2str(XLLine)]);

%         %% Unbalanced Dataset
%         %%--Feature selection
%         clc;
% 
%         NumHighRankedFeatures = 64;
%         FSType = 2;     % FSType: 1=fscmrmr 2=fscchi2 3=fsrftest ; 
%                         %         otherwise (e.g 0)=all features
%         Kfolds = 2;
%         NumIterations = 10;
%         BalancedDataset = 0;
% 
%         fprintf('UnBalanced Datasets : \n');
% 
%         %SVM
%         ACCs = [];
%         Kappas = [];
% 
%         for i = 1:NumIterations
%         [Accuracies, Kappa, CMs] = KfoldSVMFS5FoldTraining (Paradigms(o).PeakFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
% 
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results.xlsx',[tmpRes,ACCs_str] , 'SVM-UnBal', ['A' num2str(XLLine)]);
% 
%         %LDA
%         ACCs = [];
%         Kappas = [];
% 
%         for i = 1:NumIterations
%         [Accuracies, Kappa, CMs] = KfoldLDAS5FoldTraining (Paradigms(o).PeakFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
% 
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results.xlsx',[tmpRes,ACCs_str] , 'LDA-UnBal', ['A' num2str(XLLine)]);
% 
%         %% Balanced
%         BalancedDataset = 1;
% 
%         fprintf('Balanced Datasets : \n');
% 
%         %SVM
%         ACCs = [];
%         Kappas = [];
% 
%         for i = 1:NumIterations
%         [Accuracies, Kappas, CMs] = KfoldSVMFS5FoldTraining (Paradigms(o).PeakFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
% 
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results.xlsx',[tmpRes,ACCs_str] , 'SVM-Bal', ['A' num2str(XLLine)]);
% 
%         %LDA
%         ACCs = [];
%         Kappas = [];
% 
%         for i = 1:NumIterations
%         [Accuracies, Kappas, CMs] = KfoldLDAS5FoldTraining (Paradigms(o).PeakFeatures,Paradigms(o).SegmentsLabels,Kfolds,NumHighRankedFeatures,FSType,BalancedDataset);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
% 
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {['Pt_' num2str(pt)] , Paradigms(o).Tag , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results.xlsx',[tmpRes,ACCs_str] , 'LDA-Bal', ['A' num2str(XLLine)]);

    end

    

%%    Feature selection
% [idx,scores] = fscmrmr(Dataset,Labels);
% [idx,scores] = fscchi2(Dataset,Labels);
% [idx,scores] = fsrftest(Dataset,Labels);

% bar(idx,scores(idx))
% cellstr(num2str(tmpidx));

%% 

end

    end
end
% for f = 1:length(ERPs.Tags)
% %     for Elec = 1:32
% 
%     FeatureMat_DiffTvsNT = [];
%     
%     tmpHeader = {'Pt';'Pt'};
%     for o = 1:length(Paradigms)
%         
%         for pt = 1:20
%             if pt == 8 || pt == 9
%                 continue;
%             end
% %             for f = 1:length(ERPs.Tags)
%             for Elec = 1:32
%                 if ERPs.Tags{f}(1) =='P'
%                     [FeatureMat_DiffTvsNT.Peaks(pt,length(Paradigms)*(Elec-1) + o),Ind] = max(PtSegments{pt,o}(1,Elec,ERPs.Ranges{f}(1)*Fs:ERPs.Ranges{f}(2)*Fs),[],3);
%                 else
%                     [FeatureMat_DiffTvsNT.Peaks(pt,length(Paradigms)*(Elec-1) + o),Ind] = min(PtSegments{pt,o}(1,Elec,ERPs.Ranges{f}(1)*Fs:ERPs.Ranges{f}(2)*Fs),[],3);
%                 end
%                     
%                 FeatureMat_DiffTvsNT.Latency(pt,length(Paradigms)*(Elec-1) + o) = ((Ind - 1)/ Fs) + ERPs.Ranges{f}(1) - StimulousStart;
%                 tmpHeader{1,length(Paradigms)*(Elec-1) + o + 1} = Labels{Elec};
%                 tmpHeader{2,length(Paradigms)*(Elec-1) + o + 1} = Paradigms{o};
%             end
%         end    
%     end
%     
%     XLLine = 1;
%     xlswrite(XLNameAmp,tmpHeader,ERPs.Tags{f},['A' num2str(XLLine)]);
%     xlswrite(XLNameLat,tmpHeader,ERPs.Tags{f},['A' num2str(XLLine)]);
%     
%     XLLine = XLLine + size(tmpHeader,1);
%     xlswrite(XLNameAmp,[[1:20]' , FeatureMat_DiffTvsNT.Peaks ],ERPs.Tags{f},['A' num2str(XLLine)]);
%     xlswrite(XLNameLat,[[1:20]' , FeatureMat_DiffTvsNT.Latency ],ERPs.Tags{f},['A' num2str(XLLine)]);
%     
%     for r = 1:length(ERPs.Regions.Chann{f})
%         if isempty(ERPs.Regions.Chann{f}{r})
%             continue;
%         end
%         XLLine = 1;
%         
%         HeaderInd = (ERPs.Regions.Chann{f}{r} .* ones(length(Paradigms),1)*length(Paradigms)') - [length(Paradigms)-1:-1:0]';
%         
%         xlswrite(XLNameAmp,tmpHeader(:,[1,HeaderInd(:)'+1]),[ERPs.Tags{f} '-' Regions.Labels{r}],['A' num2str(XLLine)]);
%         xlswrite(XLNameLat,tmpHeader(:,[1,HeaderInd(:)'+1]),[ERPs.Tags{f} '-' Regions.Labels{r}],['A' num2str(XLLine)]);
% 
%         XLLine = XLLine + size(tmpHeader,1);
%         tmpAverages_Peaks = [mean(FeatureMat_DiffTvsNT.Peaks(:,HeaderInd(1,:)),2),...
%                              mean(FeatureMat_DiffTvsNT.Peaks(:,HeaderInd(2,:)),2),...
%                              mean(FeatureMat_DiffTvsNT.Peaks(:,HeaderInd(3,:)),2)];
%         tmpAverages_Latency = [mean(FeatureMat_DiffTvsNT.Latency(:,HeaderInd(1,:)),2),...
%                              mean(FeatureMat_DiffTvsNT.Latency(:,HeaderInd(2,:)),2),...
%                              mean(FeatureMat_DiffTvsNT.Latency(:,HeaderInd(3,:)),2)];
%                          
%         xlswrite(XLNameAmp,[[1:20]' , FeatureMat_DiffTvsNT.Peaks(:,HeaderInd(:)),tmpAverages_Peaks ],[ERPs.Tags{f} '-' Regions.Labels{r}],['A' num2str(XLLine)]);
%         xlswrite(XLNameLat,[[1:20]' , FeatureMat_DiffTvsNT.Latency(:,HeaderInd(:)),tmpAverages_Latency ],[ERPs.Tags{f} '-' Regions.Labels{r}],['A' num2str(XLLine)]);
%     end
%     
%     tmpHeader = {'Pt';'Pt'};
%     
%     FeatureMat_DiffTvsNT_Regions = [];
%     for r = 1:length(Regions.Chann)
%         ElecPara_Indx = 3*(Regions.Chann{r}-1)+[1,2,3]';
% 
%         for o = 1:length(Paradigms)
% 
%             FeatureMat_DiffTvsNT_Regions.Peaks(:,length(Paradigms)*(r-1)+o) = mean(FeatureMat_DiffTvsNT.Peaks(:,ElecPara_Indx(o,:)),2);
%             FeatureMat_DiffTvsNT_Regions.Latency(:,length(Paradigms)*(r-1)+o) = mean(FeatureMat_DiffTvsNT.Latency(:,ElecPara_Indx(o,:)),2);
%             tmpHeader{1,length(Paradigms)*(r-1) + o + 1} = Regions.Labels{r};
%             tmpHeader{2,length(Paradigms)*(r-1) + o + 1} = Paradigms{o};
%         end
%             
%     end
%     
%     XLLine = 1;
%     xlswrite(XLNameAmp,tmpHeader,[ERPs.Tags{f} '- Regions'],['A' num2str(XLLine)]);
%     xlswrite(XLNameLat,tmpHeader,[ERPs.Tags{f} '- Regions'],['A' num2str(XLLine)]);
%     
%     XLLine = XLLine + size(tmpHeader,1);
%     xlswrite(XLNameAmp,[[1:20]' , FeatureMat_DiffTvsNT_Regions.Peaks ],[ERPs.Tags{f} '- Regions'],['A' num2str(XLLine)]);
%     xlswrite(XLNameLat,[[1:20]' , FeatureMat_DiffTvsNT_Regions.Latency ],[ERPs.Tags{f} '- Regions'],['A' num2str(XLLine)]);
%     
%     
%     
% end
% 
% 
% %%
% for pt = 1:size(Filenames,1)
%     tmpfileinfo = split(Filenames{pt,1},'_');
%     
%     [PtSegments{1,1}, Labels, Fs, ChannInfo] = ImportingBCIData(Filenames{pt,1});
%     [PtSegments{1,2}, Labels, Fs, ChannInfo] = ImportingBCIData(Filenames{pt,2});
%     if size(PtSegments{1,1},1) > 120
%         PtSegments{1,1}(121:end,:,:) = [];
%     end
%     if size(PtSegments{1,2},1) > 840
%         PtSegments{1,1}(841:end,:,:) = [];
%     end
% 
%     %% Cpmare averaged Targets vs averaged NonTargets
%     Directory = ['Results\P' num2str(pt) 'C\'];
%     mkdir([Directory 'Averages\']);
% 
%     % Filename = 'NewSamples\TARG_REJECT_HannahS000R02.mat';
%     [Segments, ChLabels, Fs, ChannInfo] = ImportingBCIAvgDatatoSegments(Filenames{pt,1});
%     AvgSegmentsTarg(:,:) = mean(Segments,1); 
% 
%     % Filename = 'NewSamples\HannahS000R02_NT_Artifact_Rejection.mat';
%     [Segments, ChLabels, Fs, ChannInfo] = ImportingBCIAvgDatatoSegments(Filenames{pt,2});
%     AvgSegmentsNonTarg(:,:) = mean(Segments,1); 
% 
%     % for i = 0:3
%     %     figure('Visible','off')
%     %     for ch = 1 : 8
%     %         subplot(4,2,ch)
%     % %         plot(AvgSegmentsTarg((i*8)+ch,:))
%     %         plot(smoothdata(AvgSegmentsTarg((i*8)+ch,:)))
%     %         hold on
%     % %         plot(AvgSegmentsNonTarg((i*8)+ch,:))
%     %         plot(smoothdata(AvgSegmentsNonTarg((i*8)+ch,:)))
%     %         title(['Target Vs. NonTargets Average - ' ChLabels{(i*8)+ch}])
%     %         legend('Target','NonTarget')    
%     %         xlim([1 size(AvgSegmentsTarg,2)]);
%     %         xt = get(gca,'XTick');
%     %         set(gca, 'XTick',xt, 'XTickLabel',xt/Fs)
%     %     end
%     %     set(gcf, 'Position', get(0, 'Screensize'))
%     %     saveas(gcf,[Directory,'Averages\Channel Averages- ', num2str(i+1), '.jpg']);
%     %     close all force 
%     % end
% 
% 
% 
%     %% Datasets
%         mkdir([Directory 'Dataset\']);
% 
%         %% -- Time
%         Data = [PtSegments{1,1} ; PtSegments{1,2}];
%         Labels = [ones(size(PtSegments{1,1},1),1) ; zeros(size(PtSegments{1,2},1),1)];
% 
%         %-- unbalaced - dataset
%         if exist([Directory,'Dataset\','BCI_pt_',num2str(pt),'_Raw_Unbal.mat'],'file')
%             disp('------------Loading Raw datasets --------------------');
%             load([Directory,'Dataset\','BCI_pt_',num2str(pt),'_Raw_Unbal.mat'])
%         else
%             [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(Data, Labels,2);
%             try
%                 save([Directory,'Dataset\','BCI_pt_',num2str(pt),'_Raw_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%             catch
%                 warning('Saved as version v7.3......');
%                 save([Directory,'Dataset\','BCI_pt_',num2str(pt),'_Raw_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%             end
%             clear Dataset_Train Labels_Train Dataset_Test Labels_Test
%             load([Directory,'Dataset\','BCI_pt_',num2str(pt),'_Raw_Unbal.mat'])
%         end
% 
% 
%           %%  Kfold
%         clc;
%         Kfolds = 2;
%         NumIterations = 10;
%         fprintf('UnBalanced Datasets : \n');
% 
%         %SVM
%         ACCs = [];
%         Kappas = [];
%         for i = 1:NumIterations
%             [Accuracies, Kappa, CMs] = KfoldSVM (Dataset_Train,Dataset_Test,Labels_Train,Labels_Test,Kfolds);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
%         
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {tmpfileinfo{1} , tmpfileinfo{2} , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results.xlsx',[tmpRes,ACCs_str] , 'SVM-UnBal', ['A' num2str(pt+1)]);
%         
%         % LDA
% 
%         ACCs = [];
%         Kappas = [];
%         for i = 1:NumIterations
%             [Accuracies, Kappa, CMs] = KfoldLDA (Dataset_Train,Dataset_Test,Labels_Train,Labels_Test,Kfolds);
%     %         fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
%         
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {tmpfileinfo{1} , tmpfileinfo{2} , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results.xlsx',[tmpRes,ACCs_str] , 'LDA-UnBal', ['A' num2str(pt+1)]);
% 
%                 
%         % QDA
% 
%         ACCs = [];
%         Kappas = [];
%         for i = 1:NumIterations
%             [Accuracies, Kappa, CMs] = KfoldQDA (Dataset_Train,Dataset_Test,Labels_Train,Labels_Test,Kfolds);
%     %         fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             ACCs = [ACCs Accuracies];
%             Kappas = [Kappas Kappa];
%         end
%         fprintf('Average QDA crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
%          
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {tmpfileinfo{1} , tmpfileinfo{2} , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results.xlsx',[tmpRes,ACCs_str] , 'QDA-UnBal', ['A' num2str(pt+1)]);
%        
%         %%
% 
%         %-- balanced - dataset
%         if exist([Directory,'Dataset\','BCI_pt_',num2str(pt),'_Raw_bal.mat'],'file')
%             disp('------------Loading Raw datasets --------------------');
%             load([Directory,'Dataset\','BCI_pt_',num2str(pt),'_Raw_bal.mat'])
%         else
%             [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(Data, Labels,2);
%             try
%                 save([Directory,'Dataset\','BCI_pt_',num2str(pt),'_Raw_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%             catch
%                 warning('Saved as version v7.3......');
%                 save([Directory,'Dataset\','BCI_pt_',num2str(pt),'_Raw_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%             end
%             clear Dataset_Train Labels_Train Dataset_Test Labels_Test
%             load([Directory,'Dataset\','BCI_pt_',num2str(pt),'_Raw_bal.mat'])
%         end
% 
% 
%         %%  Kfold
%     %     clc;
%         Kfolds = 2;
%         NumIterations = 10; 
%         fprintf('Balanced Datasets : \n');
% 
%         %SVM
%         ACCs = [];
%         Kappas = [];
%         for i = 1:NumIterations
%             [Accuracies, Kappa, CMs] = KfoldSVM (Dataset_Train,Dataset_Test,Labels_Train,Labels_Test,Kfolds);
%     %         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             Kappas = [Kappas Kappa];
%             ACCs = [ACCs Accuracies];
%         end
%         fprintf('Average SVM crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
%         
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {tmpfileinfo{1} , tmpfileinfo{2} , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results.xlsx',[tmpRes,ACCs_str] , 'SVM-Bal', ['A' num2str(pt+1)]);
% 
%         % LDA
% 
%         ACCs = [];
%         Kappas = [];
%         for i = 1:NumIterations
%             [Accuracies, Kappa, CMs] = KfoldLDA (Dataset_Train,Dataset_Test,Labels_Train,Labels_Test,Kfolds);
%     %         fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             Kappas = [Kappas Kappa];
%             ACCs = [ACCs Accuracies];
%         end
%         fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
%         
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {tmpfileinfo{1} , tmpfileinfo{2} , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results.xlsx',[tmpRes,ACCs_str] , 'LDA-Bal', ['A' num2str(pt+1)]);
% 
%         % QDA
% 
%         ACCs = [];
%         Kappas = [];
%         for i = 1:NumIterations
%             [Accuracies, Kappa, CMs] = KfoldQDA (Dataset_Train,Dataset_Test,Labels_Train,Labels_Test,Kfolds);
%     %         fprintf('Average LDA crossvalidation accuracies = %.2f \n',mean(Accuracies)*100);
%             Kappas = [Kappas Kappa];
%             ACCs = [ACCs Accuracies];
%         end
%         fprintf('Average QDA crossvalidation accuracies = %.2f \n',mean(ACCs)*100);
%         
%         ACCs_str = split(cellstr(num2str(ACCs)))';
%         tmpRes = {tmpfileinfo{1} , tmpfileinfo{2} , num2str(mean(ACCs)*100) , ...
%                   num2str(std(ACCs)*100), num2str(min(ACCs(:))*100), num2str(max(ACCs(:))*100)};
%         xlswrite('Results\Results.xlsx',[tmpRes,ACCs_str] , 'QDA-Bal', ['A' num2str(pt+1)]);
%%
    
%     rshDataset_Train = reshape(Dataset_Train,size(Dataset_Train,1),size(Dataset_Train,2)*size(Dataset_Train,3));
%     rshDataset_Test = reshape(Dataset_Test,size(Dataset_Test,1),size(Dataset_Test,2)*size(Dataset_Test,3));
    
% 
% 
%     rshDataset_Test = reshape(Dataset_Train,size(Dataset_Train,1),size(Dataset_Train,2)*size(Dataset_Train,3));
%     rshDataset_Train = reshape(Dataset_Test,size(Dataset_Test,1),size(Dataset_Test,2)*size(Dataset_Test,3));
%     
%     
%     % SVM
%     disp(' SVM classifier : ');
%     MdlLinear = fitclinear(rshDataset_Train,Labels_Train,'KFold',2);
%     
%     Labels_Predict = predict(MdlLinear,rshDataset_Test);
%     
%     acc = 1 - (abs(sum(Labels_Test-Labels_Predict))/length(Labels_Test));
%     [C,order] = confusionmat(Labels_Test,Labels_Predict,'Order',[0 1]);
%     cm = confusionchart(Labels_Test,Labels_Predict);
%     
%     fprintf('Acc = %.3f, TP = %i, TN = %i, FP = %i, FN = %i.\n',acc,C(2,2),C(1,1),C(2,1),C(1,2));
%     
%     
%     % LDA
%     disp(' LDA classifier : ');
%     MdlLinear = fitcdiscr(rshDataset_Train,Labels_Train);
%     Labels_Predict = predict(MdlLinear,rshDataset_Test);
%     
%     acc = 1 - (abs(sum(Labels_Test-Labels_Predict))/length(Labels_Test));
%     
%     [C,order] = confusionmat(Labels_Test,Labels_Predict,'Order',[0 1]);
%     cm = confusionchart(Labels_Test,Labels_Predict);
%     fprintf('Acc = %.3f, TP = %i, TN = %i, FP = %i, FN = %i.\n',acc,C(2,2),C(1,1),C(2,1),C(1,2));
    

    %%
%
%     %-- balanced - dataset
%     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(Data, Labels,2);
%     try
%         save(['BCI_pt_',num2str(pt),'_Raw_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%     catch
%         warning('Saved as version v7.3......');
%         save(['BCI_pt_',num2str(pt),'_Raw_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%     end
%     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% % 
% %         %%---Dist - dataset - Euclidean
% %     
% %     DistMetricType = 'euclidean'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
% %     [DistData] = DistGenerator(Data, DistMetricType);
% %     
% %         %-- unbalaced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_Raw_Euclid_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_Raw_Euclid_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% % 
% %         %-- balanced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_Raw_Euclid_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_Raw_Euclid_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% %     
% %         %%---Dist - dataset - cosine
% %     
% %     DistMetricType = 'cosine'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
% %     [DistData] = DistGenerator(Data, DistMetricType);
% %     
% %         %-- unbalaced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_Raw_Cos_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_Raw_Cos_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% % 
% %         %-- balanced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_Raw_Cos_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_Raw_Cos_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% % 
% %         %%---Dist - dataset - correlation
% %     
% %     DistMetricType = 'correlation'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
% %     [DistData] = DistGenerator(Data, DistMetricType);
% %     
% %         %-- unbalaced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_Raw_Corr_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_Raw_Corr_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% % 
% %         %-- balanced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_Raw_Corr_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_Raw_Corr_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% %     
% %     
% %     %% -- Time- AMIs
% %     NLevel = 16;
% %     Dataset_AMI = zeros(size(Data)-[0,1,0]);
% %     for seg = 1:size(Data,1)
% %         clear tmpSeg; tmpSeg(:,:) = Data(seg,:,:);
% %         Dataset_AMI(seg,:,:) = AMIXcrosElec(tmpSeg',NLevel);
% %     end
% %     
% %     %-- unbalaced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(Dataset_AMI, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_AMI_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_AMI_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% % 
% %         %-- balanced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(Dataset_AMI, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_AMI_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_AMI_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% % 
% %         %%---Dist - dataset - Euclidean
% %     
% %     DistMetricType = 'euclidean'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
% %     [DistData] = DistGenerator(Dataset_AMI, DistMetricType);
% %     
% %         %-- unbalaced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_AMI_Euclid_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_AMI_Euclid_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% % 
% %         %-- balanced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_AMI_Euclid_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_AMI_Euclid_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% %     
% %         %%---Dist - dataset - cosine
% %     
% %     DistMetricType = 'cosine'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
% %     [DistData] = DistGenerator(Dataset_AMI, DistMetricType);
% %     
% %         %-- unbalaced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_AMI_Cos_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_AMI_Cos_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% % 
% %         %-- balanced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_AMI_Cos_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_AMI_Cos_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% % 
% %         %%---Dist - dataset - correlation
% %     
% %     DistMetricType = 'correlation'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
% %     [DistData] = DistGenerator(Dataset_AMI, DistMetricType);
% %     
% %         %-- unbalaced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_AMI_Corr_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_AMI_Corr_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% % 
% %         %-- balanced - dataset
% %     [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
% %     try
% %         save(['BCI_pt_',num2str(pt),'_AMI_Corr_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
% %     catch
% %         warning('Saved as version v7.3......');
% %         save(['BCI_pt_',num2str(pt),'_AMI_Corr_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
% %     end
% %     clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% %     
% %     % Draw Samples ---- AMIs examples 
% %     for seg = 1:500
% %         tmpSegData = [];
% %         tmpSegData(:,:) =  Dataset_AMI(seg,:,:);
% %         
% %         figure('Visible','off')
% %         heatmap(tmpSegData,'GridVisible','off')
% %         if Labels(seg) == 1
% %             title({'AMI','Targets',['Seg = ' num2str(seg)]})
% %         else
% %             title({'AMI','Non-Targets',['Seg = ' num2str(seg)]})
% %         end
% %         xlabel('Time (Samples)')
% %         set(gcf, 'Position', get(0, 'Screensize'))
% %         saveas(gcf,['Results\', 'AMI XElec- Pt- ' num2str(pt) '- Seg- ' num2str(seg) '.jpg']);
% %         close all force   
% %     end
% 
%     %% Frequency
%     PatientsFreqDatasets = {};
% 
%     NLevel = 16; % Number of Quantizer levels
%     MAXAMIK = 100; % Maximum lag
% 
%     FreqBand = FreqBand_init();    
%     
%     % Freq Dataset
%     df=Fs/size(Segments{pt,1},3);
%     for f = 6:length(FreqBand)
%         disp(['Patient = ', num2str(pt), '  FreqBand = ', FreqBand(f).Name]);
%         Dataset_Train1 = [Segments{pt,1} ; Segments{pt,2}];
%         FreqRange=FreqBand(f).Range;   
%         Dataset_Freq = [];
%         for seg = 1:size(Dataset_Train1,1)
%             tmp = reshape(Dataset_Train1(seg,:,:),size(Dataset_Train1,2),size(Dataset_Train1,3));
%             Wtmp = tmp .* repmat(tukeywin(size(tmp,2))',size(tmp,1),1);
%             tmp1 = abs(fft(Wtmp,size(Wtmp,2),2));        
%             tmp2 = tmp1(:,max(1,round((FreqRange(1)/df))):round((FreqRange(2)/df)));
%             Dataset_Freq(seg,:,:) = tmp2;
%             clear tmp tmp1 tmp2
%         end
% %         FreqBand(f).PatientsDatasets{pt}.Dataset = Dataset_Freq;
% %         FreqBand(f).PatientsDatasets{pt}.Labels = PatientsDatasets{pt}.Labels;
%     
%         %-- unbalaced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(Dataset_Freq, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %-- balanced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(Dataset_Freq, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
%     
%         
%         %%---Dist - dataset - Euclidean
% 
%         DistMetricType = 'euclidean'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
%         [DistData] = DistGenerator(Dataset_Freq, DistMetricType);
% 
%             %-- unbalaced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Euclid_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Euclid_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %-- balanced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Euclid_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Euclid_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %%---Dist - dataset - cosine
% 
%         DistMetricType = 'cosine'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
%         [DistData] = DistGenerator(Dataset_Freq, DistMetricType);
% 
%             %-- unbalaced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Cos_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Cos_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %-- balanced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Cos_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Cos_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %%---Dist - dataset - correlation
% 
%         DistMetricType = 'correlation'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
%         [DistData] = DistGenerator(Dataset_Freq, DistMetricType);
% 
%             %-- unbalaced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Corr_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Corr_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %-- balanced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Corr_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_Corr_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
%         
%         %% -- Freq- AMIs
%         NLevel = 16;
%         Dataset_Freq_AMI = zeros(size(Dataset_Freq)-[0,1,0]);
%         for seg = 1:size(Dataset_Freq,1)
%             clear tmpSeg; tmpSeg(:,:) = Dataset_Freq(seg,:,:);
%             Dataset_Freq_AMI(seg,:,:) = AMIXcrosElec(tmpSeg',NLevel);
%         end
% 
%         %-- unbalaced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(Dataset_Freq_AMI, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %-- balanced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(Dataset_Freq_AMI, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %%---Dist - dataset - Euclidean
%         DistMetricType = 'euclidean'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
%         [DistData] = DistGenerator(Dataset_Freq_AMI, DistMetricType);
% 
%             %-- unbalaced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Euclid_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Euclid_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %-- balanced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Euclid_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Euclid_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %%---Dist - dataset - cosine
%         DistMetricType = 'cosine'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
%         [DistData] = DistGenerator(Dataset_Freq_AMI, DistMetricType);
% 
%             %-- unbalaced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Cos_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Cos_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %-- balanced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Cos_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Cos_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %%---Dist - dataset - correlation
%         DistMetricType = 'correlation'; % Dsitance types : 'euclidean', 'cosine', 'correlation'
%         [DistData] = DistGenerator(Dataset_Freq_AMI, DistMetricType);
% 
%             %-- unbalaced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Corr_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Corr_Unbal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%             %-- balanced - dataset
%         [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(DistData, Labels);
%         try
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Corr_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test');
%         catch
%             warning('Saved as version v7.3......');
%             save(['BCI_pt_',num2str(pt),'_',FreqBand(f).Name,'_AMI_Corr_bal.mat'],'Dataset_Train','Dataset_Test','Labels_Train','Labels_Test','-v7.3');
%         end
%         clear Dataset_Train Labels_Train Dataset_Test Labels_Test
% 
%         % Draw Samples ---- AMIs examples 
% %         for seg = 1:500
% %             tmpSegData = [];
% %             tmpSegData(:,:) =  Dataset_Freq_AMI(seg,:,:);
% % 
% %             figure('Visible','off')
% %             heatmap(tmpSegData,'GridVisible','off');
% %             if Labels(seg) == 1
% %                 title({'AMI','Targets',FreqBand(f).Name,['Seg = ' num2str(seg)]})
% %             else
% %                 title({'AMI','Non-Targets',FreqBand(f).Name,['Seg = ' num2str(seg)]})
% %             end
% %             xlabel('Time (Samples)')
% %             set(gcf, 'Position', get(0, 'Screensize'))
% %             saveas(gcf,['Results\', 'AMI XElec- Pat- ' num2str(pt) '- Seg- ' num2str(seg) '- ' FreqBand(f).Name '.jpg']);
% %             close all force   
% %         end
%         
%     end
% 
% end

%% Done        
disp('---------DONE--------');

%% Functions

function Kappa = CM2Kappa(CM)
%     Kappa = (2*(TP*TN - FN*FP))/((TP+FP)*(FP+TN) + (TP+FN)*(fn+tn))));
    Kappa = (2*(CM(2,2)*CM(1,1) - CM(2,1)*CM(1,2)))/((CM(2,2)+CM(1,2))*(CM(1,2)+CM(1,1)) + (CM(2,2)+CM(2,1))*(CM(2,1)+CM(1,1)));
%      TP = CM(2,2), TN = CM(1,1), FP = ,CM(1,2), FN = CM(2,1)
end

%Classification with Feature selection
function [Accuracies, Kappas, CMs] = KfoldQDAFS (Dataset,Labels,Kfolds,NumHighRankedFeatures,FSType,Balanced)

    % Balanced: 1=Balanced dataset, 2=Unbalanced
  
    % FSType: 1=fscmrmr 2=fscchi2 3=fsrftest ; 
    %         otherwise (e.g 0)=all features
    
    
    if Balanced == 1
        Labelstmp = Labels; Datasettmp = Dataset; clear Labels Dataset
        
        tmpidx = randsample(find(Labelstmp==0),length(find(Labelstmp==1)));
        tmpidx = [find(Labelstmp==1) ; tmpidx];

        Labels = Labelstmp(tmpidx,:);
        Dataset = Datasettmp(tmpidx,:);
    end
    
    
    Accuracies = [];
    Kappas = [];
    CMs = [];
    
    %QDA
    disp([num2str(Kfolds) '-Fold QDA crossvalidation: ']);
    indices = crossvalind('Kfold',Labels,Kfolds);

    for i = 1:Kfolds
        test = (indices == i); 
        train = ~test;
        
        switch FSType
            case 1
                [idx,scores] = fscmrmr(Dataset(train,:),Labels(train,:));
            case 2
                [idx,scores] = fscchi2(Dataset(train,:),Labels(train,:));
            case 3
                [idx,scores] = fsrftest(Dataset(train,:),Labels(train,:));
            otherwise
                idx = [1:size(Dataset,2)];
                NumHighRankedFeatures = size(Dataset,2);
        end
        
        MdlLinear = fitcdiscr(Dataset(train,idx(1:NumHighRankedFeatures)),Labels(train,:),'DiscrimType','pseudoQuadratic'); 
%         'diagquadratic' 'pseudoquadratic'

        Labels_Predict = predict(MdlLinear,Dataset(test,idx(1:NumHighRankedFeatures)));

        acc = 1 - (sum(abs(Labels(test,:)-Labels_Predict))/length(Labels(test,:)));
        [CM,order] = confusionmat(Labels(test,:),Labels_Predict,'Order',[0 1]);
%         cm = confusionchart(Labels(test,:),Labels_Predict);

        fprintf('Acc = %.3f, TP = %i, TN = %i, FP = %i, FN = %i.\n',acc,CM(2,2),CM(1,1),CM(1,2),CM(2,1));
        Accuracies = [Accuracies acc];
        Kappas = [Kappas CM2Kappa(CM)];
        CMs = [CMs ; CM];
    end
end

function [Accuracies, Kappas, CMs] = KfoldLDAFS (Dataset,Labels,Kfolds,NumHighRankedFeatures,FSType,Balanced)

    % Balanced: 1=Balanced dataset, 2=Unbalanced
  
    % FSType: 1=fscmrmr 2=fscchi2 3=fsrftest ; 
    %         otherwise (e.g 0)=all features
    
    
    if Balanced == 1
        Labelstmp = Labels; Datasettmp = Dataset; clear Labels Dataset
        
        tmpidx = randsample(find(Labelstmp==0),length(find(Labelstmp==1)));
        tmpidx = [find(Labelstmp==1) ; tmpidx];

        Labels = Labelstmp(tmpidx,:);
        Dataset = Datasettmp(tmpidx,:);
    end
    
    Accuracies = [];
    Kappas = [];
    CMs = [];
    
    %LDA
    disp([num2str(Kfolds) '-Fold LDA crossvalidation: ']);
    indices = crossvalind('Kfold',Labels,Kfolds);

    for i = 1:Kfolds
        test = (indices == i); 
        train = ~test;
        
        switch FSType
            case 1
                [idx,scores] = fscmrmr(Dataset(train,:),Labels(train,:));
            case 2
                [idx,scores] = fscchi2(Dataset(train,:),Labels(train,:));
            case 3
                [idx,scores] = fsrftest(Dataset(train,:),Labels(train,:));
            otherwise
                idx = [1:size(Dataset,2)];
                NumHighRankedFeatures = size(Dataset,2);
        end
        
        MdlLinear = fitcdiscr(Dataset(train,idx(1:NumHighRankedFeatures)),Labels(train,:));
%         'linear' 'diaglinear' 'pseudolinear'

        Labels_Predict = predict(MdlLinear,Dataset(test,idx(1:NumHighRankedFeatures)));

        acc = 1 - (sum(abs(Labels(test,:)-Labels_Predict))/length(Labels(test,:)));
        [CM,order] = confusionmat(Labels(test,:),Labels_Predict,'Order',[0 1]);
%         cm = confusionchart(Labels(test,:),Labels_Predict);

        fprintf('Acc = %.3f, TP = %i, TN = %i, FP = %i, FN = %i.\n',acc,CM(2,2),CM(1,1),CM(1,2),CM(2,1));
        Accuracies = [Accuracies acc];
        Kappas = [Kappas CM2Kappa(CM)];
        CMs = [CMs ; CM];
    end
end

function [Accuracies, Kappas, CMs] = KfoldLDAS5FoldTraining (Dataset,Labels,Kfolds,NumHighRankedFeatures,FSType,Balanced)

    % Balanced: 1=Balanced dataset, 2=Unbalanced
  
    % FSType: 1=fscmrmr 2=fscchi2 3=fsrftest ; 
    %         otherwise (e.g 0)=all features
    
    
    if Balanced == 1
        Labelstmp = Labels; Datasettmp = Dataset; clear Labels Dataset
        
        tmpidx = randsample(find(Labelstmp==0),length(find(Labelstmp==1)));
        tmpidx = [find(Labelstmp==1) ; tmpidx];

        Labels = Labelstmp(tmpidx,:);
        Dataset = Datasettmp(tmpidx,:);
    end
    
    Accuracies = [];
    Kappas = [];
    CMs = [];
    
    %LDA
    disp([num2str(Kfolds) '-Fold LDA crossvalidation: ']);
    indices = crossvalind('Kfold',Labels,Kfolds);

    for i = 1:Kfolds
        test = (indices == i); 
        train = ~test;
        
        switch FSType
            case 1
                [idx,scores] = fscmrmr(Dataset(train,:),Labels(train,:));
            case 2
                [idx,scores] = fscchi2(Dataset(train,:),Labels(train,:));
            case 3
                [idx,scores] = fsrftest(Dataset(train,:),Labels(train,:));
            otherwise
                idx = [1:size(Dataset,2)];
                NumHighRankedFeatures = size(Dataset,2);
        end
        tmpTrainACC = [];
        for ft = 1:length(idx)
            MdlLinear = fitcdiscr(Dataset(train,idx(1:ft)),Labels(train,:));
            Labels_Predict = predict(MdlLinear,Dataset(train,idx(1:ft)));
            acc = 1 - (sum(abs(Labels(train,:)-Labels_Predict))/length(Labels(train,:)));
            tmpTrainACC(ft) = acc;
        end
%         [~,ii] = max(tmpTrainACC);
%         NumHighRankedFeatures = ii;
        DifftmpTrainACC = diff(tmpTrainACC);
        idx(find(DifftmpTrainACC<=0)+1) = [];
%         MdlLinear = fitclinear(Dataset(train,idx(1:NumHighRankedFeatures)),Labels(train,:));
        MdlLinear = fitcdiscr(Dataset(train,idx),Labels(train,:));
        
        Labels_Predict = predict(MdlLinear,Dataset(test,idx));

        acc = 1 - (sum(abs(Labels(test,:)-Labels_Predict))/length(Labels(test,:)));
        [CM,order] = confusionmat(Labels(test,:),Labels_Predict,'Order',[0 1]);
%         cm = confusionchart(Labels(test,:),Labels_Predict);

        fprintf('Acc = %.3f, TP = %i, TN = %i, FP = %i, FN = %i.\n',acc,CM(2,2),CM(1,1),CM(1,2),CM(2,1));
        Accuracies = [Accuracies acc];
        Kappas = [Kappas CM2Kappa(CM)];
        CMs = [CMs ; CM];
    end
end

function [Accuracies, Kappas, CMs] = KfoldSVMFS (Dataset,Labels,Kfolds,NumHighRankedFeatures,FSType,Balanced)

    % Balanced: 1=Balanced dataset, 2=Unbalanced
  
    % FSType: 1=fscmrmr 2=fscchi2 3=fsrftest ; 
    %         otherwise (e.g 0)=all features
    
    
    if Balanced == 1
        Labelstmp = Labels; Datasettmp = Dataset; clear Labels Dataset
        
        tmpidx = randsample(find(Labelstmp==0),length(find(Labelstmp==1)));
        tmpidx = [find(Labelstmp==1) ; tmpidx];

        Labels = Labelstmp(tmpidx,:);
        Dataset = Datasettmp(tmpidx,:);
    end
      
    Accuracies = [];
    Kappas = [];
    CMs = [];
    % SVM
    disp([num2str(Kfolds) '-Fold SVM crossvalidation: ']);
    indices = crossvalind('Kfold',Labels,Kfolds);

    for i = 1:Kfolds
        test = (indices == i); 
        train = ~test;
        
        switch FSType
            case 1
                [idx,scores] = fscmrmr(Dataset(train,:),Labels(train,:));
            case 2
                [idx,scores] = fscchi2(Dataset(train,:),Labels(train,:));
            case 3
                [idx,scores] = fsrftest(Dataset(train,:),Labels(train,:));
            otherwise
                idx = [1:size(Dataset,2)];
                NumHighRankedFeatures = size(Dataset,2);
        end
        
        MdlLinear = fitclinear(Dataset(train,idx(1:NumHighRankedFeatures)),Labels(train,:));

        Labels_Predict = predict(MdlLinear,Dataset(test,idx(1:NumHighRankedFeatures)));

        acc = 1 - (sum(abs(Labels(test,:)-Labels_Predict))/length(Labels(test,:)));
        [CM,order] = confusionmat(Labels(test,:),Labels_Predict,'Order',[0 1]);
%         cm = confusionchart(Labels(test,:),Labels_Predict);

        fprintf('Acc = %.3f, TP = %i, TN = %i, FP = %i, FN = %i.\n',acc,CM(2,2),CM(1,1),CM(1,2),CM(2,1));
        Accuracies = [Accuracies acc];
        Kappas = [Kappas CM2Kappa(CM)];
        CMs = [CMs ; CM];
    end

end

function [Accuracies, Kappas, CMs] = KfoldSVMFS5FoldTraining (Dataset,Labels,Kfolds,NumHighRankedFeatures,FSType,Balanced)

    % Balanced: 1=Balanced dataset, 2=Unbalanced
  
    % FSType: 1=fscmrmr 2=fscchi2 3=fsrftest ; 
    %         otherwise (e.g 0)=all features
    
    
    if Balanced == 1
        Labelstmp = Labels; Datasettmp = Dataset; clear Labels Dataset
        
        tmpidx = randsample(find(Labelstmp==0),length(find(Labelstmp==1)));
        tmpidx = [find(Labelstmp==1) ; tmpidx];

        Labels = Labelstmp(tmpidx,:);
        Dataset = Datasettmp(tmpidx,:);
    end
      
    Accuracies = [];
    Kappas = [];
    CMs = [];
    % SVM
    disp([num2str(Kfolds) '-Fold SVM crossvalidation: ']);
    indices = crossvalind('Kfold',Labels,Kfolds);

    for i = 1:Kfolds
        test = (indices == i); 
        train = ~test;
        
        switch FSType
            case 1
                [idx,scores] = fscmrmr(Dataset(train,:),Labels(train,:));
            case 2
                [idx,scores] = fscchi2(Dataset(train,:),Labels(train,:));
            case 3
                [idx,scores] = fsrftest(Dataset(train,:),Labels(train,:));
            otherwise
                idx = [1:size(Dataset,2)];
                NumHighRankedFeatures = size(Dataset,2);
        end
        
        tmpTrainACC = [];
        for ft = 1:length(idx)
            MdlLinear = fitclinear(Dataset(train,idx(1:ft)),Labels(train,:));
            Labels_Predict = predict(MdlLinear,Dataset(train,idx(1:ft)));
            acc = 1 - (sum(abs(Labels(train,:)-Labels_Predict))/length(Labels(train,:)));
            tmpTrainACC(ft) = acc;
        end
%         [~,ii] = max(tmpTrainACC);
%         NumHighRankedFeatures = ii;
        DifftmpTrainACC = diff(tmpTrainACC);
        idx(find(DifftmpTrainACC<=0)+1) = [];
%         MdlLinear = fitclinear(Dataset(train,idx(1:NumHighRankedFeatures)),Labels(train,:));
        MdlLinear = fitclinear(Dataset(train,idx),Labels(train,:));
        
        Labels_Predict = predict(MdlLinear,Dataset(test,idx));

        acc = 1 - (sum(abs(Labels(test,:)-Labels_Predict))/length(Labels(test,:)));
        [CM,order] = confusionmat(Labels(test,:),Labels_Predict,'Order',[0 1]);
%         cm = confusionchart(Labels(test,:),Labels_Predict);

        fprintf('Acc = %.3f, TP = %i, TN = %i, FP = %i, FN = %i.\n',acc,CM(2,2),CM(1,1),CM(1,2),CM(2,1));
        Accuracies = [Accuracies acc];
        Kappas = [Kappas CM2Kappa(CM)];
        CMs = [CMs ; CM];
    end

end

%Changing Structure of BCI Average signals structure to Segments:
function [Segments, ChLabels, Fs, ChannInfo] = ImportingBCIAvgDatatoSegments(Filename)
    load(Filename);

    Fs = SampleRate;
    Segments = [];
    ChLabels = cell(ChannelCount,1);
    for ch = 1:ChannelCount
        Segments(:,ch,:) = eval([Channels(ch).Name '(:,:)']);
        ChLabels{ch} = Channels(ch).Name;
    end
    
    ChannInfo = Channels;
    [~,tmpInd,~] = intersect(ChLabels,'photo');
    Segments(:,tmpInd,:) = [];
    ChLabels(tmpInd) = [];
    ChannInfo(tmpInd) = [];
end

%Changing Structure BCI raw structure:
function [Segments, Labels, Fs, ChannInfo] = ImportingBCIData(Filename)
    load(Filename);

    Fs = SampleRate;
    Segments = zeros(SegmentCount,ChannelCount,length(t));
    Labels = cell(ChannelCount,1);
    for ch = 1:ChannelCount
        for Seg = 1:SegmentCount
            Segments(Seg,ch,:) = eval([Channels(ch).Name '(Seg,:)']);
        end
        Labels{ch} = Channels(ch).Name;
    end
    ChannInfo = Channels;
    Segments(:,33:end,:) = [];
end

function [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorUnbal(Dataset, Labels,Kfold)
    %Labels are 0 or 1
    Labels_Train = Labels;
    Dataset_Train = Dataset;
    Dataset_Test = []; Labels_Test = [];
    TrainTestRatio = (1/Kfold);
    
    tmp1 = find(Labels_Train==1);
    tmp11 = randsample(tmp1,floor(length(tmp1)*TrainTestRatio));

    tmp0 = find(Labels_Train==0);
    tmp00 = randsample(tmp0,floor(length(tmp0)*TrainTestRatio));

    for t = 1:length(tmp11)
        Dataset_Test(end+1,:,:) = Dataset_Train(tmp11(t),:,:);
        Labels_Test(end+1,1) = Labels_Train(tmp11(t));
    end
    for t = 1:length(tmp00)
        Dataset_Test(end+1,:,:) = Dataset_Train(tmp00(t),:,:);
        Labels_Test(end+1,1) = Labels_Train(tmp00(t));
    end
    tmp01 = sort([tmp00;tmp11],'descend');
    for t = 1:length(tmp01)
        Dataset_Train(tmp01(t),:,:) = [];
        Labels_Train(tmp01(t)) = [];
    end

end

function [Dataset_Train,Labels_Train,Dataset_Test,Labels_Test] = DatasetGeneratorBal(Dataset, Labels,Kfold)
    %Labels are 0 or 1
    Labels_Train = Labels;
    Dataset_Train = Dataset;
    Dataset_Test = []; Labels_Test = [];
    TrainTestRatio = (1/Kfold);
    
    tmp1 = find(Labels_Train==1);
    tmp11 = randsample(tmp1,floor(length(tmp1)*TrainTestRatio));

    tmp0 = find(Labels_Train==0);
    tmp00 = randsample(tmp0,floor(length(tmp1)*TrainTestRatio));

    for t = 1:length(tmp11)
        Dataset_Test(end+1,:,:) = Dataset_Train(tmp11(t),:,:);
        Labels_Test(end+1,1) = Labels_Train(tmp11(t));
    end
    for t = 1:length(tmp00)
        Dataset_Test(end+1,:,:) = Dataset_Train(tmp00(t),:,:);
        Labels_Test(end+1,1) = Labels_Train(tmp00(t));
    end

    tmp01 = sort([tmp00;tmp11],'descend');
    for t = 1:length(tmp01)
        Dataset_Train(tmp01(t),:,:) = [];
        Labels_Train(tmp01(t)) = [];
    end

    tmp1 = find(Labels_Train==1);
    tmp00 = randsample(find(Labels_Train==0),length(find(Labels_Train==0))-length(tmp1));
    Dataset_Train(tmp00,:,:) = [];
    Labels_Train(tmp00) = [];
end

function [Dataset_Train1,Labels_Train1,Dataset_Test1,Labels_Test1] = PatientSpecDatasetsGenerator (PatientsDatasets, NumTestSample)

Dataset_Train = [];
AMIDataset_Train = [];
Labels_Train = [];
Dataset_Test1 = [];
AMIDataset_Test1 = [];
Labels_Test1 = [];

for s = 1:length(PatientsDatasets) 
    if s == NumTestSample
        Dataset_Test1 = PatientsDatasets{s}.Dataset;
        Labels_Test1 = PatientsDatasets{s}.Labels;
    else
        Dataset_Train = [Dataset_Train ; PatientsDatasets{s}.Dataset];
        Labels_Train = [Labels_Train ; PatientsDatasets{s}.Labels];
    end
end

p1 = randperm(length(Labels_Train)); % Shuffle the dataset
Labels_Train1 = Labels_Train(p1);
Dataset_Train1 = Dataset_Train(p1,:,:);

end

function [DistData] = DistGenerator(Data, DistMetricType)

    tmp = size(Data);
    DistData = zeros(tmp(1),tmp(2),tmp(2));

    for seg = 1:size(Data,1)
        tmp11(:,:) = Data(seg,:,:);
        D = pdist(tmp11, DistMetricType);
        DistData(seg,:,:) = squareform(D);
    end
end

function [AMIs] = AMIElec(Data,NLevel,MAXAMIK)
%[AMIs] = AMI(Data,NLevel,MAXAMIK)
%   Calculate the AMI by uniformly quantization. The Data should be a row
%   vector or a row matrix.
    
    Mins = min(Data(:));
    Maxs = max(Data(:));
    
    NormData = ((2.*Data)-(Maxs+Mins))./(Maxs-Mins);
    Data = NormData;
    Levels = [-1:((1)-(-1))/NLevel:1];
    
    NRow = size(Data,1);
    TotalSamp = size(Data,2);
    AMIs = zeros(NRow, MAXAMIK);
    JointProb = zeros(NLevel);
    Prob = zeros(1,NLevel);

    for m = 1:NLevel
       tmp = Data >= Levels(m) & Data < Levels(m+1);
       Prob(m) = sum(tmp(:))/length(Data(:));
    end

    Loc = cell(1,NLevel);
    for i = 1:NRow
        for m = 1:NLevel
            Loc{m} = find(Data(i,:) >= Levels(m) & Data(i,:) < Levels(m+1));
        end
        for k = 1:MAXAMIK
            for p = 1:NLevel
                for q = 1:NLevel
                    [Lia,~] = ismember(Loc{p},Loc{q}-k);
                    JointProb(p,q) = sum(Lia)/(TotalSamp-k);
                    if Prob(p)~= 0 && Prob(q)~=0 && JointProb(p,q)~=0
                        AMIs(i,k) = AMIs(i,k) + JointProb(p,q)*log2(JointProb(p,q)/(Prob(p)*Prob(q)));
                    end
                end
            end
        end
    end
end

function [PrePostAMIs] = AllAMIELECGenerator(Dataset_Train1, NLevel, MAXAMIK)

    PreAMIs = zeros(size(Dataset_Train1,1),size(Dataset_Train1,2)/2,MAXAMIK);
    PostAMIs = zeros(size(Dataset_Train1,1),size(Dataset_Train1,2)/2,MAXAMIK);
    PreDataset = Dataset_Train1(:,1:256,:);
    PostDataset = Dataset_Train1(:,257:end,:);
    parfor elec = 1:size(PreDataset,2)
        tmpDataElec = [];
        tmpDataElec(:,:) = PreDataset(:,elec,:);
        PreAMIs(:,elec,:) = AMIElec(tmpDataElec,NLevel,MAXAMIK);
    end
    parfor elec = 1:size(PostDataset,2)
        tmpDataElec = [];
        tmpDataElec(:,:) = PostDataset(:,elec,:);
        PostAMIs(:,elec,:) = AMIElec(tmpDataElec,NLevel,MAXAMIK);
    end
    PrePostAMIs = zeros(size(Dataset_Train1,1),size(Dataset_Train1,2),MAXAMIK);
    PrePostAMIs = [PreAMIs PostAMIs];

end

function [AMIs] = AMIXcrosElec(Data,NLevel)
% Data should contain samples in rows and electrodes in columns
    MAXAMIK = size(Data,2) - 1;

    Mins = min(Data(:));
    Maxs = max(Data(:));

    NormData = ((2.*Data)-(Maxs+Mins))./(Maxs-Mins);
    Data = NormData;
    Levels = [-1:((1)-(-1))/NLevel:1];

    NRow = size(Data,1);
    TotalSamp = size(Data,2);
    AMIs = zeros(NRow, MAXAMIK);
    JointProb = zeros(NLevel);
    Prob = zeros(1,NLevel);

    for m = 1:NLevel
       tmp = Data >= Levels(m) & Data < Levels(m+1);
       Prob(m) = sum(tmp(:))/length(Data(:));
    end

    Loc = cell(1,NLevel);
    for i = 1:NRow
        for m = 1:NLevel
            Loc{m} = find(Data(i,:) >= Levels(m) & Data(i,:) < Levels(m+1));
        end
        for k = 1:MAXAMIK
            for p = 1:NLevel
                for q = 1:NLevel
                    tmpq = Loc{q}-k;
%                     tmpq(tmpq<0) = tmpq(tmpq<0) + MAXAMIK;
                    [Lia,~] = ismember(Loc{p},tmpq);
                    JointProb(p,q) = sum(Lia)/(TotalSamp-k);
                    if Prob(p)~= 0 && Prob(q)~=0 && JointProb(p,q)~=0
                        AMIs(i,k) = AMIs(i,k) + JointProb(p,q)*log2(JointProb(p,q)/(Prob(p)*Prob(q)));
                    end
                end
            end
        end
    end
    AMIs = AMIs';
end
            
function [PrePostAMIs] = AllAMITimeGenerator(Dataset_Train1, NLevel)

    PreAMIs = zeros(size(Dataset_Train1,1),(size(Dataset_Train1,2)/2)-1,size(Dataset_Train1,3));
    PostAMIs = zeros(size(Dataset_Train1,1),(size(Dataset_Train1,2)/2)-1,size(Dataset_Train1,3));
    PreDataset = Dataset_Train1(:,1:256,:);
    PostDataset = Dataset_Train1(:,257:end,:);
    parfor seg = 1:size(PreDataset,1)
        tmpDataElec = [];
        tmpDataElec(:,:) = PreDataset(seg,:,:);
        PreAMIs(seg,:,:) = AMIXcrosElec(tmpDataElec,NLevel);
    end
    parfor seg = 1:size(PostDataset,1)
        tmpDataElec = [];
        tmpDataElec(:,:) = PostDataset(seg,:,:);
        PostAMIs(seg,:,:) = AMIXcrosElec(tmpDataElec,NLevel);
    end
    PrePostAMIs = zeros(size(Dataset_Train1,1),size(Dataset_Train1,2)-2,size(Dataset_Train1,3));
    PrePostAMIs = [PreAMIs PostAMIs];

end

% * 1) FreqBand initials
function FreqBand = FreqBand_init(varargin)
    %- MaxF is the Nyquist freq.
    
     if ~isempty(varargin) && isa(varargin{1},'double')
         MaxF = floor(varargin{1});
     else
         MaxF = 125;
     end
    
    FreqBand(1).Range = [0.5 4];
    FreqBand(1).Name = 'Delta';
    FreqBand(2).Range = [4 8];
    FreqBand(2).Name = 'Theta';
    FreqBand(3).Range = [8 14];
    FreqBand(3).Name = 'Alpha';
    FreqBand(4).Range = [14 30];
    FreqBand(4).Name = 'Beta';
    FreqBand(5).Range = [30 80];
    FreqBand(5).Name = 'Gamma';
    FreqBand(6).Range = [80 MaxF];
    FreqBand(6).Name = 'High-Gamma';
    FreqBand(7).Range = [0.5 8];
    FreqBand(7).Name = 'Delta-Theta'; 
    FreqBand(8).Range = [4 14];
    FreqBand(8).Name = 'Theta-Alpha';
    FreqBand(9).Range = [8 30];
    FreqBand(9).Name = 'Alpha-Beta';
    FreqBand(10).Range = [14 80];
    FreqBand(10).Name = 'Beta-Gamma';
    FreqBand(11).Range = [30 MaxF];
    FreqBand(11).Name = 'Gammas';
    FreqBand(12).Range = [0.5 MaxF];
    FreqBand(12).Name = 'All';
    
end

