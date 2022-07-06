Program  Crocodil;
        uses crt, Graph;
         var  x, y, x1, y1, j, i, z, k, gkv, vkv, gM, gD, S, R: integer;
                 js : string;  kv: array[1..3000]  of integer;              
BEGIN
         randomize;   
         clrscr;
         write('Введите число побегов (экспериментов) k  ');
         readln (k);
         gD:= Detect;  InitGraph(gD, gM, 'G:\BGI ');
         setbkcolor(15);   setcolor(1);   setfillstyle(1,1);
         y:=25; S:=0;
         for i:=0 to 8 do
              begin
                    x:=100;
                    for j:=0 to 8 do bar(x+ j*50, y+ i*50, x+25+ j*50, y+25+ i*50);
              end;
         setcolor(2);
         rectangle(300,225,325,250);setfillstyle(1,2); floodfill(312,240,2);
         setcolor(15);
         outtextxy(300,230,'3OO');  outtextxy(300,240,'PARK');
         setlinestyle(2,2,3);
         for j:=1 to  k do
             begin
                  x:=300; y:=225;
                  if j <=15  then
                      begin
                           setcolor(j);circle(x,y,4);
                           {readkey;}
                           setcolor(0);  circle(x,y,4);

                       end;
                  for i:=1 to 5 do
                      begin
                            z:= random(4)+1;
                if z=1 then  begin y1:=y-50; x1:=x; end;
           if z=2 then  begin y1:=y+50; x1:=x; end;
               if z=3 then  begin y1:=y; x1:=x-50; end;
                                  if z=4 then  begin y1:=y; x1:=x+50; end;
                                  if j <=15  then
                                           begin
                                                setcolor(j); line(x,y,x1,y1);circle(x1,y1,4);
                                                {readkey;}   setcolor(0);  circle(x1,y1,4);
                                            end;
                                 x:=x1;y:=y1
                         end;
                  if j<=15 then
                        begin
                              setcolor(j);  if j =1 then  setcolor(15);
                              circle(x1+12,y1+12,6);
                              str(j,js);   outtextxy(x1+9,y1+9,js);

	               end;
                 gkv:= round(abs(x-300)/50);
                 vkv:= round(abs(y-225)/50);
	       if  gkv > vkv then   kv[ j ]:=  gkv  else kv[ j ]:=  vkv ;
                 S:=S + kv[j];
               end;
           R:=round(S/k);     if  R < S/k then R:=R+1;
           setcolor(5); setlinestyle(0,1,3);
            rectangle(300 - R*50, 225 - R*50, 325 + R*50, 250 + R*50);
            readkey;
            closegraph;
            writeln ('Номер эксперимента    Число кварталов от зоопарка');
            writeln;
             if k < 25 then i:=1 else if k <40 then  i:=2 else i:=round(k/20);
             for j:=1 to k do if (j mod i =0) then writeln(j:10, kv[j]:25);
             writeln( k:10,   kv[k]:25);
             writeln;
             writeln('Крокодила нужно искать в ближайших ', R, 'кварталах от зоопарка ');
            readln;
END.
