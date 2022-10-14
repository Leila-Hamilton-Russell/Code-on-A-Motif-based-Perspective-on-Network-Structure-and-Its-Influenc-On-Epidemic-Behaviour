%print 30 random barabasi-Albert networks save as:
n = 1000;
d = 5;
r = 30;
a = pref(n,d);

for i = 1:r
    a = pref(n,d);
    BAmatrix = sprintf('%s_%d','BAmatrix',i);
    writematrix(a,BAmatrix);
end 

