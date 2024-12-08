% Load the signals
sig = load('sig_2.mat'); % Assuming the variables are 'y' and 'z'
Fs = sig.Fs;

Ny =length (sig.y);
Nz = length (sig.z);

% Compute and plot the Fourier Transform
Y = fft(sig.y);
Z = fft(sig.z);
f = (0:length(Y)-1)*Fs/length(Y);

% Shift the FFT and calculate the magnitude
Y_shifted = fftshift(Y);
magnitudeY = abs(Y_shifted);


% Shift the FFT and calculate the magnitude
Z_shifted = fftshift(Z);
magnitudeZ = abs(Z_shifted);


fy = (-Ny/2:Ny/2-1) *(Fs / Ny);
fz = (-Nz/2:Nz/2-1) * (Fs / Nz);


%plot the graphs
figure;
subplot(2, 1, 1);
plot(fy, abs(magnitudeY).^2);
title('magnitude squared of fourier transform of normalized y(t)');
xlabel('Frequency (Hz)');
ylabel('|Y(f)|^2');

subplot(2, 1, 2);
plot(fz, abs(magnitudeZ).^2);
title('magnitude squared of fourier transform of normalized z(t)');
xlabel('Frequency (Hz)');
ylabel('|Z(f)|^2');