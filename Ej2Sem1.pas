program ejercicio2;
type
 pelicula = record
  codp:integer;
  codg:integer; //1...6
  puntp:integer;
 end;
 lista = ^nodo;
 nodo = record
  dato:pelicula;
  sig:lista;
 end;
 vec = array[1..6]of lista;
 vecp = array[1..6] of pelicula;
 
//PROCEDIMIENTOS
procedure inicializar(var v:vec);
var
 i:integer;
begin
 for i:= 1 to 6 do 
  v[i]:= nil;
end;

procedure AgregarAtras (var l, ult: lista;p:pelicula); 
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

procedure leer(var p:pelicula);
begin
 p.codp:= random(100);
 if(p.codp <> 0)then begin
  p.codg:= random(6);
  p.puntp:= random(10);
 end;
end; 

procedure generar(var v:vec);
var
 ult:lista;
 p:pelicula;
begin
 ult:= v[p.codg];
 leer(p);
 while(p.codp <> 0)do begin
  AgregarAtras(v[p.codg],ult,p);
  leer(p);
 end;
end; 
 
procedure imprimirvec(v:vec);
var
 i:integer;
begin
 for i:=1 to 6 do begin
  while(v[i] <> nil)do begin
   writeln('Genero ',i);
   writeln('Codigo de pelicula: ',v[i]^.dato.codp);
   writeln('Puntaje promedio: ',v[i]^.dato.puntp);
   v[i]:= v[i]^.sig;
  end; 
 end;
end;  
 
procedure buscar(v:vec;var vp:vecp);
var
 i:integer;
 codmax,max:integer;
begin
 max:= -1;
 for i:=1 to 6 do begin
  while(v[i] <> nil)do begin
   if(v[i]^.dato.puntp > max)then begin
    max:= v[i]^.dato.puntp;
    codmax:= v[i]^.dato.codp;
   end;
   vp[i].codp:= codmax;
   vp[i].puntp:= max;
   v[i]:= v[i]^.sig;
  end;
 end;
end;

procedure OrdenadoPorInsercion(var vp:vecp); 
var
 i,j:integer;
 aux:pelicula;
begin
 for i:=2 to 6 do begin
  aux:= vp[i];
  j:=i-1;
  while(j > 0)and(vp[j].puntp > aux.puntp)do begin
   vp[j+1]:= vp[j];
   j:= j - 1;
  end;
  vp[j+1]:= aux;
 end;
end; 

procedure imprimir(vp:vecp);
var
 i:integer;
begin
 for i:= 1 to 6 do begin 
  writeln('Genero ',i);
  writeln('Codigo de pelicula: ',vp[i].codp);
  writeln('Puntaje promedio: ',vp[i].puntp);
 end;
end;  

procedure calcular(vp:vecp;var codmx:integer;var codmn:integer);
var
 i,min,max:integer;
begin
 min:= 9999;
 max:= -1;
 for i:= 1 to 6 do begin
  if(vp[i].puntp > max)then begin
   max:= vp[i].puntp;
   codmx:= vp[i].codp;
  end;
  if(vp[i].puntp < min)then begin
   min:= vp[i].puntp;
   codmn:= vp[i].codp;
  end;
 end;
end;

//PROGRAMA PRINCIPAL
var
 v:vec;
 vp:vecp;
 codmx,codmn:integer;
BEGIN
 Randomize;
 inicializar(v);
 writeln('Se va a generar la lista de peliculas');
 generar(v);
 writeln('Lista de peliculas generadas');
 imprimirvec(v);
 writeln('Se va a cargar el vector de peliculas con datos del primer vector');
 buscar(v,vp);
 writeln('A continuacion se ordenara el vector de peliculas con mayor puntaje');
 OrdenadoPorInsercion(vp);
 writeln('Lista de peliculas con mayor puntaje');
 imprimir(vp);
 writeln('Se calculara la pelicula con mayor y menor puntaje');	
 calcular(vp,codmx,codmn);
 writeln('El codigo de pelicula con mayor puntaje es: ',codmx);
 writeln('El codigo de pelicula con menor puntaje es: ',codmn);	 	
END.

