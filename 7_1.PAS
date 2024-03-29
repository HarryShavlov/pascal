program Eks_Pad;
   uses Crt, Graph;
   const H=20; kvz1=1; c=0.55; psh=15500; p1=1000; g=9.8; p2=1020; kvz2=1.1;
     var gD, gM, g0m, v0m, rm ,tm, ym, i, j, z, br, bt, k: integer;
         r,v2,t2,dt2,s2, m, v0, v1,a0, a1,a2,a3,H1, s0, s1, t0, t1, dt, k1, k2,k3,k4, ar, at, kr, ky, kt : real;
         masr, mast: array[1..1000] of real;

         ags, avs: string;
BEGIN
	dt := sqrt(2*H/g)/100; {��� �६��� ������ ��������}
        H1:=H/3;
	r:=0; {��砫쭮� ���祭�� ࠤ���} j:=0;
	repeat {���譨� 横� ��� ������ �᪮���� ���祭�� ࠤ���}
		r:=r+0.01; {0,005 蠣 ��ᯥਬ��� �� ������ ࠤ���}
		m:= 2/3*pi*exp(3*ln(r))*psh; {���� �ਪ� ��� ⥪�饣� r}
		k1:= 6*pi*kvz1*r; k2:= 0.5*c*pi*sqr(r)*p1;
                k3:= 6*pi*kvz2*r; k4:= 0.5*c*pi*sqr(r)*p2;
		{ k1, k2 - �����樥��� ᮯ�⨢����� �।� ��� ⥪�饣� r}
		t0:=0; s0:=0; v0:=0; a0:=g; {��砫�� ������}
                repeat { 横� ���������騩 ������� ��� ⥪�饩 ���⭮�� �।�}
			t1:= t0+dt;
			s1 := s0 + v0*dt + a0*sqr(dt)/2;
		        v1 := v0 + a0*dt;
                        if s1>H1 then a1:= (m*g - k3*v1 - k4*sqr(v1)-p2*2/3*pi*exp(3*ln(r))*g)/m
                                 else a1:= (m*g - k1*v1 - k2*sqr(v1)-p1*2/3*pi*exp(3*ln(r))*g)/m;
			t0:=t1; s0:=s1; v0:=v1; a0:=a1; {��८�।������ ��� ������}
		until s1>=H;
		j:=j + 1; {���稪 蠣�� ��ᯥਬ���}
		{������ १���⮢ � ���ᨢ� �� ������ 蠣� ��ᯥਬ���}
		masr[j]:=r; mast[j]:=t1;
	until abs(t1-3)<=0.1; {᪮���� �ਧ������� 㤮���⢮��� �����}
	if j<25 then k:=1 else if j<40 then k:=2 else k:= round(j/20+1);
	clrscr; {� ᫥���饩 ��ப� ��
        ������ 蠯�� ������ ⠡����}
	writeln(' 蠣 z     ࠤ��� r          �६� t ');
	for z:= 1 to j do
         if (z mod k ) =0 then
          writeln(z:3,'           ',masr[z]:5:3,'        ',mast[z]:10:4);
	{�뢮� ��᫥����� १���� �� ���ᨢ��}
        writeln(j:3,'           ',masr[j]:5:3,'        ',mast[j]:10:4);
	writeln;
	write(' �ॡ���� � ���⠭���� ��ᯥਬ��� �६� = ' ,t1:2:4);
        writeln(' ᥪ ���⨣����� �� ࠤ��� �ਪ� = ', r:3:3, ' �');
	readln;
	gD:=Detect;
        InitGraph(gD, gM, 'G:\BGI');
	g0m:= 40; v0m:=420; {��設�� ���न���� ��砫� ���न��� XOY}
	br:= 50; ar:=0.05; {�᫮ ���ᥫ�� � 業� ������� �� ��� �� ࠤ��ᮢ}
	bt:= 25; at:=0.5; {�᫮ ���ᥫ�� � 業�������� �� ���� �� ᪮��⥩}
	setbkcolor(15); setcolor(1);
	{�� ��ਧ��⠫쭮� �� �⪫��뢠���� ���祭�� ࠤ��� r}
	line(10, v0m, 620, v0m); line(615, v0m - 5, 620, v0m);
	line(615, v0m + 5, 620, v0m); outtextxy(630, v0m, 'r');
	{�� ���⨪ �� �⪫��뢠���� ���祭�� ᪮��� �ਧ������� V}
	line(g0m, 15, g0m, 460); line(g0m - 10, 25, g0m, 15);
	line(g0m + 10, 25, g0m, 15); outtextxy(g0m, 5, 't');
	for i := 1 to 10 do line(g0m + i*br, v0m - 5, g0m + i*br, v0m + 5);
	for i := 1 to 13 do line(g0m- 5, v0m - i*bt, g0m + 5, v0m - i*bt);
	outtextxy(g0m - 8, v0m + 8, 'O');
	str(ar : 1 : 2, ags); outtextxy(g0m + br, v0m + 8, ags);
	str(at : 2: 0, avs); outtextxy(g0m - 20, v0m - bt, avs);
	kr:= br / ar ; kt:= bt / at ; { �����樥��� ��ॢ��� ���न��� }
	setcolor(2); {梥� �祪 ��䨪�}
	for z:=1 to j do
		begin
			rm:= round(g0m+ kr*masr[z]);{��ॢ�� r � ��設 ��⥬� ���न���}
			tm:= round(v0m -kt*mast[z]);{��ॢ�� V � ��設 ��⥬� ���न���}
			circle(rm,tm,1);
		end;
	readkey;
	cleardevice; setcolor(1); circle(300,50,5); {⥫� �ਪ� � ��砫� �������}
	setfillstyle(5,2); bar(200,420,400,430); {���᪮���, �� ��� ������ ⥫�}
	readkey;
	setcolor(0); circle(300,50,5);
	t0:=0; s0:=0; v0:=0; a0:=g;  {��砫�� ����� ����� ��������}
	repeat {横� ������� ������� ⥫� �� ��࠭� �� ��������� r}
                t1:= t0+dt;
		s1 := s0 + v0*dt + a0*sqr(dt)/2;
		v1 := v0 + a0*dt;
                if s1>H1 then a1:= (m*g - k3*v1 - k4*sqr(v1)-p2*2/3*pi*exp(3*ln(r))*g)/m
                         else a1:= (m*g - k1*v1 - k2*sqr(v1)-p1*2/3*pi*exp(3*ln(r))*g)/m;
		ky := (420 - 50)/H; {������⢮ ���ᥫ�� ��室�� �� 1 ����}
		ym:= round(50 + ky*s1); {��設 �न� �����饣� ⥫�}
		setcolor(1); circle(300,ym,5); delay(450);
		setcolor(0); circle(300,ym,5);
		t0:=t1; s0:=s1; v0:=v1; a0:=a1;
	until s1<=H; {⥫� �ਧ���������}
	setcolor(1); circle(300,415,5); {㯠�襥 ⥫�}
	readkey; closegraph;
END.