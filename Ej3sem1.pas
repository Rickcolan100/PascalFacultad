program ejercicio3;
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
 vec = array[1..6]of lista;
 vecprod = array[1..30]of producto;

//PROCEDIMIENTOS 
procedure inicializar(var v:vec);
var
 i:integer;
begin
 for i:= 1 to 6 do 
  v[i]:= nil;
end;

Procedure AgregarOrdenado(var l: lista; p:producto);
var ant, nue, act: lista;
begin
 new (nue);
 nue^.dato := p;
 act := l;
 while (act<>NIL) and (act^.dato.cod < p.cod) do begin
   ant := act;
   act := act^.sig ;
 end;
 if (act = l)  then l := nue   
                  else ant^.sig := nue; 
 nue^.sig := act ;
end;

procedure leer(var p:producto);
begin
 p.cod:= random(100);
 if(p.cod <> 0)then begin
  p.rubro:= random(6);
  p.precio:= random(100);
 end;
end;

procedure generar(var v:vec);
var
 p:producto;
begin 
 leer(p);
 while(p.cod <> 0)do begin
  AgregarOrdenado(v[p.rubro],p);
  leer(p);
 end;
end; 

procedure imprimirrubros(v:vec);
var
 i:integer;
begin
 for i:=1 to 6 do begin
  writeln('---------- Rubro: ',i,'------------------');
  while(v[i] <> nil)do begin
   writeln('Codigo de producto: ',v[i]^.dato.cod);
   writeln('Precio: ',v[i]^.dato.precio);
   writeln('-------------------------------------');
   v[i]:= v[i]^.sig;
  end; 
 end;
end;  

procedure OrdenadoPorInsercion(var vp:vecprod;diml:integer); 
var
 i,j:integer;
 aux:producto;
begin
 for i:=2 to diml do begin
  aux:= vp[i];
  j:=i-1;
  while(j > 0)and(vp[j].precio > aux.precio)do begin
   vp[j+1]:= vp[j];
   j:= j - 1;
  end;
  vp[j+1]:= aux;
 end;
end; 

procedure generarvectornuevo(var vp:vecprod; l:lista;var diml:integer);
begin
 while(l <> nil)and(diml <= 30)do begin
  diml:= diml + 1;
  vp[diml]:= l^.dato;
  l:= l^.sig;
 end;
end;

procedure imprimirproductos(vp:vecprod; diml:integer);
var
 i:integer;
begin
 for i:= 1 to diml do begin 
  writeln('Codigo de producto: ',vp[i].cod);
  writeln('Precio: ',vp[i].precio);
  writeln('--------------------------------');
 end;
end;  
 
//PROGRAMA PRINCIPAL
var
 v:vec;
 vp:vecprod;
 diml:integer;
BEGIN
 Randomize;
 diml:= 0;
 inicializar(v);
 writeln('Se generara la lista de productos para cada rubro');
 generar(v);
 writeln('Lista de rubros almacenados: ');
 writeln('-------------------------------------');
 imprimirrubros(v);
 writeln('Se generara la lista de productos del rubro 3');
 generarvectornuevo(vp,v[3],diml);
 writeln('Se ordenara la lista de productos del rubro 3 por precio');
 OrdenadoPorInsercion(vp,diml);	
 writeln('Lista de productos del rubro 3: ');
 writeln('--------------------------------------');
 imprimirproductos(vp,diml);	
END.

