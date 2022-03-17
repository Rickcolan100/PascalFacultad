program actividad3;
type
 arbol = ^nodo;
 nodo = record
   elem: integer;
   hi: arbol;
   hd: arbol;
 end;
  
procedure Insertar(var a:arbol; num:integer);
begin
 if(a = nil) then begin
  new(a);
  a^.elem:= num;
  a^.hi:= nil;
  a^.hd:= nil;
 end
 else begin
  if(num < a^.elem) then
   insertar(a^.hi,num)
  else
   insertar(a^.hd,num);
  end;
end;
 
procedure generar(var a:arbol);
var 
 num,i:integer;
begin
 for i:= 1 to 8 do begin
  writeln('ingrese un numero');
  readln(num);
  insertar(a,num);
 end;
end;

procedure recorridoPreorden(a:arbol; var sum:integer); //de las raiz a las hojas
begin
 if(a <> nil)then begin
  sum:= sum + a^.elem;
  recorridoPreorden(a^.hi,sum);
  recorridoPreorden(a^.hd,sum);
 end;
end;

function varMax(a:arbol):integer; //valores maximos en el lado derecho del arbol
begin
 if(a <> nil)then begin
  if(a^.hd <> nil)then
   varMax:= varMax(a^.hd) //recursion aca
  else
   varMax:= a^.elem;
 end
 else
  varMax:= -1;
end;

var
 a:arbol;
 sum,valor:integer;
BEGIN
 sum:= 0;
 writeln('Bienvenido al programa,ingrese 8 numeros');
 generar(a);
 recorridoPreorden(a,sum);
 writeln('Suma de todos los elementos: ',sum); 	
 valor:= varMax(a);
 writeln('El valor mas grande en el arbol es: ',valor); 	
END.

