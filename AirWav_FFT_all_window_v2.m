%% This is the one to calculate the FFT for the 0.6 window air wave for 
% all technologies. These are in the spreadsheet 

% written 250319 A. Perttu 

%% set up the code 
clear all
close all

addpath Scripts\

%% Load infrasound data

load SensorData\Infra_230513_TsuExp1.mat
load SensorData\Infra_230611_TsuExp2.mat
load SensorData\Infra_231018_TsuExp3.mat
load SensorData\Infra_231123_TsuExp4.mat
load SensorData\Infra_20190113_Mie1.mat
load SensorData\Infra_20190118_Mie2.mat
load SensorData\Infra_20230209_InfraPDC1.mat
load SensorData\Infra_20230723_InfraPDC2.mat
load SensorData\Infra_20240306_InfraPDC3.mat

% order by size
% Mie 2 -       120
% Infra 1 -     250
% Tsunami 1 -   250
% Mie 1 -       300
% Infra 2 -     500
% Tsunami 2 -   600
% Tsunami 4 -   960
% Tsunami 3 -   1089
% Infra 3       1116 

% formatted into a structre for filtering
load Results\isInfraFilt50I1.mat
load Results\isInfraFilt50I2.mat
load Results\isInfraFilt50I3.mat
load Results\isInfraFilt50M1.mat
load Results\isInfraFilt50M2.mat
load Results\isInfraFilt50T1.mat
load Results\isInfraFilt50T2.mat
load Results\isInfraFilt50T3.mat
load Results\isInfraFilt50T4.mat

load InfraPDC1_20230209.mat
load InfraPDC2_20230723.mat
load InfraPDC3_20240306.mat
load Tsunami1_20230513.mat
load Tsunami2_20230611.mat
load Tsunami3_20231123.mat
load Tsunami4_20231123.mat

load ColorShapeExp.mat

% plot the data with the window
figure(1); clf 
set(gcf,'Position',[-1882 266 1141 695])
Twin1 = [1.6 1.66 1.3 1.68 1.72 1.32 1.29 1.88 1.61]; % infra Tsu mie
Offset = [7 4 0 6 3 1 2 5 8];

plot(isInfraFilt50M2.etime{1}, isInfraFilt50M2.sig{1}+8,'color',Color.Mie2)
hold on
plot(isInfraFilt50I1.etime{1}, isInfraFilt50I1.sig{1}+7, 'color',Color.Infra1)
plot(isInfraFilt50T1.etime{1}, isInfraFilt50T1.sig{1}+6, 'color',Color.Tsu1)
plot(isInfraFilt50M1.etime{1}, isInfraFilt50M1.sig{1}+5,'color',Color.Mie1)
plot(isInfraFilt50I2.etime{1}, isInfraFilt50I2.sig{1}+4, 'color',Color.Infra2)
plot(isInfraFilt50T2.etime{1}, isInfraFilt50T2.sig{1}+3, 'color',Color.Tsu2)
plot(isInfraFilt50T4.etime{1}, isInfraFilt50T4.sig{1}+2, 'color',Color.Tsu4)
plot(isInfraFilt50T3.etime{1}, isInfraFilt50T3.sig{1}+1, 'color',Color.Tsu3)
plot(isInfraFilt50I3.etime{1}, isInfraFilt50I3.sig{1}, 'color',Color.Infra3)

for i = 1:9
    plot(Twin1(i)*[1 1],[Offset(i)-0.75 Offset(i)+0.75],'--','color',[0.5 0.5 0.5])
     plot(Twin1(i)*[1 1]+0.6,[Offset(i)-0.75 Offset(i)+0.75],'--','color',[0.5 0.5 0.5])
end
ylim([-1 9])
xlim([0 5])
title('Window in order')

%% calculate the FFT in the window
% 
II = min(find(isInfraFilt50I1.etime{2} > Twin1(1)));
JJ = min(find(isInfraFilt50I1.etime{2} > Twin1(1)+0.6));
[AmpI1, FI1] = specz3_mo(isInfraFilt50I1.sig{1}(II:JJ),isInfraFilt50I1.Fs{1});

II = min(find(isInfraFilt50I2.etime{1} > Twin1(2)));
JJ = min(find(isInfraFilt50I2.etime{1} > Twin1(2)+0.6));
[AmpI2, FI2] = specz3_mo(isInfraFilt50I2.sig{1}(II:JJ),isInfraFilt50I2.Fs{1});

II = min(find(isInfraFilt50I3.etime{1} > Twin1(3)));
JJ = min(find(isInfraFilt50I3.etime{1} > Twin1(3)+0.6));
[AmpI3, FI3] = specz3_mo(isInfraFilt50I3.sig{1}(II:JJ),isInfraFilt50I3.Fs{1});

%
II = min(find(isInfraFilt50T1.etime{1} > Twin1(4)));
JJ = min(find(isInfraFilt50T1.etime{1} > Twin1(4)+0.6));
[AmpT1, FT1] = specz3_mo(isInfraFilt50T1.sig{1}(II:JJ),isInfraFilt50T1.Fs{1});

II = min(find(isInfraFilt50T2.etime{1} > Twin1(5)));
JJ = min(find(isInfraFilt50T2.etime{1} > Twin1(5)+0.6));
[AmpT2, FT2] = specz3_mo(isInfraFilt50T2.sig{1}(II:JJ),isInfraFilt50T2.Fs{1});

