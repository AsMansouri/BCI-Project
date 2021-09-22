clear;
clc;

%% Dataset folder
DatasetFold = ['Z:\BCI_learning\P300_VSD_EEG_Research\Data\Processed EEG Data\Contextual\Adults\Diff-Waves\'];

  
%% Regions
Regions.Chann = {[1:4,30:32];[6,7,8,9,12,11,13,14,15,19,22:25,26,20,28,29];[6,9,8,11,14,15];[28,26,25,22,19,20];[16:18]};
Regions.Labels = {'Frontal';'Centro-Parietal';'L-CP';'R-CP';'Occipital'};
        
% 1) a frontal bin (average for the F elects), 
% 2) centro-parietal (average of the FC/C/CP/P elecs), 
% 3) Left centro-parietal (average of the FC/C/CP/P elecs on the Left Hemisphere), 
% 4) Right centro-parietal (average of the FC/C/CP/P elecs on the Right Hemisphere), and 
% 5) Occipital bin (average o elec).
%% ERP features
StimulousStart = 0.1; %seconds

ERPs.Ranges = {[0.090 0.230]+StimulousStart ; [0.150 0.500]+StimulousStart ; [0.400 0.700]+StimulousStart ; [0.625 0.720]+StimulousStart};
ERPs.Tags = {'N170' ; 'P300' ; 'N400+' ; 'P600'};
ERPs.Time = { [0.170 + StimulousStart] ; [0.300 + StimulousStart] ;[0.400 + StimulousStart] ; [0.600 + StimulousStart]};

ERPs.Regions.Chann = {{[];[12,11,13,14,15,22,19,20];[9,11,14,15];[26,22,19,20];[16:18]};...
                      {[1:4,30:32];[6,7,8,9,12,11,13,14,15,19,22:25,26,20,28,29];[6,9,8,11,14,15];[28,26,25,22,19,20];[16:18]};...
                      {[2,3,30];[7,12,11,13,14,15,19,22:23,20,29];[9,11,14,15];[26,22,19,20];[16:18]};...
                      {[];[8,9,12,13,14,22:25];[9,8,11,14];[26,25,22,19];[]}};

Paradigms = {'Grid', 'RandLoc', 'Scene'};

XLNameAmp = ['Results-BCI-ERPs-',datestr(now,'HH-MM-SS'),'-Amplitudes.xlsx'];
XLNameLat = ['Results-BCI-ERPs-',datestr(now,'HH-MM-SS'),'-Latency.xlsx'];


%% Reading Samples

for o = 1:length(Paradigms)
    for pt = 1:20
        if pt == 8 || pt == 9
            continue;
        end
        
        tmpfileAdd = [DatasetFold 'P' num2str(pt) '_Diff._Waves-' Paradigms{o} '-TvsNT.mat'];
        [PtSegments{pt,o}, Labels, Fs, ChannInfo] = ImportingBCIData(tmpfileAdd);

    end
end

%% ERPs extractions

for f = 1:length(ERPs.Tags)
%     for Elec = 1:32

    FeatureMat_DiffTvsNT = [];
    
    tmpHeader = {'Pt';'Pt'};
    for o = 1:length(Paradigms)
        
        for pt = 1:20
            if pt == 8 || pt == 9
                continue;
            end
