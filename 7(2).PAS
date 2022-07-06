program Eks_Pad;
   uses Crt, Graph;
{ёЄрЄшёЄшўхёъшх ярЁрьхЄЁ√ ьюфхыш }
   const H=5000; kvz =0.0182; c=0.55; pv=1.29; r = 0.1; g=9.8;
     var gD, gM, g0m, v0m, pshm ,vm, ym, i, j, z, bpsh, bv, k: integer;
         psh, m, v0, v1, a0, a1, s0, s1, t0, t1, dt, k1, k2, apsh, av, kpsh, ky, kv : real;
         maspsh, masm, mask1, mask2, mast, masv, masa : array[1..1000] of real;
         ags, avs: string;
BEGIN
	dt := sqrt(2*H/g)/100; {Шаг времени модели падения }
	psh:=0; {начальное значение радиуса} j:=0;
	repeat {внешний цикл для подбора искомого значения радиуса}
		psh:=psh+10; {0,005 шаг эксперимента при подборе радиуса}
		m:= 2/3*pi*exp(3*ln(r))*psh; {масса шарика для текущего r}
		k1:= 6*pi*kvz*r; k2:= 0.5*c*pi*sqr(r)*pv;
		{ k1, k2 - коэффициенты сопротивления среды для текущего r}
		t0:=0; s0:=0; v0:=0; a0:=g; {начальные данные модели падения }
		repeat { цикл моделирующий падение для текущего радиуса}
			t1:= t0+dt;
			s1 := s0 + v0*dt + a0*sqr(dt)/2;
			v1 := v0 +a0*dt;
			a1:= (m*g - k1*v1 - k2* sqr (v1))/m;
			t0:=t1; s0:=s1; v0:=v1; a0:=a1; {Переопределение нач данных}
		until s1>=H; {Заверешение цикла при падение тела на землю}
		j:=j + 1; {счетчик шагов эксперимента}
		{запись результатов в массивы на каждом шаге эксперимента}
		maspsh[j]:=psh; masv[j]:=v1;
	until abs(v1-48.1) <=1; {скорость приземления удовлетворяет критерию}
	if j<25 then k:=1 else if j<40 then k:=2 else k:= round(j/20+1);
	clrscr; {в следующей строке выводится шапка модели таблицы}
	writeln(' z      psh        V ');
	for z:= 1 to j do
         if (z mod k ) =0 then
          writeln(z:3,' ',maspsh[z]:5:3,' ',masv[z]:10:4);
	{вывод последнего результата из массивов}
        writeln(j:3,' ',maspsh[j]:5:3,' ',masv[j]:10:4);
	writeln;
	write(' Требуется в постановке эксперимента скорость = ' ,v1:2:4);
        writeln(' м/сек достигается при плотность шарика = ', psh:3:3, ' кг/м^3');
	readln;
	gD:=Detect;
        InitGraph(gD, gM, 'G:\BGI');
	g0m:= 40; v0m:=420; {машинные координаты начала координат XOY}
	bpsh:= 50; apsh:=200; {число пикселей и цена деления на гор оси радиусов}
	bv:= 25; av:=4.8; {число пикселей и ценаделения на верт оси скоростей}
	setbkcolor(15); setcolor(1);
	{на горизонтальной оси откладываются значения радиуса r}
	line(10, v0m, 620, v0m); line(615, v0m - 5, 620, v0m);
	line(615, v0m + 5, 620, v0m); outtextxy(630, v0m, 'psh');
	{на вертик оси откладывается значения скорости приземления V}
	line(g0m, 15, g0m, 460); line(g0m - 10, 25, g0m, 15);
	line(g0m + 10, 25, g0m, 15); outtextxy(g0m, 5, 'V');
	for i := 1 to 10 do line(g0m + i*bpsh, v0m - 5, g0m + i*bpsh, v0m + 5);
	for i := 1 to 13 do line(g0m- 5, v0m - i*bv, g0m + 5, v0m - i*bv);
	outtextxy(g0m - 8, v0m + 8, 'O');
	str(apsh : 1 : 2, ags); outtextxy(g0m + bpsh, v0m + 8, ags);
	str(av : 2: 0, avs); outtextxy(g0m - 20, v0m - bv, avs);
	kpsh:= bpsh / apsh ; kv:= bv / av ; { коэффициенты перевода координат }
	setcolor(2); {цвет точек графика}
	for z:=1 to j do
		begin
			pshm:= round(g0m+ kpsh*maspsh[z]);{перевод r в машин систему координат}
			vm:= round(v0m -kv*masv[z]);{перевод V в машин систему координат}
			circle(pshm,vm,1);
		end;
	readkey;
	cleardevice; setcolor(1); circle(300,50,5); {тело шарика в начале падения}
	setfillstyle(5,2); bar(200,420,400,430); {плоскость, на кот падает тело}
	readkey;
	setcolor(0); circle(300,50,5);
	t0:=0; s0:=0; v0:=0; a0:=g; {начальные данные процесса падения }
	repeat {цикл моедлир падение тела на экране при найденном r}
		t1:= t0+dt;
		s1:= s0+v0*dt+a0*sqr(dt)/2;
		v1:= v0+a0*dt;
		a1:= (m*g - k1*v1 - k2* sqr (v1))/m;
		ky := (420 - 50)/H; {количество пикселей приходящ на 1 метр}
		ym:= round(50 + ky*s1); {машин ордин падающего тела}
		setcolor(1); circle(300,ym,5); delay(450);
		setcolor(0); circle(300,ym,5);
		t0:=t1; s0:=s1; v0:=v1; a0:=a1;
	until s1<=H; {тело приземлилость}
	setcolor(1); circle(300,415,5); {упавшее тело}
	readkey; closegraph;
END.