clear all

Fs1 = 1000;
t1 = 0 : 1/Fs1 : 1;
y1 = sin(2*pi*257*t1) + randn(1,length(t1));
flag1 = 1;

[Py, f] = spec_fun1(t1, y1, Fs1, flag1);

