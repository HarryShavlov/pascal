program Polet_R;
    uses crt,graph;
    const psh=8500; pv=1.29; kvz=0.0182; r=0.1; c=0.4; g:=9.8;
    var gD,gM,xm,ym: integer; g,alf,alf1,t0,t1,dt,x0,y0,x1,y1,v0,vx0,vx1,vy0,vy1,ax,ay,v,m,k1,k2,ax0,ay0,ax1,ay1: real;
BEGIN
    gD:=Detect;
    Initgraph(gD,gM,'G:\BGI');
{входные данные процесса полета}
    v0:=10; alf:=45;
    alf1:=alf*pi/180; dt:=0.001; {угол в радианах}
{начальные данные полета}
    t0:=0; x0:=0; y0:=0;
    vx0:=v0*cos(alf1);
    vy0:=v0*sin(alf1);
    ax0:=-(k1*vx0+k2*sqrt(sqr(vx0)+sqr(vy0))*vx0)/m;
    ay0:=-g-(k1*vy0+k2*sqrt(sqr(vx0)+sqr(vy0))*vy0)/m;
    m:=4/3*pi*exp(3*ln(r))*psh;
    k1:=6*pi*kvz*r;
    k2:=0.5*c*pi*sqr(r)*pv;
    setfillstyle(5,2);
    bar(10,420,600,430); {плоскость}
    circle(13,412,5); {тело кружок в начале полета}
    readkey;
    setcolor(0);
    circle(13,412,5);
    repeat
        t1:=t0+dt;
        x1:=x0+vx0*dt+ax*sqr(dt)/2;
        y1:=y0+vy0*dt+ay*sqr(dt)/2;
        vx1:=vx0+ax*dt;
        vy1:=vy0+ay*dt;
        ax1:=-(k1*vx1+k2*sqrt(sqr(vx1)+sqr(vy1))*vx1)/m;
        ay1:=-g-(k1*vy1*+k2*sqrt(sqr(vx1)+sqr(vy1))*vy1)/m;
        xm:=round(13+45*x1);
        ym:=round(412-75*y1);
        setcolor(15);
        circle(xm,ym,5);
        delay(200);
        setcolor(0);
        circle(xm,ym,5);
{переопределение начальных данных для следующего цикла}
        t0:=t1;
        x0:=x1;
        y0:=y1;
        vx0:=vx1;
        vy0:=vy1;
        ax0:=ax1;
        ay0:=ay1;
    until y1<=0; {тело приземлилось}
    v:=sqrt(sqr(vx1)+sqr(vy1)); {скорость приземления}
    setcolor(15);
    circle(xm,412,5); {приземлившееся тело}
    readkey;
    closegraph;
    clrscr;
{выходные данные}
    writeln('=====================================================');
    writeln('    Входные данные');
    writeln(' Угол = ',alf:4:1);
    writeln(' Начальная скорость v0 = ',v0:4:4);
    writeln('=====================================================');
    writeln('    Расчетные данные ');
    writeln(' Масса шарика m = ', m:4:4);
    writeln(' Коэффициент сопротивления k1 = ',k1:4:4 , ' Коэффициент сопротивления k2 = ',k2:4:4 );
    writeln('=====================================================');
    writeln('    Выходные данные ');
    writeln(' Время полета ');
    writeln(' Экспериментальное = ',t1:4:4);
    writeln(' Дальность полета ');
    writeln(' Экспериментальная = ',x1:4:4);
    writeln(' Скорость приземления ');
    writeln(' Экспериментальная = ',v:4:4 );
    writeln(' Горизонтальная составляющая скорости ');
    writeln(' Экспериментальная = ',vx1:4:4);
    writeln(' Вертикальная составляющая скорости ');
    writeln(' Экспериментальная ',vy1:4:4);
    writeln(' Горизонтальная составляющая ускорения ax = ',ax1:4:2);
    writeln(' Вертикальная составляющая ускорения ay = ',ay1:4:2);
    writeln('=====================================================');
    readln;
END.