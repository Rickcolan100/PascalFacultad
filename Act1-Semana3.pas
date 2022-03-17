program actividad1Sem3;
const
 cant = 8;
type
 pelicula = record
  codp:integer;
  codg:integer;
  puntp:integer;
 end;
 lista = ^nodo;
 nodo = record
  dato:pelicula;
  sig:lista;
 end;
 vec = array[1..cant]of lista;
 
procedure inicializar(var v:vec);
var
 i:integer;
begin
 for i:=1 to 8 do
  v[i]:=nil;
end;

Procedure AgregarOrdenado(var l: lista; p:pelicula);
var ant, nue, act: lista;
begin
 new (nue);
 nue^.dato := p;
 act := l;
 while (act <> nil) and (act^.dato.codp < p.codp) do begin
  ant := act;
  act := act^.sig;
 end;
 if (act = l)  then l := nue   
                 else ant^.sig := nue; 
 nue^.sig := act ;
end; 

procedure leer(var p:pelicula);
begin
 writeln('Ingrese codigo de pelicula');
 readln(p.codp);
 if(p.codp <> -1)then begin
  writeln('Ingrese codigo de genero de pelicula(1..8)');
  readln(p.codg);
  writeln('Ingrese puntaje promedio de la critica');
  readln(p.puntp);
 end;
end;

procedure generar(var v:vec);
var
 p:pelicula;
begin
 leer(p);
 while(p.codp <> -1)do begin
  AgregarOrdenado(v[p.codg],p);
  leer(p);
 end;
end;

procedure determinarMinimo(var v:vec;var min:pelicula);  
Var
 pos,i:integer;
Begin
 min.codp:= 9999;
 pos:=0;
 for i:=1 to 8 do begin
  if(v[i] <> nil)then begin
   if(v[i]^.dato.codp < min.codp)then begin
    min.codp:= v[i]^.dato.codp;
    pos:= i;
   end;
  end;
 end;
 if(min.codp <> 9999)then begin
  min:= v[pos]^.dato;
  v[pos]:=v[pos]^.sig;
 end;
end;

procedure Merge(v:vec;var ln:lista;min:pelicula); 
begin
 determinarMinimo(v,min);
 while(min.codp <> 9999)do begin
  AgregarOrdenado(ln,min);
  determinarMinimo(v,min);
 end;
end;

procedure imprimir(var ln:lista);
begin
 if(ln <> nil)then begin
  writeln('*****************************************');
  writeln('Codigo de pelicula: ',ln^.dato.codp);
  writeln('Codigo genero: ',ln^.dato.codg);
  writeln('Puntaje promedio: ',ln^.dato.puntp);
  writeln('*****************************************');
  imprimir(ln^.sig);
 end;
end;

var
 v:vec;
 ln:lista;
 min:pelicula;
BEGIN
 ln:= nil;
 inicializar(v);
 writeln('Bienvenido al programa,por favor ingrese peliculas y con codigo de pelicula -1 deja de procesarlas');
 generar(v);
 writeln('A continuacion se creara una nueva estructura con las peliculas ingresadas');
 Merge(v,ln,min);	
 writeln('Lista de peliculas realizada - RESULTADOS');
 imprimir(ln);	
END.