II = min(find(isInfraFilt50T3.etime{2} > Twin1(6)));
JJ = min(find(isInfraFilt50T3.etime{2} > Twin1(6)+0.6));
[AmpT3, FT3] = specz3_mo(isInfraFilt50T3.sig{1}(II:JJ),isInfraFilt50T3.Fs{1});

II = min(find(isInfraFilt50T4.etime{1} > Twin1(7)));
JJ = min(find(isInfraFilt50T4.etime{1} > Twin1(7)+0.6));
[AmpT4, FT4] = specz3_mo(isInfraFilt50T4.sig{1}(II:JJ),isInfraFilt50T4.Fs{1});

%
II = min(find(isInfraFilt50M1.etime{1} > Twin1(8)));
JJ = min(find(isInfraFilt50M1.etime{1} > Twin1(8)+0.6));
[AmpM1, FM1] = specz3_mo(isInfraFilt50M1.sig{2}(II:JJ),isInfraFilt50M1.Fs{1});

II = min(find(isInfraFilt50M2.etime{1} > Twin1(9)));
JJ = min(find(isInfraFilt50M2.etime{1} > Twin1(9)+0.6));
[AmpM2, FM2] = specz3_mo(isInfraFilt50M2.sig{3}(II:JJ),isInfraFilt50M2.Fs{1});

% plot the FFT 
figure(2); clf 
set(gcf,'Position',[-1895 257 1332 695])
plot(FI1, AmpI1*10+Offset(1)*0.1, 'Color',Color.Infra1)
hold on
plot(FI2, AmpI2*5+Offset(2)*0.1, 'Color',Color.Infra2)
plot(FI3, AmpI3*2+Offset(3)*0.1, 'Color',Color.Infra3)

plot(FT1, AmpT1*10+Offset(4)*0.1, 'Color',Color.Tsu1)
plot(FT2, AmpT2*10+Offset(5)*0.1, 'Color',Color.Tsu2)
plot(FT3, AmpT3*3+Offset(6)*0.1, 'Color',Color.Tsu3)
plot(FT4, AmpT4*30+Offset(7)*0.1, 'Color',Color.Tsu4)

plot(FM1, AmpM1*10+Offset(8)*0.1, 'Color',Color.Mie1)
plot(FM2, AmpM2*10+Offset(9)*0.1, 'Color',Color.Mie2)

set(gca,'XScale','log')
plot([15 15],[0 0.9],'--','color',[0.5 0.5 0.5])
text(5*10^2,Offset(1)*0.1,'InfraPDC1 - 250')
text(5*10^2,Offset(2)*0.1,'InfraPDC2 - 500')
text(5*10^2,Offset(3)*0.1,'InfraPDC3 - 1115')

text(5*10^2,Offset(4)*0.1,'Tsunami1 - 250')
text(5*10^2,Offset(5)*0.1,'Tsunami2 - 600')
text(5*10^2,Offset(6)*0.1,'Tsunami3 - 1100')
text(5*10^2,Offset(7)*0.1,'Tsunami4 - 960')

text(5*10^2,Offset(8)*0.1,'Mie1 - 300')
text(5*10^2,Offset(9)*0.1,'Mie2 - 120')

Fmin = 20;
% over 20, max amp
plot(FI1(find(AmpI1 == max(AmpI1(min(find(FI1 > Fmin)):end)))),Offset(1)*0.1,'*k')
plot(FI2(find(AmpI2 == max(AmpI2(min(find(FI2 > Fmin)):end)))),Offset(2)*0.1,'*k')
plot(FI3(find(AmpI3 == max(AmpI3(min(find(FI3 > Fmin)):end)))),Offset(3)*0.1,'*k')

plot(FT1(find(AmpT1 == max(AmpT1(min(find(FT1 > Fmin)):end)))),Offset(4)*0.1,'*k')
plot(FT2(find(AmpT2 == max(AmpT2(min(find(FT2 > Fmin)):end)))),Offset(5)*0.1,'*k')
plot(FT3(find(AmpT3 == max(AmpT3(min(find(FT3 > Fmin)):end)))),Offset(6)*0.1,'*k')
plot(FT4(find(AmpT4 == max(AmpT4(min(find(FT4 > Fmin)):end)))),Offset(7)*0.1,'*k')

plot(FM1(find(AmpM1 == max(AmpM1(min(find(FM1 > Fmin)):end)))),Offset(8)*0.1,'*k')
plot(FM2(find(AmpM2 == max(AmpM2(min(find(FM2 > Fmin)):end)))),Offset(9)*0.1,'*k')

%manually added
plot(45,Offset(3)*0.1,'ok')
plot(128,Offset(1)*0.1,'ok')

DomPeak = [FI1(find(AmpI1 == max(AmpI1(min(find(FI1 > Fmin)):end))))...
    FI2(find(AmpI2 == max(AmpI2(min(find(FI2 > Fmin)):end))))...
    FI3(find(AmpI3 == max(AmpI3(min(find(FI3 > Fmin)):end))))...
    FT1(find(AmpT1 == max(AmpT1(min(find(FT1 > Fmin)):end))))...
    FT2(find(AmpT2 == max(AmpT2(min(find(FT2 > Fmin)):end))))...
    FT3(find(AmpT3 == max(AmpT3(min(find(FT3 > Fmin)):end))))...
    FT4(find(AmpT4 == max(AmpT4(min(find(FT4 > Fmin)):end))))...
    FM1(find(AmpM1 == max(AmpM1(min(find(FM1 > Fmin)):end))))...
    FM2(find(AmpM2 == max(AmpM2(min(find(FM2 > Fmin)):end))))];

