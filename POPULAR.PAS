program Popul_mf;
   uses Crt, Graph;
    var i, j, l, z, gM, gD, bg, bv, g0m, v0m, ym, tm, Nm, vm : integer;
        a, b, r, k, as, t0, dt, ag, av, kg, kv, Np, N0, N1: real; ass: string;
        t, v, N: array [1..2000] of real; ysl: boolean;
function f (z: integer; x: real): real;
   begin if z = 1 then f:=(a-b)*x;
   if z = 2 then f:=r*x - k * sqr(x);
end;
BEGIN
	a:=0.5; b:=0.6;
	r:= 0.6; k:= 0.001;
	dt:=0.01;
	for z:=1 to 2 do
	begin
		t0:=0; N0:=1000;
		i:=1; t[1]:=t0; N[1]:=N0; v[1]:=f(z, N0);
		repeat
			Np:=N0+dt*f(z, N0);
			N1:=N0+dt*(f(z, N0)+f(z, Np))/2;
			t0:=t0+dt; N0:=N1;
			i:=i+1; t[i]:=t0; N[i]:=N1; v[i]:=f(z,N1);
			if z = 1 then ysl:= abs(t0-10)<=0.1;
			if z =2 then ysl:= abs(N0-r/k)<= 1;
		until ysl;
		clrscr;
		if i < 25 then l:=1 else if i < 40 then l:=2 else l:= round(i/20);
		writeln ('Шаг j Время  t Численность N  Скорость v');
		for j:=1 to i do if (j mod l) = 0 then writeln('    ',j,'    ',t[j]:6:3,'    ' , N[j]:6:0,'     ',v[j]:6:0);
		writeln('    ',i,'    ',t[i]:6:3,'    ', N[i]:6:0,'   ',v[i]:6:0);
		readln;
		gD:=Detect; Initgraph(gD, gM, 'G:\BGI');
		setbkcolor(15); setcolor(1);
		g0m:=20;
		if z = 1 then v0m:=420; if z = 2 then v0m:=300;
		line(g0m,v0m,620,v0m); line (615,v0m-5,620,v0m);
		line (625,v0m-5,620,v0m);
		line (g0m,20,g0m,470); line (g0m-5,25,g0m,20);
		line (g0m+5,25,g0m,20); outtextxy(620,v0m,'t');
		outtextxy(g0m-10,15,'N/v');
		bg:=50; bv:=50; ag:=1;
		if z = 1 then av:=100; if z = 2 then av:=50;
		kg:=bg/ag; kv:=bv/av;
		for j:=1 to 10 do line(g0m+j*bg, v0m-5, g0m+j*bg, v0m+5);
		str(ag:3:0,ass); outtextxy(g0m+bg, v0m+5, ass);
		for j:=1 to 10 do line(g0m-5, v0m- j*bv, g0m+5, v0m - j*bv);
		for j:=1 to 5 do line(g0m-5, v0m + j*bv, g0m+5, v0m + j*bv);
		str(av:2:0,ass); outtextxy(g0m-20,v0m-bv-10,ass);
		if z=2 then
		begin
			as:=r/k; ym:= round (v0m - kv*as);
			setcolor(4);
			line (g0m, ym, 640, ym);
		end;
		for j:=1 to i do
			begin
				tm:= round(g0m+kg*t[ j]);
				Nm:= round (v0m-kv*N[j]);
				vm:= round (v0m-kv*V[j]);
				setcolor(2); circle(tm, Nm ,1);
				setcolor (13); circle (tm, vm,1);
			end;
		setcolor(2); outtextxy (tm-10,Nm-10 ,'N(t)');
		setcolor(13); outtextxy(tm-10,vm+10,'v(t)');
		readkey;
		closegraph;
	end;
END.