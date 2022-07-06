program Polet;
   uses crt, Graph;
  const kvz =0.0182; c=0.4; psh=8500; r=0.1; g=9.8; pv=1.29;
    var gD, gM, xm, ym : integer;
        m, alf, alf1,k1,k2, t0,t1,dt, x0, y0, x1, y1, v0, v, vx0, vx1, vy0, vy1, ax, ay, vt, ax1,ay1,
        tt, st, vxt, vyt: real;
BEGIN
	gD:=Detect; Initgraph(gD, gM,'G:\BGI');
{входные данные процесса полета}
	v0 :=20; alf :=45; {Угол в градусах}
	alf1:= alf *pi/180; {Угол в радианах}; dt :=0.001;
{начальные данные полета}
	t0 :=0; x0 :=0; y0 :=0;
	vx0 := v0*cos(alf1); vy0 := v0*sin(alf1);
        ax:=0; ay:=-g;
        m:= 2/3*pi*exp(3*ln(r))*psh;
        k1:=6*pi*kvz*r;
        k2:=0.5*c*pi*sqr(r)*pv;
	setfillstyle (5,2); bar (10,420,600,430); {плоскость}
	circle (13,412,5); {Тело кружок в начале полета}
	readkey; setcolor(0); circle(13,412,5);
	repeat {цикл модел полет тела кружка}
		t1 := t0 + dt;
		x1 := x0 + vx0*dt + ax*sqr(dt)/2;
		y1 := y0 + vy0*dt + ay* sqr(dt)/2;
		vx1 := vx0 + ax*dt;
		vy1 := vy0 + ay*dt;
                ax1:=k1*vx1+k2*sqrt(sqr(vx1)+sqr(vy1))*vx1;
                ay1:=-g*m+k1*vy1+k2*sqrt(sqr(vx1)+sqr(vy1))*vy1;
		xm :=round (13+45*x1);
		ym :=round (412- 75*y1);
		setcolor (15); circle (xm,ym,5); delay (200);
		setcolor (0); circle (xm,ym,5);
{переопределение начальных данных для следующего витка цикла}
		t0 :=t1; x0 :=x1; y0 :=y1; vx0 :=vx1; vy0 :=vy1;ax:=ax1;ay:=ay1;
	until y1<= 0; {тело приземлилось}
	v:= sqrt(sqr(vx1) + sqr(vy1));{скорость приземления}
	setcolor(15); circle (xm,412,5); {приземлившееся тело}
	readkey; closegraph;
	clrscr;
	{выходные данные расчитанные по теорет формулам}
	tt:=2*v0*sin(alf1)/g; {время полета}
	St:=v0*v0*sin(2*alf1)/g; {дальность полета}
	Vxt:=v0*sin(alf1); {гориз сост скорости приземлен }
	Vyt:=v0*cos(alf1)- g*tt; {верт сост скорости приземл}
	Vt:=sqrt(sqr(vxt) + sqr(vyt)); {скорость приземл }
	writeln ('==============================================');
	writeln (' Входные данные модели полета');
	writeln (' Угол под которым бросили тело =', alf:4:1);
	writeln (' Начальная скорость полета = ', v0:4:0);
	writeln ('==============================================');
	writeln (' Выходные данные модели полета ');
	writeln (' Продолжительность полета: ');
	writeln ('Экспериментальная = ', t1:4:4);
	writeln (' Дальность полета');
	writeln ('Экспериментальная = ', x1:4:4);
	writeln ( 'Скорость приземления  ');
	writeln ( 'Экспериментальная =', v:4:4);
	writeln ( ' Горизонтальная составляющая этой скорости');
	writeln ( 'Экспериментальная = ',vx1:4:4);
	writeln ( 'Вертикальная составляющая этой скорости');
	writeln ( 'Экспериментальная = ',vy1:4:4);
	writeln ( 'Горизонтальная составляющая  ax= ', ax:4:2);
	writeln ( 'Вертикальная составляющая ay= ', ay:4:2);
	writeln ('==============================================');
	readkey;
END.