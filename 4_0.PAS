program  Graphic;
   uses  Crt, Graph;
   var   gM, gD, i, bx, by, x0m, y0m, tx1, tx2, ty1, ty2,xm,ym: integer;
                 a, b, x, y, ax, ay ,kx , ky: real; s1, s2 : string ;
BEGIN
   clrscr;
   write ('');
   readln (x0m,y0m);
   write ('');
   readln (bx,by);
   write ('');
   readln (ax,ay);
   write ('�������  ����� ������� [a,b], �� ������� �������� ������ ');
   readln(a,b);
   gD:= Detect;  InitGraph(gD, gM, 'F:\BGI');
   outtextxy(240, 1, '������ ������� � = �*�');
   line (10, y0m, 620, y0m);  line (615, y0m - 5, 620, y0m);
   line (615, y0m + 5, 620, y0m);  outtextxy (630,  y0m, 'X');
   line (x0m, 25, x0m, 460);  line (x0m - 10, 35, x0m, 25);
   line (x0m + 10, 35, x0m, 25);  outtextxy (x0m,  20, 'Y');
   tx1 := round((x0m - 10) / bx);  tx2 := round((620 - x0m) / bx);
   for i := 1 to  tx1 do  line(x0m - i*bx, y0m - 5, x0m - i*bx, y0m + 5);
   for i := 1 to  tx2 do  line (x0m + i*bx,y0m - 5, x0m + i*bx, y0m + 5);
   ty1 := round((y0m - 15) / by); ty2 := round((460 - y0m) / by);
   for i := 1 to  ty1 do  line (x0m - 5,y0m - i*by, x0m + 5, y0m - i*by);
   for i := 1 to  ty2 do  line (x0m - 5, y0m + i*by, x0m + 5,y0m + i*by);
   str (ax : 2 : 1, s1);   outtextxy (x0m + bx,  y0m + 8, s1);
   str (ay : 2 : 1, s2);   outtextxy (x0m - 10,  y0m - by, s2);
   kx:= bx / ax ;   ky :=  by / ay;
   x := a;
   repeat
         y:=sqr(x);
	 xm := round(x0m +kx*x);
         ym :=  round(y0m -ky*y);
	 circle( xm, ym, 1);
    	 x := x + 0.01;
   until x >= b;
   readkey;
   closegraph;
END.
