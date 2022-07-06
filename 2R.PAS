program Eks2_Pol;
   uses Crt, Graph;
    var gD, gM, i, j, x, y, x0m, y0m, xm, ym, bx, by: integer;
        v0, t0, t1,dt, x0, y0, vx0, vy0, ax0, ay0, x1, y1, vx1, vy1, ax1, ay1, alf,
        alf1, h, g, ax, ay, kx,k1,k2,m, ky, S: real;
        as, xs, ms : string;  yskor : array[1..1000] of real;
BEGIN
     v0:=16;
     g:=0;
     dt:=0.001; alf :=65; {начальное значение искомого угла}{ шаг эксперимента в градусах}
     repeat {цикл для определения значения угла на j планете}
            g:=g+0.1;
            t0:=0; x0:=0; y0:=0;
	    vx0:=v0*cos(alf); vy0:=v0*sin(alf); ax0:=0; ay0:= -g;
	    repeat {цикл, моделирующий полет для текущего угла}
	           t1:=t0+dt;
		   x1:=x0+vx0*dt+ax0*sqr(dt)/2;
		   y1:=y0+vy0*dt+ay0* sqr(dt)/2;
		   vx1:=vx0+ax0*dt;
		   vy1:=vy0+ay0*dt;
                   x0:=x1; y0:=y1;vx0:=vx1; vy0:=vy1;
	    until y1<=0; { условие «приземления» тела на j планете}
            j:=j+1;
            yskor[j]:=g;
     until abs(t1 - 3)<=1;
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
     for i:=0 to 14 do line(x0m +i *bx, 415, x0m+ i*bx, 425);
     for i:=0 to 9 do line(15, y0m - i*by, 25, y0m - i*by);
     str(ax:1:0,as); outtextxy(x0m + bx, y0m +10, as); { ед. масшт. по ОХ}
     str(ay:2:1,as); outtextxy(x0m -20, y0m -by-10, as); {ед. масшт. по ОY}
     v0:=16;
     g:=0;
     dt:=0.001; alf :=65; {начальное значение искомого угла}{ шаг эксперимента в градусах}
     repeat {цикл для определения значения угла на j планете}
            g:=g+0.1;
            t0:=0; x0:=0; y0:=0;
	    vx0:=v0*cos(alf); vy0:=v0*sin(alf);
	    ax0:=0;
	    ay0:=-g;
	    repeat {цикл, моделирующий траекторию для текущего угла}
	           t1:=t0+dt;
		   x1:=x0+vx0*dt+ax0*sqr(dt)/2;
		   y1:=y0+vy0*dt+ay0* sqr(dt)/2;
		   vx1:=vx0+ax0*dt;
		   vy1:=vy0 + ay0*dt;
		   xm:= round(x0m + kx*x1);
		   ym:= round(y0m - ky*y1);
		   circle(xm,ym,1);
                   x0:=x1; y0:=y1;vx0:=vx1; vy0:=vy1;
            until y1<=0; { условие «приземления» тела на j планете}
            str(g:3:2,xs); str(t1:2,as);
            outtextxy(450, 50+i*10, ' t1= ' + as + ' g= ' + xs);
     until abs(t1-3)<=1;
     str(g:2:1,ms); str(t1:2:2,as);
     outtextxy(350,20+j*10, 'g= ' + ms +' t1=' + as );
     g:=sqr(v0)*sin(2*alf)/x1; str(g:3:2,ms);
     outtextxy(50,430+j*10,'Теор. дальность g=' + ms );
     readkey; closegraph;
END.