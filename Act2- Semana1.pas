program Ej2Semana1; 
type
 pelicula = record
  cod:integer;
  gen:integer; //1 a 8 generos
  puntprom:integer;
 end;
 lista = ^nodo;
 nodo = record
  dato:pelicula;
  sig:lista;
 end;
 vec = array[1..8]of lista;
 vecmax = array[1..8]of pelicula;
 
procedure inicializar(var v:vec);
var
 i:integer;
begin
 for i:= 1 to 8 do 
  v[i]:= nil;
end; 
  
procedure leer(var p:pelicula);
begin
 writeln('Ingrese codigo del pelicula: ');
 readln(p.cod);
 if(p.cod <> -1)then begin
  writeln('Ingrese genero de pelicula(1..8)');
  readln(p.gen);
  writeln('Ingrese puntaje promedio de la pelicula');
  readln(p.puntprom);
 end;
end;

procedure AgregarAtras (var l, ult: lista; p:pelicula); 
var  
 nue : lista;
begin 
 new(nue);
 nue^.dato:= p;
 nue^.sig := nil;
 if (l <> nil) then 
  ult^.sig := nue
 else 
  l := nue;
 ult := nue;
end;

procedure generar(var v:vec);
var
 ult:lista;
 p:pelicula;
begin
 ult:= v[p.gen];
 leer(p);
 while(p.cod <> -1)do begin
  AgregarAtras(v[p.gen],ult,p);
  leer(p);
 end;
end;

procedure buscar(v:vec;var vm:vecmax;max:integer;var codmax:integer;var genmax:integer);
var
 i:integer;
begin
 for i:=1 to 8 do begin
  while(v[i] <> nil)do begin
   if(v[i]^.dato.puntprom > max)then begin
    max:= v[i]^.dato.puntprom;
    codmax:= v[i]^.dato.cod;
    genmax:= v[i]^.dato.gen;
   end;
   v[i]:= v[i]^.sig;
   vm[genmax].cod:= codmax;
   vm[genmax].puntprom:= max;
  end;
 end;
end;
 
procedure OrdenadoInsercion(var vm:vecmax); 
var
 i,j:integer;
 aux:pelicula;
begin
 for i:=2 to 8 do begin
  aux:= vm[i];
  j:=i-1;
  while(j > 0)and(vm[j].puntprom > aux.puntprom)do begin
   vm[j+1]:=vm[j];
   j:= j - 1;
  end;
  vm[j+1]:=aux;
 end;
end;

procedure imprimir(vm:vecmax);
var
 i:integer;
begin
 for i:= 1 to 8 do begin 
  writeln('Genero ',i);
  writeln('Codigo de pelicula: ',vm[i].cod);
  writeln('Puntaje promedio: ',vm[i].puntprom);
 end;
end;  

procedure calcular(vm:vecmax; max:integer; min:integer;var codmx:integer;var codmn:integer);
var
 i:integer;
begin
 for i:= 1 to 6 do begin
  if(vm[i].puntprom > max)then begin
   max:= vm[i].puntprom;
   codmx:= vm[i].cod;
  end;
  if(vm[i].puntprom < min)then begin
   min:= vm[i].puntprom;
   codmn:= vm[i].cod;
  end;
 end;
end;

var
 v:vec;
 vm:vecmax;
 max,min:integer;
 codmax,genmax:integer;
 codmx,codmn:integer;
BEGIN
 max:= 0;
 min:= 999;
 inicializar(v);
 writeln('Bienvenido al programa,ingrese peliculas o puede pasar de categoria con -1 hasta llegar a la categoria 8');
 generar(v);
 buscar(v,vm,max,codmax,genmax);
 writeln('Vector ordenado de puntajes para cada genero de peliculas');
 OrdenadoInsercion(vm);
 imprimir(vm);
 writeln('Codigo de pellculas categorizadas por menor o mayor puntaje');
 calcular(vm,max,min,codmx,codmn);
 writeln('El codigo de pelicula con mayor puntaje es: ',codmx);
 writeln('El codigo de pelicula con menor puntaje es: ',codmn);	
END.

