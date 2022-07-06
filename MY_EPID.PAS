program My_Epidemia;
    uses Crt, Graph;
    var gD,gM, i, j, k, bg, bv, g0m, v0m, tm, xbm, xzm,vm: integer;
        a, t0,  dt, tt, xb0, xbp, xby,  ag, av, av1, kv1, kg, kv, v: real;
        t, xb, xz, vb: array [1..2000] of real; ags, avs, ts: string; N : longint;
    function f(x: real): real;
    begin   f:=a*x*(N+1-x); end;
BEGIN
    clrscr;
    N:=2000000;
    a:=0.000002;
    dt:=0.01;
    t0:=0;
    xb0:=1;
    i:=1; t[1]:=t0; xb[1]:=xb0; xz[1]:=N; vb[1]:=f(xb0);
    repeat
        xbp:=xb0+dt*f(xb0);
        xby:=xb0+dt*(f(xb0)+f(xbp))/2;
        v:=f(xby);
        t0:=t0+dt;
        xb0:=xby;
        i:=i+1;
        t[i]:=t0;
        xb[i]:=xb0;
        xz[i]:=N - xb[i];
        vb[i]:=v;
    until  round(xb0) >= N+1;
    clrscr;
    writeln ('  Шаг      Время     Кол_во больных   Кол_во здоровых   Скорость ');
    if i < 25  then k:=1 else if i<40 then k:=2 else k:= round(i/20);
    for j:=1 to i do if (j mod k = 0) then
    writeln('  ',j:3,'     ',t[j]:5:2,'       ',xb[j]:5:0,'             ',xz[j]:5:0, '           ',vb[j]:5:2);
    writeln('  ',i:3,'     ',t[i]:5:2,'       ',xb[i]:5:0,'             ',xz[i]:5:0, '           ',vb[j]:5:2);
    readln;
    gD:=Detect;  Initgraph(gD, gM, 'G:\BGI');
    g0m:=20;v0m:=420;
    setbkcolor(15); setcolor(1);
    bg:=500;  bv:=125; ag:=7; av:=1000000;
    kg:=bg/ag;  kv:=bv/av;
    line(10,v0m,620,v0m); line(615,v0m-5,620,v0m);
    line(615,v0m+5,620,v0m);  outtextxy(625,v0m-10,'t');
    line(g0m,10,g0m,450);  line(g0m-5,15,g0m,10);
    line(g0m+5,15,g0m,10); outtextxy(5,5,'X/V');
    outtextxy(5,v0m+10,'O');
    for j:=1 to 25 do line(g0m+j*bg, v0m+5, g0m+j*bg, v0m-5);
    for j:=1 to 4 do line(g0m-5, v0m-j*bv, g0m+5, v0m-j*bv);
    str(ag:2:1,ags);    outtextxy(g0m-10+bg,v0m+10,ags);
    str(av:3:0,avs);     outtextxy(g0m+10,v0m-bv,avs);
    for j:=1 to i do
        begin
            tm:=round(g0m + kg*t[j]);
            xbm:=round(v0m - kv*xb[j]);
            xzm:=round(v0m - kv*xz[j]);
            vm:=round(v0m-kv*vb[j]);
            setcolor(2); circle(tm,xbm,1);
            setcolor(4); circle(tm,xzm,1);
            setcolor(5); circle(tm,vm,1);
        end;
    str(N,ags); str (a:0:6,avs);
    str(t0:0:2,ts);
    setcolor(1);
    outtextxy(50,450,'N='+ags+' a='+avs+' Заразный период T='+ts);
    tt:=  2*ln(N)/(a*(N + 1)); str(tt:0:2,ts);
    outtextxy(50, 460, 'Теоретический заразный период T='+ts);
    readkey;
    closegraph;
END.
