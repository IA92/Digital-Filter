##https://www.mathworks.com/help/signal/ref/butter.html
##https://au.mathworks.com/help/signal/ref/freqz.html#bt829u7
##https://au.mathworks.com/help/matlab/ref/filter.html

#Low pass filter implementation
#with Butterworth filter order 2
#with fixed point operation

fc = 5;
fs = 50;

#Get the filter coefficient
[b,a] = butter(2,fc/(fs/2));

freqz(b,a,[],fs)

subplot(2,1,1)
ylim([-100 20])

#Plot input data
t = linspace(0,1,fs);
x = sin(2*pi*1*t)+sin(2*pi*15*t);
figure();
plot(t,x);
title('Input data');

#Filter the data using the generated expression and 'filter' function
y=filter(b,a,x);
figure();
plot(t,y);
title('Filtered data')

#Reproduce the same output directly from the filter coefficients
disp(b)
disp(a)
yman=zeros(1,fs);
for i = 3:fs
    yman(i)=b(1)*x(i)+b(2)*x(i-1)+b(3)*x(i-2)-a(2)*yman(i-1)-a(3)*yman(i-2);
end
figure();
plot(t,yman);
title('Manual filtered data');

#Reproduce the data using fixed point operation
fp_res = 16;
x_fp = int64( x * 10000 * bitshift(1, fp_res));
b_fp = int64( b * bitshift(1, fp_res));
a_fp = int64( a * bitshift(1, fp_res));
figure();
plot(t,x_fp);
title('X_FP');

yman_fp=zeros(1,fs);
for i = 3:fs
    yman_fp(i)=int64(bitshift(b_fp(1)*x_fp(i), -fp_res) + bitshift(b_fp(2)*x_fp(i-1), -fp_res) + bitshift(b_fp(3)*x_fp(i-2), -fp_res) - bitshift(a_fp(2) * yman_fp(i-1), -fp_res)- bitshift(a_fp(3)*yman_fp(i-2), -fp_res));
end
figure();
plot(t,yman_fp);
title('Y_FP');

yman_fp = bitshift(yman_fp,-fp_res)/10000;
figure();
plot(t,yman_fp);
title('Manual filtered data with FP');

