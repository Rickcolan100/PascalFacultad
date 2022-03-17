program Act5Semana2;
type
 arbol = ^nodo;
 nodo = record
   elem: string;
   hi: arbol;
   hd: arbol;
 end;
 
procedure Insertar(var a:arbol; nom:string);
begin
 if(a = nil) then begin
  new(a);
  a^.elem:= nom;
  a^.hi:= nil;
  a^.hd:= nil;
 end
 else begin
  if(nom < a^.elem) then
   insertar(a^.hi,nom)
  else
   insertar(a^.hd,nom);
  end;
end; 
 
procedure generar(var a:arbol);
var 
 nom:string;
begin
 writeln('ingrese un nombre');
 readln(nom);
 while(nom <> 'ZZZ')do begin
  insertar(a,nom);
  writeln('ingrese un nombre');
  readln(nom); 
 end;
end;  

function Buscar(a:arbol;nom:string;var punt:arbol;var ok:boolean):arbol;
begin
 if(a <> nil)then begin
  if(a^.elem = nom)then begin
   ok:= true;
   punt:= a;
   Buscar:= punt;
   end;
 end
 else begin
  if(a^.elem > nom)then
   Buscar:=Buscar(a^.hi,nom,punt,ok)
  else
   Buscar:=Buscar(a^.hd,nom,punt,ok);
  end;
  Buscar:= nil;
end;

var
 a,punt:arbol;
 nom:string;
 ok:boolean;
BEGIN
 ok:= false;
 writeln('Bienvenido al programa,por favor ingrese nombre y con ZZZ deja de ingresarlos');
 generar(a);
 writeln('Busqueda de nombres');
 writeln('Ingrese nombre a buscar');
 readln(nom);
 buscar(a,nom,punt,ok);
 if(ok)then
  writeln('El nombre existe')
 else if(not ok)then
  writeln('El nombre no existe');	
END.

