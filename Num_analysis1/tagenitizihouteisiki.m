A = [ 5 2 0 0 0 0 0 0 0 0 ;
      2 5 2 0 0 0 0 0 0 0;
      0 2 5 2 0 0 0 0 0 0
      0 0 2 5 2 0 0 0 0 0
      0 0 0 2 5 2 0 0 0 0
      0 0 0 0 2 5 2 0 0 0
      0 0 0 0 0 2 5 2 0 0
      0 0 0 0 0 0 2 5 2 0
      0 0 0 0 0 0 0 2 5 2
      0 0 0 0 0 0 0 0 2 5];
B = [3; 1; 4; 0; 5; -1; 6; -2; 7; -15];
X = linsolve(A,B);