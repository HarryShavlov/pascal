program  Students;
   uses  Crt, Graph;
   const   kol : array [1..6] of longint =(1143823,2512234,52312266,62123119,137074,80123100);
           god : array [1..6]of string  =('1900', '1950', '1990','2000','2010','2200');
          var  gM, gD, k, x0m, y0m, by, ay, ax : integer;   ky: real;
                  ks, kols : string [6];
BEGIN
         gD:= Detect;  InitGraph(gD, gM, 'G:\BGI');
         setbkcolor(15);  setcolor(1);
         setlinestyle (0,0,1);
         x0m:=60; y0m:=400;
         line(x0m, y0m, 600, y0m);  line(x0m, 30, x0m, y0m);
         by:=4099;
         ay:= 1000;
         ky:= by/ay;
         for  k :=1 to 8 do
              begin
	           line(x0m - 3, y0m - k*by, x0m + 3, y0m - k*by);
	           str (k*1000,ks);  outtextxy(25 , y0m - k*by - 4, ks);
              end;
         settextstyle (0,0,1);
         outtextxy(20,20, 'Рост численности населения Земли в млн. чел');
         settextstyle (0,0,1);
         ax := 85;
         for  k :=1 to  6 do
             begin
   	        setfillstyle(1, k);
                  bar(70 + (k - 1)*ax,  y0m, 70 + k*ax, round (y0m-(kol[k])*ky));
                  str (kol[k], kols);
	        outtextxy(110+(k-1)*ax, round(y0m -10 -( kol[k]*ky)), kols);
                  outtextxy(90+(k-1)*ax, y0m + 10 , god[k]);
             end;
         readkey; closegraph;
END.
