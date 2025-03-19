% this script is to read in the data for each experiment and save in
% correct location with the time corrected and cut to appropriate size 
% this will also generated the experimental conditions for each expieriment
% as well as the scrupture for all of them. 
%
% naming conventions is sensorstype_YYYYMMDD_expname.mat 

% A. Perttu 20250114 
% 
% first commit is made the file and and did InfraPDC1-3 
% 250124 adding in the DQ layer and resaving 

%% set envrionment 
clear all
close all

addpath Scripts\ 

%% Data Quality structures Infrasound
DQ1.Sensor = {'PCB_P1_45','PCB_P2_4','PCB_P2_15','PCB_P2_30','PCB_P2_45',...
    'PCB_P2_75','PCB_P2_120','PCB_P2_170','PCB_P3_4','PCB_P3_15',...
    'PCB_P3_30','PCB_P3_45','PCB_P3_75','PCB_P3_120','PCB_P4_4',...
    'PCB_P4_15','PCB_P4_30','PCB_P4_45','PCB_P4_75','PCB_P4_120',...
    'PCB_P4_160','PCB_P5_45','T_P2_6','T_P2_18','T_P2_43','T_P2_73',...
    'T_P2_107','T_P2_141','T_P2_177','T_P3_19','T_P3_43','T_P3_72',...
    'T_P3_108','T_P4_8','T_P4_15','T_P4_45','T_P4_75','T_P4_110',...
    'T_P4_145','T_P4_160','T_P5_4','T_P5_15','T_P5_30','T_P5_45',...
    'T_P5_75','T_P5_120'};

DQ1.Status = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,];

DQ2.Sensor = {'PCB_P1_45','PCB_P2_4','PCB_P2_15','PCB_P2_30','PCB_P2_45',...
    'PCB_P2_75','PCB_P2_120','PCB_P3_15','PCB_P3_30','PCB_P3_45',...
    'PCB_P3_75','PCB_P4_4','PCB_P4_15','PCB_P4_30','PCB_P4_45',...
    'PCB_P4_75','PCB_P4_120','PCB_P5_15','PCB_P5_30','PCB_P5_45',...
    'PCB_P5_75','PCB_P6_45','T_P2_5','T_P2_19','T_P2_42','T_P2_72',...
    'T_P2_107','T_P2_141','T_P2_176','T_P3_20','T_P3_44','T_P3_74',...
    'T_P3_109','T_P3_142','T_P3_178','T_P3_350','T_P4_7','T_P4_19',...
    'T_P4_43','T_P4_72','T_P4_108','T_P4_350','T_P5_4','T_P5_15',...
    'T_P5_30','T_P5_45','T_P5_75',};

DQ2.Status = [1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,...
    1,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,];

DQ3.Sensor = {'PCB_P1_45','PCB_P2_4','PCB_P2_15','PCB_P2_30','PCB_P2_45',...
    'PCB_P2_75','PCB_P2_120','PCB_P3_15','PCB_P3_30','PCB_P3_45',...
    'PCB_P3_75','PCB_P4_4','PCB_P4_15','PCB_P4_30','PCB_P4_45',...
    'PCB_P4_75','PCB_P4_120','PCB_P5_15','PCB_P5_30','PCB_P5_45',...
    'PCB_P5_75','PCB_P6_45','T_P2_4','T_P2_8','T_P2_20','T_P2_46',...
    'T_P2_75','T_P2_120','T_P3_6','T_P3_23','T_P3_47','T_P3_77',...
    'T_P3_112','T_P3_350','T_P4_5','T_P4_21','T_P4_46','T_P4_75',...
    'T_P4_110','T_P4_350','T_P5_4','T_P5_15','T_P5_30','T_P5_45',...
    'T_P5_75'};
DQ3.Status = [1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,...
    0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,];

save('SensorData/InfraPDC1_DQ.mat','DQ1','-mat')
save('SensorData/InfraPDC2_DQ.mat','DQ2','-mat')
save('SensorData/InfraPDC3_DQ.mat','DQ3','-mat')

% Data Quality Tsunami 
% TO WRITE 
%% load data Expriment 1 
T0 = -5;

