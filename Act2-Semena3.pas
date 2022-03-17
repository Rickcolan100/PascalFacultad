program actividad2semana3;
const
 cant = 4;
type
 cad = string[10];
 producto = record
  fech:cad;
  cod:integer;
  cods:integer; //1...4
  cant:integer;
 end;
 lista = ^nodo;
 nodo = record
  dato:producto;
  sig:lista;
 end;
 vec = array[1..cant]of lista;
 
procedure inicializar(var v:vec);
var
 i:integer;
begin
 for i:=1 to 4 do
  v[i]:=nil;
end;

Procedure AgregarOrdenado(var l: lista; p:producto);
var ant, nue, act: lista;
begin
 new (nue);
 nue^.dato := p;
 act := l;
 while (act <> nil) and (act^.dato.cod < p.cod) do begin
  ant := act;
  act := act^.sig;
 end;
 if (act = l)  then l := nue   
                 else ant^.sig := nue; 
 nue^.sig := act ;
end; 

procedure leer(var p:producto);
begin
 writeln('Ingrese sucursal donde se compro el producto(1..4)');
 readln(p.cods);
 if(p.cods <> 0)then begin
  writeln('Ingrese codigo del producto');
  readln(p.cod);
  writeln('Ingrese fecha del producto');
  readln(p.fech);
  writeln('Ingrese cantidad vendida');
  readln(p.cant);
 end;
end;

procedure generar(var v:vec);
var
 p:producto;
begin
 leer(p);
 while(p.cods <> 0)do begin
  AgregarOrdenado(v[p.cods],p);
  leer(p);
 end;
end;

procedure determinarMinimo(var v:vec;var min:producto);  
Var
 pos,i:integer;
Begin
 min.cod:= 9999;
 pos:=0;
 for i:=1 to 4 do begin
  if(v[i] <> nil)then begin
   if(v[i]^.dato.cod < min.cod)then begin
    min.cod:= v[i]^.dato.cod;
    pos:= i;
   end;
  end;
 end;
 if(min.cod <> 9999)then begin
  min:= v[pos]^.dato;
  v[pos]:=v[pos]^.sig;
 end;
end;

procedure AgregarAdelante(var ln:lista;aux:producto);
var
 nue:lista;
begin
 new(nue);
 nue^.dato:= aux;
 nue^.sig:= ln;
 ln:= nue;
end;
 
procedure copiar(var aux:producto; total:integer; actual:integer);
begin
 aux.cod:= actual;
 aux.cant:= total;
end;

procedure Merge(v:vec;var ln:lista;var min:producto); 
var
 total,actual:integer;
 aux:producto;
begin
 determinarMinimo(v,min);
 while(min.cod <> 9999)do begin
  actual:= min.cod;
  total:= 0;
  while((actual = min.cod)and(min.cod <> 9999))do begin
   total:= total + min.cant;
   determinarMinimo(v,min);
  end;
  copiar(aux,total,actual);
  AgregarAdelante(ln,aux);
 end;
end;

procedure imprimir(ln:lista);
begin
 while(ln <> nil)do begin
  writeln('Codigo de producto; ',ln^.dato.cod);
  writeln('Cantidad vendida: ',ln^.dato.cant);
  writeln('--------------------------------------');
  ln:= ln^.sig;
 end;
end;

var
 v:vec;
 ln:lista;
 min:producto;
BEGIN
 ln:= nil;
 inicializar(v);
 writeln('Bienvenido al programa,ingrese productos de surcursales.Con codigo de sucursal 0 se deja de ingresar productos');
 generar(v);	
 writeln('A continuacion se generara una lista con la cantidad de productos vendidos en todas las surcursales');
 Merge(v,ln,min);
 writeln('Lista de productos vendidos - RESULTADOS');
 imprimir(ln);	
END.