xlim([10 10^3])
ylim([-0.05 0.9])
title('FFT 0.6 window')

print(gcf,'Figures/FFT_Window_06_v2.png','-dpng')

figure(3); clf
set(gcf,'Position',[-1895 94 1306 861])
subplot(2,2,1)
InitMass = [5.52 41.97 139.07 15.08 18.9124 78.61 42.54 1.39 6.42];
flds = fields(Color);
cl = [1:7 11:12];
for i = 1:9
    plot(DomPeak(i),InitMass(i),'Marker',Shape.(flds{cl(i)}(1:end-1)),...
        'MarkerFaceColor',Color.(flds{cl(i)}),'MarkerEdgeColor','k')
    hold on
end
xlabel('frequency (Hz)')
ylabel('Initial Mass (kg)')

%rectangle('position',[290 300 50 90])
Ht = [300 290 280 270 260 250 240 230 220 210]-150;
plot(300,Ht(1),'Marker',Shape.Infra,'MarkerEdgeColor','k',...
    'MarkerFaceColor',Color.Infra1)
plot(300,Ht(2),'Marker',Shape.Infra,'MarkerEdgeColor','k',...
    'MarkerFaceColor',Color.Infra2)
plot(300,Ht(3),'Marker',Shape.Infra,'MarkerEdgeColor','k',...
    'MarkerFaceColor',Color.Infra3)
text(310,Ht(1),'Infra1')
text(310,Ht(2),'Infra2')
text(310,Ht(3),'Infra3')

plot(300,Ht(4),'Marker',Shape.Tsu,'MarkerEdgeColor','k',...
    'MarkerFaceColor',Color.Tsu1)
plot(300,Ht(5),'Marker',Shape.Tsu,'MarkerEdgeColor','k',...
    'MarkerFaceColor',Color.Tsu2)
plot(300,Ht(6),'Marker',Shape.Tsu,'MarkerEdgeColor','k',...
    'MarkerFaceColor',Color.Tsu3)
plot(300,Ht(7),'Marker',Shape.Tsu,'MarkerEdgeColor','k',...
    'MarkerFaceColor',Color.Tsu4)
text(310,Ht(4),'Tsu1')
text(310,Ht(5),'Tsu2')
text(310,Ht(6),'Tsu3')
text(310,Ht(7),'Tsu4')

plot(300,Ht(8),'Marker',Shape.Mie,'MarkerEdgeColor','k',...
    'MarkerFaceColor',Color.Mie1)
plot(300,Ht(9),'Marker',Shape.Mie,'MarkerEdgeColor','k',...
    'MarkerFaceColor',Color.Mie2)
text(310,Ht(8),'Mie1')
text(310,Ht(9),'Mie2')

ManualPicks(1) = 128;
ManualPicks(3) = 45;
plot(ManualPicks(1),InitMass(1),'o','MarkerEdgeColor',Color.Infra1)
plot(ManualPicks(3),InitMass(3),'o','MarkerEdgeColor',Color.Infra3)

set(gca,'XScale','lin')
ylim([0 160])
xlim([35 400])
title('Initial Mass vs Dominant Frequency')

time1 = [0:.01:1.2];
Dist = 0.5*9.8*time1.^2;
VelF = 9.8*time1;

HtH = [7 7 5.767 7 5.824+1.5 5.5 5.5 5.767+1.5 5.795+1.5]-0.4;
for i = 1:9
    Vel = VelF(min(find(Dist> HtH(i))));
    Momentum(i) = [InitMass(i)*Vel];
end
%Momentum = [VelF(12)*InitMass(1) VelF(12)*InitMass(2) VelF(10)*InitMass(3)...
%    VelF(12)*InitMass(4) VelF(12)*InitMass(5) VelF(10)*InitMass(6)...
%    VelF(10)*InitMass(7) VelF(12)*InitMass(8) VelF(12)*InitMass(9)]; % mass * vel 

subplot(2,2,2)
for i = 1:9
    plot(DomPeak(i),Momentum(i),'Marker',Shape.(flds{cl(i)}(1:end-1)),...
        'MarkerFaceColor',Color.(flds{cl(i)}),'MarkerEdgeColor','k')
    hold on
end
xlabel('frequency (Hz)')
ylabel('Momentum')
title('Momentum from modeled velocity vs. Dominant Frequency')

Ea{1} = [0.00307 0.0179 0.0468]; 
Ea{2} = [0.196 0.2185];
Ea{3} = [0.49572 0.38931];
Ea{4} = [0.0326 0.1003];
Ea{5} = [0.0067 0.052];
Ea{6} = [0.3675 0.5319];
Ea{7} = [0.0003 0.0007];
Ea{8} = [0.0054 0.00994];
Ea{9} = [0.0016 0.0028];
subplot(2,2,3)
for i = 1:9
    plot(Ea{i},InitMass(i)*length(Ea{i}),'Marker',Shape.(flds{cl(i)}(1:end-1)),...
        'MarkerFaceColor',Color.(flds{cl(i)}),'MarkerEdgeColor','k')
    hold on