%             for f = 1:length(ERPs.Tags)
            for Elec = 1:32
                if ERPs.Tags{f}(1) =='P'
                    [FeatureMat_DiffTvsNT.Peaks(pt,length(Paradigms)*(Elec-1) + o),Ind] = max(PtSegments{pt,o}(1,Elec,ERPs.Ranges{f}(1)*Fs:ERPs.Ranges{f}(2)*Fs),[],3);
                else
                    [FeatureMat_DiffTvsNT.Peaks(pt,length(Paradigms)*(Elec-1) + o),Ind] = min(PtSegments{pt,o}(1,Elec,ERPs.Ranges{f}(1)*Fs:ERPs.Ranges{f}(2)*Fs),[],3);
                end
                    
                FeatureMat_DiffTvsNT.Latency(pt,length(Paradigms)*(Elec-1) + o) = ((Ind - 1)/ Fs) + ERPs.Ranges{f}(1) - StimulousStart;
                tmpHeader{1,length(Paradigms)*(Elec-1) + o + 1} = Labels{Elec};
                tmpHeader{2,length(Paradigms)*(Elec-1) + o + 1} = Paradigms{o};
            end
        end    
    end
    
    XLLine = 1;
    xlswrite(XLNameAmp,tmpHeader,ERPs.Tags{f},['A' num2str(XLLine)]);
    xlswrite(XLNameLat,tmpHeader,ERPs.Tags{f},['A' num2str(XLLine)]);
    
    XLLine = XLLine + size(tmpHeader,1);
    xlswrite(XLNameAmp,[[1:20]' , FeatureMat_DiffTvsNT.Peaks ],ERPs.Tags{f},['A' num2str(XLLine)]);
    xlswrite(XLNameLat,[[1:20]' , FeatureMat_DiffTvsNT.Latency ],ERPs.Tags{f},['A' num2str(XLLine)]);
    
    for r = 1:length(ERPs.Regions.Chann{f})
        if isempty(ERPs.Regions.Chann{f}{r})
            continue;
        end
        XLLine = 1;
        
        HeaderInd = (ERPs.Regions.Chann{f}{r} .* ones(length(Paradigms),1)*length(Paradigms)') - [length(Paradigms)-1:-1:0]';
        
        xlswrite(XLNameAmp,tmpHeader(:,[1,HeaderInd(:)'+1]),[ERPs.Tags{f} '-' Regions.Labels{r}],['A' num2str(XLLine)]);
        xlswrite(XLNameLat,tmpHeader(:,[1,HeaderInd(:)'+1]),[ERPs.Tags{f} '-' Regions.Labels{r}],['A' num2str(XLLine)]);

        XLLine = XLLine + size(tmpHeader,1);
        tmpAverages_Peaks = [mean(FeatureMat_DiffTvsNT.Peaks(:,HeaderInd(1,:)),2),...
                             mean(FeatureMat_DiffTvsNT.Peaks(:,HeaderInd(2,:)),2),...
                             mean(FeatureMat_DiffTvsNT.Peaks(:,HeaderInd(3,:)),2)];
        tmpAverages_Latency = [mean(FeatureMat_DiffTvsNT.Latency(:,HeaderInd(1,:)),2),...
                             mean(FeatureMat_DiffTvsNT.Latency(:,HeaderInd(2,:)),2),...
                             mean(FeatureMat_DiffTvsNT.Latency(:,HeaderInd(3,:)),2)];
                         
        xlswrite(XLNameAmp,[[1:20]' , FeatureMat_DiffTvsNT.Peaks(:,HeaderInd(:)),tmpAverages_Peaks ],[ERPs.Tags{f} '-' Regions.Labels{r}],['A' num2str(XLLine)]);
        xlswrite(XLNameLat,[[1:20]' , FeatureMat_DiffTvsNT.Latency(:,HeaderInd(:)),tmpAverages_Latency ],[ERPs.Tags{f} '-' Regions.Labels{r}],['A' num2str(XLLine)]);
    end
    
    tmpHeader = {'Pt';'Pt'};
    
    FeatureMat_DiffTvsNT_Regions = [];
    for r = 1:length(Regions.Chann)
        ElecPara_Indx = 3*(Regions.Chann{r}-1)+[1,2,3]';

        for o = 1:length(Paradigms)

            FeatureMat_DiffTvsNT_Regions.Peaks(:,length(Paradigms)*(r-1)+o) = mean(FeatureMat_DiffTvsNT.Peaks(:,ElecPara_Indx(o,:)),2);
            FeatureMat_DiffTvsNT_Regions.Latency(:,length(Paradigms)*(r-1)+o) = mean(FeatureMat_DiffTvsNT.Latency(:,ElecPara_Indx(o,:)),2);
            tmpHeader{1,length(Paradigms)*(r-1) + o + 1} = Regions.Labels{r};
            tmpHeader{2,length(Paradigms)*(r-1) + o + 1} = Paradigms{o};
        end
            
    end
    
    XLLine = 1;
    xlswrite(XLNameAmp,tmpHeader,[ERPs.Tags{f} '- Regions'],['A' num2str(XLLine)]);
    xlswrite(XLNameLat,tmpHeader,[ERPs.Tags{f} '- Regions'],['A' num2str(XLLine)]);
    
    XLLine = XLLine + size(tmpHeader,1);
    xlswrite(XLNameAmp,[[1:20]' , FeatureMat_DiffTvsNT_Regions.Peaks ],[ERPs.Tags{f} '- Regions'],['A' num2str(XLLine)]);
    xlswrite(XLNameLat,[[1:20]' , FeatureMat_DiffTvsNT_Regions.Latency ],[ERPs.Tags{f} '- Regions'],['A' num2str(XLLine)]);
    
    
    
end
   

%% Done        
disp('---------DONE--------');

%% Functions

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

