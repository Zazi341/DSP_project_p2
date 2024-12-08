%calculated parameters of the analog filter
Omega_p = 5.192774; % rad/sec
Omega_s =8.7691; % rad/sec
delta_p = 0.4376; % 1-1/4th root of 10
delta_s = 0.1;

% calculated Omega_0
Omega_0 = 4.72;


% calculate k, d, and filter order N (also calculated in the Word document)
d = sqrt(((1 / (1 - delta_p)^2) - 1) / ((1 / delta_s^2) - 1));
kappa = Omega_p / Omega_s;
N = ceil(log10(1 / d) / log10(1 / kappa));


% display results
fprintf('filter Order N: %d\nChosen Omega_0: %.4f rad/sec\n', N, Omega_0); %%%WHAT DOING HERE

% calculate poles and transfer function coefficients
poles = Omega_0 * exp(1j * pi * (2 * (0:N-1) + N + 1) / (2 * N)); 



% frequency response calculation
w = logspace(0, 4, 1000); % frequency sampling vector from 1 to 10^4 rad/sec
H_s = ones(size(w)); % initialize H(s) to 1 for the upcoming product calculation

% evaluate H(s) at the given frequency points, thus building the neccessary filter.                  
for k = 0:N-1
    sk = Omega_0 * exp(1j * pi * (2 * k + 1 + N) / (2 * N));
    H_s = H_s .* (-sk) ./ (1j * w - sk);
end




% plot the results
figure;

% plot the magnitude response in linear scale
subplot(3, 1, 1);
semilogx(w, abs(H_s), 'lineWidth', 1.5);
grid on;
xlabel('frequency (rad/sec)');
ylabel('magnitude');
title('magnitude response (linear scale)');





% plot the magnitude response in dB scale
subplot(3, 1, 2);
semilogx(w, 20*log10(abs(H_s)), 'lineWidth', 1.5);
grid on;
xlabel('frequency (rad/sec)');
ylabel('magnitude (dB)');
title('magnitude response (dB Scale)');
hold on;
hold off;

% Plot the poles
subplot(3, 1, 3);
plot(real(poles), imag(poles), 'x', 'linewidth', 1.5);
grid on;
xlabel('Real');
ylabel('Imaginary');
title('poles of the Butterworth filter');
axis equal;