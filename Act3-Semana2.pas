program Act3Semana2;

procedure binario(num:integer);
begin
 if(num < 2)then
  writeln(num)
 else begin
  binario(num DIV 2);
  writeln(num MOD 2);
 end;
end;

procedure generar(num:integer);
begin
 writeln('ingrese un numero');
 readln(num);
 while(num <> 0)do begin
  writeln('NUMERO EN BINARIO');
  binario(num);
  writeln('ingrese un numero');
  readln(num);
 end;
end;

var
 num:integer; 
BEGIN
 writeln('Bienvenido al programa,ingrese numero para mostrar el numero en binario');	
 generar(num);	
END.

