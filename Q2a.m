function testR()
  %2a
  % Parameters
A0 = 1;
A1 = 1;
Omega0 = 2 * pi * 1000;  % תדר סינוסואידה ראשוני ברד/שנייה
Omega_s = 2 * pi* 6720;  % תדר דגימה ברד/שנייה
N_values = [16, 32, 64, 128, 256];  % ערכים שונים של N
colors = ['b', 'g', 'r', 'c', 'm'];  % צבעים שונים לגרפים

figure;
hold on;  % מאפשר ציור של כל הגרפים באותה תמונה

for idx = 1:length(N_values)
    N = N_values(idx);
    Omega1 = Omega_s*(Omega0 + (4 * pi / N));  % חישוב אומגה 1
    t = (0:N-1) / Omega_s;  % וקטור הזמן
    
    % חלון מלבני
    window = ones(1, N);
    
    % בניית האות
    x = (A0 * sin(Omega0 * t) + A1 * sin(Omega1 * t)) .* window;
    
    % התמרת פורייה דיסקרטית (DFT)
    X = fft(x);
    freqs = (0:N-1) * (Omega_s / N);  % וקטור תדרים
    
    % ציור הספקטרום
    plot(freqs, abs(X), 'Color', colors(idx), 'DisplayName', sprintf('N=%d', N));
end

title('Spectrum of the Windowed Signal for Different N');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend show;
grid on;
hold off;



end