%DESIGN AND OPTIMIZATION OF A RECTANGULAR WAVEGUIDE
%DEFAULT MODE OF PROPAGATION IS BY DESIGN TE10

clear all
close all
clc

format shortEng
format compact

%INPUT VARIABLES

%NUMBER OF OPTIMIZATION POINTS
number_of_combinations = input('Input of the desired length-offset combinations.\n');
clc

%PROBE DIAMETER
feedwidth = input('Input of probe diameter in MILLIMETERS.\n');
feedwidth = feedwidth * 1e-3;
clc

%CENTRAL FREQUENCY IN Hz
fc = input('Input of the desired central frequency in Hz.\n');
clc

%ANTENNA GAIN
hr_gain = input('Input of the desired antenna gain in dB.\n');
clc

%PARAMETRI MEDIJA
%ZRAK
c0 = 299792458;
e0 = 8.854187817e-12;
u0 = 1.256637061e-6;

e_r = 1.00058986;
u_r = 1.00000037;

e = e0 * e_r;
u = u0 * u_r;

%WAVELENGTH CALCULATION
omega = 2 * pi * fc;
lambda_fc = c0 / fc;
lambda4_fc = lambda_fc / 4;

fprintf('Central frequency = %d Hz', fc);
fprintf('\nWavelength = %d m', lambda_fc);
fprintf('\nQuarter-wavelength = %d m', lambda4_fc);
fprintf('\n');

%ADAPTER DIMENSIONS
wg_a = 3 / (4 * fc * sqrt(u * e));
wg_b = (wg_a / 2) - 0.6e-3;

lambda_g = (2 * pi) / (sqrt( (omega * sqrt(u * e))^2 - (pi / wg_a)^2));
wg_length = lambda_g / 2;

fprintf('Guide wavelength = %d m', lambda_g);

fprintf('\n');
fprintf('\nAdapter parameters:');
fprintf('\na = %.2f mm', wg_a * 1e3);
fprintf('\nb = %.2f mm', wg_b * 1e3);
fprintf('\nl = %.2f mm', wg_length * 1e3);
fprintf('\n');

%HORN FLARE DIMENSIONS
ea = 0.511;

x = wg_a / wg_b;
hr_a = sqrt( (hr_gain * (lambda_fc^2) * x) / (4 * 3.141 * ea) );
hr_b = sqrt( (hr_gain * (lambda_fc^2)) / (4 * 3.141 * ea * x) );

hr_length = lambda_fc / 3;

fprintf('\nHorn parameters:');
fprintf('\nA: %.2f mm', hr_a * 1e3);
fprintf('\nB: %.2f mm', hr_b * 1e3);
fprintf('\nRp: %.2f mm\n', hr_length * 1e3);

%PROBE PARAMETERS
feedheight = lambda4_fc;

optimization_points = round(sqrt(number_of_combinations));

%PARAMETERS MATRIX GENERATOR

feedheightrange = linspace((feedheight * 0.5), (feedheight), optimization_points);
feedoffsetrange = linspace(0.2, 1.8, optimization_points);

absolute_min = 0;
optimal_height = 0;
optimal_distance = 0;

%OPTIMIZACIJSKI ALGORITAM

fprintf('\n');
fprintf('OPTIMIZATION IN PROGRESS.');
fprintf('\n');

rl_array = zeros(optimization_points, optimization_points);

iter = 0;
for m = 1:optimization_points
    for n = 1:optimization_points
        
        clear wg
        clear rl
        
        feedoffset_position = - (lambda_g / 4) + ((lambda_g / 4) * feedoffsetrange(n));
        
        feedoffset = [feedoffset_position 0];
        
        hr = horn('FeedHeight', feedheightrange(m), 'Length', wg_length, 'Width', wg_a, 'Height', wg_b, 'FeedOffset', feedoffset, 'FeedWidth', feedwidth, 'FlareLength', hr_length, 'FlareWidth', hr_a, 'FlareHeight', hr_b);
        
        rl = returnLoss(hr, fc, 50);
        rl_array(m, n) = rl; 
        
            if rl > absolute_min
                absolute_min = rl;
                optimal_height = feedheightrange(m);
                optimal_distance = feedoffset(1); 
           
            end
         
    end
