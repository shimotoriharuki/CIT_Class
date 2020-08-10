clf

% -----------------元データ-------------------
Angle = [-10, 0, 10, 20, 30, 40, 50, 60];
Lift = [-11.7937, -0.0751935, 11.1168, 14.0047, 15.8419, 16.5799, 16.3529, 14.0563];
Drag = [6.62958, 4.33768, 6.59023, 9.80552, 13.4044, 16.823, 19.7304, 23.3778];

figure(1)
% subplot(2, 1, 1)
hold on 
plot(Angle, Lift);
plot(Angle, Drag);

%-----------------揚力近似---------------%
n1 = 4;
p1 = polyfit(Angle, Lift, n1); 

a1 = p1(:,1);
b1 = p1(:,2);
c1 = p1(:,3);
d1 = p1(:,4);
e1 = p1(:,5);
syms s;
y1 = a1 * s^4 + b1 * s^3 + c1 * s^2 + d1 * s + e1 ;

fplot(y1, [-10, 60]);

%-----------------抗力近似---------------%
n2 = 4;
p2 = polyfit(Angle, Drag, n2); 

a2 = p2(:,1);
b2 = p2(:,2);
c2 = p2(:,3);
d2 = p2(:,4);
e2 = p2(:,5);
syms s;
y2 = a2 * s^4 + b2 * s^3 + c2 * s^2 + d2 * s + e2 ;

fplot(y2, [-10, 60]);

hold off
legend("揚力元データ", "抗力元データ", "揚力近似曲線", "抗力近似曲線")
ylabel("Force")
xlabel("Angle")

% subplot(2, 1, 2)

%-----------------揚抗比---------------%
figure(2)
LD_ratio = y1 / y2;
fplot(LD_ratio, [-10, 60]);

%-----------------揚抗比　最大値計算---------------%
xx = -10 : 60;
yy1 = a1 * xx.^4 + b1 * xx.^3 + c1 * xx.^2 + d1 * xx + e1 ;
yy2 = a2 * xx.^4 + b2 * xx.^3 + c2 * xx.^2 + d2 * xx + e2 ;
LD_ratio_ = yy1 ./ yy2;
MAX = max(LD_ratio_);

plot(xx, LD_ratio_)
ylabel("Lift-Drag ratio")
xlabel("Angle")




