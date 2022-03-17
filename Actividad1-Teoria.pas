program actividad1;
type
 lista = ^nodo;
 nodo = record
  dato:integer;
  sig:lista;
 end;
 
procedure AgregarAdelante(var l:lista; num:integer);
var 
 nue:lista;
begin  
 New(nue);
 nue^.dato:= num; 
 nue^.sig:=l;
 l:=nue;
end; 

procedure generar(var l:lista);
var 
 num,i:integer;
begin
 for i:= 1 to 8 do begin
  writeln('ingrese un numero');
  readln(num);
  AgregarAdelante(l,num);
 end;
end;

procedure imprimir(l:lista);
begin
 if(l <> nil)then begin
  writeln(l^.dato);
  imprimir(l^.sig);
 end;
end;

var 
 l:lista;
BEGIN
 l:= nil;
 writeln('Bienvenido al programa,ingrese 8 numeros');
 generar(l);
 writeln('Lista impresa con recurisividad');
 imprimir(l);	
END.