load D:\DATA\PELE\Experiments\230209_InfraPDC_Exp1\PCB_230209.mat
flds1 = fields(PCB);
PI = min(find(PCB.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            PCB1.Time = PCB.(flds1{i})(PI:end)+1/1000;
        case 'Trigger'
            PCB1.Trigger = PCB.(flds1{i})(PI:end); 
        case 'Fs'
            PCB1.Fs = PCB.Fs; 
        otherwise % the data fields 
            tmp = flds1{i}([1:7,10:end]); % check the status of the sensor
            Ind = find(strcmp(tmp,DQ1.Sensor) == 1);
            if DQ1.Status(Ind) == 1 % only save when DQ = 1
                PCB1.(flds1{i}(5:end)) = PCB.(flds1{i})(PI:end);
            end
    end
end
clear PCB flds1 tmp Ind

load D:\DATA\PELE\Experiments\230209_InfraPDC_Exp1\Therm_230209.mat
flds1 = fields(Therm);
PT = min(find(Therm.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            Therm1.Time = Therm.(flds1{i})(PT:end);
        case 'Trigger'
            Therm1.Trigger = Therm.(flds1{i})(PT:end);
        case 'Fs'
            Therm1.Fs = Therm.Fs;
        case 'P_2_6_141' % custom but same as below
            tmp = ['T_' flds1{i}([1,3,6:end])]; % check the status of the sensor
            Ind = find(strcmp(tmp,DQ1.Sensor) == 1);
            if DQ1.Status(Ind) == 1 % only save when DQ = 1
                Therm1.(flds1{i}([1,3:end])) = Therm.(flds1{i})(PT:end);
            end
        otherwise
            tmp = ['T_' flds1{i}([1:3,6:end])]; % check the status of the sensor
            Ind = find(strcmp(tmp,DQ1.Sensor) == 1);
            if DQ1.Status(Ind) == 1 % only save when DQ = 1
                Therm1.(flds1{i}) = Therm.(flds1{i})(PT:end);
            end
    end
end
clear Therm flds1

load D:\DATA\PELE\Experiments\230209_InfraPDC_Exp1\INFRASOUND_230209.mat
flds1 = fields(Infra);
II = min(find(Infra.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            Infra1.Time = Infra.(flds1{i})(II:end);
        case 'Trigger'
            Infra1.Trigger = Infra.(flds1{i})(II:end);
        case 'Fs'
            Infra1.Fs = Infra.Fs;
        otherwise 
            Infra1.(flds1{i}) = Infra.(flds1{i})(II:end);
    end
end
clear Infra flds1

load D:\DATA\PELE\Experiments\230209_InfraPDC_Exp1\MIC_230209.mat
flds1 = fields(MIC);
MI = min(find(MIC.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            MIC1.Time = MIC.(flds1{i})(MI:end);
        case 'Trigger'
            MIC1.Trigger = MIC.(flds1{i})(MI:end);
        case 'Fs'
            MIC1.Fs = MIC.Fs;
        otherwise 
            MIC1.(flds1{i}) = MIC.(flds1{i})(MI:end);
    end
end
clear MIC flds1

load D:\DATA\PELE\Experiments\230209_InfraPDC_Exp1\Hopper_230209.mat
HI = min(find(Hopper.Time >= T0));
Hopper1.Time = Hopper.Time(HI:end);
Hopper1.Trigger = Hopper.Trigger(HI:end);
Hopper1.Weight = Hopper.Hopperweight(HI:end);
Hopper1.Temp = Hopper.HopperTemp(HI:end);
Hopper1.Fs = Hopper.Fs; 

clear Hopper 

load D:\DATA\PELE\Experiments\230209_InfraPDC_Exp1\ACC_230209.mat
ACC1 = ACC; clear ACC 
 
%load D:\DATA\PELE\Experiments\230209_InfraPDC_Exp1\Pitot_230209.mat

% Save
Code = '20230209_InfraPDC1';
save(['SensorData\PCB_' Code '.mat'],'PCB1','-mat')
save(['SensorData\Therm_' Code '.mat'],'Therm1','-mat')
save(['SensorData\Infra_' Code '.mat'],'Infra1','-mat')
save(['SensorData\Hopper_' Code '.mat'],'Hopper1','-mat')
save(['SensorData\Mic_' Code '.mat'],'MIC1','-mat')

clear PCB1 Infra1 Therm1 Hopper1 MIC1

%% InfraPDC2 
T0 = -5;

load D:DATA\PELE\Experiments\230723_InfraPDC2\PCB_230723.mat
PCB.Fs = 1000;
flds1 = fields(PCB);
PI = min(find(PCB.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            PCB2.Time = PCB.(flds1{i})(PI:end-10)+1/1000;
        case 'Trigger'
            PCB2.Trigger = PCB.(flds1{i})(PI:end); 
        case 'Fs'
            PCB2.Fs = 1000; 
        otherwise % check status
            tmp = flds1{i}([1:7,10:end]); % check the status of the sensor
            Ind = find(strcmp(tmp,DQ2.Sensor) == 1);
            if DQ2.Status(Ind) == 1 % only save when DQ = 1
                PCB2.(flds1{i}(5:end)) = PCB.(flds1{i})(PI:end-10);
            end
    end
end
clear PCB flds1

load D:\DATA\PELE\Experiments\230723_InfraPDC2\Therm_230723.mat
flds1 = fields(Therm);
PT = min(find(Therm.Time >= T0));

for i = 1:length(flds1) % NEED TO FIX
    switch flds1{i}
        case 'Time'
            Therm2.Time = Therm.(flds1{i})(PT:end);
        case 'Trigger'
            Therm2.Trigger = Therm.(flds1{i})(PT:end);
        case 'Fs'
            Therm2.Fs = Therm.Fs;
        otherwise
            tmp = ['T_' flds1{i}([1:3,6:end])]; % check the status of the sensor
            Ind = find(strcmp(tmp,DQ2.Sensor) == 1);
            if DQ2.Status(Ind) == 1 % only save when DQ = 1
                Therm2.(flds1{i}) = Therm.(flds1{i})(PT:end);
            end
    end
end
clear Therm flds1

load D:\DATA\PELE\Experiments\230723_InfraPDC2\Infrasound_230723.mat
Infra.Fs = 1000;
flds1 = fields(Infra);
II = min(find(Infra.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            Infra2.Time = Infra.(flds1{i})(II:end-10);
        case 'Trigger'
            Infra2.Trigger = Infra.(flds1{i})(II:end-10);
        case 'Fs'
            Infra2.Fs = Infra.Fs;
        otherwise 
            Infra2.(flds1{i}) = Infra.(flds1{i})(II:end-10);
    end
end
clear Infra flds1

load D:\DATA\PELE\Experiments\230723_InfraPDC2\Hopper_230723.mat
HI = min(find(Hopper.Time >= T0));
Hopper2.Time = Hopper.Time(HI:end);
Hopper2.Trigger = Hopper.Trigger(HI:end);
Hopper2.Weight = Hopper.Weight(HI:end);
Hopper2.Temp = Hopper.Temp(HI:end);
Hopper2.Fs = 72; 
clear Hopper 

load D:\DATA\PELE\Experiments\230723_InfraPDC2\Microphone_230723.mat
MI1 = min(find(Mic.Time >= T0));

MIC2.Time = Mic.Time(MI1:end);
MIC2.Trigger = Mic.Trigger(MI1:end);
MIC2.MIC1 = Mic.MIC1(MI1:end);
MIC2.MIC2 = Mic.MIC2(MI1:end);
clear MIC 

% Save
Code = '20230723_InfraPDC2';
save(['SensorData\Hopper_' Code '.mat'],'Hopper2','-mat')
save(['SensorData\PCB_' Code '.mat'],'PCB2','-mat')
save(['SensorData\Infra_' Code '.mat'],'Infra2','-mat')
save(['SensorData\Mic_' Code '.mat'],'MIC2','-mat')


%% InfraPDC3 
T0 = -5;

load D:\DATA\PELE\Experiments\240306_InfraPDC_Exp3_PF\PCB_240306.mat
PCB.Fs = 1000;
flds1 = fields(PCB);
PI = min(find(PCB.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            PCB3.Time = PCB.(flds1{i})(PI:end)+1/1000;
        case 'Trigger'
            PCB3.Trigger = PCB.(flds1{i})(PI:end); 
        case 'Fs'
            PCB3.Fs = 1000; 
        otherwise 
            tmp = flds1{i}([1:7,10:end]); % check the status of the sensor
            Ind = find(strcmp(tmp,DQ3.Sensor) == 1);
            if DQ3.Status(Ind) == 1 % only save when DQ = 1
                PCB3.(flds1{i}(5:end)) = PCB.(flds1{i})(PI:end);
            end
    end
end
clear PCB flds1

load D:\DATA\PELE\Experiments\240306_InfraPDC_Exp3_PF\Thermal_240309.mat
Therm.Fs = 72;
flds1 = fields(Therm);
PT = min(find(Therm.Time >= T0));

for i = 1:length(flds1)
     switch flds1{i}
        case 'Time'
            Therm3.Time = Therm.(flds1{i})(PT:end);
        case 'Trigger'
            Therm3.Trigger = Therm.(flds1{i})(PT:end);
        case 'Fs'
            Therm3.Fs = Therm.Fs;
        otherwise
            Therm3.(flds1{i}) = Therm.(flds1{i})(PT:end);
    end
end
clear Therm flds1
 
load D:\DATA\PELE\Experiments\240306_InfraPDC_Exp3_PF\Infrasound_240306.mat
Infra.Fs = 1000;
flds1 = fields(Infra);
II = min(find(Infra.Time >= T0));

for i = 1:length(flds1)
    switch flds1{i}
        case 'Time'
            Infra3.Time = Infra.(flds1{i})(II:end);
        case 'Trigger'
            Infra3.Trigger = Infra.(flds1{i})(II:end);
        case 'Fs'
            Infra3.Fs = Infra.Fs;
        otherwise 
            Infra3.(flds1{i}) = Infra.(flds1{i})(II:end);
    end
end
clear Infra flds1
 
load D:\DATA\PELE\Experiments\240306_InfraPDC_Exp3_PF\MIC_240309.mat
MI1 = min(find(MIC.Time1 >= T0));
MI2 = min(find(MIC.Time2 >= T0));

MIC3.Time1 = MIC.Time1(MI1:end);
MIC3.Time2 = MIC.Time2(MI2:end);
MIC3.Trigger1 = MIC.Trigger1(MI1:end);
MIC3.Trigger2 = MIC.Trigger2(MI2:end);
MIC3.MIC1 = MIC.MIC1(MI1:end);
MIC3.MIC2 = MIC.MIC2(MI1:end);
MIC3.MIC3 = MIC.MIC3(MI2:end);
MIC3.MIC4 = MIC.MIC4(MI2:end);
clear MIC 
 
load D:\DATA\PELE\Experiments\240306_InfraPDC_Exp3_PF\Hopper_240306.mat
HI = min(find(Hopper.Time >= T0));
Hopper3.Time = Hopper.Time(HI:end);
Hopper3.Trigger = Hopper.Trigger(HI:end);
Hopper3.Weight = Hopper.Weight(HI:end);
Hopper3.Temp = Hopper.HopperTemp(HI:end);
Hopper3.Fs = 72; 

clear Hopper

% Save
Code = '20240306_InfraPDC3';
save(['SensorData\PCB_' Code '.mat'],'PCB3','-mat')
save(['SensorData\Therm_' Code '.mat'],'Therm3','-mat')
save(['SensorData\Infra_' Code '.mat'],'Infra3','-mat')
save(['SensorData\Hopper_' Code '.mat'],'Hopper3','-mat')
save(['SensorData\Mic_' Code '.mat'],'MIC3','-mat')

clear PCB3 Infra3 Therm3 Hopper3 MIC3

%% Tsunami 1
T0 = -5;

load D:\DATA\PELE\Experiments\230513_TsuExp1\Hopper_230513.mat
HI = min(find(Hopper.Time >= T0));
Hopper4.Time = Hopper.Time(HI:end);
Hopper4.Trigger = Hopper.Trigger(HI:end);
Hopper4.Weight = Hopper.Hopperweight(HI:end);
Hopper4.Temp = Hopper.HopperTemp(HI:end);
Hopper4.Fs = 72; 
clear Hopper 

% Save
Code = '20230513_Tsunami1';
save(['SensorData\Hopper_' Code '.mat'],'Hopper4','-mat')

%% Tsunami 2
T0 = -5;

load D:DATA\PELE\Experiments\230611_TsuExp2\Hopper_230611.mat
HI = min(find(Hopper.Time >= T0));
Hopper5.Time = Hopper.Time(HI:end);
Hopper5.Trigger = Hopper.Trigger(HI:end);
Hopper5.Weight = Hopper.Hopperweight(HI:end);
Hopper5.Temp = Hopper.HopperTemp(HI:end);
Hopper5.Fs = 72; 
clear Hopper 

% Save
Code = '20230611_Tsunami2';
save(['SensorData\Hopper_' Code '.mat'],'Hopper5','-mat')

%% Tsunami 3
T0 = -5;

load C:\AAIRS\MATLAB\PELE\EXPERIMENTS\231018_TsuExp3_PF\matData\Hopper_231018.mat
HI = min(find(Hopper.Time >= T0));
Hopper6.Time = Hopper.Time(HI:end);
Hopper6.Trigger = Hopper.Trigger(HI:end);
Hopper6.Weight = Hopper.Weight(HI:end);
Hopper6.Temp = Hopper.HopperTemp(HI:end);
Hopper6.Fs = 72; 
clear Hopper 

% Save
Code = '20231018_Tsunami3';
save(['SensorData\Hopper_' Code '.mat'],'Hopper6','-mat')


%% Tsunami 4
T0 = -5;

load C:\AAIRS\MATLAB\PELE\EXPERIMENTS\231123_TsuExp4_PFH\matData\Hopper_231123.mat
HI = min(find(Hopper.Time >= T0));
Hopper7.Time = Hopper.Time(HI:end);
Hopper7.Trigger = Hopper.Trigger(HI:end);
Hopper7.Weight = Hopper.Weight(HI:end);
Hopper7.Temp = Hopper.HopperTemp(HI:end);
Hopper7.Fs = 72; 
clear Hopper 

% Save
Code = '20231123_Tsunami4';
save(['SensorData\Hopper_' Code '.mat'],'Hopper7','-mat')

% %% Mie 1
% load D:DATA\PELE\Experiments\190113_Mie1\Hopper_190112.mat
% Hopper8.Time = Hopper.Time;
% Hopper8.Weight = Hopper.Hopperweight;
% Hopper8.Fs = Hopper.Fs;
% clear Hopper 
% 
% % save 
% Code = '20190113_Mie1';
% save(['SensorData\Hopper_' Code '.mat'],'Hopper8','-mat')
% %% Mie 2
% load D:\DATA\PELE\Experiments\190119_Mie2\Hopper_190118.mat
% T0 = 930;
% T1 = 1000;
% 
% HI = min(find(Hopper.Time >= T0));
% H2 = min(find(Hopper.Time >= T1));
% 
% Hopper9.Time = Hopper.Time(HI:H2)-T0;
% Hopper9.Weight = Hopper.Hopperweight(HI:H2);
% clear Hopper 
% 
% % save 
% Code = '20190119_Mie2';
% save(['SensorData\Hopper_' Code '.mat'],'Hopper9','-mat')

%% experiment parameters and setup 
Exp1.ProfileX = [1.33 3.02 9.29 12.62 17 NaN]; % profile locations (general) 
Exp1.kg = 250; % mass pf the experiment kg
Exp1.tmp = 100; % material temperature C
Exp1.disch = 36.2; % discharge rate kg/sec
Exp1.discT1 = 1.1; % discharge start time (sec) 
Exp1.discT2 = 9.3; % discharge end time (sec)
Exp1.TmpAmb = 17; % Temperature in channel (C)
Exp1.Rho = 1.211042; % calculated air density
Exp1.C = round(331+(0.61*Exp1.TmpAmb)); % sound speed m/sec

Exp1.PCBX = [1.33 3.042 NaN 9.29 12.62 17]; % PCB Profile locations (m)
Exp1.InfraX = [3.045 8.605 13.1 17]; % Infrasound sensor locations (m)
Exp1.ThermX = []; % Temperature sensor locations (m)
Exp1.MicX = [8.605 13.1]; % microphone locations (m)

Exp1.PCBZ = [.45 NaN NaN NaN NaN NaN NaN;
    0.04 0.15 0.30 0.45 0.75 1.2 NaN;
    0.04 0.15 0.30 0.45 0.75 1.2 1.7;
    0.04 0.15 0.30 0.45 0.75 1.2 1.6;
    0.45 NaN NaN NaN NaN NaN NaN]; % Heights of PCB sensors (m)
Exp1.InfraZ = [458-136; 414; 350; 47]./100; % Heights of Infrasound (m)
Exp1.MicZ = [Exp1.InfraZ(1)-.268; Exp1.InfraZ(3)-.268]; % heights of the Microphones (m)
save('InfraPDC1_20230209.mat','Exp1','-mat')

% InfraPDC2
Exp2.ProfileX = [1.33 3.02 5.08 9.29 12.62 17];
Exp2.kg = 500;
Exp2.tmp = 14.6;
Exp2.disch = 55.79;
Exp2.discT1 = 1.3;
Exp2.discT2 = 10;
Exp2.TmpAmb = 9;
Exp2.Rho = 1.230003;
Exp2.C = round(331+(0.61*Exp2.TmpAmb)); % m/sec

Exp2.PCBX = [1.33 3.042 5.08 9.29 12.62 16.8];
Exp2.InfraX = [8.42 9.42];
Exp2.ThermX = [];
Exp2.MicX = [8.42 9.42];

Exp2.PCBZ = [0.45 NaN NaN NaN NaN NaN;
    0.04 0.15 0.30 0.45 0.75 1.2;
    0.15 0.30 0.45 0.75 NaN NaN;
    0.04 0.15 0.30 0.45 0.75 1.2;
    0.15 0.30 0.45 0.75 NaN NaN;
    0.45 NaN NaN NaN NaN NaN];
Exp2.InfraZ = [447.5-136; 458-136]/100;
Exp2.MicZ = [Exp2.InfraZ(1)-.268; Exp2.InfraZ(2)-.268];
save('InfraPDC2_20230723.mat','Exp2','-mat')

% InfraPDC3
Exp3.ProfileX = [1.33 3.88 5.05 9.22 12.6 17];
Exp3.kg = 1100; 
Exp3.tmp = 100; 
Exp3.disch = 383.9;
Exp3.disT1 = 0.5;
Exp3.disT2 = 3.6;
Exp3.TmpAmb = 10;
Exp3.C = (331+(0.61*Exp3.TmpAmb));
Exp3.Rho = 1.22722;

Exp3.PCBX = [1.33 3.88 5.05 9.22 12.62 16.8];
Exp3.InfraX = [8.42 9.42];
Exp3.ThermX = [];
Exp3.MicX = [8.42 9.42 11.38 17];

Exp3.PCBZ = [0.45 NaN NaN NaN NaN NaN
    0.04 0.15 0.30 .45 0.75 1.2
    0.15 0.30 0.45 0.75 NaN NaN
    0.04 0.15 0.30 0.45 0.75 1.2
    0.15 0.30 0.45 0.75 NaN NaN
    0.45 NaN NaN NaN NaN NaN];
Exp3.InfraZ = [447.5-136; 458-136]/100;
Exp3.MicZ = [Exp3.InfraZ(1)-.268; Exp3.InfraZ(2)-.268; (478.58-136)/100-0.268; .47];
save('InfraPDC3_20240306.mat','Exp3','-mat')

%% 

% Tsunami 1
ExpT1.ProfileX = [0.1 1.9 3.36 7.35 11.3]+10.7;
ExpT1.kg = [249];
ExpT1.tmp = [120]; 
ExpT1.disch = [25.29];
ExpT1.disT1 = [];
ExpT1.disT2 = [];
ExpT1.TmpAmb = [6.2];
ExpT1.C = round(331+(0.61*ExpT1.TmpAmb));
ExpT1.Rho = [1.2735];

ExpT1.PCBX = [0.1 1.9 3.36 7.35 11.3]+10.7;
ExpT1.InfraX = [NaN 2.4 2.37 NaN NaN]+10.7;
ExpT1.ThermX = [];
ExpT1.MicX = [];

ExpT1.PCBZ = [4 15 30 45 75 120;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN]./100+0.5;
ExpT1.InfraZ = [NaN; 347; 135; NaN; NaN]./100;
ExpT1.MicZ = [];
save('Tsunami1_20230513.mat','ExpT1','-mat')

% Tsunami 2
ExpT2.ProfileX = [0.1 1.9 3.36 7.35 11.3]+10.7;
ExpT2.kg = [569];
ExpT2.tmp = [100]; 
ExpT2.disch = [50.2700];
ExpT2.disT1 = [];
ExpT2.disT2 = [];
ExpT2.TmpAmb = [4.4];
ExpT2.C = round(331+(0.61*ExpT2.TmpAmb));
ExpT2.Rho = [1.2717];

ExpT2.PCBX = [0.1 1.9 3.36 7.35 11.3]+10.7;
ExpT2.InfraX = [NaN 2.4 2.37 NaN NaN]+10.7;
ExpT2.ThermX = [];
ExpT2.MicX = [];

ExpT2.PCBZ = [4 15 30 45 75 120;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN]./100+0.5;
ExpT2.InfraZ = [NaN; 347; 135; NaN; NaN]./100;
ExpT2.MicZ = [];
save('Tsunami2_20230611.mat','ExpT2','-mat')

% Tsunami 3
ExpT3.ProfileX = [0.1 1.9 3.36 7.35 11.3]+10.7;
ExpT3.kg = [1089];
ExpT3.tmp = [30]; 
ExpT3.disch = [238.8000];
ExpT3.disT1 = [];
ExpT3.disT2 = [];
ExpT3.TmpAmb = [12.7000];
ExpT3.C = round(331+(0.61*ExpT3.TmpAmb));
ExpT3.Rho = [1.2364];

ExpT3.PCBX = [0.1 1.9 3.36 7.35 11.3]+10.7;
ExpT3.InfraX = [NaN NaN -2.28 -1.25 NaN]+10.7;
ExpT3.ThermX = [];
ExpT3.MicX = [NaN NaN ExpT3.InfraX(3) ExpT3.InfraX(4) NaN];

ExpT3.PCBZ = [4 15 30 45 75 120;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN]./100+0.5;
ExpT3.InfraZ = [NaN; NaN; 447.5-136; 458-136; NaN]/100;
ExpT3.MicZ = [NaN; NaN; ExpT3.InfraZ(3)-.268; ExpT3.InfraZ(4)-.268; NaN];
save('Tsunami3_20231123.mat','ExpT3','-mat')

% Tsunami 4
ExpT4.ProfileX = [0.1 1.9 3.36 7.35 11.3]+10.7;
ExpT4.kg = [963];
ExpT4.tmp = [500]; 
ExpT4.disch = [81.7000];
ExpT4.disT1 = [];
ExpT4.disT2 = [];
ExpT4.TmpAmb = [17.0000];
ExpT4.C = round(331+(0.61*ExpT4.TmpAmb));
ExpT4.Rho = [1.2096];

ExpT4.PCBX =[0.1 1.9 3.36 7.35 11.3]+10.7;
ExpT4.InfraX = [NaN NaN -2.28 -1.25 NaN]+10.7;
ExpT4.ThermX = [];
ExpT4.MicX = [NaN NaN ExpT4.InfraX(3) ExpT4.InfraX(4) NaN];

ExpT4.PCBZ = [4 15 30 45 75 120;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN;
    NaN 15 30 45 75 NaN]./100+0.5;
ExpT4.InfraZ = [NaN; NaN; 447.5-136; 458-136; NaN]/100;
ExpT4.MicZ = [NaN; NaN; ExpT4.InfraZ(3)-.268; ExpT4.InfraZ(4)-.268; NaN];

save('Tsunami4_20231123.mat','ExpT4','-mat')


