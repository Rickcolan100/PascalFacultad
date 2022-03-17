program Actrepa3;
type
 auto = record
  pat:integer;
  anofab:integer;
  marca:string; 
  modelo:integer;   
 end;
 lista = ^nodo;
 nodo = record
  dato: auto;
  sig:lista;
 end; 
 arbol= ^nodoA;
 nodoA= record
  elem: auto;
  hi:arbol;
  hd:arbol;
 end;

procedure leer(var au:auto);
begin
 writeln('Ingrese numero de patente: ');
 readln(au.pat);
 if(au.pat <> 111)then begin
  writeln('Ingrese año de fabricacion(2010 - 2018): ');
  readln(au.anofab);
  writeln('Ingrese marca del auto: ');
  readln(au.marca);
  writeln('Ingrese modelo del auto: ');
  readln(au.modelo);
 end; 
end; 

Procedure Insertar(var a:arbol; au:auto);
begin
 if(a = nil) then begin
  new(a);
  a^.elem:= au;
  a^.hi:=nil;
  a^.hd:=nil;
 end
 else begin
  if(a^.elem.pat > au.pat) then
   insertar(a^.hi,au)
  else 
   insertar(a^.hd,au);
  end;
end; 
 
procedure crear(var a:arbol);
var
 au:auto;
begin
 leer(au);
 while(au.pat <> 111)do begin
  Insertar(a,au);
  leer(au)
 end;
end; 

procedure imprimira(a:arbol);
begin
 if(a <> nil)then begin
  imprimira(a^.hi);
  writeln('Pantente: ',a^.elem.pat);
  writeln('Año de fabricacion: ',a^.elem.anofab);
  writeln('Marca: ',a^.elem.marca);
  writeln('Modelo: ',a^.elem.modelo);
  imprimira(a^.hd);
 end;
end;  

procedure BusquedaMarca(a:arbol;marca:string; var cant:integer); 
begin
 if(a <> nil)then begin
  BusquedaMarca(a^.hi,marca,cant);
  if(a^.elem.marca = marca)then
   cant:= cant + 1;
  BusquedaMarca(a^.hd,marca,cant);
 end;
end;   
 
Procedure AgregarOrdenado(var l: lista; au:auto);
var ant, nue, act: lista;
begin
 new (nue);
 nue^.dato := au;
 act := l;
 while (act<>NIL) and (act^.dato.anofab < au.anofab) do begin
  ant := act;
  act := act^.sig ;
 end;
 if (act = l)  then l := nue   
                  else ant^.sig := nue; 
 nue^.sig := act ;
end; 
 
procedure generarLista(a:arbol; var l:lista);
begin
 if(a <> nil)then begin
  generarLista(a^.hi,l);
  AgregarOrdenado(l,a^.elem);
  generarLista(a^.hd,l);
 end; 
end; 

procedure imprimir(l:lista);
begin
 while(l <> nil)do begin
  writeln('Pantente: ',l^.dato.pat);
  writeln('Año de fabricacion: ',l^.dato.anofab);
  writeln('Marca: ',l^.dato.marca);
  writeln('Modelo: ',l^.dato.modelo);
  l:= l^.sig;
 end;
end;  

procedure BuscarAnoFab(a:arbol; pat:integer); //orden normal sin importar
begin
 if(a <> nil)then begin
  BuscarAnoFab(a^.hi,pat);
  if(a^.elem.pat = pat)then
   writeln('El año de fabricacion de la pantente fue en ',a^.elem.anofab);
  BuscarAnoFab(a^.hd,pat);
 end;
end;


var
 a:arbol;
 l:lista;
 cant,pat:integer;
 marca:string;
BEGIN
 l:= nil;
 cant:= 0;
 writeln('************************************************************************');
 writeln('Bienvenido al programa,ingrese autos a la agencia.Con patente 111 deja de ingresar');
 crear(a);
 writeln('---------------------------------------------------------------------------');
 writeln('- LISTA DE AUTOS EN LA AGENCIA(arbol) -');
 imprimira(a);
 writeln('---------------------------------------------------------------------------');
 writeln('- CANTIDAD DE AUTOS POR MARCA -');
 writeln('Ingrese marca: ');
 readln(marca);
 BusquedaMarca(a,marca,cant);
 writeln('La marca ',marca,' tiene ',cant,' de autos en la agencia');
 writeln('---------------------------------------------------------------------------');
 writeln('- LISTA DE AUTOS ORDENADA POR AÑO DE FABRICACION -');
 generarLista(a,l);
 imprimir(l);
 writeln('---------------------------------------------------------------------------');
 writeln('- BUSQUEDA DE AÑO DE FABRICACION POR PATENTE -');
 writeln('Ingrese patente: ');
 readln(pat);
 BuscarAnoFab(a,pat);
 writeln('************************************************************************');	
END.

