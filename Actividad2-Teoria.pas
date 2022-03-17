program actividad2;

procedure imprimirdig(num:integer);
begin
 if(num <> 0)then begin
  imprimirdig(num DIV 10);
  writeln(num MOD 10);
 end;
end;

procedure generar(num:integer);
begin
 writeln('ingrese un numero');
 readln(num);
 while(num <> 0)do begin
  writeln('DIGITOS');
  imprimirdig(num);
  writeln('ingrese un numero');
  readln(num);
 end;
end;

var
 num:integer;
BEGIN
 writeln('Bienvenido al programa,ingrese un numero para mostrar sus digitos y con 0 deja de procesar');
 generar(num);		
END.