end
xlabel('Acoustic Power (W)')
ylabel('Initial Mass')
set(gca,'XScale','log')
title('Acoustic Power vs Initial Mass')

subplot(2,2,4)
for i = 1:9
    plot(Ea{i},Momentum(i)*length(Ea{i}),'Marker',Shape.(flds{cl(i)}(1:end-1)),...
        'MarkerFaceColor',Color.(flds{cl(i)}),'MarkerEdgeColor','k')
    hold on
end
xlabel('Acoustic Power (W)')
ylabel('Momentum')
set(gca,'XScale','log')
title('Acoustic Power vs Momentum')

print(gcf,'Figures/FFT_relationship_v3.png','-dpng')

%% other technologies 
load SensorData\Mic_231018_TsuExp3.mat
load SensorData\Mic_231123_TsuExp4.mat
load SensorData\Mic_20230209_InfraPDC1.mat
load SensorData\Mic_20230723_InfraPDC2.mat
load SensorData\Mic_20240306_InfraPDC3.mat

isWavMicI1.etime{1} = MIC1.Time;
isWavMicI1.etime{2} = MIC1.Time;
isWavMicI1.sig{1} = double(MIC1.MIC1);
isWavMicI1.sig{2} = double(MIC1.MIC2);
isWavMicI1.Fs{1} = MIC1.Fs;
isWavMicI1.Fs{2} = MIC1.Fs;
isWavMicI1.name{1} = 'Microphone1';
isWavMicI1.name{2} = 'Microphone2';

isWavMicI2.etime{1} = MIC2.Time;
isWavMicI2.etime{2} = MIC2.Time;
isWavMicI2.sig{1} = MIC2.MIC1;
isWavMicI2.sig{2} = MIC2.MIC2;
isWavMicI2.Fs{1} = 44100;
isWavMicI2.Fs{2} = 44100;
isWavMicI2.name{1} = 'Microphone1';
isWavMicI2.name{2} = 'Microphone2';

isWavMicI3.etime{1} = MIC3.Time1;
isWavMicI3.etime{2} = MIC3.Time1;
isWavMicI3.etime{3} = MIC3.Time2;
isWavMicI3.etime{4} = MIC3.Time2;
isWavMicI3.sig{1} = MIC3.MIC1;
isWavMicI3.sig{2} = MIC3.MIC2;
isWavMicI3.sig{3} = MIC3.MIC3;
isWavMicI3.sig{4} = MIC3.MIC4;
isWavMicI3.Fs{1} = 44100;
isWavMicI3.Fs{2} = 44100;
isWavMicI3.Fs{3} = 44100;
isWavMicI3.Fs{4} = 44100;
isWavMicI3.name{1} = 'Microphone1';
isWavMicI3.name{2} = 'Microphone2';
isWavMicI3.name{3} = 'Microphone3';
isWavMicI3.name{4} = 'Microphone4';

isWavMicT3.etime{1} = MICT3.Time;
isWavMicT3.etime{2} = MICT3.Time;
isWavMicT3.sig{1} = MICT3.MIC1;
isWavMicT3.sig{2} = MICT3.MIC2;
isWavMicT3.Fs{1} = 44100;
isWavMicT3.Fs{2} = 44100;
isWavMicT3.name{1} = 'Microphone1';
isWavMicT3.name{2} = 'Microphone2';

isWavMicT4.etime{1} = MICT4.Time;
isWavMicT4.etime{2} = MICT4.Time;
isWavMicT4.sig{1} = MICT4.MIC1;
isWavMicT4.sig{2} = MICT4.MIC2;
isWavMicT4.Fs{1} = 44100;
isWavMicT4.Fs{2} = 44100;
isWavMicT4.name{1} = 'Microphone1';
isWavMicT4.name{2} = 'Microphone2';

% FFT 
for i = 1:length(isWavMicI1.name)
    II = min(find(isWavMicI1.etime{2} > Twin1(1)));
    JJ = min(find(isWavMicI1.etime{2} > Twin1(1)+0.6));
    [AmpI1m{i}, FI1m{i}] = specz3_mo(isWavMicI1.sig{i}(II:JJ),isWavMicI1.Fs{i});
end

for i = 1:length(isWavMicI2.name)
    II = min(find(isWavMicI2.etime{2} > Twin1(2)));
    JJ = min(find(isWavMicI2.etime{2} > Twin1(2)+0.6));
    [AmpI2m{i}, FI2m{i}] = specz3_mo(isWavMicI2.sig{i}(II:JJ),isWavMicI2.Fs{i});
end

for i = 1:length(isWavMicI3.name)
    II = min(find(isWavMicI3.etime{2} > Twin1(3)));
    JJ = min(find(isWavMicI3.etime{2} > Twin1(3)+0.6));
    [AmpI3m{i}, FI3m{i}] = specz3_mo(isWavMicI3.sig{i}(II:JJ),isWavMicI3.Fs{i});
end

% skip 4 and 5 

for i = 1:length(isWavMicT3.name)
    II = min(find(isWavMicT3.etime{2} > Twin1(6)));
    JJ = min(find(isWavMicT3.etime{2} > Twin1(6)+0.6));
    [AmpT3m{i}, FT3m{i}] = specz3_mo(isWavMicT3.sig{i}(II:JJ),isWavMicT3.Fs{i});