end
fprintf('OPTIMIZATION FINISHED.');
fprintf('\n');
fprintf('\n');

%ANTENNA SIMULATIONS

freqspan = linspace((fc * 0.8), (fc * 1.2), 500);

hr = horn('FeedHeight', optimal_height, 'Length', wg_length, 'Width', wg_a, 'Height', wg_b, 'FeedOffset', [optimal_distance 0], 'FeedWidth', feedwidth, 'FlareLength', hr_length, 'FlareWidth', hr_a, 'FlareHeight', hr_b);

p = PatternPlotOptions;
p.Transparency = 0.5;
pattern(hr, fc, patternOptions=p,Type="realizedgain")

sparam = sparameters(hr, freqspan, 50);

rlpeaks = returnLoss(hr, freqspan, 50);
[peakrl, peakf] = findpeaks(rlpeaks);

optimal_offset = optimal_distance;
optimal_distance = (lambda_g / 4) + optimal_offset;

fprintf('S11 at the central frequency: %.4f dB\n', -absolute_min)
fprintf('Local minima of the S11: %.4f dB at %.4f Hz\n', -peakrl(1), freqspan(peakf(1)))
fprintf('Optimal probe length (lp): %.4f m\n', optimal_height)
fprintf('Optimal probe length (lp): %.4f lambda0\n', (optimal_height/lambda_fc))
fprintf('Optimal probe length (lp): %.4f lambda0/4\n', (optimal_height/lambda4_fc))
fprintf('Optimal probe offset from the shorted end of the adapter (bs): %.4f m\n', optimal_distance)
fprintf('Optimal probe offset from the shorted end of the adapter (bs): %.4f lambda_g\n', (optimal_distance/lambda_g))
fprintf('Optimal probe offset from the shorted end of the adapter (bs): %.4f lambda_g/4\n', (optimal_distance/(lambda_g/4)))
fprintf('Optimal probe offset (bs) in regars to the center of the waveguide: %.4f m\n', optimal_offset)


k_scaling = 2.4;
k_width_height = 1.6;

width = 8.89 * k_scaling;
height = width / k_width_height;

top = 1.25;
bottom = 3;
left = 3.5;
right = 1.25;


set(0,'defaultFigureUnits','centimeters');
set(0,'defaultFigurePosition',[0 0 width height]);

set(0,'defaultLineLineWidth',2);
set(0,'defaultAxesLineWidth',1.5);

set(0,'defaultAxesGridLineStyle',':');
set(0,'defaultAxesYGrid','on');
set(0,'defaultAxesXGrid','on');

set(0,'defaultAxesFontName','Times New Roman');
set(0,'defaultAxesFontSize',8*k_scaling);

set(0,'defaultTextFontName','Times New Roman');
set(0,'defaultTextFontSize',8*k_scaling);

set(0,'defaultLegendFontName','Times New Roman');
set(0,'defaultLegendFontSize',8*k_scaling);

set(0,'defaultAxesUnits','normalized');
set(0,'defaultAxesPosition',[left/width bottom/height (width-left-right)/width  (height-bottom-top)/height]);

set(0,'defaultAxesColorOrder',[0 0 0]);
set(0,'defaultAxesTickDir','out');

set(0,'defaultFigurePaperPositionMode','auto');

set(0,'defaultLegendLocation','southeast');
set(0,'defaultLegendBox','on');
set(0,'defaultLegendOrientation','vertical');

figure();
rfplot(sparam, 'db', 'k-')

yline(-10, 'k', '', 'LineWidth',1.5, 'FontName','Times New Roman', 'FontSize', 8*k_scaling, 'LabelHorizontalAlignment','left', 'LabelVerticalAlignment','bottom');

ylabel('S_{11} (dB)');

box on

set(gcf,'PaperUnits','centimeters','PaperSize',[width height])
fig = gcf;fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 width height];fig.Units = 'centimeters';
fig.PaperSize=[width height];fig.Units = 'centimeters';

ax = gca;
ax.GridAlpha = 0.5;
