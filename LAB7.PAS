program Eks_Pad;
   uses Crt, Graph;
   const H=2700; kvz =0.0182; c=0.55; psh=8900; r = 0.11; g=9.8;
     var gD, gM, g0m, v0m, pvm ,vm, ym, i, j, z, bpv, bv, k: integer;
         pv, m, v0, v1, a0, a1, s0, s1, t0, t1, dt, k1, k2, apv, av, kpv, ky, kv : real;
         maspv, masm, mask1, mask2, mast, masv, masa : array[1..1000] of real;
         ags, avs: string;
BEGIN
	dt := sqrt (2*H/g)/100; {��� �६��� ������ ��������}
	pv:=0; {��砫쭮� ���祭�� ���⭮�� �।�} j:=0;
	repeat {���譨� 横� ��� ������ �᪮���� ���祭�� ���⭮�� �।�}
		pv:=pv+0.01; {0,01 蠣 ��ᯥਬ��� �� ������ ���⭮�� �।�}
		m:= 2/3*pi*exp(3*ln(r))*psh; {���� �ਪ� ��� ������� r}
		k1:= 6*pi*kvz*r; k2:= 0.5*c*pi*sqr(r)*pv;
		{ k1, k2 - �����樥��� ᮯ�⨢����� �।� ��� ������� r}
		t0:=0; s0:=0; v0:=0; a0:=g; {��砫�� ����� ������ ��������}
		repeat { 横� ���������騩 ������� ��� ⥪�饩 ���⭮�� �।�}
			t1:= t0+dt;
			s1 := s0 + v0*dt + a0*sqr(dt)/2;
			v1 := v0 +a0*dt;
			a1:= (m*g - k1*v1 - k2* sqr (v1))/m;
			t0:=t1; s0:=s1; v0:=v1; a0:=a1; {��८�।������ ��� ������}
		until s1>=H; {�����襭�� 横�� �� ������� ⥫� �� �����}
		j:=j + 1; {���稪 蠣�� ��ᯥਬ���}
		{������ १���⮢ � ���ᨢ� �� ������ 蠣� ��ᯥਬ���}
		maspv[j]:=pv; masv[j]:=v1;
	until abs(v1-139) <=1; {᪮���� �ਧ������� 㤮���⢮��� �����}
	if j<25 then k:=1 else if j<40 then k:=2 else k:= round(j/20+1);
	clrscr; {� ᫥���饩 ��ப� �뢮����� 蠯�� ������ ⠡����}
	writeln(' z      pv        V ');
	for z:= 1 to j do
         if (z mod k ) =0 then
          writeln(z:3,' ',maspv[z]:5:3,' ',masv[z]:10:4);
	{�뢮� ��᫥����� १���� �� ���ᨢ��}
        writeln(j:3,' ',maspv[j]:5:3,' ',masv[j]:10:4);
	writeln;
	write(' �ॡ���� � ���⠭���� ��ᯥਬ��� ᪮���� = ' ,v1:2:4);
        writeln(' �/ᥪ ���⨣����� �� ���⭮�� ������ = ', pv:3:3, ' ��/�^3');
	readln;
	gD:=Detect;
        InitGraph(gD, gM, 'G:\BGI');
	g0m:= 40; v0m:=420; {��設�� ���न���� ��砫� ���न��� XOY}
	bpv:= 100; apv:=0.25; {�᫮ ���ᥫ�� � 業� ������� �� ��� �� ���⭮�⥩ �।�}
	bv:= 25; av:=25; {�᫮ ���ᥫ�� � 業�������� �� ���� �� ᪮��⥩}
	setbkcolor(15); setcolor(1);
	{�� ��ਧ��⠫쭮� �� �⪫��뢠���� ���祭�� ���⭮�� �।�}
	line(10, v0m, 620, v0m); line(615, v0m - 5, 620, v0m);
	line(615, v0m + 5, 620, v0m); outtextxy(630, v0m, 'pv');
	{�� ���⨪ �� �⪫��뢠���� ���祭�� ᪮��� �ਧ������� V}
	line(g0m, 15, g0m, 460); line(g0m - 10, 25, g0m, 15);
	line(g0m + 10, 25, g0m, 15); outtextxy(g0m, 5, 'V');
	for i := 1 to 10 do line(g0m + i*bpv, v0m - 5, g0m + i*bpv, v0m + 5);
	for i := 1 to 13 do line(g0m- 5, v0m - i*bv, g0m + 5, v0m - i*bv);
	outtextxy(g0m - 8, v0m + 8, 'O');
	str(apv : 1 : 2, ags); outtextxy(g0m + bpv, v0m + 8, ags);
	str(av : 2: 0, avs); outtextxy(g0m - 20, v0m - bv, avs);
	kpv:= bpv / apv ; kv:= bv / av ; { �����樥��� ��ॢ��� ���न��� }
	setcolor(2); {梥� �祪 ��䨪�}
	for z:=1 to j do
		begin
			pvm:= round(g0m+ kpv*maspv[z]);{��ॢ�� pv � ��設 ��⥬� ���न���}
			vm:= round(v0m -kv*masv[z]);{��ॢ�� V � ��設 ��⥬� ���न���}
			circle(pvm,vm,1);
		end;
	readkey;
	cleardevice; setcolor(1); circle(300,50,5); {⥫� �ਪ� � ��砫� �������}
	setfillstyle(5,2); bar(200,420,400,430); {���᪮���, �� ��� ������ ⥫�}
	readkey;
	setcolor(0); circle(300,50,5);
	t0:=0; s0:=0; v0:=0; a0:=g; {��砫�� ����� ����� ��������}
	repeat {横� ������� ������� ⥫� �� ��࠭� �� ��������� pv}
		t1:= t0+dt;
		s1:= s0+v0*dt+a0*sqr(dt)/2;
		v1:= v0+a0*dt;
		a1:= (m*g - k1*v1 - k2* sqr (v1))/m;
		ky := (420 - 50)/H; {������⢮ ���ᥫ�� ��室�� �� 1 ����}
		ym:= round(50 + ky*s1); {��設 �न� �����饣� ⥫�}
		setcolor(1); circle(300,ym,5); delay(450);
		setcolor(0); circle(300,ym,5);
		t0:=t1; s0:=s1; v0:=v1; a0:=a1;
	until s1<=H; {⥫� �ਧ���������}
	setcolor(1); circle(300,415,5); {㯠�襥 ⥫�}
	readkey; closegraph;
END.