end

for i = 1:length(isWavMicT4.name)
    II = min(find(isWavMicT4.etime{2} > Twin1(7)));
    JJ = min(find(isWavMicT4.etime{2} > Twin1(7)+0.6));
    [AmpT4m{i}, FT4m{i}] = specz3_mo(isWavMicT4.sig{i}(II:JJ),isWavMicT4.Fs{i});
end

%% 

% plot 
figure(4); clf 
set(gcf,'Position',[-1867 165 994 741])
clear DomPeakm
n = 1;
Fmin = 50;
for i = 1:4
    if i <3
        plot(FI3m{i}, AmpI3m{i}+Offset(3)*0.01, 'Color',[Color.Infra3 0.5])
        hold on
    end
    DomPeakm(n) = [FI3m{i}(find(AmpI3m{i} == max(AmpI3m{i}(min(find(FI3m{i} > Fmin)):end))))];
    plot(DomPeakm(n),Offset(3)*0.01+0.01, '*k')
    n = n + 1;
end
for i = 1:2
    plot(FT4m{i}, AmpT4m{i}+Offset(7)*0.01, 'Color',[Color.Tsu4 0.5])
    hold on
    plot(FT3m{i}, AmpT3m{i}+Offset(6)*0.01, 'Color',[Color.Tsu3 0.5])
    %plot(FI3m{i}, AmpI3m{i}+Offset(3)*0.01, 'Color',[Color.Infra3 0.5])
    plot(FI2m{i}, AmpI2m{i}+Offset(2)*0.01, 'Color',[Color.Infra2 0.5])
    plot(FI1m{i}, AmpI1m{i}*2+Offset(1)*0.01, 'Color',[Color.Infra1 0.5]) 
end

for i = 1:2
    DomPeakm(n) = [FT4m{i}(find(AmpT4m{i} == max(AmpT4m{i}(min(find(FT4m{i} > Fmin)):end))))];
    plot(DomPeakm(n),Offset(7)*0.01+0.01, '*k')
    n = n + 1;
end

for i = 1:2
    DomPeakm(n) = [FT3m{i}(find(AmpT3m{i} == max(AmpT3m{i}(min(find(FT3m{i} > Fmin)):end))))];
    plot(DomPeakm(n),Offset(6)*0.01+0.01, '*k')
    n = n + 1;
end

for i = 1:2
    DomPeakm(n) = [FI2m{i}(find(AmpI2m{i} == max(AmpI2m{i}(min(find(FI2m{i} > Fmin)):end))))];
    plot(DomPeakm(n),Offset(2)*0.01+0.01, '*k')
    n = n + 1;
end

for i = 1:2
    DomPeakm(n) = [FI1m{i}(find(AmpI1m{i} == max(AmpI1m{i}(min(find(FI1m{i} > Fmin)):end))))];
    plot(DomPeakm(n),Offset(1)*0.01+0.01, '*k')
    n = n + 1;
end

plot([3600 5590],[0.07 0.07],'-b','LineWidth',1.25)
plot([68 140],[0.04 0.04],'-b','LineWidth',1.25)
plot([60 142],[0.02 0.02],'-b','LineWidth',1.25)
plot([65 125],[0.01 0.01],'-b','LineWidth',1.25)
plot([56 142],[0 0],'-b','LineWidth',1.25)

plot([40 51],[0 0],'-','color',[0.5 0.5 1],'LineWidth',1.25)
plot([45 60],[0.01 0.01],'-','color',[0.5 0.5 1],'LineWidth',1.25)
plot([47 56],[0.02 0.02],'-','color',[0.5 0.5 1],'LineWidth',1.25)

plot([50 50],[0 0.09],'--k','LineWidth',1.25)
plot([30 30],[0 0.09],'--','color',[0.5 0.5 0.5],'LineWidth',1.25)
plot([1000 1000],[0 0.09],'--k','LineWidth',1.25)
plot([10000 10000],[0 0.09],'--','color',[0.5 0.5 0.5],'LineWidth',1.25)
plot([15000 15000],[0 0.09],'--','color',[0.75 0.75 0.75],'LineWidth',1.25)

text(22,Offset(1)*0.01-0.0025,'Infra1','FontWeight','bold')
text(22,Offset(2)*0.01-0.0025,'Infra2','FontWeight','bold')
text(22,Offset(3)*0.01-0.0025,'Infra3','FontWeight','bold')

text(22,Offset(6)*0.01-0.0025,'Tsu3','FontWeight','bold')
text(22,Offset(7)*0.01-0.0025,'Tsu4 (hot)','FontWeight','bold')

text(32,0.08,'-10 dB')
text(100,0.08,'+/- 0 dB')
text(1500,0.08,'+ 5 dB')
text(11000,0.08,'+ 10 dB')
text(25,0.075,'Rolloff','Rotation',90)
text(21000,0.075,'Rolloff','Rotation',90)

xlabel('Frequency (Hz)')
set(gca,'XScale','log')
xlim([20 2.5*10^4])
ylim([-0.005 0.09])
title('Microphone FFT')

