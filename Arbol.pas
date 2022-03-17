program actividadteoria;
type
 tdato = record
  val:integer;
  cont:integer;
 end;
 arbol = ^nodo;
 nodo = record
  elem: tdato;
  hi: arbol;
  hd: arbol;
 end;

//PROCEDIMIENTOS
 Procedure Insertar(var a:arbol; n:integer);
 begin
  if(a = nil) then begin
     new(a);
     a^.elem.val:= n;
     a^.elem.cont:= 1; //primera aparicion del elemento
     a^.hi:= nil;
     a^.hd:= nil;
  end
  else 
   if(a^.elem.val > n) then
    insertar(a^.hi,n)
   else 
    if(a^.elem.val < n)then
     insertar(a^.hd,n)
    else 
     a^.elem.cont:= a^.elem.cont + 1;   
 end;
 
 procedure generar(var a:arbol);
 var
  n:integer;
 begin
  a:= nil;
  n:= random(100);
  while(n <> 0)do begin
   write(n,' ');
   Insertar(a,n);
   n:= random(100);
  end;
  writeln;
 end; 
 
 procedure mostrardato(elem:tdato);
 begin
  writeln('Valor: ',elem.val, ', Apariciones: ',elem.cont);
 end;
 
 procedure imprimirABB(a:arbol); 
 begin
  if(a <> nil)then begin
   imprimirABB(a^.hi);
   mostrardato(a^.elem);
   imprimirABB(a^.hd);
  end;
 end;

 procedure contarvalorex(a:arbol;x:integer;var total:integer); 
 begin
  if(a <> nil)then begin
   contarvalorex(a^.hi,x,total);
   if(x > a^.elem.cont)then
    total:= total + 1;
   contarvalorex(a^.hd,x,total);
  end;
 end;
 
 function verMinimo(a:arbol):arbol;
 begin
  if(a = nil)then 
   verMinimo:= nil
  else
   if(a^.hi = nil)then
    verMinimo:= a
   else
    verMinimo:= verMinimo(a^.hi);
 end;   
 
 function Buscar (a:arbol; dato: integer):arbol;
 begin
  if(a=nil) then
   Buscar:= nil
  else
   if(dato = a^.elem.val) then
    Buscar:= a
   else
    if(dato < a^.elem.val) then
     Buscar:=Buscar(a^.HI,dato) 
    else
     Buscar:= Buscar(a^.HD,dato); 
 end;
  
//PROGRAMA PRINCIPAL
var
 a,puntm,puntb:arbol;
 x,total,dato:integer;
BEGIN
 Randomize;
 total:= 0;	
 writeln('El arbol se ha generado y los elementos son los siguientes: ');
 generar(a);
 writeln('Valor y cantidad de apariciones: ');
 imprimirABB(a);
 writeln('Ingrese valor para retornar la cantidad de veces mas de x veces: ');
 readln(x);	
 contarvalorex(a,x,total);
 writeln('La cantidad de valores que aparecieron mas de X veces es: ',total);
 puntm:= verMinimo(a);
 if(puntm <> nil)then begin
  writeln('Los datos del minimos son los siguientes: ');
  mostrardato(puntm^.elem);
 end
 else
  writeln('El arbol esta vacio - No se registran elementos');
 writeln('Ingrese numero a buscar en el arbol: ');
 readln(dato); 
 puntb:= Buscar(a,dato);
 if(puntb <> nil)then begin
  writeln('El dato existe y sus elementos son los siguientes: ');
  mostrardato(puntb^.elem);
 end
 else
  writeln('No existe el numero');
END.

