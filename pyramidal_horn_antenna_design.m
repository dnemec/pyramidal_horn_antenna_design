%COAX-PINFED PYRAMIDAL HORN ANTENNA DESIGN

clear all
close all
clc

format shortEng
format compact

%GENERAL INPUTS
hr_gain = 10; %DESIRED HORN ANTENNA GAIN IN dB

%WAVEGUIDE INPUTS
wg_a = 44.96e-3; %WAVEGUIDE WIDTH
wg_b = 21.88e-3; %WAVEGUIDE HEIGHT
wg_length = 40.2095e-3; %WAVEGUIDE LENGTH
wg_feedwidth = 1.265e-3; %FEED MONOPOLE ANTENNA DIAMETER
wg_feedheight = 12.8e-3; %FEED MONOPOLE ANTENNA DIAMETER

feedoffset_position = -5.5e-3; %FEED OFFSET FROM THE CENTRE OF WAVEGUIDE
feedoffset = [feedoffset_position 0];

%CENTRAL FREQUENCY IN HERTZ (e.g. 1GHz = 1e9)
fc = input('Enter the central frequency in Hz.\n');
freqspan = linspace((fc * 0.8), (fc * 1.6), 100);
clc

c0 = 299792458;
lambda_fc = c0 / fc;
ea = 0.511; %DEFAULT

%INPUT DISPLAY
clc
fprintf('INPUT PARAMETERS\n');
fprintf('\nFrequency = %d Hz', fc);
fprintf('\nWavelength = %d m', lambda_fc);
fprintf('\nWaveguide height: %.2f mm', wg_b * 1e3);
fprintf('\nWaveguide width: %.2f mm', wg_b * 1e3);
fprintf('\nWaveguide length: %.2f mm', wg_length * 1e3);
fprintf('\nWaveguide feed monopole diameter: %.2f mm', wg_feedwidth * 1e3);
fprintf('\nWaveguide feed monopole offset from center: %.2f mm\n', feedoffset_position * 1e3);

%HORN DIMENSIONS CALCULATION
x = wg_a / wg_b;
hr_a = sqrt( (hr_gain * (lambda_fc^2) * x) / (4 * 3.141 * ea) );
hr_b = sqrt( (hr_gain * (lambda_fc^2)) / (4 * 3.141 * ea * x) );

lh = (hr_a^2) / (3 * lambda_fc);

hr_length = ( sqrt( (lh^2) - (hr_a / 2)^2 ) / (hr_a / (hr_a - wg_a)));

fprintf('\nHORN ANTENNA DIMENSIONS\n');
fprintf('\nHorn height: %.2f mm', hr_a * 1e3);
fprintf('\nHorn width: %.2f mm', hr_b * 1e3);
fprintf('\nHorn length: %.2f mm\n', hr_length * 1e3);

%HORN SIMULATION
fprintf('\nPERFORMANCE ANALYSIS\n');
hr = horn('FeedHeight', wg_feedheight, 'Length', wg_length, 'Width', wg_a, 'Height', wg_b, 'FeedOffset', feedoffset, 'FeedWidth', wg_feedwidth, 'FlareLength', hr_length, 'FlareWidth', hr_a, 'FlareHeight', hr_b);

figure;
vswr(hr, freqspan, 50);
yline(1.5, 'r', '1.5', 'LineWidth', 1.5);

figure;
pattern(hr, fc, 'Type', 'gain');
gain = pattern(hr, fc, 'Type', 'gain');
gain = max(max(gain));
fprintf('\nGain: %.1fdB', gain);

figure;
S = sparameters(hr, freqspan, 50);
rfplot(S);
yline(-10, 'r', '-10dB', 'LineWidth', 1.5);

[azbw,angles] = beamwidth(hr, fc, 1:1:360,0,3);
fprintf('\nAzimuth HPBW: %.0fº', 2 * azbw);

[elbw,angles] = beamwidth(hr, fc, 0,1:1:360,3);
fprintf('\nElevation HPBW: %.0fº\n', 2 * elbw);


