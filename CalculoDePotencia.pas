program actividad1;

Function potencia(x,n: integer): real;
begin
 if(n = 0) then
  potencia:= 1  
 else
  potencia := x * potencia(x,n-1); 
end;

Function potencia1(x,n: integer): real;
begin
 potencia1 := x * potencia1(x,n-1); //no tiene caso base
end;

Function potencia2(x,n: integer): real;
begin
 if(n = 0) then
  potencia2:= 1  //tiene caso base
 else
  potencia2 := x * potencia2(x,n); //no achica el problema
end;

var
 x,n:integer;
BEGIN
 writeln('Ingrese numero');
 readln(x);
 writeln('Ingrese potencia a calcular');
 readln(n);
 writeln('La potencia de ',x,' es: ',potencia(x,n):0:2);
 //writeln('La potencia de ',x,' es: ',potencia1(x,n):0:2);
 //writeln('La potencia de ',x,' es: ',potencia2(x,n):0:2);	
END.