disp(['InfraPDC3: ' mat2str(round(mean(DomPeakm(1:4)))) ' (' ...
    mat2str(round(min(DomPeakm(1:4)))) ' - ' mat2str(round(max(DomPeakm(1:4))))...
    ') Hz'])
disp(['Tsu4: '  mat2str(round(mean(DomPeakm(5:6)))) ' (' ...
    mat2str(round(DomPeakm(5))) ', ' mat2str(round(DomPeakm(6))) ') Hz'])
disp(['Tsu3: ' mat2str(round(mean(DomPeakm(7:8)))) ' (' ...
    mat2str(round(DomPeakm(7))) ', ' mat2str(round(DomPeakm(8))) ') Hz'])
disp(['InfraPDC2: ' mat2str(round(mean(DomPeakm(9:10)))) ' (' ...
    mat2str(round(DomPeakm(9))) ', ' mat2str(round(DomPeakm(10))) ') Hz'])
disp(['InfraPDC1: ' mat2str(round(mean(DomPeakm(11:12)))) ' (' ...
    mat2str(round(DomPeakm(11))) ', ' mat2str(round(DomPeakm(12))) ') Hz'])

DomPeakMman = [4637 93 98 102 100];

print(gcf,'Figures/FFT_microphone_v1.png','-dpng')

%% 
load SensorData\PCB_230513_TsuExp1.mat
load SensorData\PCB_230611_TsuExp2.mat
load SensorData\PCB_231018_TsuExp3.mat
load SensorData\PCB_231123_TsuExp4.mat
load SensorData\PCB_20230209_InfraPDC1.mat
load SensorData\PCB_20230723_InfraPDC2.mat
load SensorData\PCB_20240306_InfraPDC3.mat

flds1 = fields(PCB1);
n = 1; 
for i = 4:24
    isPCBWavI1.etime{n} = PCB1.Time;
    isPCBWavI1.sig{n} = PCB1.(flds1{i});
    isPCBWavI1.Fs{n} = PCB1.Fs;
    isPCBWavI1.name{n} = flds1{i};
    n = n+1;
end

flds2 = fields(PCB2);
n = 1; 
for i = 1:21
    isPCBWavI2.etime{n} = PCB2.Time;
    isPCBWavI2.sig{n} = PCB2.(flds2{i});
    isPCBWavI2.Fs{n} = PCB2.Fs;
    isPCBWavI2.name{n} = flds2{i};
    n = n+1;
end

flds3 = fields(PCB3);
n = 1; 
for i = [3:16 18:22]
    isPCBWavI3.etime{n} = PCB3.Time;
    isPCBWavI3.sig{n} = PCB3.(flds3{i});
    isPCBWavI3.Fs{n} = PCB3.Fs;
    isPCBWavI3.name{n} = flds3{i};
    n = n+1;
end

% tsunami
flds4 = fields(PCBT1);
n = 1; 
for i = 4:24
    isPCBWavT1.etime{n} = PCBT1.Time;
    isPCBWavT1.sig{n} = PCBT1.(flds4{i});
    isPCBWavT1.Fs{n} = PCBT1.Fs;
    isPCBWavT1.name{n} = flds4{i};
    n = n+1;
end

flds5 = fields(PCBT2);
n = 1; 
for i = 4:25
    isPCBWavT2.etime{n} = PCBT2.Time;
    isPCBWavT2.sig{n} = PCBT2.(flds5{i});
    isPCBWavT2.Fs{n} = PCBT2.Fs;
    isPCBWavT2.name{n} = flds5{i};
    n = n+1;
end

flds6 = fields(PCBT3);
n = 1; 
for i = [3:20 22 24:26]
    isPCBWavT3.etime{n} = PCBT3.Time;
    isPCBWavT3.sig{n} = PCBT3.(flds6{i});
    isPCBWavT3.Fs{n} = PCBT3.Fs;
    isPCBWavT3.name{n} = flds6{i};
    n = n+1;
end

flds7 = fields(PCBT4);
n = 1; 
for i = [3:24]
    isPCBWavT4.etime{n} = PCBT4.Time;
    isPCBWavT4.sig{n} = PCBT4.(flds7{i});
    isPCBWavT4.Fs{n} = PCBT4.Fs;
    isPCBWavT4.name{n} = flds7{i};
    n = n+1;
end

isPCBWavM1.etime{1} = InfraM1.Time;
isPCBWavM1.etime{2} = InfraM1b.Time;
isPCBWavM1.sig{1} = InfraM1.SICh;
isPCBWavM1.sig{2} = InfraM1b.SI4;
isPCBWavM1.Fs{1} = InfraM1.Fs;
isPCBWavM1.Fs{2} = InfraM1b.Fs;
isPCBWavM1.name{1} = 'SICh';
isPCBWavM1.name{2} = 'SI4';

isPCBWavM2.etime{1} = InfraM2.Time;
isPCBWavM2.etime{2} = InfraM2b.Time;
isPCBWavM2.sig{1} = InfraM2.SICh;
isPCBWavM2.sig{2} = InfraM2b.SI4;
isPCBWavM2.Fs{1} = InfraM2.Fs;
isPCBWavM2.Fs{2} = InfraM2b.Fs;
isPCBWavM2.name{1} = 'SICh';
isPCBWavM2.name{2} = 'SI4';

