% parameters of the analog filter as calculated in the word documentN = 36;
Omega_0 = 3563*2*pi*1000; % rad/sec
N=36;

% load the signal 
load('sig_2.mat'); % 
Fs = sig.Fs; % sampling frequency = 8192 Hz

% calculate poles
poles = Omega_0 * exp(1j * pi * (2 * (0:N-1) + N + 1) / (2 * N));

% define frequency points for evaluation
omega = linspace(-pi, pi, 1000); % frequency sampling points in the discrete-time domain
s = 1j* Omega_0 * tan(omega / 2); % mapping discrete-time frequencies to s-plane (digital)

% initialize H(s) for the given frequency points
H_s = ones(size(s));  %%%% WHY DO WE NEED A VECTOR AND NOT JUST INTIALIZE H_s =1??


% evaluate H(s) at the given frequency points, thus building the neccessary filter.                  
                                                                                 
for k = 0:N-1
    sk = Omega_0 * exp(1j * pi * (2 * k + 1 + N) / (2 * N));
    H_s = H_s .* (-sk) ./ (s - sk);
end



% normalize frequency vector for plotting
f = (omega) * (Fs / (2 * pi)); % convert omega to the required normalized frequency using Fs

% plot the frequency response
figure;
subplot(2, 1, 1);
plot(f, abs(H_s).^2);
title('magnitude response of the filter');
xlabel('Frequency (Hz)');
ylabel('magnitude');
xlim([0, Fs/2]); %again print the positive x-axys, the filter is symmetrical around w=0

%now in dB
subplot(2, 1, 2);
plot(f, 20*log10(abs(H_s)));
title('magnitude response of the filter in dB scale');
xlabel('Frequency (Hz)');
ylabel('magnitude [dB]');
xlim([0, Fs/2]); 