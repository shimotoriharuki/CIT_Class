load ("ans_000.txt");
load ("ans_111.txt");

round = linspace(0,34,34);
x1 = ans_000(:,1);
x2 = ans_000(:,2);
x3 = ans_000(:,3);

%{
round = linspace(0,36,36);
x1 = ans_111(:,1);
x2 = ans_111(:,2);
x3 = ans_111(:,3);
%}

plot(round, x1, round, x2, round, x3)

xlabel("round");
ylabel("x");
legend('x1', 'x2', 'x3');