program Eks1_Pol;
   uses Crt, Graph;
  const kvz =0.0182; c=0.4; psh=8500; r=0.1; pv=1.29;
    var gD, gM, i, x, y, x0m, y0m, xm, ym, alf, alfa, h, bx, by :integer;
        g, v0, t0, t1, dt,m,k1,k2, alf1, x0, y0, vx0, vy0, ax0, ay0, x1, y1,
        vx1, vy1, ax1, ay1, max, ax, ay, kx, ky, S,S1 : real;
        as, xs, ms : string;
BEGIN
	gD:=Detect; Initgraph(gD, gM, 'G:\BGI');
	setbkcolor(15); setcolor (1);
	x0m:=20; y0m:=420;{���. ����. ������ ������. ������� �����. ���}
	bx:=40; ax:=1;{���-�� �������� � 1 ������� � ���� ������� �� ��� ��}
	by:=45; ay:=0.6; {���. �������� � 1 ������� � ���� ������� �� ��� ��}
	kx:=bx/ax; ky:=by/ay; {�����. �������� ��������� �� ��� � ���m}
	line(x0m,y0m,620,y0m); line(615,y0m -5,620,y0m);
	line(615,y0m +5,620,y0m); outtextxy(625,y0m, 'X'); { ��� ��}
	line(x0m,20,x0m,y0m); line(x0m -5,25, x0m,20);
	line(x0m + 5,25,x0m,20); outtextxy(x0m ,10, 'Y'); {��� ��}
	outtextxy(x0m -10,y0m+5,'O'); {������ ��������� ���}
{ ��������������� ���� ���������}
	for i:=0 to 14 do line(x0m +i*bx,415, x0m+ i*bx,425);
	for i:=0 to 8 do line(15,y0m - i*by,25,y0m - i*by);
	str(ax:1:0,as); outtextxy(x0m + bx,y0m +10,as); { ��. �������� �� ��}
	str(ay:2:1,as); outtextxy(x0m -20,y0m -by-10,as); {��. �������� �� �Y}
	g:=0; v0:=10; {�������� ������ ������}
	i:=0; max:=0; dt:=0.001;
	alf:=65;
	repeat
		g:=g+0.1;
		t0:=0; x0:=0; y0:=0;
		vx0:=v0*cos(alf); vy0:=v0*sin(alf);
		ax0:=0;
		ay0:=-g;
		i:=i+1; setcolor (i); {���� ���������� ������}
		repeat {����, ������������ ����� ��� �������� ����}
			t1:=t0+dt;
			x1:=x0+vx0*dt+ax0*sqr(dt)/2;
			y1:=y0+vy0*dt+ay0* sqr(dt)/2;
			vx1:=vx0+ax0*dt;
			vy1:=vy0 + ay0*dt;
			xm:=round(x0m+kx*x1); {�������� �������� ����}
			ym:=round(y0m-ky*y1); {�������� �������� ����}
			circle(xm,ym,1); {����� ������� ����������}

{��������������� ��������� �������}
			x0:=x1; y0:=y1;vx0:=vx1; vy0:=vy1; ax0:=ax1; ay0:=ay1;
		until (t1-3)<=0.1; { ������� ������������� ����}
		str(t1:3:2,xs); str(g:2,as);
		outtextxy(450, 50+i*10, ' g= ' + as + ' t1= ' + xs);
	until y1<=0;
{����� �� ����� ���������� ������������ � ��������� �����}
	setcolor (1); outtextxy(50,450,'��������� ���쭮��� ����� S=' + ms+' ���⨣����� �� 㣫� ' + as + ' �ࠤ�ᮢ');
	g:=sqr(v0)*sin(2*alfa*pi/180)/x1;{��������� �� ������������� �������}
	str(S1:3:2,ms); outtextxy(50,470, '������᪠� ���쭮��� �� �⮬ 㣫�' + ms);
	readkey;
	closegraph;
END.