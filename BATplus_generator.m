n = 1000;
d = 5;
p = 151;
r = 180;
%tr = 500; 
%tr = 750, %tr = 1000, %tr = 1250, %tr = 1500
tr = 1500;
fl = 4;
T = BAplusTN(n,d,tr,fl);

for i = p:r
    T = BAplusTN(n,d,tr,fl);
    BAplusT = sprintf('%s_%d_%d','BAplusTN', i, tr);
    writematrix(T, BAplusT);
end 

