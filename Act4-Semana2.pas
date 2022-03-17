program Act4Semana2;
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
  else if(num > a^.elem)then
   insertar(a^.hd,num);
  end;
end;
 
procedure generar(var a:arbol);
var 
 num:integer;
begin
 writeln('ingrese un numero');
 readln(num);
 while(num <> 0)do begin
  writeln('ingrese un numero');
  readln(num); 
  insertar(a,num);
 end;
end; 

function varMax(a:arbol):integer; 
begin
 if(a <> nil)then begin
  if(a^.hd <> nil)then
   varMax:= varMax(a^.hd) 
  else
   varMax:= a^.elem;
 end
 else
  varMax:= -1;
end;

function varMin(a:arbol):integer; 
begin
 if(a <> nil)then begin
  if(a^.hi <> nil)then
    varMin:= varMin(a^.hi)
  else
   varMin:= a^.elem;
 end
 else
    varMin:= -1;
end;

procedure contar(a:arbol;var cant:integer);
begin
 if(a <> nil)then begin
  cant:= cant + 1;
  contar(a^.hi,cant);
  contar(a^.hd,cant);
 end;
end;

procedure imprimirorden(a:arbol);
begin
 if(a <> nil)then begin
  writeln(a^.elem);
  imprimirorden(a^.hi);
  imprimirorden(a^.hd);
 end;
end;

procedure paresdecrecientes(a:arbol);
var
 num:integer;
begin
 if(a <> nil)then begin
  paresdecrecientes(a^.hd);
  if(a^.elem <> 0)then begin
   num:= a^.elem DIV 10;
   if(num DIV 2 = 0)then
    writeln(a^.elem);
   num:= num MOD 10;
  end;
  paresdecrecientes(a^.hi);
 end;
end;


var
 a:arbol;
 vlmax,vlmin,cant:integer;
BEGIN
 cant:= 0;
 writeln('Bienvenido al programa,inserte numeros al arbol y con 0 deja de ingresarlos');
 generar(a);
 vlmax:= varMax(a);	
 vlmin:= varMin(a);
 writeln('El valor mas grande en el arbol es el numero: ',vlmax);
 writeln('El valor max chico en el arbol es el numero:',vlmin);
 contar(a,cant);
 writeln('La cantidad de elementos que tiene el arbol es: ',cant);
 writeln('Elementos impresos acorde a su orden:');
 imprimirorden(a);
 writeln('Elementos en el arbol pares impresos en orden decreciente:');
 paresdecrecientes(a); 	
END.

