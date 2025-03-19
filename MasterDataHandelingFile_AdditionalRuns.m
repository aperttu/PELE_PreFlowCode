% this script is to read in the data for each experiment and save in
% correct location with the time corrected and cut to appropriate size 
% this will also generated the experimental conditions for each expieriment
% as well as the scrupture for all of them. 
%
% naming conventions is sensorstype_YYYYMMDD_expname.mat 

% A. Perttu 20250114 
% new set of runs 250228

%% set envrionment 
clear all
close all

addpath Scripts\ 

%% Data Quality structures Infrasound
% Data Quality Tsunami 
DQT1.Sensor = {'PCB_P1_4','PCB_P1_15','PCB_P1_30','PCB_P1_45',...
    'PCB_P1_75','PCB_P1_120','PCB_P2_15','PCB_P2_30','PCB_P2_45',...
    'PCB_P2_75','PCB_P3_15','PCB_P3_30','PCB_P3_45','PCB_P3_75',...
    'PCB_P4_15','PCB_P4_30','PCB_P4_45','PCB_P4_75','PCB_P5_15',...
    'PCB_P5_30','PCB_P5_45','PCB_P5_75','TP1_4','TP1_15','TP1_30',...
    'TP1_45','TP1_75','TP1_120','TP2_15','TP2_30','TP2_45',...
    'TP2_75','TP2_120','TP3_15','TP3_30','TP3_45','TP3_75',...
    'TP3_120','TP4_15','TP4_30','TP4_45','TP4_75','TP5_4',...
    'TP5_15','TP5_30','TP5_45','TP5_75','TP5_120'}; 
    % PCB P2 30 noisy 

DQT1.Status = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1];


%save('SensorData/Tsunami1_DQ.mat','DQT1','-mat')

% Data Quality Mie
DQM1.Sensor = {};
DQM1.Status = [];

%save('SensorData/Mie1_DQ.mat','DQT1','-mat')

%% load data Expriment Tsunami 1 
T0 = -5;

