%{
x = [-20:.1:20];
y1 = normpdf(x,0,1);
y2 = normpdf(x,0,4);
y3 = normpdf(x,0,9);
y4 = normpdf(x,4,4);

plot(x, y1, x, y2, x, y3, x, y4);

legend('N(0, 1)','N(0, 4)','N(0, 9)','N(4, 4)');
%}
x = [-7:.1:70];
y1 = normpdf(x,0,1);
y2 = normpdf(x,57,4);


plot(x, y1, x, y2);

legend('N(0, 1)','N(57, 4)');