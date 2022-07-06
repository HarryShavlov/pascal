program Eks2_Pol;
   uses Crt, Graph;
    var gD, gM, k,i, j, x, y, x0m, y0m, xm, ym, bx, by: integer;
        v0, t0, t1,dt, x0, y0, vx0, vy0, ax0, ay0, x1, y1, vx1, vy1, ax1, ay1,
        alf,alf1, h, g, ax, t, ay, kx, ky, S: real; yskor :array [1..100] of real;
	as, xs, ms : string;
BEGIN
	v0:=16; g:=0;
	j:=0; t:=0;
	dt:=0.001; alf :=65;
        alf1:=alf*pi/180;
        t0:=0;
	repeat
		g:=g+0.5;
                x0:=0; y0:=0;
                t:=t+dt;
		vx0:=v0*cos(alf1); vy0:=v0*sin(alf1);
		ax0:=0; ay0:=-g;
                repeat
                      t1:=t0+dt;
	              x1:=x0+vx0*dt+ax0*sqr(dt)/2;
		      y1:=y0+vy0*dt+ay0* sqr(dt)/2;
		      vx1:=vx0+ax0*dt;
		      vy1:=vy0 + ay0*dt;
		      x0:=x1; y0:=y1;vx0:=vx1; vy0:=vy1;
                until y1<=0.1;
		j:=j+1;
		yskor[j]:=g;
        until (t1-3)<=0.1;
        gD:=Detect; Initgraph(gD, gM, 'G:\BGI');
	x0m:=20;y0m:=420;
	bx:=100; ax:=100;
	by:=100; ay:=100;
	kx:=bx/ax; ky:=by/ay;
	line(x0m,y0m,620,y0m); line(615,y0m -5,620,y0m);
	line(615,y0m +5,620,y0m); outtextxy(625,y0m,'x');
	line(x0m,20,x0m,y0m); line(x0m -5,25, x0m,20);
	line(x0m + 5,25,x0m,20); outtextxy(x0m ,10,'y');
	outtextxy(x0m -10,y0m+5,'O');
	for i:=0 to 14 do line(x0m +i *bx, 415, x0m+ i*bx, 425);
	for i:=0 to 9 do line(5, y0m - i*by, 25, y0m - i*by);
	str(ax:1:0,as); outtextxy(x0m + bx, y0m +10, as);
	str(ay:2:1,as); outtextxy(x0m -20, y0m -by-10, as);
        k:=1;
	for i:=1 to j do
		begin
                        if k>14 then k:=1;
			setcolor(k); g:=yskor[i];
			t0:=0; x0:=0; y0:=0;
			vx0:=v0*cos(alf1); vy0:=v0*sin(alf1);
			ax0:=0; ay0:=-g;
                        repeat
                              t1:=t0+dt;
			      x1:=x0+vx0*dt+ax0*sqr(dt)/2;
			      y1:=y0+vy0*dt+ay0* sqr(dt)/2;
			      vx1:=vx0+ax0*dt;
			      vy1:=vy0 + ay0*dt;
			      xm:= round(x0m + kx*x1);
			      ym:= round(y0m - ky*y1);
			      circle(xm,ym,1);
			      x0:=x1; y0:=y1;vx0:=vx1; vy0:=vy1;
                        until y1<=0;
			str(g:2:1,ms); str(t1:2:2,as);
			outtextxy(350,20+j*10, 'g=' + ms + 't1=' + as);
			g:=sqr(v0)*sin(2*alf)/x1; str(g:3:2,ms);
			outtextxy(50,430+j*10,'Teop. g=' + ms );
                        k:=k+1;
		end;
	readkey;closegraph;
END.