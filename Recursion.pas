program CalculoDigitoMaximoRec;
type digito=-1..9;

var num: integer;
    max: digito;

procedure digitoMaximoRec(n: integer; var max: digito);
var
  dig: integer;
begin
  if (n <> 0) then begin
                dig:= n mod 10;
                if (dig > max) then
                                max:= dig;
                n:= n div 10;
                //writeln('max:',max);
                digitoMaximoRec(n, max);
                //writeln('max:',max);
              end;
end;

procedure ImprimirDigitos1(n:integer);
var
 dig:integer;
begin
 if(n <> 0)then begin
  dig:= n mod 10;
  writeln(dig);
  n:= n div 10;
  ImprimirDigitos1(n);
 end; 
end;

procedure ImprimirDigitos2(n:integer);
begin
 if(n <> 0)then begin
  ImprimirDigitos2(n div 10);
  writeln(n mod 10);
 end;
end;

var
 n:integer;
begin
  writeln('Ingrese un numero entero (menor a 32767)');
  readln (n);
  max := -1;
  digitoMaximoRec(n, max);
  writeln('El digito maximo de ', n, ' es: ', max);
  writeln('Imprimir digitos 1:');
  ImprimirDigitos1(n);
  writeln('Imprimir digitos 2:');
  ImprimirDigitos2(n);
  readln;
end.

