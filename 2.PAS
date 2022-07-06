program Eks2_Pol;
   uses Crt, Graph;
   const yskor :array[1..3] of real = (7.4, 8.8, 10.5);
	pvz: array[1..3] of real =(900 ,67,600);
        plan : array [1..3] of string = ('“а ­' , '‚Ґ­Ґа ', '‘ вга­');
	kvz =0.0182; c=0.4; psh=8500;r=0.1;
    var gD, gM, i, j, x, y, x0m, y0m, xm, ym, bx, by: integer;
        v0, t0, t1,dt, x0, y0, vx0, vy0, ax0, ay0, x1, y1, vx1, vy1, ax1, ay1, alf,
        alf1, h, g, ax, ay, kx,k1,k2,m, ky,pv, S: real; ugol :array [1..3] of real;
        as, xs, ms : string;
BEGIN
{Эксперимент проводится в текстовом режиме}
	for j:=1 to 3 do { цикл для определение угла на каждой планете}
		begin
			g:= yskor[j]; v0:=15; pv:=pvz[j];
			m:= 4/3*pi*exp(3*ln(r))*psh;
			k1:= 6*pi*kvz*r; k2:= 0.5*c*pi*sqr(r)*pv;		 {исходные данные полета на j планете}
			dt:=0.001; alf :=0; {начальное значение искомого угла}
			h:=0.5; { шаг эксперимента в градусах}
			repeat {цикл для определения значения угла на j планете}
				alf:=alf+h; { текущий угол в градусной мере}
				alf1:=alf*pi/180; {этот же угол в радианной мере}
{начальные данные полета для этого угла}
				t0:=0; x0:=0; y0:=0;
				vx0:=v0*cos(alf1); vy0:=v0*sin(alf1);
				ax0:= - (k1*vx0 + k2*sqrt (sqr(vx0) + sqr(vy0))*vx0)/m;
				ay0:= -g - (k1*vy0 + k2*sqrt (sqr(vx0) + sqr(vy0))*vy0)/m;
				repeat {цикл, моделирующий полет для текущего угла}
					t1:=t0+dt;
					x1:=x0+vx0*dt+ax0*sqr(dt)/2;
					y1:=y0+vy0*dt+ay0* sqr(dt)/2;
					vx1:=vx0+ax0*dt;
					vy1:=vy0 + ay0*dt;
					ax1:= - (k1*vx1 + k2*sqrt (sqr(vx1) + sqr(vy1))*vx1)/m;
					ay1:= -g - (k1*vy1 + k2*sqrt (sqr(vx1) + sqr(vy1))*vy1)/m;
{переопределение начальных условий}
					x0:=x1; y0:=y1;vx0:=vx1; vy0:=vy1; ax0:=ax1; ay0:=ay1;
				until y1<=0; { условие «приземления» тела на j планете}
			until abs(x0 - 10)<=5;
			ugol[j]:= alf; {найденное значение угла на j-той планете}
		end; {конец цикла по j}
	gD:=Detect; Initgraph(gD, gM, 'G:\BGI');
	x0m:=20;y0m:=420; {машинные kординаты центра системы ХОУ}
	bx:=40; ax:=1;{кол. пикселей в 1 делении на оси ОХ и цена деления}
	by:=45; ay:=0.3; {кол.пикселей в 1 делении на оси ОУ и цена деления}
	kx:=bx/ax; ky:=by/ay; {коэф-ты перевода координат из ХОУ в ХОУm}
	line(x0m,y0m,620,y0m); line(615,y0m -5,620,y0m);
	line(615,y0m +5,620,y0m); outtextxy(625,y0m,'X'); { ось ОХ}
	line(x0m,20,x0m,y0m); line(x0m -5,25, x0m,20);
	line(x0m + 5,25,x0m,20); outtextxy(x0m ,10,'Y'); {ось ОУ}
	outtextxy(x0m -10,y0m+5,'O');
	{ масштабирование осей координат}
	for i:=0 to 14 do line(x0m +i *bx, 415, x0m+ i*bx, 425);
	for i:=0 to 9 do line(15, y0m - i*by, 25, y0m - i*by);
	str(ax:1:0,as); outtextxy(x0m + bx, y0m +10, as); { ед. масшт. по ОХ}
	str(ay:2:1,as); outtextxy(x0m -20, y0m -by-10, as); {ед. масшт. по ОY}
	for j:=1 to 3 do { цикл для рисования траекторий на планетах}
		begin
			setcolor(j); alf :=ugol[j]; g := yskor[j];
			alf1:=alf*pi/180; { alf в радианной мере}
{начальные данные полета на j планете}
			pv:=pvz[j];
			t0:=0; x0:=0; y0:=0;
			k1:= 6*pi*kvz*r; k2:= 0.5*c*pi*sqr(r)*pv;
			vx0:=v0*cos(alf1); vy0:=v0*sin(alf1);
			ax0:= - (k1*vx0 + k2*sqrt (sqr(vx0) + sqr(vy0))*vx0)/m ;
			ay0:= -g - (k1*vy0 + k2*sqrt (sqr(vx0) + sqr(vy0))*vy0)/m;
			repeat {цикл, моделирующий траекторию для текущего угла}
				t1:=t0+dt;
				x1:=x0+vx0*dt+ax0*sqr(dt)/2;
				y1:=y0+vy0*dt+ay0* sqr(dt)/2;
				vx1:=vx0+ax0*dt;
				vy1:=vy0 + ay0*dt;
				ax1:= - (k1*vx1 + k2*sqrt (sqr(vx1) + sqr(vy1))*vx1)/m ;
				ay1:= -g - (k1*vy1 + k2*sqrt (sqr(vx1) + sqr(vy1))*vy1)/m;
				xm:= round(x0m + kx*x1);
				ym:= round(y0m - ky*y1);
				circle(xm,ym,1);
{переопределение начальных условий}
				x0:=x1; y0:=y1;vx0:=vx1; vy0:=vy1; ax0:=ax1; ay0:=ay1;
			until y1<=0; { условие «приземления» тела на j планете}
{вывод на экран результата эксперимента}
			str(alf:2:1,ms); str(x1:2:2,as);
			outtextxy(350,20+j*10, 'alf= ' + ms +' S=' + as + ' на '+plan[j]);
			S:=sqr(v0)*sin(2*alf1)/g; str(S:3:2,ms);
			outtextxy(50,430+j*10,'Теор. дальность S=' + ms + ' на ' + plan[j]);
	end; {конец цикла по j}
	readkey; closegraph;
END.