load D:DATA\PELE\Experiments\230513_TsuExp1\PCB_230513.mat
flds1 = fields(PCB);
PI = min(find(PCB.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            PCBT1.Time = PCB.(flds1{i})(PI:end)+1/1000;
        case 'Trigger'
            PCBT1.Trigger = PCB.(flds1{i})(PI:end); 
        case 'Fs'
            PCBT1.Fs = PCB.Fs; 
        otherwise % the data fields 
            tmp = flds1{i}([1:7,10:end]); % check the status of the sensor
            Ind = find(strcmp(tmp,DQT1.Sensor) == 1);
            if DQT1.Status(Ind) == 1 % only save when DQ = 1
                PCBT1.(flds1{i}(5:end)) = PCB.(flds1{i})(PI:end);
            end
    end
end
clear PCB flds1 tmp Ind

load D:DATA\PELE\Experiments\230513_TsuExp1\Therm_230513.mat
flds1 = fields(Therm);
PT = min(find(Therm.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            ThermT1.Time = Therm.(flds1{i})(PT:end);
        case 'Trigger'
            ThermT1.Trigger = Therm.(flds1{i})(PT:end);
        case 'Fs'
            ThermT1.Fs = Therm.Fs;
        otherwise
            tmp = ['TP' flds1{i}([3,6:end])]; % check the status of the sensor
            Ind = find(strcmp(tmp,DQT1.Sensor) == 1);
            if DQT1.Status(Ind) == 1 % only save when DQ = 1
                ThermT1.(flds1{i}) = Therm.(flds1{i})(PT:end);
            end
    end
end
clear Therm flds1

load D:\DATA\PELE\Experiments\230513_TsuExp1\INFRASOUND_230513.mat
flds1 = fields(Infra);
II = min(find(Infra.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            InfraT1.Time = Infra.(flds1{i})(II:end);
        case 'Trigger'
            InfraT1.Trigger = Infra.(flds1{i})(II:end);
        case 'Fs'
            InfraT1.Fs = Infra.Fs;
        otherwise 
            InfraT1.(flds1{i}) = Infra.(flds1{i})(II:end);
    end
end
clear Infra flds1

load D:\DATA\PELE\Experiments\230513_TsuExp1\Hopper_230513.mat
HI = min(find(Hopper.Time >= T0));
HopperT1.Time = Hopper.Time(HI:end);
HopperT1.Trigger = Hopper.Trigger(HI:end);
HopperT1.Weight = Hopper.Hopperweight(HI:end);
HopperT1.Temp = Hopper.HopperTemp(HI:end);
HopperT1.Fs = Hopper.Fs; 

% Save
Code = '230513_TsuExp1';
save(['SensorData\PCB_' Code '.mat'],'PCBT1','-mat')
save(['SensorData\Therm_' Code '.mat'],'ThermT1','-mat')
save(['SensorData\Infra_' Code '.mat'],'InfraT1','-mat')
save(['SensorData\Hopper_' Code '.mat'],'HopperT1','-mat')

%% Expriment Tsunami 2
T0 = -5;

load D:DATA\PELE\Experiments\230611_TsuExp2\PCB_230611.mat
flds1 = fields(PCB);
PI = min(find(PCB.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            PCBT2.Time = PCB.(flds1{i})(PI:end)+1/1000;
        case 'Trigger'
            PCBT2.Trigger = PCB.(flds1{i})(PI:end); 
        case 'Fs'
            PCBT2.Fs = PCB.Fs; 
        otherwise % the data fields 
            PCBT2.(flds1{i}(5:end)) = PCB.(flds1{i})(PI:end);
    end
end
clear PCB flds1 tmp Ind

load D:DATA\PELE\Experiments\230611_TsuExp2\Therm_230611.mat
flds1 = fields(Therm);
PT = min(find(Therm.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            ThermT2.Time = Therm.(flds1{i})(PT:end);
        case 'Trigger'
            ThermT2.Trigger = Therm.(flds1{i})(PT:end);
        case 'Fs'
            ThermT2.Fs = Therm.Fs;
        otherwise
            ThermT2.(flds1{i}) = Therm.(flds1{i})(PT:end);
    end
end
clear Therm flds1

load D:\DATA\PELE\Experiments\230611_TsuExp2\INFRASOUND_230611.mat
flds1 = fields(Infra);
II = min(find(Infra.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            InfraT2.Time = Infra.(flds1{i})(II:end);
        case 'Trigger'
            InfraT2.Trigger = Infra.(flds1{i})(II:end);
        case 'Fs'
            InfraT2.Fs = Infra.Fs;
        otherwise 
            InfraT2.(flds1{i}) = Infra.(flds1{i})(II:end);
    end
end
clear Infra flds1

load D:\DATA\PELE\Experiments\230611_TsuExp2\Hopper_230611.mat
HI = min(find(Hopper.Time >= T0));
HopperT2.Time = Hopper.Time(HI:end);
HopperT2.Trigger = Hopper.Trigger(HI:end);
HopperT2.Weight = Hopper.Hopperweight(HI:end);
HopperT2.Temp = Hopper.HopperTemp(HI:end);
HopperT2.Fs = Hopper.Fs; 
clear Hopper 

% Save
Code = '230611_TsuExp2';
save(['SensorData\PCB_' Code '.mat'],'PCBT2','-mat')
save(['SensorData\Therm_' Code '.mat'],'ThermT2','-mat')
save(['SensorData\Infra_' Code '.mat'],'InfraT2','-mat')
save(['SensorData\Hopper_' Code '.mat'],'HopperT2','-mat')

%% Experiment 3 
T0 = -5;

load ../../231018_TsuExp3_PF/matData/PCB_231018.mat
flds1 = fields(PCB);
PI = min(find(PCB.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            PCBT3.Time = PCB.(flds1{i})(PI:end)+1/1000;
        case 'Trigger'
            PCBT3.Trigger = PCB.(flds1{i})(PI:end); 
        case 'Fs'
            PCBT3.Fs = 1000; 
        otherwise % the data fields 
            PCBT3.(flds1{i}(5:end)) = PCB.(flds1{i})(PI:end);
    end
end
PCBT3.Fs = 1000; 
PCBT3.Fs = 1000; 
clear PCB flds1 tmp Ind

load D:DATA\PELE\Experiments\231018_TsuExp3\INFRASOUND_231018.mat
flds1 = fields(Infra);
II = min(find(Infra.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            InfraT3.Time = Infra.(flds1{i})(II:end);
        case 'Trigger'
            InfraT3.Trigger = Infra.(flds1{i})(II:end);
        case 'Fs'
            InfraT3.Fs = 1000;
        otherwise 
            InfraT3.(flds1{i}) = Infra.(flds1{i})(II:end);
    end
end
InfraT3.Fs = 1000;
clear Infra flds1

load D:DATA\PELE\Experiments\231018_TsuExp3\MIC_231018.mat
flds1 = fields(MIC);
MI = min(find(MIC.Time >= T0));
for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            MICT3.Time = MIC.(flds1{i})(MI:end);
        case 'Trigger'
            MICT3.Trigger = MIC.(flds1{i})(MI:end);
        case 'Fs'
            MICT3.Fs = 44100;
        otherwise 
            MICT3.(flds1{i}) = MIC.(flds1{i})(MI:end);
    end
end
MICT3.Fs = 44100;
clear MIC flds1

load ../../231018_TsuExp3_PF/matData/Hopper_231018.mat
HI = min(find(Hopper.Time >= T0));
HopperT3.Time = Hopper.Time(HI:end);
HopperT3.Trigger = Hopper.Trigger(HI:end);
HopperT3.Weight = Hopper.Weight(HI:end);
HopperT3.Temp = Hopper.HopperTemp(HI:end);
HopperT3.Fs = 72; 
clear Hopper 

% Save
Code = '231018_TsuExp3';
save(['SensorData\PCB_' Code '.mat'],'PCBT3','-mat')
save(['SensorData\Infra_' Code '.mat'],'InfraT3','-mat')
save(['SensorData\Hopper_' Code '.mat'],'HopperT3','-mat')
save(['SensorData\Mic_' Code '.mat'],'MICT3','-mat')

%% Experiment 4
T0 = -5;

load ../../231123_TsuExp4_PFH/matData/PCB_231123.mat
flds1 = fields(PCB);
PI = min(find(PCB.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            PCBT4.Time = PCB.(flds1{i})(PI:end)+1/1000;
        case 'Trigger'
            PCBT4.Trigger = PCB.(flds1{i})(PI:end); 
        case 'Fs'
            PCBT4.Fs = 1000; 
        otherwise % the data fields 
            PCBT4.(flds1{i}(5:end)) = PCB.(flds1{i})(PI:end);
    end
end
PCBT4.Fs = 1000; 
clear PCB flds1 tmp Ind

load D:DATA\PELE\Experiments\231123_TsuExp4\INFRASOUND_231123.mat
flds1 = fields(Infra);
II = min(find(Infra.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            InfraT4.Time = Infra.(flds1{i})(II:end);
        case 'Trigger'
            InfraT4.Trigger = Infra.(flds1{i})(II:end);
        case 'Fs'
            InfraT4.Fs = 1000;
        otherwise 
            InfraT4.(flds1{i}) = Infra.(flds1{i})(II:end);
    end
end
InfraT4.Fs = 1000;
clear Infra flds1

load D:DATA\PELE\Experiments\231123_TsuExp4\MIC_231123.mat
flds1 = fields(MIC);
MI = min(find(MIC.Time >= T0));
for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            MICT4.Time = MIC.(flds1{i})(MI:end);
        case 'Trigger'
            MICT4.Trigger = MIC.(flds1{i})(MI:end);
        case 'Fs'
            MICT4.Fs = 44100;
        otherwise 
            MICT4.(flds1{i}) = MIC.(flds1{i})(MI:end);
    end
end
MICT4.Fs = 44100;
clear MIC flds1

load ../../231123_TsuExp4_PFH/matData/Hopper_231123.mat  
HI = min(find(Hopper.Time >= T0));
HopperT4.Time = Hopper.Time(HI:end);
HopperT4.Trigger = Hopper.Trigger(HI:end);
HopperT4.Weight = Hopper.Weight(HI:end);
HopperT4.Temp = Hopper.HopperTemp(HI:end);
HopperT4.Fs = 72; 
clear Hopper 

% Save
Code = '231123_TsuExp4';
save(['SensorData\PCB_' Code '.mat'],'PCBT4','-mat')
save(['SensorData\Infra_' Code '.mat'],'InfraT4','-mat')
save(['SensorData\Hopper_' Code '.mat'],'HopperT4','-mat')
save(['SensorData\Mic_' Code '.mat'],'MICT4','-mat')

%% Mie 1
T0 = -5;

load D:DATA\PELE\Experiments\190113_Mie1\Infra_190112.mat
load D:\DATA\PELE\Experiments\190113_Mie1\Hopper_190112.mat

flds1 = fields(Infra);
II = min(find(Infra.Time >= T0));
for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            InfraM1.Time = Infra.(flds1{i})(II:end);
        case 'Trigger'
            InfraM1.Trigger = Infra.(flds1{i})(II:end);
        case 'Fs'
            InfraM1.Fs = 1000;
        otherwise 
            InfraM1.(flds1{i}) = Infra.(flds1{i})(II:end);
    end
end

flds1 = fields(Infra2);
II = min(find(Infra2.Time >= T0));
for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            InfraM1b.Time = Infra2.(flds1{i})(II:end);
        case 'Trigger'
            InfraM1b.Trigger = Infra2.(flds1{i})(II:end);
        case 'Fs'
            InfraM1b.Fs = Infra2.Fs;
        otherwise 
            InfraM1b.(flds1{i}) = Infra2.(flds1{i})(II:end);
    end
end
clear Infra flds1 Infra2

HopperM1.Time = Hopper.Time-0.361;
HopperM1.Weight = Hopper.Hopperweight;
HopperM1.Fs = Hopper.Fs;
clear Hopper 

% save 
Code = '20190113_Mie1';
save(['SensorData\Infra_' Code '.mat'],'InfraM1','InfraM1b','-mat')
save(['SensorData\Hopper_' Code '.mat'],'HopperM1','-mat')

%% Mie 2
T0 = -5;

load D:DATA\PELE\Experiments\190119_Mie2\Infra_190118.mat
load D:\DATA\PELE\Experiments\190119_Mie2\Hopper_190118.mat

flds1 = fields(Infra);
II = min(find(Infra.Time >= T0));
for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            InfraM2.Time = Infra.(flds1{i})(II:end);
        case 'Trigger'
            InfraM2.Trigger = Infra.(flds1{i})(II:end);
        case 'Fs'
            InfraM2.Fs = 1000;
        otherwise 
            InfraM2.(flds1{i}) = Infra.(flds1{i})(II:end);
    end
end

flds1 = fields(Infra2);
II = min(find(Infra2.Time >= T0));
for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            InfraM2b.Time = Infra2.(flds1{i})(II:end);
        case 'Trigger'
            InfraM2b.Trigger = Infra2.(flds1{i})(II:end);
        case 'Fs'
            InfraM2b.Fs = Infra2.Fs;
        otherwise 
            InfraM2b.(flds1{i}) = Infra2.(flds1{i})(II:end);
    end
end
clear Infra flds1 Infra2

TimeTmp = Hopper.Time-937.1790;
II = min(find(TimeTmp >= T0));
HopperM2.Weight = Hopper.Hopperweight(II:end);
HopperM2.Time = TimeTmp(II:end);
HopperM2.Fs = Hopper.Fs;
clear Hopper

% save 
Code = '20190118_Mie2';
save(['SensorData\Infra_' Code '.mat'],'InfraM2','InfraM2b','-mat')
save(['SensorData\Hopper_' Code '.mat'],'HopperM2','-mat')

%% roughness 1
T0 = -5;

load ../../211003_rough/PCB_211103.mat
Fs = 1000;

flds1 = fields(PCB);
II = min(find(PCB.Time >= T0));
for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            PCBR1.Time = PCB.(flds1{i})(II:end);
        case 'Trigger'
            PCBR1.Trigger = PCB.(flds1{i})(II:end);
        case 'Fs'
            PCBR1.Fs = 1000;
        otherwise 
            PCBR1.(flds1{i}) = PCB.(flds1{i})(II:end);
    end
end
PCBR1.Fs = Fs;
clear PCB 

% Hopper
fDir = '\\Tur-iaegis2\vrs2\Share\PDC_Marsden\Exp_PDC\2021_10_03_RoughExperiment\Loadcell Data\';
File = '03102021_experiment.xlsx';
[num, txt, all] = xlsread([fDir File]);

Hopper10.Time = num(:,3);
Hopper10.Weight = num(:,1);

% save 
Code = '20211003_Rough';
save(['SensorData\PCB_' Code '.mat'],'PCBR1','-mat')
save(['SensorData\Hopper_' Code '.mat'],'Hopper10','-mat')

%% Roughness 2 
T0 = -5;
Fs = 1000;

load ../../211109_smooth/PCB_211109.mat
flds1 = fields(PCB);
II = min(find(PCB.Time >= T0));
for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            PCBR2.Time = PCB.(flds1{i})(II:end);
        case 'Trigger'
            PCBR2.Trigger = PCB.(flds1{i})(II:end);
        case 'Fs'
            PCBR2.Fs = 1000;
        otherwise 
            PCBR2.(flds1{i}) = PCB.(flds1{i})(II:end);
    end
end
PCBR2.Fs = Fs;
clear PCB 

% Hopper 
fDir = '\\Tur-iaegis2\vrs2\Share\PDC_Marsden\Exp_PDC\2021_11_09_SmoothExperiment\Loadcell Data\';
File = '09112021_experiment.csv';
[num, txt, all] = xlsread([fDir File]);
Fs = 250;
Hopper11.Weight = num;
Hopper11.Time = [0:1/Fs:length(num)/Fs-1/Fs];

% save 
Code ='20211109_Smooth';
save(['SensorData\PCB_' Code '.mat'],'PCBR2','-mat')
save(['SensorData\Hopper_' Code '.mat'],'Hopper11','-mat')

%% Roughness 3
T0 = -5;
Fs = 1000;

load ../../211125_Surge125_med/PCB.mat
flds1 = fields(PCB);
II = min(find(PCB.Time >= T0));
for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            PCBR3.Time = PCB.(flds1{i})(II:end);
        case 'Trigger'
            PCBR3.Trigger = PCB.(flds1{i})(II:end);
        case 'Fs'
            PCBR3.Fs = 1000;
        otherwise 
            PCBR3.(flds1{i}) = PCB.(flds1{i})(II:end);
    end
end
PCBR3.Fs = Fs;
clear PCB 

% Hopper 
fDir = '\\Tur-iaegis2\vrs2\Share\PDC_Marsden\Exp_PDC\2021_11_25_Medium\Loadcell\';
File = '25112021_experiment.csv';
[num, txt, all] = xlsread([fDir File]);
Fs = 250;
Hopper12.Weight = num;
Hopper12.Time = [0:1/Fs:length(num)/Fs-1/Fs];

% save 
Code ='20211125_Medium';
save(['SensorData\PCB_' Code '.mat'],'PCBR3','-mat')









