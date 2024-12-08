%2c
% Parameters
A0 = 0.001;
A1 = 1;
Omega0 = 2 * pi * 1000;  % תדר סינוסואידה ראשוני ברד/שנייה
F_s = 6720;  % תדר דגימה ברד/שנייה
N_values = [16, 32, 64, 128, 256];  % ערכים שונים של N
colors = ['b', 'g', 'r', 'c', 'm'];  % צבעים שונים לגרפים
beta = 7;

figure;
hold on;  % מאפשר ציור של כל הגרפים באותה תמונה

for idx = 1:length(N_values)
    N = N_values(idx);
    Omega1 = Omega0 + (2 * pi * 1.5 * 1000);  % Adjusted frequency of the second sinusoid
    t = (0:N-1) /(F_s);  % וקטור הזמן
    
    % חלון קייזר (Kaiser window)
    window = kaiser(N, beta)';
    
    % בניית האות
    x = (A0 * sin(Omega0 * t) + A1 * sin(Omega1 * t)) .* window;
    
    % אפס ריפוד להגדלת רזולוציית ה-FFT (zero-padding to increase FFT resolution)
    X = fft(x, 1024);
    freqs = (0:1023) * (F_s / 1024);  % וקטור תדרים עם ריפוד
    
    % ציור הספקטרום
    plot(freqs, 20*log10(abs(X)), 'Color', colors(idx), 'DisplayName', sprintf('N=%d', N));
end

title('Spectrum of the Windowed Signal for Different N with Zero-Padding');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend show;
grid on;
hold off;

