program Act1Semana2;
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
 new(nue);
 nue^.dato:= num;
 nue^.sig:=l;
 l:=nue;
end; 
 
procedure generar(l:lista);
var
 num:integer;
begin
 writeln('ingrese un numero');
 readln(num);
 while(num <> 0)do begin
  AgregarAdelante(l,num);
  writeln('ingrese un numero');
  readln(num);
 end;
end; 

procedure varmaximo(l:lista;var max:integer);
begin
 if(l <> nil)then begin
  if(l^.dato > max)then begin
   max:= l^.dato;
   varmaximo(l^.sig,max);
  end;
 end;
end;

procedure varminimo(l:lista;var min:integer);
begin
 if(l <> nil)then begin
  if(l^.dato < min)then begin
   min:= l^.dato;
   varminimo(l^.sig,min);
  end;
 end;
end;
 
procedure busqueda(l:lista;num:integer;var ok:boolean);
begin
 if(l <> nil)then begin
  if(num = l^.dato)then 
   ok:= true
  else
   busqueda(l^.sig,num,ok);
 end; 
end;

var
 l:lista;
 max,min,num:integer;
 ok:boolean;
BEGIN
 ok:= false;
 max:= 0;
 min:= 999;
 l:= nil;
 writeln('Bienvenido al programa,ingrese numeros y con 0 deja de ingresar');
 generar(l);
 varmaximo(l,max);
 writeln('El valor mas grande encontrado es: ',max);
 varminimo(l,min);
 writeln('El valor mas chico encontrado es: ',min);
 writeln('Ingrese un valor a buscar en la lista: ');
 readln(num);
 busqueda(l,num,ok);
 if(ok = true)then
  writeln('El elemento se encontro')
 else
  writeln('El numero no se encuentra en la lista');	
END.

