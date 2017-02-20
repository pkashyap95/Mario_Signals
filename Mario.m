close all
clear 
clc
 
%Super Mario Bros. Theme Song
 
%Note Beats and Rests
E5=sin(2*pi*659.25*(0:0.000125:1));
E53=sin(2*pi*659.25*(0:0.000125:1.33));
C5=sin(2*pi*523.25*(0:0.000125:1));
G5=sin(2*pi*783.99*(0:0.000125:1));
G5F=sin(2*pi*739.99*(0:0.000125:1));
G53=sin(2*pi*783.99*(0:0.000125:1.33));
G4=sin(2*pi*392.00*(0:0.000125:1));
G4S=sin(2*pi*415.30*(0:0.000125:1));
G43=sin(2*pi*392.00*(0:0.000125:1.33));
E4=sin(2*pi*329.63*(0:0.000125:1));
A5=sin(2*pi*880.00*(0:0.000125:1));
A4=sin(2*pi*440.00*(0:0.000125:1));
B5=sin(2*pi*987.77*(0:0.000125:1));
B5F=sin(2*pi*932.33*(0:0.000125:1));
A6=sin(2*pi*1760.00*(0:0.000125:1));
F5=sin(2*pi*698.46*(0:0.000125:1));
D5=sin(2*pi*587.33*(0:0.000125:1));
D5S=sin(2*pi*622.25*(0:0.000125:1));
 
R = sin(2*pi*0*(0:0.000125:1)); 
 
line1 = [E5,E5,R,E5,R, C5,E5,R, G5,R,R,R G4,R, R, R];
line2 = [C5,R, R,G4,R,R,E4,R,R,A5,R,B5,R,B5F,A5,R];
line3 = [G43,E53, G53,A5,R,F5,G5,R,E5,R,C5,D5,B5,R,R];
line4 = [C5,R, R,G4,R,R,E4,R,R,A5,R,B5,R,B5F,A5,R];
line5 = [G43,E53, G53,A5,R,F5,G5,R,E5,R,C5,D5,B5,R];
line6 = [R,G5,G5F,F5,D5S,R,E5,R,G4S,A5,E5,R,A5,C5,D5];
line7 = [R,G5,G5F,F5,D5S,R,E5,R,A5,R,A5,A5,R,R,R];
song=[line1,line2,line3,line4,line5,line6,line7];
 
audiowrite('Mario.wav',song, 44100);

% music components 
[wave, fs] = audioread('MARIO.wav');   % sampling frequency (fs = 30000)
n = length(wave)-1; % discrete increments
t = 0:1/fs:n/fs; % time axis increments
f = 0:fs/n:fs;  % frequency axis increments
y = awgn(wave,1);   %white Gaussian noise
wavefft = abs(fft(wave));   % fast fourier transform of the original music
yfft = abs(fft(y));       % fast fourier transform of the Gaussian noise

noise= awgn(wave,5,'measured');  
audiowrite('MarioWithNoise.wav',noise,44100);

% t-domain filtered components 
nn = 5;
mag = 700;
w = mag*2/fs;
[b, a] = butter(nn,w,'low');
res = filter(b,a,wave);

out=filter(b,a,noise);
audiowrite('MarioFiltered.wav',out,44100);