# Assign the variables
# Sampling rate
fs = 50
# Sampling interval
ts = 1.0/fs
t = linspace(0, 1, fs)
# Input signal
f_in = [1., 10., 15.]
x = 0
for i = 1: 3
  x = x + sin(2*pi*f_in(i)*t)
end
figure();
plot(t,x);
title('Input data');

# Get the FFT
N = length(x)
n = 1:N
T = N/fs
f = n/T

Y =fftn(x)

figure()
stem(f,abs(Y))
xlabel('Freq (Hz)')
ylabel('DFT Amplitude|X(freq)|')