% FFT 
for i = 1:length(isPCBWavI1.name)
    II = min(find(isPCBWavI1.etime{2} > Twin1(1)));
    JJ = min(find(isPCBWavI1.etime{2} > Twin1(1)+0.6));
    [AmpI1P{i}, FI1P{i}] = specz3_mo(isPCBWavI1.sig{i}(II:JJ),isPCBWavI1.Fs{i});
end

for i = 1:length(isPCBWavI2.name)
    II = min(find(isPCBWavI2.etime{2} > Twin1(2)));
    JJ = min(find(isPCBWavI2.etime{2} > Twin1(2)+0.6));
    [AmpI2P{i}, FI2P{i}] = specz3_mo(isPCBWavI2.sig{i}(II:JJ),isPCBWavI2.Fs{i});
end

for i = 1:length(isPCBWavI3.name)
    II = min(find(isPCBWavI3.etime{2} > Twin1(3)));
    JJ = min(find(isPCBWavI3.etime{2} > Twin1(3)+0.6));
    [AmpI3P{i}, FI3P{i}] = specz3_mo(isPCBWavI3.sig{i}(II:JJ),isPCBWavI3.Fs{i});
end

for i = 1:length(isPCBWavT1.name)
    II = min(find(isPCBWavT1.etime{2} > Twin1(4)));
    JJ = min(find(isPCBWavT1.etime{2} > Twin1(4)+0.6));
    [AmpT1P{i}, FT1P{i}] = specz3_mo(isPCBWavT1.sig{i}(II:JJ),isPCBWavT1.Fs{i});
end

for i = 1:length(isPCBWavT2.name)
    II = min(find(isPCBWavT2.etime{2} > Twin1(5)));
    JJ = min(find(isPCBWavT2.etime{2} > Twin1(5)+0.6));
    [AmpT2P{i}, FT2P{i}] = specz3_mo(isPCBWavT2.sig{i}(II:JJ),isPCBWavT2.Fs{i});
end

for i = 1:length(isPCBWavT3.name)
    II = min(find(isPCBWavT3.etime{2} > Twin1(6)));
    JJ = min(find(isPCBWavT3.etime{2} > Twin1(6)+0.6));
    [AmpT3P{i}, FT3P{i}] = specz3_mo(isPCBWavT3.sig{i}(II:JJ),isPCBWavT3.Fs{i});
end

for i = 1:length(isPCBWavT4.name)
    II = min(find(isPCBWavT4.etime{2} > Twin1(7)));
    JJ = min(find(isPCBWavT4.etime{2} > Twin1(7)+0.6));
    [AmpT4P{i}, FT4P{i}] = specz3_mo(isPCBWavT4.sig{i}(II:JJ),isPCBWavT4.Fs{i});
end

for i = 1:length(isPCBWavM1.name)
    II = min(find(isPCBWavM1.etime{2} > Twin1(8)));
    JJ = min(find(isPCBWavM1.etime{2} > Twin1(8)+0.6));
    [AmpM1P{i}, FM1P{i}] = specz3_mo(isPCBWavM1.sig{i}(II:JJ),isPCBWavM1.Fs{i});
end

for i = 1:length(isPCBWavM2.name)
    II = min(find(isPCBWavM2.etime{2} > Twin1(8)));
    JJ = min(find(isPCBWavM2.etime{2} > Twin1(8)+0.6));
    [AmpM2P{i}, FM2P{i}] = specz3_mo(isPCBWavM2.sig{i}(II:JJ),isPCBWavM2.Fs{i});
end

%% plot
figure(5); clf 
set(gcf,'Position',[-1893 57 948 919])
axes('Position',[0.1 0.7 0.8 0.275])
rectangle('Position',[225 0.1 100 23.8],'FaceColor',[0.75 0.75 0.75],'EdgeColor','none')
hold on
for i = 1:length(isPCBWavI1.name)
        plot(FI1P{i}, AmpI1P{i}*7+22-i, 'Color',[Color.Infra1 0.5])
        hold on
        text(550,22-i+0.25,[isPCBWavI1.name{i}(1:2) '-' isPCBWavI1.name{i}(6:end)])
end
plot(DomPeak(1)*[1 1],[0 26],'--k')
plot(DomPeakMman(1)*[1 1],[0 26],'--','color',[0.5 0.5 0.5])
ylim([0 24])
xlim([10 10^3])
set(gca,'XScale','log')
title('InfraPDC1 250 - PCB')
box on

axes('Position',[0.1 0.375 0.8 0.275])
rectangle('Position',[130 0.1 50 23.8],'FaceColor',[0.75 0.75 0.75],'EdgeColor','none')
hold on
for i = 1:length(isPCBWavT1.name)
        plot(FT1P{i}, AmpT1P{i}*7+22-i, 'Color',[Color.Tsu1 0.5])
        hold on
        text(550,22-i+0.25,[isPCBWavT1.name{i}(1:2) '-' isPCBWavT1.name{i}(6:end)])
end
plot(DomPeak(4)*[1 1],[0 26],'--k')
ylim([0 24])
xlim([10 10^3])
set(gca,'XScale','log')
title('Tsunami 1 250 - PCB')
box on

axes('Position',[0.1 0.225 0.8 0.1])
for i = 1:length(isPCBWavM2.name)
        plot(FM2P{i}, AmpM2P{i}*100+3-i, 'Color',[Color.Mie2])
        hold on
        text(550,22-i+0.25,[isPCBWavM2.name{i}(1:2) '-' isPCBWavM2.name{i}(6:end)])
