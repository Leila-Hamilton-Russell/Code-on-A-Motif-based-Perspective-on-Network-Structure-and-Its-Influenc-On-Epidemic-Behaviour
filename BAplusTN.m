function [A,t] = BAplusTN(n, d, tr, fl)
% Take a BA network with n nodes and minimum degree d edges and rewire so that it has
% around tr triangles.  Uses pref.m (courtesy of Higham and Taylor).
warning off
% Optional flag to report statistics.
if nargin < 4, fl = 0; end

A = triu(pref(n,d),0); % Upper tirangular portion of a BA network.

% Find edges that lie in existing triangles
B = A.*(A+A')^2;%, pause
% Initial number of triangles
TR = sum(full(sum(B)))/3; trg = tr - TR;

if fl, fprintf('Initial graph has %d triangles.\n',TR), end

if trg <= 0
    k = 0;
else
    k = 1;
end

ct = 0;

while k && ct < 5
    k = 0; ct = ct+1;
    % Find edges that aren't part of triangles
    C = A-(B>0); [x,y] = find(C);
    % Remove trg of these edges, if there are that many.
    pote = length(x);
    if pote < trg
       de = 1:pote;
    else
        re = randperm(pote); de = re(1:trg);
    end
    A = A - sparse(x(de),y(de),1,n,n);
  
    mxeadd = min([pote trg]);
    % Find P2s that aren't in triangles and identify missing edges
        A2 = triu((A+A')^2,1);
        D = A2 - A2.*A;
        [xn,yn] = find(D);
        me = length(xn);
        % If there aren't enough, put back some of the removed edges.
        % Then it's worth another iteration.
        if me < mxeadd
            k = 1;
            xx = unique([xn yn;x y],'rows');
            xn = xx(:,1); yn = xx(:,2);
            me = length(xn);
        end
            re = randperm(me); re = re(1:mxeadd);
            xn = xn(re); yn = yn(re);
        A = A + sparse(xn,yn,1,n,n);
    %plot(graph(A+A'));pause
    if k % Recalculate values needed for another iteration.
        B = A.*(A+A')^2; TRa = sum(full(sum(B)))/3;
        trg = tr - TRa; if trg <=0, k = 0; end
    end
        
end

if fl || nargout==2
    t = sum(full(sum(A.*(A^2))));
end
if fl
    fprintf('Final graph has %d triangles.\n', t)
end 

A = A + A';

