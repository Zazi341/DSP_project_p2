% parameters of the digital filter as calculated in the word document
N = 4;
Omega_0 = 4.8; % rad/sec

%load Fs
sig = load('sig_2.mat'); % The variables 'y', 'z', and 'Fs' should be loaded
Fs = sig.Fs; % Sampling frequency

% define frequency points for evaluation
omega = linspace(-pi, pi, 1000); % frequency points in the discrete-time domain
z=exp(1j*omega);
s = (z-1)./(z+1); % mapping discrete-time frequencies to s-plane

% initialize H(s) for the given frequency points
H_s = ones(size(s)); %%%% WHY DO WE NEED A VECTOR AND NOT JUST INTIALIZE H_s =1??

% evaluate H(s) at the given frequency points
for k = 0:N-1
    sk = Omega_0 * exp(1j * pi * (2 * k + 1 + N) / (2 * N)); % the poles
    H_s = H_s .* (-sk) ./ (s - sk);
end



% normalize frequency vector for plotting
f = (omega) * (8192 / (2 * pi)); % get the new frequency by omega and the original samling rate

% plotting the frequency response
figure;
subplot(2, 1, 1);
plot(f, abs(H_s).^2);
title('magnitude response of the filter');
xlabel('Frequency (Hz)');
ylabel('magnitude');
xlim([0, Fs/2]); % the filter is symmetrical, so itll look mirrored in [-Fs/2, 0]

subplot(2, 1, 2);
plot(f, 20*log10(abs(H_s)));
title('magnitude response of the filter in dB scale');
xlabel('Frequency (Hz)');
ylabel('magnitude [dB]');
xlim([0, Fs/2]);  % the filter is symmetrical, so itll look mirrored in [-Fs/2, 0]