end
ylim([0 3])
xlim([10 10^3])
set(gca,'XScale','log')
title('Mie 2 120 - PCB')

axes('Position',[0.1 0.05 0.8 0.1])
for i = 1:length(isPCBWavM1.name)
        plot(FM1P{i}, AmpM1P{i}*100+3-i, 'Color',[Color.Mie1])
        hold on
        text(550,22-i+0.25,[isPCBWavM1.name{i}(1:2) '-' isPCBWavM1.name{i}(6:end)])
end
ylim([0 3])
xlim([10 10^3])
set(gca,'XScale','log')
title('Mie 1 300 - PCB')

print(gcf,'Figures/FFT_PCB_surge_v1.png','-dpng')

%%
figure(6); clf 
set(gcf,'Position',[-1893 57 948 919])
axes('Position',[0.1 0.55 0.8 0.4])
rectangle('Position',[180 0.1 70 25.8],'FaceColor',[0.75 0.75 0.75],'EdgeColor','none')
hold on
rectangle('Position',[85 0.1 20 25.8],'FaceColor',[0.75 0.75 0.75],'EdgeColor','none')
for i = 1:length(isPCBWavI2.name)
        plot(FI2P{i}, AmpI2P{i}*5+22-i, 'Color',[Color.Infra2])
        hold on
        text(550,22-i+0.25,[isPCBWavI2.name{i}(1:2) '-' isPCBWavI2.name{i}(6:end)])
end
plot(DomPeak(2)*[1 1],[0 26],'--k')
plot(DomPeakMman(2)*[1 1],[0 26],'--','color',[0.5 0.5 0.5])
ylim([0 26])
xlim([10 10^3])
set(gca,'XScale','log')
title('InfraPDC2 500 - PCB')
box on

axes('Position',[0.1 0.1 0.8 0.4])
rectangle('Position',[55 0.1 30 25.8],'FaceColor',[0.5 0.5 0.5],'EdgeColor','none')
hold on
for i = 1:length(isPCBWavT2.name)
        plot(FT2P{i}, AmpT2P{i}*10+25-i, 'Color',[Color.Tsu2])
        hold on
        text(550,25-i+0.25,[isPCBWavT2.name{i}(1:2) '-' isPCBWavT2.name{i}(6:end)])
end
plot(DomPeak(5)*[1 1],[0 26],'--k')
ylim([2 26])
xlim([10 10^3])
set(gca,'XScale','log')
title('Tsunami 2 600 - PCB')
box on

print(gcf,'Figures/FFT_PCB_mid_v1.png','-dpng')

%%
figure(7); clf 
set(gcf,'Position',[-1893 57 948 919])
axes('Position',[0.1 0.7 0.8 0.275])
rectangle('Position',[40 0.1 40 22.8],'FaceColor',[0.75 0.75 0.75],'EdgeColor','none')
hold on
for i = 1:length(isPCBWavI3.name)
        plot(FI3P{i}, AmpI3P{i}*3+20-i, 'Color',[Color.Infra3])
        hold on
        text(550,20-i+0.25,[isPCBWavI3.name{i}(1:2) '-' isPCBWavI3.name{i}(6:end)])
end
plot(DomPeak(3)*[1 1],[0 23],'--k')
plot(DomPeakMman(3)*[1 1],[0 23],'--','color',[0.5 0.5 0.5])
ylim([0 23])
xlim([10 10^3])
set(gca,'XScale','log')
title('InfraPDC3 1100 - PCB')
box on

axes('Position',[0.1 0.375 0.8 0.275])
rectangle('Position',[45 0.1 40 25.8],'FaceColor',[0.75 0.75 0.75],'EdgeColor','none')
hold on
for i = 1:length(isPCBWavT3.name)
        plot(FT3P{i}, AmpT3P{i}*10+23-i, 'Color',[Color.Tsu3])
        hold on
        text(550,23-i+0.25,[isPCBWavT3.name{i}(1:2) '-' isPCBWavT3.name{i}(6:end)])
end
plot(DomPeak(7)*[1 1],[0 25],'--k')
plot(DomPeakMman(4)*[1 1],[0 25],'--','color',[0.5 0.5 0.5])
ylim([0 26])
xlim([10 10^3])
set(gca,'XScale','log')
title('Tsunami 3 1090 - PCB')
box on

axes('Position',[0.1 0.05 0.8 0.275])
rectangle('Position',[88 0.1 30 25.8],'FaceColor',[0.75 0.75 0.75],'EdgeColor','none')
hold on
for i = 1:length(isPCBWavT4.name)
        plot(FT4P{i}, AmpT4P{i}*10+23-i, 'Color',[Color.Tsu4])
        hold on
        text(550,23-i+0.25,[isPCBWavT4.name{i}(1:2) '-' isPCBWavT4.name{i}(6:end)])
end
plot(DomPeak(8)*[1 1],[0 25],'--k')
plot(DomPeakMman(5)*[1 1],[0 25],'--','color',[0.5 0.5 0.5])
ylim([0 26])
xlim([10 10^3])
set(gca,'XScale','log')
title('Tsunami 4 960 - PCB')
box on

print(gcf,'Figures/FFT_PCB_PF_v1.png','-dpng')

