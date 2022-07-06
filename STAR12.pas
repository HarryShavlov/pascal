Program Star;
   uses Crt,Graph;
   var gD,gH,i,k,x0,y0,p:integer; r1,r2,a1,a2,a3:real;
   procedure Ugol;
      var x1,y1,x2,y2,x3,y3:real;
         begin
            x1:=x0+r1*cos(a1); y1:=y0-r1*sin(a1);
            x2:=x0+r2*cos(a2); y2:=y0-r2*sin(a2);
            x3:=x0+r2*cos(a3); y3:=y0-r2*sin(a3);
               line(round(x1),round(y1),round(x2),round(y2));
               line(round(x1),round(y1),round(x3),round(y3));
         end;

BEGIN
   gD:=Detect; Initgraph(gD,gH,'f:\BGI');
   setbkcolor(15);
   randomize;
   repeat
   if ord(readkey) <>27 then
   begin
      cleardevice;
      k:=random(16);
      setcolor(k);
      x0:=280;y0:=250;
      r1:=random(30)+40; r2:=random(100)+100;
      a1:=0;
      p:=random(5)+15;
      for i:=1 to p do
         begin
            a1:=a1+2*pi/p;
            a2:=a1+pi/p;
            a3:=a1-pi/p;
            ugol;
            readkey;
         end;
   end;
   setfillstyle (1,k);
   floodfill (x0,y0,k);
   until ord(readkey) = 27;
   readkey;
   closegraph;
END.