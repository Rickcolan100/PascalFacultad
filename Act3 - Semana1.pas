program Ej3Semana1;
type
 producto = record
  cod:integer;
  rubro:integer; //1..6
  precio:integer;
 end;
 lista = ^nodo;
 nodo = record
  dato:producto;
  sig:lista;
 end;
 vec = array[1..6] of lista;
 vecrubro = array[1..30] of producto; //almacena los elementos del rubro 3
  
procedure inicializar(var v:vec);
var
 i:integer;
begin
 for i:= 1 to 6 do
  v[i]:= nil;
end;

procedure leer(var p:producto);
begin
 writeln('Ingrese precio del producto: ');
 readln(p.precio);
 if(p.precio <> -1)then begin
  writeln('Ingrese rubro(1..6)');
  readln(p.rubro);
  writeln('Ingrese codigo');
  readln(p.cod);
 end;
end;
 
procedure AgregarOrdenado(var l: lista; p:producto);
var ant, nue, act: lista;
begin
 new (nue);
 nue^.dato := p;
 act := l;
 while (act<>NIL) and (act^.dato.rubro <> p.rubro)do begin //busca en la zona del rubro
  ant := act;
  act := act^.sig ;
 end;
 while (act<>NIL) and (act^.dato.cod < p.cod)and(act^.dato.rubro = p.rubro) do begin //busca en el rubro especifico
  ant := act;
  act := act^.sig ;
 end;
 if (act = l)  then l := nue   
                 else ant^.sig := nue; 
 nue^.sig := act ;
end; 
 
procedure generar(var v:vec);
var
 p:producto;
begin
 leer(p);
 while(p.precio <> -1)do begin
  AgregarOrdenado(v[p.rubro],p);
  leer(p);
 end;
end;

procedure generarvr(var vr:vecrubro;var diml:integer;l:lista);
begin
 while(l <> nil)and(diml < 30)do begin
  diml:= diml + 1;
  vr[diml]:= l^.dato;
  l:= l^.sig;
 end;
end;
  
procedure OrdenadoInsercion(var vr:vecrubro; diml:integer); 
var
 i,j:integer;
 aux:producto;
begin
 for i:=2 to diml do begin
  aux:= vr[i];
  j:=i-1;
  while(j > 0)and(vr[j].precio > aux.precio)do begin
   vr[j+1]:=vr[j];
   j:= j - 1;
  end;
  vr[j+1]:=aux;
 end;
end;

procedure imprimir(vr:vecrubro; diml:integer);
var
 i:integer;
begin
 for i:= 1 to diml do begin
  writeln('Codigo: ',vr[i].cod);
  writeln('Precio: ',vr[i].precio);
 end;
end; 
   
var
 v:vec;
 vr:vecrubro;
 diml:integer;
BEGIN
 diml:= 0;
 writeln('Bienvenido al programa. Ingrese productos para los 6 rubros,con -1 cambia de rubro hasta llegar al final');
 generar(v);
 writeln('A continuacion se moveran datos del rubro 3 al vector nuevo');
 generarvr(vr,diml,v[3]); //v[3] es el acceso directo a la lista sin tener que recorrer por que es el vector de listas
 writeln('Se ordenara el vector que contiene elementos del rubro 3 en base su precio');
 OrdenadoInsercion(vr,diml);
 writeln('Lista de precio ordenada en base al rubro 3');
 imprimir(vr,diml);	
END.

