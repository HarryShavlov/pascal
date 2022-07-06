program Eks_Pad;
   uses Crt, Graph;
{ёЄрЄшёЄшўхёъшх ярЁрьхЄЁ√ ьюфхыш }
   const H=20; kvz1=1; c=0.55; psh=15500; p1=1000; g=9.8; p2=1020; kvz2=1.1;
     var gD, gM, g0m, v0m, rm ,tm, ym, i, j, z, br, bt, k: integer;
         r,v2,t2,dt2,s2, m, v0, v1,a0, a1,a2,a3, s0, s1, t0, t1, dt, k1, k2,k3,k4, ar, at, kr, ky, kt : real;
         masr, masm, mask1, mask2, mast, masv, masa : array[1..1000] of real;

         ags, avs: string;
BEGIN
	dt := sqrt(2/3*H/g)/3; {Шаг времени модели падения }
        dt2:= sqrt(4/3*H/g)/3;
	r:=0; {начальное значение радиуса} j:=0;
	repeat {внешний цикл для подбора искомого значения радиуса}
		r:=r+0.01; {0,005 шаг эксперимента при подборе радиуса}
		m:= 2/3*pi*exp(3*ln(r))*psh; {масса шарика для текущего r}
		k1:= 6*pi*kvz1*r; k2:= 0.5*c*pi*sqr(r)*p1;
                k3:= 6*pi*kvz2*r; k4:= 0.5*c*pi*sqr(r)*p2;
		{ k1, k2 - коэффициенты сопротивления среды для текущего r}
		t0:=0; s0:=0; v0:=0; a0:=g; a2:=a0+(m*g - k1*v1 - k2* sqr (v1)+p2*g*4/3*pi*exp(3*ln(r)))/m;{начальные данные }
		repeat { цикл моделирующий падение для текущего радиуса}
			t1:= t0+dt;
                        t2:= t1+dt2;
			s1 := s0 + v0*dt + a0*sqr(dt)/2;
                        s2 := s1 + v1*dt2+ a2*sqr(dt2)/2;
                        v1 := v0 +a0*dt;
                        v2 := v1 +a1*dt2;
                        a1:= (m*g - k1*v1 - k2* sqr (v1)+p1*g*4/3*pi*exp(3*ln(r)))/m;
                        a3:= a1+(m*g - k3*v2 - k4* sqr (v2)+p2*g*4/3*pi*exp(3*ln(r)))/m;
			t0:=t1; s0:=s1; v0:=v1; a0:=a1; a2:=a3; {Переопределение нач данных}
		until s2>=H; {Заверешение цикла при падение тела на землю}
		j:=j + 1; {счетчик шагов эксперимента}
		{запись результатов в массивы на каждом шаге эксперимента}
		masr[j]:=r; mast[j]:=t2;
	until abs(t2+t1-4)<=1; {скорость приземления удовлетворяет критерию}
	if j<25 then k:=1 else if j<40 then k:=2 else k:= round(j/20+1);
	clrscr; {в следующей строке выводится шапка модели таблицы}
	writeln(' z    r    t ');
	for z:= 1 to j do
         if (z mod k ) =0 then
          writeln(z:3,' ',masr[z]:5:3,' ',mast[z]:10:4);
	{вывод последнего результата из массивов}
        writeln(j:3,' ',masr[j]:5:3,' ',mast[j]:10:4);
	writeln;
	write(' Требуется в постановке эксперимента время = ' ,t2:2:4);
        writeln(' сек достигается при радиусе шарика = ', r:3:3, ' м');
	readln;
	gD:=Detect;
        InitGraph(gD, gM, 'G:\BGI');
	g0m:= 40; v0m:=420; {машинные координаты начала координат XOY}
	br:= 20; ar:=0.01; {число пикселей и цена деления на гор оси радиусов}
	bt:= 50; at:=0.5; {число пикселей и ценаделения на верт оси скоростей}
	setbkcolor(15); setcolor(1);
	{на горизонтальной оси откладываются значения радиуса r}
	line(10, v0m, 620, v0m); line(615, v0m - 5, 620, v0m);
	line(615, v0m + 5, 620, v0m); outtextxy(630, v0m, 'r');
	{на вертик оси откладывается значения скорости приземления V}
	line(g0m, 15, g0m, 460); line(g0m - 10, 25, g0m, 15);
	line(g0m + 10, 25, g0m, 15); outtextxy(g0m, 5, 't');
	for i := 1 to 10 do line(g0m + i*br, v0m - 5, g0m + i*br, v0m + 5);
	for i := 1 to 13 do line(g0m- 5, v0m - i*bt, g0m + 5, v0m - i*bt);
	outtextxy(g0m - 8, v0m + 8, 'O');
	str(ar : 1 : 2, ags); outtextxy(g0m + br, v0m + 8, ags);
	str(at : 2: 0, avs); outtextxy(g0m - 20, v0m - bt, avs);
	kr:= br / ar ; kt:= bt / at ; { коэффициенты перевода координат }
	setcolor(2); {цвет точек графика}
	for z:=1 to j do
		begin
			rm:= round(g0m+ kr*masr[z]);{перевод r в машин систему координат}
			tm:= round(v0m -kt*mast[z]);{перевод V в машин систему координат}
			circle(rm,tm,1);
		end;
	readkey;
	cleardevice; setcolor(1); circle(300,50,5); {тело шарика в начале падения}
	setfillstyle(5,2); bar(200,420,400,430); {плоскость, на кот падает тело}
	readkey;
	setcolor(0); circle(300,50,5);
	t0:=0; s0:=0; v0:=0; a0:=g; a2:=a0+(m*g - k1*v1 - k2* sqr (v1))/m; {начальные данные процесса падения }
	repeat {цикл моедлир падение тела на экране при найденном r}
                t1:= t0+dt;
                t2:= t1+dt2;
                a1:= (m*g - k1*v1 - k2* sqr (v1))/m;
                a3:= (m*g - k3*v2 - k4* sqr (v2))/m;
		s1 := s0 + v0*dt + a0*sqr(dt)/2;
                s2 := s1 + v1*dt2+ a2*sqr(dt2)/2;
                v1 := v0 +a0*dt;
                v2 := v1 +a1*dt2;
		ky := (420 - 50)/H; {количество пикселей приходящ на 1 метр}
		ym:= round(50 + ky*s1); {машин ордин падающего тела}
		setcolor(1); circle(300,ym,5); delay(450);
		setcolor(0); circle(300,ym,5);
		t0:=t1; s0:=s1; v0:=v1; a0:=a1; a2:=a3;
	until s1<=H; {тело приземлилость}
	setcolor(1); circle(300,415,5); {упавшее тело}
	readkey; closegraph;
END.