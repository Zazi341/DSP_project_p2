% load the signals
sig = load('sig_2.mat');
Fs = sig.Fs;
Nz = length(sig.z);

% compute the Fourier Transform of Z, then shift acordingly.
Z = fft(sig.z);
Z_shifted = fftshift(Z);
magnitudeZ = abs(Z_shifted);
% create frequency vector to sample Z
fz = (-Nz/2:Nz/2-1) * (Fs / Nz);

% parameters of the digital filter as calculated in the word document
N = 4;
Omega_0 = 4.72; % rad/sec

% define frequency points for evaluation
omega = linspace(-pi, pi, Nz); % frequency points in the discrete-time domain
% map discrete-time frequencies to z-plane
z = exp(1j*omega);

% map z-plane to s-plane using bilinear transform
s = (z - 1) ./ (z + 1);
% initialize H(s) for the given frequency points, for the following product
H_s = 1;

% evaluate H(s) at the given frequency points, thus building the neccessary filter.                  
for k = 0:N-1
    sk = Omega_0 *exp(1j * pi * (2 * k + 1 + N) / (2 * N));
    H_s = H_s .* (-sk) ./ (s - sk);
end

% absolute squared value of H_s as required
H_s_mag = abs(H_s).^2;

% filter Z in frequency domain using our filter
Z_filtered = Z_shifted .* H_s_mag.';

% convert back to time domain to listen to the audio
z_filtered = real(ifft(ifftshift(Z_filtered)));

% plot frequency responses
figure;
subplot(3, 1, 1);
plot(omega * Fs / (2*pi), H_s_mag.^2);
title('Magnitude Response of the Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude ');
xlim([0, Fs/2]); % the filter is symmetrical, so itll look mirrored in [-Fs/2, 0]


%in dB
subplot(3, 1, 2);
plot(fz, abs(magnitudeZ).^2);
title('Magnitude Response of the Original Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0, Fs/2]);

subplot(3, 1, 3);
plot(fz, abs(Z_filtered).^2);
title('magnitude Response of the Filtered Signal');
xlabel('frequency (Hz)');
ylabel('magnitude (dB)');
xlim([0, Fs/2]);

% plot time domain signals for comparasion and check filtering quality
figure;
subplot(2,1,1);
plot((0:Nz-1)/Fs, sig.z);
title('original Signal in Time Domain');
xlabel('time (s)');
ylabel('amplitude');

subplot(2,1,2);
plot((0:Nz-1)/Fs, z_filtered);
title('filtered Signal in Time Domain');
xlabel('time (s)');
ylabel('amplitude');


%play the audio of the new filtered Z.
playerObj = audioplayer(z_filtered,Fs);
start = 1;
stop = playerObj.SampleRate *3;
play(playerObj,[start,stop])